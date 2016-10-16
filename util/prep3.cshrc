#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=c_set_dele_ins_fail

foreach i (823)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "on setting delegation for a local variable, performes the set, instead of responding with FAILED" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-c.scr test correctness $i >! test.json
  cd ..
end
