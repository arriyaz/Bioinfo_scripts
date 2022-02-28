

read -e -p 'provide the name: ' name 

myname=$(echo $name | sed 's/.sh//g')


mkdir ${myname}


