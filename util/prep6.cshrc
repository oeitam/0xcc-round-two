#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_does_not_return

foreach i (840)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "when running the test, at some point the connection is reset by the server (crush?)" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-c.scr test security $i >! test.json
  cd ..
end
