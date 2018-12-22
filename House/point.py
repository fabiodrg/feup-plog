import random


class Point(object):
    xPoint = 0
    yPoint = 0
    maxRange = 0
    # connected = Point

    # The class "constructor" - It's actually an initializer
    def __init__(self, maxRange):
        self.maxRange = maxRange
        self.xPoint = random.randint(0, maxRange - 1)
        self.yPoint = random.randint(0, maxRange - 1)

    def getPoint(self):
        return [self.xPoint, self.yPoint]

    def getXPoint(self):
        return self.xPoint

    def getYPoint(self):
        return self.yPoint

    def getConnected(self):
        return Point(self.maxRange)

    def __str__(self):
        return "[{},{}] ".format(self.xPoint, self.yPoint)


def createPointList(list, maxRange, number):

    if number == 0:
        return

    point = Point(maxRange)

    if point in list:
        createPointList(list, maxRange, number)

    if point not in list:
        list.append(point)
        createPointList(list, maxRange, number - 1)


def distanceBetween(pointA, pointB):
    xDistance = pointA.getXPoint() - pointB.getXPoint()
    yDistance = pointA.getYPoint() - pointB.getYPoint()
    return [abs(xDistance), abs(yDistance)]


def generatePair(anotherPoint, pairList, maxRange, distance):

    point = Point(maxRange)
    print("Pair {}".format(point))
    if (
        anotherPoint.getXPoint() != point.getXPoint()
        or anotherPoint.getYPoint() != point.getYPoint()
    ):
        pairList.append(point)
        distance = distanceBetween(point, anotherPoint)

