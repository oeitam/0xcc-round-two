#! /usr/bin/tcsh -f

echo "#########"
find . -name "*#*"
find . -name "*#*" -exec rm {} \;
echo "check 1"
find . -name "*#*"
echo "check 2"


echo "~~~~~~~~~~~"
find . -name "*~*"
find . -name "*~*" -exec rm {} \;
echo "check 1"
find . -name "*~*"
echo "check 2"

