#! /usr/bin/tcsh -f

# ps -a
foreach i ( `ps -a | grep python | cut -c1-5` )
  echo $i
  kill -9 $i
end


