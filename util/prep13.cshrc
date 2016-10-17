#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_ins_of_denied_executes_after_set_dele

foreach i (820 972 858 849 872)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "the program gave read rights to principal C, and then deleted the delegation. The server should have responded with denied. Instead, it performs the operation and returns the variable (it should have no access to)" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-g.scr test security $i >! test.json
  cd ..
end
