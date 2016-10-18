#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_pw_err_gets_DEN_ins_FAIL

foreach i (900 931 913 946)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "after changing the principal PW, the program tries to access with teh old PW. the server returns with DENIED instead of teh expected FAILED (like the oracle does)" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/cpw-1.scr test security $i >! test.json
  cd ..
end
