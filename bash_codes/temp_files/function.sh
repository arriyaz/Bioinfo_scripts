# Declaring the function
#!/bin/bash
function hello(){
	for NAME in $@
	do
		echo "Hei $NAME"
	done
}

# Calling the function
hello Riyaz James Jhon