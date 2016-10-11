#! /usr/bin/python

# help in making a regular program into a test teh oracle understands

import os
import sys
import re

def serializeProgram(program):

    plist = list(program)
    l = len(plist)

    for i in range(l-1,-1,-1):
        if (ord(plist[i]) == 10): # new line
            plist[i] = "n"
            plist.insert(i,chr(92)) # "\"
        if (ord(plist[i]) == 34): # -"-
            plist.insert(i,chr(92)) # "\"

        #print "%2d: -%s-%d-" % (i,alist[i],ord(alist[i]))

    return ("".join(plist))

#############################

filename = sys.argv[1]
print filename


progs1 = []
progs2 = []
f = open(filename,'r')
build_prog = ""
for line in f:
    match = re.search(r'^\s*$', line)
    if match:
        continue
    print line.rstrip("\n")
    build_prog = build_prog+line
    match = re.search(r'^\*\*\*', line)
    if match:
        progs1.append(serializeProgram(build_prog))
        progs2.append(build_prog)
        #print "--" + build_prog
        build_prog = ""

f.close()

for p in progs1:
    print p
