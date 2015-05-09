#!/usr/bin/env python3

import csv
from subprocess import call
import os

with open('respondents.csv') as csvfile:
	reader = csv.reader(csvfile)
	headers = next(reader, None)
	for row in reader:
		respondent = row[0]
		repo = row[1]
		call([os.getcwd() + "/gitter.sh", repo, respondent])