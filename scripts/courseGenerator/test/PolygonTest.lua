require('include')
function testPolygon()
    local p = Polygon({ Vector(0, 0), Vector(0, 1), Vector(0, 2), Vector(1, 2) })
    local e = {}
    for _, edge in p:edges() do
        table.insert(e, edge)
    end
    lu.assertEquals(e[1], CourseGenerator.LineSegment(0, 0, 0, 1))
    lu.assertEquals(e[2], CourseGenerator.LineSegment(0, 1, 0, 2))
    lu.assertEquals(e[3], CourseGenerator.LineSegment(0, 2, 1, 2))
    lu.assertEquals(e[4], CourseGenerator.LineSegment(1, 2, 0, 0))

    lu.assertEquals(p:getLength(), 3 + e[4]:getLength())

    -- vertex iterator
    local f = p:vertices()
    local i, cv, pv, nv = f()
    lu.assertEquals(i, 1)
    pv:assertAlmostEquals(Vector(1, 2))
    cv:assertAlmostEquals(Vector(0, 0))
    nv:assertAlmostEquals(Vector(0, 1))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 2)
    pv:assertAlmostEquals(Vector(0, 0))
    cv:assertAlmostEquals(Vector(0, 1))
    nv:assertAlmostEquals(Vector(0, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 3)
    pv:assertAlmostEquals(Vector(0, 1))
    cv:assertAlmostEquals(Vector(0, 2))
    nv:assertAlmostEquals(Vector(1, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 4)
    pv:assertAlmostEquals(Vector(0, 2))
    cv:assertAlmostEquals(Vector(1, 2))
    nv:assertAlmostEquals(Vector(0, 0))
    i, cv, pv, nv = f()
    lu.assertIsNil(i)

    f = p:vertices(3)
    i, cv, pv, nv = f()
    lu.assertEquals(i, 3)
    pv:assertAlmostEquals(Vector(0, 1))
    cv:assertAlmostEquals(Vector(0, 2))
    nv:assertAlmostEquals(Vector(1, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 4)
    pv:assertAlmostEquals(Vector(0, 2))
    cv:assertAlmostEquals(Vector(1, 2))
    nv:assertAlmostEquals(Vector(0, 0))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 1)
    pv:assertAlmostEquals(Vector(1, 2))
    cv:assertAlmostEquals(Vector(0, 0))
    nv:assertAlmostEquals(Vector(0, 1))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 2)
    pv:assertAlmostEquals(Vector(0, 0))
    cv:assertAlmostEquals(Vector(0, 1))
    nv:assertAlmostEquals(Vector(0, 2))
    i, cv, pv, nv = f()
    lu.assertIsNil(i)

    f = p:vertices(3, 1)
    i, cv, pv, nv = f()
    lu.assertEquals(i, 3)
    pv:assertAlmostEquals(Vector(0, 1))
    cv:assertAlmostEquals(Vector(0, 2))
    nv:assertAlmostEquals(Vector(1, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 4)
    pv:assertAlmostEquals(Vector(0, 2))
    cv:assertAlmostEquals(Vector(1, 2))
    nv:assertAlmostEquals(Vector(0, 0))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 1)
    pv:assertAlmostEquals(Vector(1, 2))
    cv:assertAlmostEquals(Vector(0, 0))
    nv:assertAlmostEquals(Vector(0, 1))
    i, cv, pv, nv = f()
    lu.assertIsNil(i)

    f = p:vertices(nil, 3)
    i, cv, pv, nv = f()
    lu.assertEquals(i, 1)
    pv:assertAlmostEquals(Vector(1, 2))
    cv:assertAlmostEquals(Vector(0, 0))
    nv:assertAlmostEquals(Vector(0, 1))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 2)
    pv:assertAlmostEquals(Vector(0, 0))
    cv:assertAlmostEquals(Vector(0, 1))
    nv:assertAlmostEquals(Vector(0, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 3)
    pv:assertAlmostEquals(Vector(0, 1))
    cv:assertAlmostEquals(Vector(0, 2))
    nv:assertAlmostEquals(Vector(1, 2))
    i, cv, pv, nv = f()
    lu.assertIsNil(i)

    -- vertex iterator reverse
    f = p:vertices(#p, 1, -1)
    i, cv, pv, nv = f()
    lu.assertEquals(i, 4)
    pv:assertAlmostEquals(Vector(0, 2))
    cv:assertAlmostEquals(Vector(1, 2))
    nv:assertAlmostEquals(Vector(0, 0))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 3)
    pv:assertAlmostEquals(Vector(0, 1))
    cv:assertAlmostEquals(Vector(0, 2))
    nv:assertAlmostEquals(Vector(1, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 2)
    pv:assertAlmostEquals(Vector(0, 0))
    cv:assertAlmostEquals(Vector(0, 1))
    nv:assertAlmostEquals(Vector(0, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 1)
    pv:assertAlmostEquals(Vector(1, 2))
    cv:assertAlmostEquals(Vector(0, 0))
    nv:assertAlmostEquals(Vector(0, 1))
    i, cv, pv, nv = f()
    lu.assertIsNil(i)

    f = p:vertices(3, nil, -1)
    i, cv, pv, nv = f()
    lu.assertEquals(i, 3)
    pv:assertAlmostEquals(Vector(0, 1))
    cv:assertAlmostEquals(Vector(0, 2))
    nv:assertAlmostEquals(Vector(1, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 2)
    pv:assertAlmostEquals(Vector(0, 0))
    cv:assertAlmostEquals(Vector(0, 1))
    nv:assertAlmostEquals(Vector(0, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 1)
    pv:assertAlmostEquals(Vector(1, 2))
    cv:assertAlmostEquals(Vector(0, 0))
    nv:assertAlmostEquals(Vector(0, 1))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 4)
    pv:assertAlmostEquals(Vector(0, 2))
    cv:assertAlmostEquals(Vector(1, 2))
    nv:assertAlmostEquals(Vector(0, 0))
    i, cv, pv, nv = f()
    lu.assertIsNil(i)

    f = p:vertices(3, 1, -1)
    i, cv, pv, nv = f()
    lu.assertEquals(i, 3)
    pv:assertAlmostEquals(Vector(0, 1))
    cv:assertAlmostEquals(Vector(0, 2))
    nv:assertAlmostEquals(Vector(1, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 2)
    pv:assertAlmostEquals(Vector(0, 0))
    cv:assertAlmostEquals(Vector(0, 1))
    nv:assertAlmostEquals(Vector(0, 2))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 1)
    pv:assertAlmostEquals(Vector(1, 2))
    cv:assertAlmostEquals(Vector(0, 0))
    nv:assertAlmostEquals(Vector(0, 1))
    i, cv, pv, nv = f()
    lu.assertIsNil(i)

    f = p:vertices(nil, 3, -1)
    i, cv, pv, nv = f()
    lu.assertEquals(i, 4)
    pv:assertAlmostEquals(Vector(0, 2))
    cv:assertAlmostEquals(Vector(1, 2))
    nv:assertAlmostEquals(Vector(0, 0))
    i, cv, pv, nv = f()
    lu.assertEquals(i, 3)
    pv:assertAlmostEquals(Vector(0, 1))
    cv:assertAlmostEquals(Vector(0, 2))
    nv:assertAlmostEquals(Vector(1, 2))
    i, cv, pv, nv = f()
    lu.assertIsNil(i)

    -- inside
    p = Polygon({ Vector(0, 0), Vector(0, 5), Vector(5, 5), Vector(5, 0) })
    local o = p:createOffset(Vector(0, -1), 1, false)
    o[1]:assertAlmostEquals(Vector(1, 1))
    o[2]:assertAlmostEquals(Vector(1, 4))
    o[3]:assertAlmostEquals(Vector(4, 4))
    o[4]:assertAlmostEquals(Vector(4, 1))

    -- wrap around case
    p = Polygon({ Vector(0, 0), Vector(0, 5), Vector(5, 5), Vector(5, 0), Vector(4, 0) })
    p:ensureMinimumEdgeLength(2)
    lu.assertEquals(#p, 4)
    p[4]:assertAlmostEquals(Vector(5, 0))

    -- outside, cut corner
    p = Polygon({ Vector(0, 0), Vector(0, 5), Vector(5, 5), Vector(5, 0) })
    o = p:createOffset(Vector(0, 1), 1, false)
    o[1]:assertAlmostEquals(Vector(0, -1))
    o[2]:assertAlmostEquals(Vector(-1, 0))
    o[3]:assertAlmostEquals(Vector(-1, 5))
    o[4]:assertAlmostEquals(Vector(0, 6))
    o[5]:assertAlmostEquals(Vector(5, 6))
    o[6]:assertAlmostEquals(Vector(6, 5))
    o[7]:assertAlmostEquals(Vector(6, 0))
    o[8]:assertAlmostEquals(Vector(5, -1))

    -- outside, preserve corner
    p = Polygon({ Vector(0, 0), Vector(0, 5), Vector(5, 5), Vector(5, 0) })
    o = p:createOffset(Vector(0, 1), 1, true)
    o[1]:assertAlmostEquals(Vector(-1, -1))
    o[2]:assertAlmostEquals(Vector(-1, 6))
    o[3]:assertAlmostEquals(Vector(6, 6))
    o[4]:assertAlmostEquals(Vector(6, -1))
    lu.assertIsTrue(p:isClockwise())

    p = Polygon({ Vector(0, 0), Vector(0, 5), Vector(5, 5), Vector(5, 0), Vector(0.3, 0), Vector(0.1, 0) })
    p:ensureMinimumEdgeLength(1)
    p[1]:assertAlmostEquals(Vector(0, 0))
    p[2]:assertAlmostEquals(Vector(0, 5))
    p[3]:assertAlmostEquals(Vector(5, 5))
    p[4]:assertAlmostEquals(Vector(5, 0))

    -- wrap around
    p = Polygon({ Vector(5, 0), Vector(5, 5), Vector(0, 5), Vector(0, 0) })
    lu.assertIsFalse(p:isClockwise())
    p:calculateProperties()
    p[1]:getEntryEdge():assertAlmostEquals(CourseGenerator.LineSegment(0, 0, 5, 0))
    p[1]:getExitEdge():assertAlmostEquals(CourseGenerator.LineSegment(5, 0, 5, 5))
    p[4]:getExitEdge():assertAlmostEquals(CourseGenerator.LineSegment(0, 0, 5, 0))

    -- point in polygon
    p = Polygon({ Vector(-10, -10), Vector(10, -10), Vector(10, 10), Vector(-10, 10) })
    lu.assertIsTrue(p:isInside(0, 0))
    lu.assertIsTrue(p:isInside(5, 5))
    lu.assertIsTrue(p:isInside(-5, -5))
    lu.assertIsTrue(p:isInside(-10, -5))
    lu.assertIsTrue(p:isInside(-9.99, -10))
    lu.assertIsFalse(p:isInside(-9.99, 10))

    lu.assertIsFalse(p:isInside(-10.01, -5))
    lu.assertIsFalse(p:isInside(10.01, 50))

    p = Polygon({ Vector(-10, -10), Vector(10, -10), Vector(0, 0), Vector(10, 10), Vector(-10, 10) })

    lu.assertIsFalse(p:isInside(0, 0))
    lu.assertIsFalse(p:isInside(5, 5))
    lu.assertIsTrue(p:isInside(-5, -5))
    lu.assertIsTrue(p:isInside(-10, -5))
    lu.assertIsFalse(p:isInside(-10, 10))

    lu.assertIsFalse(p:isInside(0.01, 0))
    lu.assertIsFalse(p:isInside(10, 0))
    lu.assertIsFalse(p:isInside(5, 2))
    lu.assertIsFalse(p:isInside(5, -2))
    lu.assertIsFalse(p:isInside(-10.01, -5))
    lu.assertIsFalse(p:isInside(10.01, 50))

    p = Polygon({ Vector(-10, -10), Vector(10, -10), Vector(10, 10), Vector(-10, 10) })
    lu.assertAlmostEquals(p:getArea(), 400)
    lu.assertIsFalse(p:isClockwise())
    p:reverse()
    lu.assertAlmostEquals(p:getArea(), 400)
    lu.assertIsTrue(p:isClockwise())

    -- _getPathBetween()
    local pCw = Polygon({ Vector(-10, -10), Vector(-10, -7), Vector(-10, 7), Vector(-10, 10),
                             Vector(10, 10), Vector(10, 7), Vector(10, -7), Vector(10, -10) })
    local pCcw = Polygon({ Vector(10, -10), Vector(10, -7), Vector(10, 7), Vector(10, 10),
                              Vector(-10, 10), Vector(-10, 7), Vector(-10, -7), Vector(-10, -10) })
    local o1, o2 = pCw:_getPathBetween(1, 3)
    lu.assertEquals(#o1, 3)
    o1[1]:assertAlmostEquals(pCw[1])
    o1[2]:assertAlmostEquals(pCw[2])
    o1[3]:assertAlmostEquals(pCw[3])
    lu.assertEquals(#o2, 7)
    o2[1]:assertAlmostEquals(pCw[1])
    o2[7]:assertAlmostEquals(pCw[3])

    o2, o1 = pCw:_getPathBetween(3, 1)
    lu.assertEquals(#o1, 3)
    o1[1]:assertAlmostEquals(pCw[3])
    o1[2]:assertAlmostEquals(pCw[2])
    o1[3]:assertAlmostEquals(pCw[1])
    lu.assertEquals(#o2, 7)
    o2[1]:assertAlmostEquals(pCw[3])
    o2[7]:assertAlmostEquals(pCw[1])

    -- goAround()
    -- disable smoothing so assertions are easier
    local minSmoothingAngle = CourseGenerator.cMinSmoothingAngle
    CourseGenerator.cMinSmoothingAngle = math.huge
    local function assertGoAroundTop(line)
        lu.EPS = 0.01
        line[1]:assertAlmostEquals(Vector(-12, 8))
        line[2]:assertAlmostEquals(Vector(-10, 8)) -- intersection
        line[3]:assertAlmostEquals(Vector(-10.00, 10.00))
        line[4]:assertAlmostEquals(Vector(10.00, 10.00))
        line[5]:assertAlmostEquals(Vector(10.00, 9.00))
        line[6]:assertAlmostEquals(Vector(12.00, 9.00))
        lu.assertEquals(#line, 6)
    end

    local function assertGoAroundTopWithCircle(line)
        lu.EPS = 0.01
        line[1]:assertAlmostEquals(Vector(-12, 8))
        line[2]:assertAlmostEquals(Vector(-10, 8))
        line[3]:assertAlmostEquals(Vector(-10.00, 10.00))
        line[4]:assertAlmostEquals(Vector(10.00, 10.00))
        line[5]:assertAlmostEquals(Vector(10.00, 7))
        line[6]:assertAlmostEquals(Vector(10.00, -7))
        line[7]:assertAlmostEquals(Vector(10, -10))
        line[8]:assertAlmostEquals(Vector(-10, -10))
        line[9]:assertAlmostEquals(Vector(-10, -7))
        line[10]:assertAlmostEquals(Vector(-10, 7))
        line[11]:assertAlmostEquals(Vector(-10.00, 10.00))
        line[12]:assertAlmostEquals(Vector(10.00, 10.00))
        line[13]:assertAlmostEquals(Vector(10.00, 9.00))
        line[14]:assertAlmostEquals(Vector(12.00, 9.00))
        lu.assertEquals(#line, 14)
    end

    pCw = Polygon({ Vector(-10, -10), Vector(-10, -7), Vector(-10, 7), Vector(-10, 10),
                       Vector(10, 10), Vector(10, 7), Vector(10, -7), Vector(10, -10) })
    pCcw = Polygon({ Vector(10, -10), Vector(10, -7), Vector(10, 7), Vector(10, 10),
                        Vector(-10, 10), Vector(-10, 7), Vector(-10, -7), Vector(-10, -10) })
    o = Polyline({ Vector(-12, 8), Vector(-9, 8), Vector(0, 9), Vector(9, 9), Vector(12, 9) })
    o:goAround(pCw)
    assertGoAroundTop(o)
    o = Polyline({ Vector(-12, 8), Vector(-9, 8), Vector(0, 9), Vector(9, 9), Vector(12, 9) })
    o:goAround(pCw, nil, true)
    assertGoAroundTopWithCircle(o)

    o = Polyline({ Vector(-12, 8), Vector(-9, 8), Vector(0, 9), Vector(9, 9), Vector(12, 9) })
    o:goAround(pCcw)
    assertGoAroundTop(o)
    o = Polyline({ Vector(-12, 8), Vector(-9, 8), Vector(0, 9), Vector(9, 9), Vector(12, 9) })
    o:goAround(pCcw, nil, true)
    assertGoAroundTopWithCircle(o)

    local function assertGoAroundBottom(line)
        lu.EPS = 0.01
        line[1]:assertAlmostEquals(Vector(-12, -8))
        line[2]:assertAlmostEquals(Vector(-10, -8))
        line[3]:assertAlmostEquals(Vector(-10.00, -10.00))
        line[4]:assertAlmostEquals(Vector(10.00, -10.00))
        line[5]:assertAlmostEquals(Vector(10.00, -9.00))
        line[6]:assertAlmostEquals(Vector(12.00, -9.00))
        lu.assertEquals(#line, 6)
    end

    local function assertGoAroundBottomWithCircle(line)
        lu.EPS = 0.01
        line[1]:assertAlmostEquals(Vector(-12, -8))
        line[2]:assertAlmostEquals(Vector(-10, -8))

        line[3]:assertAlmostEquals(Vector(-10.00, -10.00))
        line[4]:assertAlmostEquals(Vector(10.00, -10.00))
        line[5]:assertAlmostEquals(Vector(10.00, -7))
        line[6]:assertAlmostEquals(Vector(10.00, 7))
        line[7]:assertAlmostEquals(Vector(10, 10))
        line[8]:assertAlmostEquals(Vector(-10, 10))
        line[9]:assertAlmostEquals(Vector(-10, 7))
        line[10]:assertAlmostEquals(Vector(-10, -7))
        line[11]:assertAlmostEquals(Vector(-10.00, -10.00))
        line[12]:assertAlmostEquals(Vector(10.00, -10.00))

        line[13]:assertAlmostEquals(Vector(10.00, -9.00))
        line[14]:assertAlmostEquals(Vector(12.00, -9.00))
        lu.assertEquals(#line, 14)
    end

    o = Polyline({ Vector(-12, -8), Vector(-9, -8), Vector(0, -9), Vector(9, -9), Vector(12, -9) })
    o:goAround(pCw)
    assertGoAroundBottom(o)
    o = Polyline({ Vector(-12, -8), Vector(-9, -8), Vector(0, -9), Vector(9, -9), Vector(12, -9) })
    o:goAround(pCw, nil, true)
    assertGoAroundBottomWithCircle(o)
    o = Polyline({ Vector(-12, -8), Vector(-9, -8), Vector(0, -9), Vector(9, -9), Vector(12, -9) })
    o:goAround(pCcw)
    assertGoAroundBottom(o)
    o = Polyline({ Vector(-12, -8), Vector(-9, -8), Vector(0, -9), Vector(9, -9), Vector(12, -9) })
    o:goAround(pCcw, nil, true)
    assertGoAroundBottomWithCircle(o)
    -- restore smoothing angle to re-enable smoothing
    CourseGenerator.cMinSmoothingAngle = minSmoothingAngle

    -- rebase
    p = Polygon({ Vector(-10, -10), Vector(10, -10), Vector(10, 10), Vector(-10, 10) })
    p:rebase(2)
    lu.assertEquals(p[1], Vector(10, -10))
    lu.assertEquals(p[2], Vector(10, 10))
    lu.assertEquals(p[3], Vector(-10, 10))
    lu.assertEquals(p[4], Vector(-10, -10))

    p = Polygon({ Vector(-10, -10), Vector(10, -10), Vector(10, 10), Vector(-10, 10) })
    p:rebase(2, true)
    lu.assertEquals(p[1], Vector(10, -10))
    lu.assertEquals(p[2], Vector(-10, -10))
    lu.assertEquals(p[3], Vector(-10, 10))
    lu.assertEquals(p[4], Vector(10, 10))

    p = Polygon({ Vector(-10, -10), Vector(10, -10), Vector(10, 10), Vector(-10, 10) })
    p:rebase(4)
    lu.assertEquals(p[1], Vector(-10, 10))
    lu.assertEquals(p[2], Vector(-10, -10))
    lu.assertEquals(p[3], Vector(10, -10))
    lu.assertEquals(p[4], Vector(10, 10))

    p = Polygon({ Vector(-10, -10), Vector(10, -10), Vector(10, 10), Vector(-10, 10) })
    p:rebase(4, true)
    lu.assertEquals(p[1], Vector(-10, 10))
    lu.assertEquals(p[2], Vector(10, 10))
    lu.assertEquals(p[3], Vector(10, -10))
    lu.assertEquals(p[4], Vector(-10, -10))

    p = Polygon({ Vector(-20, 0), Vector(-15, -3), Vector(-10, -4), Vector(-5, -4),
                     Vector(0, 0), Vector(5, 0), Vector(10, 0), Vector(15, 0) })
    lu.assertAlmostEquals(p:getSmallestRadiusWithinDistance(4, 15, 20), 1.61)

    p = Polygon({ Vector(0, 0), Vector(0, 5), Vector(5, 5), Vector(5, 0) })
    lu.assertEquals(p:moveForward(1, 6), 3)
    lu.assertEquals(p:moveForward(1, 10), 3)
    lu.assertEquals(p:moveForward(1, 12), 4)
    lu.assertEquals(p:moveForward(2, 12), 1)
    lu.assertEquals(p:moveForward(3, 12), 2)
    -- wrap around once only
    lu.assertIsNil(p:moveForward(1, 20))
    lu.assertIsNil(p:moveForward(1, 22))
    lu.assertIsNil(p:moveForward(1, 26))

    local v, d, dFromEdge = p:findClosestVertexToPoint(Vector(2, 6))
    v:assertAlmostEquals(Vector(0, 5))
    lu.assertAlmostEquals(d, 2.236)
    lu.assertAlmostEquals(dFromEdge, 1)
    v, d, dFromEdge = p:findClosestVertexToPoint(Vector(2, 4))
    lu.assertAlmostEquals(d, 2.236)
    lu.assertAlmostEquals(dFromEdge, 1)
    v, d, dFromEdge = p:findClosestVertexToPoint(Vector(-2, 4))
    lu.assertAlmostEquals(d, 2.236)
    lu.assertAlmostEquals(dFromEdge, 1)
    v, d, dFromEdge = p:findClosestVertexToPoint(Vector(0, 3))
    v:assertAlmostEquals(Vector(0, 5))
    lu.assertAlmostEquals(d, 2)
    lu.assertAlmostEquals(dFromEdge, 2)
end
function testPathBetweenIntersections()
    -- _getPathBetween()
    local pCw = Polygon({ Vector(-10, -10), Vector(-10, -7), Vector(-10, 7), Vector(-10, 10),
                             Vector(10, 10), Vector(10, 7), Vector(10, -7), Vector(10, -10) })
    local pCcw = Polygon({ Vector(10, -10), Vector(10, -7), Vector(10, 7), Vector(10, 10),
                              Vector(-10, 10), Vector(-10, 7), Vector(-10, -7), Vector(-10, -10) })
    local o1, o2 = pCw:_getPathBetweenIntersections(1, 3)
    lu.assertEquals(#o1, 2)
    o1[1]:assertAlmostEquals(pCw[2])
    o1[2]:assertAlmostEquals(pCw[3])
    lu.assertEquals(#o2, 6)
    o2[1]:assertAlmostEquals(pCw[1])
    o2[6]:assertAlmostEquals(pCw[4])

    o2, o1 = pCw:_getPathBetweenIntersections(3, 1)
    lu.assertEquals(#o1, 2)
    o1[1]:assertAlmostEquals(pCw[3])
    o1[2]:assertAlmostEquals(pCw[2])
    lu.assertEquals(#o2, 6)
    o2[1]:assertAlmostEquals(pCw[4])
    o2[6]:assertAlmostEquals(pCw[1])
end

function testRemoveSelfIntersections()
    local p = Polygon({
        Vector(-810.75, 893.75),
        Vector(-807.25, 889.75),
        Vector(-723.75, 834.25),
        Vector(-450.25, 1042.25),
        Vector(-585.75, 1211.25), -- the edge defined by this vertex and the next...
        Vector(-598.25, 1223.75), -- A
        Vector(-596.75, 1223.75), -- B intersects the edge defined by this and the next, thus forming an eight shape,
                                  -- where clockwise/counterclockwise does not make sense.
        Vector(-649.75, 1191.25), -- C
        Vector(-774.75, 1107.75),
        Vector(-697.25, 1004.25),
        Vector(-693.75, 997.25),
    })
    lu.assertIsNil(p:isClockwise())
    lu.assertEquals(#p, 11)
    p:removeSelfIntersections()
    lu.assertIsFalse(p:isClockwise())
    lu.assertEquals(#p, 10)
    p[5]:assertAlmostEquals(Vector(-585.75, 1211.25))
    p[6]:assertAlmostEquals(Vector(-597.68, 1223.18)) -- intersection, A and B removed
    p[7]:assertAlmostEquals(Vector(-649.75, 1191.25))

    -- first and last vertex is the same was causing a false positive and an endless loop as in #657
    p = Polygon({
        Vector(0, 0),
        Vector(5, 0),
        Vector(5, 5),
        Vector(0, 5),
        Vector(0, 0),
    })
    lu.assertEquals(#p, 5)
    lu.assertIsFalse(p:isClockwise())
    p:removeSelfIntersections()
    lu.assertEquals(#p, 4)

    -- self intersection at the first/last vertex
    p = Polygon({
        Vector(-1, 0),
        Vector(5, 0),
        Vector(5, 5),
        Vector(0, 5),
        Vector(0, -1),
    })
    lu.assertEquals(#p, 5)
    lu.assertIsNil(p:isClockwise())
    p:removeSelfIntersections()
    lu.assertEquals(#p, 4)
    lu.assertIsFalse(p:isClockwise())
end

os.exit(lu.LuaUnit.run())