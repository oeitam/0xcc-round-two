#! /usr/bin/tcsh -f

# ps -a
foreach i ( `ps -a | grep server | cut -d' ' -f1` )
  echo $i
  kill -9 $i
end


