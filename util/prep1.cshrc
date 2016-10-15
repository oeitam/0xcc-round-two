#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

foreach i (1010 820 860 913 941)
  echo $i
  mkdir ${i}c_returns_ins_fail
  cd ${i}c_returns_ins_fail
  echo "two return commands at the end of the program, the first one returnining. Should be FAILED." >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/bug1.scr test correctness $i >! test.json
  cd ..
end
