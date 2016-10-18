#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_exits_as_non_admin

foreach i (1010 1009 840 1007 860)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "the last program has an exit command by a non administrator principal. the server should have responded with DENIED and not exit. this server, responds with EXITING and exists." >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/cpw-1.scr test security $i >! test.json
  cd ..
end
