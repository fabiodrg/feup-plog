from generator import generate, make_config
import json


def writeFile(test):
    with open("test.pl", "w", encoding="utf-8") as file:
        file.write(test)
        file.close()


list = generate(make_config(4, 4))


writeFile("" + json.dumps(list) + "")

