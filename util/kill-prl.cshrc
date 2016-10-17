#! /usr/bin/tcsh -f

# ps -a
foreach i ( `ps -a | grep perl | cut -c1-5` )
  echo $i
  kill -9 $i
end



