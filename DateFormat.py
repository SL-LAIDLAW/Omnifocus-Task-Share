#!/usr/local/bin/python

import requests
import string
import re
import xerox

rawData = str(xerox.paste())

regex = r"(?:(?!..at.*).)*$"


Output = str(rawData)
Output = Output.replace('Monday, ', '')
Output = Output.replace('Tuesday, ', '')
Output = Output.replace('Wednesday, ', '')
Output = Output.replace('Thursday, ', '')
Output = Output.replace('Friday, ', '')




subst = ""


Output = re.sub(regex, subst, Output, 0, re.MULTILINE)

Output = Output.replace(' ', '%2F')


print(Output)
