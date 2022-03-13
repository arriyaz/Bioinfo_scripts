
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

- The variables are `$0 to #9`
- `$@` contains all the parameters
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
	- In this case the command after double pipe will executes only if the previous one failed.
## The semicolon
Separate commands with semicolon to ensure they all get executed.
- Used to chain multiple command on a sinle line.

E.g;
```bash
rm -rf MyDir; mkdir MyDir

# Same as
rm -rf MyDir
```
**Code Explanation:** Here,

- If `MyDir` folder is already exists in current direcotry `rm` command will remove it, and then `mkdir` will create it again.
- If `MyDir` is not present, then `rm` will fail and then `mkdir` will perform it's role.
- Because `;` does not check exit status.

Thus adding `;` between two or command ensures the execution of all commands. And even if one command fail, it will not prevent other commands from being executed.


## Exit command
We can use `exit` command and explicitly define the return code in our script.
```bash
exit 1
exit 2
.....
exit 255
etc
```
As for example let's consider the following script:
```bash
#!/bin/bash

HOST="gle.com"

ping -c 1 $HOST
RETURN_CODE=$?

if [ "$RETURN_CODE" -ne "0" ]
then
    echo "$HOST unreachable"
    exit 1
fi

echo "$HOST reachable"
exit 0
```
**Code Explanation:** Here,
- If the url stored in `$HOST` is not reachable the `RETURN_CODE` will be not equal(`-ne`) to zero. So the `if` statement will be true and it will print `gle.com unreachable`. 
- Then the script will terminate as we used `exit 1` command inside the `if` statement.
- That's why `gle.com reachable` text will not be printed.

**We can define the meaning of a return code in the exit command and add it to our script.**

# Function

## Creating a function
We can create functions in two ways in bash
```bash
# First method
function function-name () {
	# Code goes here
}
```
```bash
# Second method
function-name() {
	# Code goes here
}
```
```bash
# Call the function
function-name
```
<font color = red> **NB: While calling function don't use the parenthesis.** </font>

## Functions can call other functions.
Let's consider a simple script
```bash
#!/bin/bash
function hello(){
    echo "Hello!"
	now
}
function now() {
	echo "It's $(date +%r)"
}

hello
```
**Code Explanation:** Here,
- We defined two functions: `hello()` and `now()`
- By definition funtion must be defined before calling it. Here in this example we called `now()` function inside `hello()`. Then we declared the `now()` function.
- So, a question can come to our mind that we broke the rule of "Defining a function before calling it".
- No, we didn't break any rule. Before calling `hello` function, we already declared the `now` function.

<font color = red> But don't declare you function as like following exmaple: </font>

```bash
#!/bin/bash
function hello(){
    echo "Hello!"
	now
}

hello

function now() {
	echo "It's $(date +%r)"
}
```
- Here, we calling the `hello` function which use `now` function, and before declaring the `now` function we're calling it. And this will not work.

<font color = blue> Functions can accept positional parameters just like shell scripts. But remember, here $0 = the script itself, not function name. </font>

## Using positional parameters with function
Let's consider a simple example:
```bash
# Declaring the function
#!/bin/bash
function hello(){
	echo "Hei $1"
}

# Calling the function
hello Riyaz

----------
# Output
Hei Riyaz
```
Let's take this simple script to another level.
```bash
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

----------
# Output
Hei Riyaz
Hei James
Hei Jhon
```
### Variable scope
- By default, variables are global.
	- That means, variables and its values can be access anywhere in the script, including in any function.
- But beaware, variables have to be defined before use in function.

### Local Variables
A local variable is a variable that can only be accessed within the function in which it was declared.
- Create using the `local` keyword.
	- `local LOCAL_VAR=1`
- Only functions can have local variable.
- <font color = magenta>**Best paractice to keep variables local in functions.**</font>

## Exit Status (Return Codes) in Functions
Functions are like shell scripts within a shell script.
- Just like a shell script functions also have exit status which is sometime called as `RETURN_CODES`
- Explicitly
	- `return <RETURN_CODE>`
- If no return statement is used then the exit status of the function is the exit status of the last command executed in that function.
- For function, 
	- Valid exit codes range from 0 to 255
	- 0 = success
	- $? = the exit status (`$status` for fish shell)


## Shell Script Order and Checklist
1. Shebang (`#!/bin/bash`)
2. Comments/file header
3. Global variables
4. Functions
	- Use `local` variables
5. Main script content
6. Exit with an exit status
	- exit `<STATUS>` at various exit points.

## Wildcard
In the case of `wildcard` there is another concept called `globbing`.  
- **Globbing** expands the wildcard pattern into a list of files and/or directories (PATHS).

Most commonly used wild cards:
- `*`- matches zeor or more character
	- *.txt
	- a*
-  `?`- matches exactly one character
	- ?.txt
	- a?
	- `ls ?` will print all the files which name is `one character` in length.
	- If you want to print the names with **two character** long use `ls ??`.


### Character Classes
- `[]`- A character class
	- Matches any of the characters included between the brackets.
	- Mathces exactly one character.
	- For example; `ca[nt]*` can match:
		- can
		- cat
		- candy
		- catch, etc.
	- `[!]`- Matches any of the characters NOT included between the brackets. And matches exactly one character.
	- For example `[!aeiou]*` can match:
		- baseball
		- cricket

	(These two examples matched because first character of these examples do not mathch `a, e, i, o, u`.)

 ### Wildcards - Ranges
 - Use two character separated by a hyphen to create a range in a character class.
 - `[a-g]*`
	- Matches all files that start with `a, b, c, d, e, f, or g`.

- `[3-6]*`
	- Matches all files that start with `3, 4, 6, or 6`.

### Named Character Classes
Instead of creating our own ranges we can use predefined named character classes.  
Following are most commonly used character classes:
- `[[:alpha:]]`	: mathches alphabetic letters ( both lower and uppercase).
- `[[:alnum:]]`	: mathces alphabet (lower and uppercase) and numbers.
- `[[:digit:]]`	: numbers and decimal from `0` to `9`.
- `[[:lower::]]`: lowercase letters.
- `[[:space::]]`: matches space characters like space, tab, newline.
- `[[:upper:]]`	: uppercase letters.


### Matching Wildcard patterns
- `\` : escape character.
	- Use if you want to match a wildcard character.
- For example, match all files that end with a question mark:
	- `*\?`
	- will match all words end with `?` mark, e.g., `done?`



### Wildcard in Shell Scripts
Lets see an example to use **wildcard in a for loop**:


```bash
#!/bin/bash

cd /var/www
for FILE in *.html
do
	echo "Copying $FILE"
	cp $FILE /var/www-just-html
done
```

Moreover instead of navigating to `/var/www/` directory by `cd` command, let's use another approach:
```bash
for FILE in /var/www/*.html
do
	echo "Copying $FILE"
	cp $FILE /var/www-just-html
done
```

# Case Statements
Alternative to if statemens:
- `if["$VAR"="one"]`
- `elif["$VAR"="two"]`
- `elif["$VAR"="three"]`
- `elif["$VAR"="four"]`

May be easier to read than complex if statesments

## Template to create a case statement

```bash
case "$VAR" in
	pattern_1)
		# Commands go here.
		;;
	pattern_2)
		# Commands go here.
		;;
	pattern_N)
		# Commands go here.
		;;
esac
```
- Thus we can use as much pattern as we want.

Let's see an example:
```bash
case "$1" in 
	start)
		/usr/sbin/sshd
		;;
	stop)
		kill $(cat /var/run/sshd.pid)
		;;
esac
```
**Code Explanation**: 
- Here the `case` statement examine the value of first argument (`$1`). We will provide this argument during running our shell script.
- If `$1` equal to `start` then `/usr/sbin/sshd` will be executed.
- If `$1` equal to `stop` then the `kill` command will be executed.
- If `$1` doesn't match `start` or `stop` then nothing happens and shell script continues after the case statement.

**NB: `case` statement is `case-sensitive`. So be cautious about the UPPER-CASE or lower-case letter of the `patterns`.**

