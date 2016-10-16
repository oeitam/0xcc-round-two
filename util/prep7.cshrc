#! /usr/bin/tcsh -f

echo "Starting"

cd /home/ubuntu/bibifi/repo/12/0xcc-round-two/break
pwd

set name=s_server_non_responsive_crushes

foreach i (833 998 837 918 909 1010 1028 972)
  echo $i $name
  mkdir ${i}${name}
  cd ${i}${name}
  echo "when running the test, at some point the connection is reset by the server (crush?)" >! description.txt
  /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/ser.py /home/ubuntu/bibifi/repo/12/0xcc-round-two/util/sec5.scr test security $i >! test.json
  cd ..
end
