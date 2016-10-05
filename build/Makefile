# makefile 0xCC
#

PYTHON=/usr/bin/python

all: d2server


server: server.py
	$(PYTHON) -m compileall server.py ; fi
	cp server.pyc server ; fi
	chmod 755 server	
d2server:
	echo "#!/usr/bin/python" > server
	cat TDParserBase.py server.py >> server
	chmod 755 server
test:
	echo "#!/usr/bin/python" > test.py
	cat TDParserBase.py Regression.py | grep -v 'from RegressionTest' >> test.py
	chmod 755 test.py

clean:
	rm -f *.pyc *.pyo server test

