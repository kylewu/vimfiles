#!/bin/bash

find -X $1 -name \*.py -print | xargs ./ptags.py
