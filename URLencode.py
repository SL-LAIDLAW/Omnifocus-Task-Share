#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import string
import re
import xerox

rawData = (xerox.paste())
rawData = rawData.encode('utf-8')

Output = str((rawData))


Output = Output.replace(' ', '%20')
Output = Output.replace('\n', '%0A')



print(Output)
