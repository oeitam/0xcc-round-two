#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_denid_ins_append_after_def_delel

foreach i (872 904)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "after changing the default delegator, the append to Clist should work. the server does not do that, and instead issues a DENIED status" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-e.scr test security $i >! test.json
  cd ..
end
