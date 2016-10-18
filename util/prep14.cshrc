#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_server_crush

foreach i (858)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "the server does not retun, refuse teh connection and does not return the needed results. crush (?)" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/cpw-1.scr test security $i >! test.json
  cd ..
end
