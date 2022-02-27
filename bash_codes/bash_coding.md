
## Bash script variable rule
- `#! /path/to/interpretor`
For bash,
```bash
#!/bin/bash
```
- Do not put any space befor or after of the `=` sign during declaring a variable in bash
```bash
VARIABLE_NAME="Value"
```
- We can access varable by;
```bash
$VARIABLE_NAME
#or, by
${VARIABLE_NAME}
```
The later one (with curly braces) is useful we want to use this variable with other data.

**N.B: As my opinion it is good practice to always use curly braces with variable.**

- To assign the output of a command to a variable:
```bash
VARIABLE_NAME=$(command)\
```



## If statesment in bash

```bash
if [condition-is-true]
then
	command 1
	command 2
	command N
fi
```

## if/else statement
```bash
if [ condition-is-ture]
then
	command N
else
	command N
fi
```

## if/elif/else statement
```bash
if [ condition-is-ture]
then
	command N
elif [condition-is-true]
	command N
else
	command N
fi
```

## For loop
```bash
for x in ITEM_1 ITEM_N
do
	command 1
	command 2
	command N
done
```
**We can also store the items in a VARIABLE and use that in for loop**
```bash

VARIABLE="red green blue"

for x in $VARIABLE
do
	command 1
	command 2
	command N
done
```

## Positional Parameters



```bash
script.sh parameter1 parameter2 parameter3
```

Positional parameters are variable that contain the contents of the command line.

The variables are `$0 to #9`

Here,
```bash
	$0:"script.sh"
	$1:"parameter1"
	$2:"parameter2"
	$3:"parameter3"
```
We can access all the positional parameters starting as `$1` to `$9` by using the special variable `$@`.

 # Accepting User Input (STDIN)
The read command accepts STDIN.

```bash
read -p "A prompt to display" variable
```

 # Exit Status / Return Code
 - Every time we run a code it returns an exit status
 - Range from 0 to 255
 - 0 = success
 - Other than zero = error condition
 - Use for error checking
 - Use `man` or `info` to find the meaning of the exit status


 ## Checking the Exit status
 - `$?` contains the return code of the previosuly executed command.
 - **NB:** For the **fish** shell use ``$status`` instead of `$?` for exit status.
 An example:
 ```bash
 # First run
 ls /not/here
 
 # Then run
echo "$?"
# Or, in fish shell
echo "$status"

## output will be 
2
```

## && and ||
- && = AND
	- e.g.; `mkdir /tmp/bak $$ cp test.txt /tmp/bak/`
	- The command followed by double ampercend (&&) will work only if the previous command execute successfully
- || = OR
	- e.g.; `cp test.txt /tmp/bak/ || test.txt /tmp `






