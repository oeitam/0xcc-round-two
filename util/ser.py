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

# parameters

# 1: file name to serialize
# 2: target of serialization
#    oracle
#    test
#    3: type: security
#             correctness
#             crush
#    4: target biold: 900
#                     840
#                     ...

if len(sys.argv) < 2 :
    print "bad input 1"
    exit()

filename = sys.argv[1]
print "filename: %s" % filename

oracle = 0
test = 0
typ = ""
target = 0

if sys.argv[2] == "oracle":
    oracle = 1
elif sys.argv[2] == "test":
    test = 1
    typ = sys.argv[3]
    target = sys.argv[4]
else:
    print "baf input 2"
    exit()

    

    


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

if oracle == 1 :
    print "{ \"arguments\":[\"6300\",\"admin\"], \"programs\":["
    l = len(progs1)
    #print l
    for i in range(0,l):
        #print i
        print "\"" + str(progs1[i]) + "\"" ,
        if ((l > 1) and (i < (l-1))) :
            print ","
    print "] }"
    exit()

if test == 1 :
    print "{"
    print "    \"type\": \"" + typ + "\","
    print "    \"target_team\": " + str(target) + ","
    print "    \"arguments\": {"
    print "         \"argv\": [\"%PORT%\"],"
    print "         \"base64\": false"
    print "    },"
    print "    \"programs\": ["
    l = len(progs1)
    #print l
    for i in range(0,l):
        #print i
        # print "\"" + str(progs1[i]) + "\"" ,
        print "         {\"program\": \"" + str(progs1[i]) +  "\", \"base64\": false}" ,
        if ((l > 1) and (i < (l-1))) :
            print ","

    print "    ]"
    print "}"
    exit()


