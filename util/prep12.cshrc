#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_del_all_response_with_denied

foreach i (904 1009 1007 849 872 937)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "after delegation of all for A to B, the server denies access to the delegated variables. The oracle allows." >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-f.scr test security $i >! test.json
  cd ..
end
