#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_den_on_set_of_command

foreach i (1007 837)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "the last program in the test needs to do operations and retrun a value. instead - the server returns DENIED" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/rep-2.scr test security $i >! test.json
  cd ..
end
