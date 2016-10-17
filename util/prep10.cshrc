#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_after_dele_2_anyone_denied

foreach i (823 849 1009 820 941)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "after delegation to anyone for a few rights on variables, the target responds with DENIED, that is, denies access to vaiables that should have had access" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-e.scr test security $i >! test.json
  cd ..
end
