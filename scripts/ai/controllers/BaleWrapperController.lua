--[[
This file is part of Courseplay (https://github.com/Courseplay/courseplay)
Copyright (C) 2019-2022 Peter Vaiko

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

---@class BaleWrapperController : ImplementController
BaleWrapperController = CpObject(ImplementController)

function BaleWrapperController:init(vehicle, baleWrapper)
    self.baleWrapper = baleWrapper
    ImplementController.init(self, vehicle, self.baleWrapper)
    
    local baler = AIUtil.getImplementWithSpecialization(self.vehicle, Baler)
    self.haveBaler = baler ~= nil
    
    if not self.haveBaler and self.baleWrapper then
        -- Bale wrappers which aren't balers have no AI markers as they have no pick up so add a function here
        -- to get the markers
        self.baleWrapper.getAIMarkers = function(object)
            return ImplementUtil.getAIMarkersFromGrabberNode(object, object.spec_baleWrapper)
        end
    end
    self:debug('Bale wrapper controller initialized')
end

function BaleWrapperController:update()
    if not self.implement:getConsumableIsAvailable(BaleWrapper.CONSUMABLE_TYPE_NAME) then
        self.vehicle:stopCurrentAIJob(AIMessageErrorOutOfFill.new())
    end
end

function BaleWrapperController:getDriveData()
    local maxSpeed = self:handleBaleWrapper()
    return nil, nil, nil, maxSpeed
end

function BaleWrapperController:isWorking()
    return self.baleWrapper.spec_baleWrapper.baleWrapperState ~= BaleWrapper.STATE_NONE
end

function BaleWrapperController:getLastDroppedBale()
    return self.baleWrapper.spec_baleWrapper.lastDroppedBale
end

function BaleWrapperController:handleBaleWrapper()
    local maxSpeed
    -- stop while wrapping only if we don't have a baler. If we do we should continue driving and working
    -- on the next bale, the baler code will take care about stopping if we need to
    if self:isWorking() and not self.haveBaler then
        maxSpeed = 0
    end
    -- Yes, Giants has a typo in the state (and yes, in FS22 as well...)
    if self.baleWrapper.spec_baleWrapper.baleWrapperState == BaleWrapper.STATE_WRAPPER_FINSIHED then
        local loweringDropTime, turnDropTime
        -- TODO_22: state of strategy not known here!
        -- inserts unload threshold after lowering the implement, useful after e.g. transition from connecting track to fieldwork
        if false and self.fieldworkState == self.states.WAITING_FOR_LOWER then
            local unloadThreshold = 2500 --delay in msecs, 2.5 secs seems to work well
            loweringDropTime = g_currentMission.time + unloadThreshold
        elseif loweringDropTime == nil then
            loweringDropTime = 0
        end
        -- inserts unload threshold after turn so bales don't drop on headlands
        if self.turnStartedAt and self.realTurnDurationMs then
            local unloadThreshold = 4000 --delay in msecs, 4 secs seems to work well
            turnDropTime = self.turnStartedAt + self.realTurnDurationMs + unloadThreshold
        else
            turnDropTime = 0 --avoids problems in case of condition variables not existing / empty e.g. before the first turn
        end
        if g_currentMission.time > math.max(loweringDropTime,turnDropTime) then --chooses the bigger delay
            self.baleWrapper:doStateChange(BaleWrapper.CHANGE_WRAPPER_START_DROP_BALE)
        end
    end
    return maxSpeed
end

function BaleWrapperController:isFuelSaveAllowed()
    return not (self:isWorking() and not self.haveBaler)
end

--- Giants isn't unfolding the bale wrapper for us, so we do it here.
function BaleWrapperController:onStart()
    -- for some reason, bale wrappers that don't really unfold still have a spec_foldable, although there
    -- is no foldable defined in the XML file. If we unfold these, they are stuck in the unfold state, also,
    -- the check for foldAnimTime == 1 in canContinueWork() won't work, see #2598. These all have a default
    -- 0.0001 anim time, so check if the anim time is a reasonable value and only unfold then.
    if self.baleWrapper.spec_foldable and self.baleWrapper.spec_foldable.maxFoldAnimDuration > 0.1 then
        self.baleWrapper:setFoldDirection(self.baleWrapper.spec_foldable.turnOnFoldDirection)
    end
end

--- Returns false, while the wrapper is being unfolded.
---@return boolean
function BaleWrapperController:canContinueWork()
    local spec = self.baleWrapper.spec_foldable
    if spec == nil then 
        return true
    end
    return spec.foldAnimTime == 0 or spec.foldAnimTime == 1
end