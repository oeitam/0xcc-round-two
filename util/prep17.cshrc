#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_denied_ins_set_local

foreach i (918 1010)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "the test executes a bunch of local variable set (3rd program). the server responds with DENIED and not diopng teh SET LOCAL " >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/rep-1.scr test security $i >! test.json
  cd ..
end
