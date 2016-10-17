#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_ret_nothing_ins_denied

foreach i (833 998 913)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "the last program tries to set Principal C as default delegator, performed by pincipal C. this should be denied, but the server just returns nothing" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec6-d.scr test security $i >! test.json
  cd ..
end
