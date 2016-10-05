
import socket # Socket for server
import signal # sigterm - server startup and shutdown
import sys # exit etc

### Check SIGTERM and exit with the correct return code - see Server startup and shutdown
def SIGTERMhandler(signum, frame):
    sys.exit(0)

signal.signal(signal.SIGTERM, SIGTERMhandler)

ADMIN = ''
ERRORKO = False
HOST = None # Symbolic name meaning all available interfaces

def deflector_shield(testprog):
    global ERRORKO
    testsplit = testprog.lstrip().rstrip().split('\n')
    # Remove comment
    newline = []
    for line in testsplit:
        if line.count('//') > 0:
            if line [0:2] != '//': # comment inside the line - drop line that begins with //
                line = line.split('//')[0]  
                newline.append(' '.join(line.split())) # eliminate all not needed spaces
        else:
            newline.append(' '.join(line.split())) # eliminate all not needed spaces
    # check first word for fast exit
    grammar = ["append", "as", "change", "create", "default", "delete", "exit", "local", "foreach", "return", "set", "***"]
    for line in newline:
        if len(line) == 0:
            ERRORKO = True # find an empty lines
        else: 
            row = line.split()
            #print "row = ", row[0] # for debug
            if row[0] not in grammar:
                ERRORKO = True
            else:
                if row[0] == "set" and len(row) >= 4 and row[2] == "=":
                    if len(row[3]) > 65535:
                        ERRORKO = True
    return newline

### Sanitize command line
#print 'Number of arguments:', len(sys.argv), 'arguments.' # for debug
#print 'Argument List:', str(sys.argv) # for debug
# no argument
if len(sys.argv) < 2:
    sys.exit(255)
# lenght of argument greater than 4096 or more than 2 argument
for i in range(1, len(sys.argv)):
    len_sys_argv_i = len(sys.argv[i])
    if i == 1: # port number
        if sys.argv[i][0]=='0': # port number begins with 0
            sys.exit(255)
    if i == 2: # password for admin
        ADMIN = str(sys.argv[i])
        principal_table["admin"] = str(sys.argv[i])
        #print "admin =", ADMIN for debug
    if len_sys_argv_i > 4096 or i > 2:
        sys.exit(255)
# port integer and between 1024 and 65535
if not sys.argv[1].isdigit():
    sys.exit(255)
else:
    PORT = int(sys.argv[1])
    if (PORT < 1024) or (PORT > 65535):
        sys.exit(255)

### Initialize socket
s = None
for res in socket.getaddrinfo(HOST, PORT, socket.AF_UNSPEC,
                              socket.SOCK_STREAM, 0, socket.AI_PASSIVE):
    af, socktype, proto, canonname, sa = res
    try:
        s = socket.socket(af, socktype, proto)
    except socket.error as msg:
        s = None
        continue
    try:
        s.bind(sa)
        s.listen(0) # one connectionat a time - see Overview
    except KeyboardInterrupt:
        sys.exit(0)
    except socket.error as msg:
        s.close()
        s = None
        continue
    break
if s is None:
    # print 'could not open socket' # for debug
    sys.exit(63) # Port taken - see Server startup and shutdown

### Accept and close connections
while not SHUTDOWN:
    try:
        conn, addr = s.accept()
        conn.settimeout(None) # timeout 30 sec if not ***
        #print 'Connected by', addr # for debug
        progline = []
        cleanprogline = []
        prog = ""
        returnparser = ""
        endcon = True
        while endcon:
            try:
                data = conn.recv(4096) 
                conn.settimeout(30) # timeout
                if data.find("***") != -1: # ADDED IGNORE AFTER ***
                    conn.settimeout(None)
                    #progline.append(data.lstrip().strip("\n")) # strip leading spaces and newlines
                    #progline.append(data.lstrip()) # strip leading spaces 
                    progline.append(data)
                    #cleanprogline = (deflector_shield("\n".join(progline)))
                    cleanprogline = (deflector_shield("".join(progline))) # MR
                    prog = "\n".join(cleanprogline)
                    if len(prog) > 1000000 or ERRORKO:
                        #print "lenght progr: ", len(prog), " errorko= ", ERRORKO # for debug
                        data = "{\"status\": \"FAILED\"}\n"
                        ERRORKO = False
                    else:
                        #print "call parser program: ", prog # for debug
                        returnparser = parse(prog)
                        data = ''
                        if len (returnparser) > 1:
                            if type(returnparser) == type([]):
                                for ret in returnparser:
                                    data += str(ret).replace("'", '"').replace('""', '"') + "\n"
                            else:
                                data = str(returnparser).replace("'", '"').replace('""', '"') + "\n"
                        else:
                            data = str(returnparser).replace("'", '"').replace('""', '"').replace('[','').replace(']','') + "\n"
                    data = data.replace("\"[","[").replace("]\"","]")
                    data = data.replace("\"{","{").replace("}\"","}")
                    
                    progline = []
                    cleanprogline = []
                    print "RETURNING: ", data
                    conn.send(data)
                    endcon = False # data ended, close connection
                    if SHUTDOWN: 
                        conn.close()
                        sys.exit(0) # - see Command (<cmd>)
                else:
                    progline.append(data) # single rows input
            except socket.timeout:
                data = '{"status": "TIMEOUT"}\n'
                conn.send(data)
                progline = []
                cleanprogline = []
                conn.settimeout(None)
                endcon = False
            except KeyboardInterrupt:
                conn.close()
                sys.exit(0) # - see Server startup and shutdown
        conn.close()
    except KeyboardInterrupt:
        sys.exit(0) # - see Server startup and shutdown
sys.exit(0) # - see Command (<cmd>)
