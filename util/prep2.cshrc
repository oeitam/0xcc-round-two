#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_denied_non_admin

foreach i (900 837 860)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "trying to operate as a non-admin principal, returns DENIED" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-b.scr test security $i >! test.json
  cd ..
end
