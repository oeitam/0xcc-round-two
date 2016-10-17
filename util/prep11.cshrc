#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_after_del_all_crush

foreach i (840 918)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "after delegation of all for A to B, the test crushes and does not reach the end" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-f.scr test security $i >! test.json
  cd ..
end
