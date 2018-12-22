import random
from point import Point, createPointList, generatePair


class Config(object):
    size = 0
    number = 0

    # The class "constructor" - It's actually an initializer
    def __init__(self, size, number):
        self.size = size
        self.number = number


def make_config(size, number):
    config = Config(size, number)
    return config


def generate(config):
    pointList = []
    xCoord = random.randint(0, config.size)
    yCoord = random.randint(0, config.size)
    pairList = []
    # for item in range(config.number):
    # xCoord = random.randint(0, config.size)
    # yCoord = random.randint(0, config.size)

    # HousePuzzle.append([xCoord, yCoord])*/
    newNumber = config.number / 2
    createPointList(pointList, config.size, newNumber)

    for item in pointList:
        generatePair(item, pairList, config.size, 2)
        print("Original List {}".format(item))


def createDistance(pointList, number):

    number = number - 1
    if number == 0:
        return

    if len(pointList) == 0:
        firstPoint = Point(5)
        pointList.append(firstPoint)
        createDistance(pointList, number)

    secondPoint = Point(5)
    if secondPoint != pointList[0]:
        pointList.append(secondPoint)
        createDistance(pointList, number)


def createList(list, size, number):

    if number == 0:
        return

    xCoord = random.randint(0, size)
    yCoord = random.randint(0, size)

    if [xCoord, yCoord] is list:
        createList(list, size, number)

    list.append([xCoord, yCoord])

    createList(list, size, number - 1)


# generate(make_config(4, 4))

