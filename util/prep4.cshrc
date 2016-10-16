#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_den_ins_fail

foreach i (972 918)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "on the 5th program in the test, trying to set delegation on a local variable. instead of returning FAILED, the server returns DENIED" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-c.scr test security $i >! test.json
  cd ..
end
