## Options and Arguments of Shell code

This brings us to a very important point about how most commands work. Commands are often followed by one or more options that modify their behavior and, further, by one or more arguments, the items upon which the command acts. So, most commands look kind of like this:
```
command -options arguments
```
## Common Options `ls` command
| Option | Long option      | Description                                                                                                                                                                                                                   |
| :----- | :--------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| -a     | --all            | List all files, even those with names that begin with a period, which are normally not listed (that is, hidden)                                                                                                               |
| -A     | --almost-all     | Like the -a option except it does not list . (current direc- tory) and .. (parent directory).                                                                                                                                 |
| -d     | --directory      | Ordinarily, if a directory is specified, ls will list the contents of the directory, not the directory itself. Use this option in conjunction with the -l option to see details about the directory rather than its contents. |
| -F     | --classify       | This option will append an indicator character to the end of each listed name. For example, it will append a forward slash (/) if the name is a directory.                                                                    |
| -h     | --human-readable | In long format listings, display file sizes in human- readable format rather than in bytes.                                                                                                                                   |
| -l     |                  | Display results in long format.                                                                                                                                                                                               |
| -r     | --reverse        | Display the results in reverse order. Normally, ls dis- plays its results in ascending alphabetical order.                                                                                                                    |
| -S     |                  | Sort results by file size.                                                                                                                                                                                                    |
| -t     |                  | Sort by modification time.                                                                                                                                                                                                    |

## Determining a File’s Type with `file` command
```
file filename
```
## Viewing File Contents with `less`
```
less filename
```
**Common less commands:**
| Command             | Action                                                |
| :------------------ | :---------------------------------------------------- |
| page up  or b       | Scroll back one page                                  |
| page down  or space | Scroll forward one page                               |
| Up arrow            | Scroll up one line                                    |
| Down arrow          | Scroll down one line                                  |
| G                   | Move to the end of the text file                      |
| 1G or g             | Move to the beginning of the text file                |
| /characters         | Search forward to the next occurrence of characters   |
| n                   | Search for the next occurrence of the previous search |
| h                   | Display help screen                                   |
| q                   | Quit less                                             |

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
VARIABLE_NAME=$(command)
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
then
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

## Options or Flags
To use options or flags in our bash script we can use `getopts` command.  
In the following example we will use this command two create two flags `-n` for **name** and `-m` for **mode**.  
Based on our chosen mode, the script will run different code.

```bash
#!/user/bin/bash

while getopts n:m: flag
do
case "${flag}" in 
	n) name=${OPTARG};;
	m) mode=${OPTARG};;
esac

done

if [ "$mode" == 'happy' ]
then
    echo "Hi! ${name}, you're in happy mode."

elif [ "$mode" == 'sad' ]
then
    echo "Hi! ${name}, you're in sad mode."

else [ "$mode" != 'happy' ] || [ "$mode" != 'sad' ]

    echo "I don't know your mode."

fi
```
## Usage example
```bash
script.sh -n John -m happy
```
**Output**
```
Hi! John, you're in happy mode.
```


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
	- e.g.; `mkdir /tmp/bak && cp test.txt /tmp/bak/`
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
mkdir MyDir
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

| Wildcard      | Meaning                                                          |
| :------------ | :--------------------------------------------------------------- |
| *             | Matches any characters                                           |
| ?             | Matches any single character                                     |
| [characters]  | Matches any character that is a member of the set characters     |
| [!characters] | Matches any character that is not a member of the set characters |
| [[:class:]]   | Matches any character that is a member of the specified class    |


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

**Wildcards Example**
| Pattern                | Matches                                                                   |
| :--------------------- | :------------------------------------------------------------------------ |
| *                      | All files                                                                 |
| g*                     | Any file beginning with g                                                 |
| b*.txt                 | Any file beginning with b followed by any characters and ending with .txt |
| Data???                | Any file beginning with Data followed by exactly three                    |
|                        | characters                                                                |
| [abc]*                 | Any file beginning with either an a, a b, or a c                          |
| BACKUP.[0-9][0-9][0-9] | Any file beginning with BACKUP. followed by exactly three numerals        |
| [[:upper:]]*           | Any file beginning with an uppercase letter                               |
| [![:digit:]]*          | Any file not beginning with a numeral                                     |
| *[[:lower:]123]        | Any file ending with a lowercase letter or the numerals 1, 2, or 3        |


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

# ln—Create Links
The ln command is used to create either hard or symbolic links. It is used in one of two ways.  
The following creates a hard link:
```
ln file link
```
The following creates a symbolic link:
```
ln -s item link
```
where item is either a file or a directory.
-  With GNOME, holding the ctrl+shift keys while dragging a file will create a link rather than copying (or moving) the file.


**Soft Links:** In Linux, a soft link, also known as a symbolic link, is a special sort of file that points at a different file. In Windows vocabulary, you could think of it like a shortcut. Because the connection is a logical one, and not a duplication, soft links can point at entire directories or link to files on remote computers. Hard links cannot do this.

**Hard Links:** 
In the Linux operating system, a hard link is equivalent to a file stored in the hard drive – and it actually references or points to a spot on a hard drive. A hard link is a mirror copy of the original file. The distinguishing characteristic of a hard link from a soft link is that deleting the original file doesn't affect a hard link, while it renders a soft link inoperable.

# Case Statements
Alternative to if statemens:
- `if["$VAR"="one"]`
- `elif["$VAR"="two"]`
- `elif["$VAR"="three"]`
- `elif["$VAR"="four"]`

May be easier to read than complex if statesments.
That's why `case` statements can be used in place of `if` statements.

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
- Pattern can include **wildcards**.
- Can use multiple pattern matching by using `pipeline`.

**Let's see an example:**
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

Now let's make a slightly modified version of the previous script:
```bash
case "$1" in 
	start|START)
		/usr/sbin/sshd
		;;
	stop|STOP)
		kill $(cat /var/run/sshd.pid)
		;;
	*)
		echo "Usage: $0 start|stop" ; exit 1
		;;
esac
```
**Code explanaiton**: 
- Here, we used `start or START` to match both upper and lower case.
- Same for `sotp or STOP` 

### Let's use case statements to create a script that will ask for input from user.
```bash
read -p "Enter y or n: " ANSWER
case "$ANSWER in 
	[yY] | [yY][eE][sS] )
		echo "You answered yes."
		;;
	[nN] | [nN][oO] )
		echo "You answered no."
		;;
	*)
		echo "Invalid answere."
		;;
esac
```
**Code Explanation:**  
Here,
- `[yY]` is a character class, which means that user can input either `lower-case y` or `UPPER-CASE Y`.
- Then, we used pipe sign `|` which means `or`.
- By using `[yY] | [yY][eE][sS]` pattern meant that user can enter either only `y` or full word `yes` and by `[]` character class any case (both lower and upper) of the character.
- Same explanation for `no` pattern.
- `*` means if the anwser is anything other than `yes` or `no` then this case statement will print `Invalid answer.`

# Logging
- Logs are the **who, what, when, where, and why**.
- Output may scroll off the screen.
- Script may run unattendent (via `cron`, etc.)

## Syslog
The linux operating system uses the **syslog** standard for message logging.
- The **syslog** standard uses facilities and severities to categorize messages.
	- **Facilities**: kern, user, mail, daemon, auth, local0, local7
	- **Severities**: emerg, alert, crit, err, warnings, notice, info, debug
> If it is not clear what facility to use, then you can use **user** facility.
> Facilites ranging from **local0** to **local7** are to be used for custom log. These facilites would also be useful for custom written shell scripts.
> The most severe message is an **emergency** message and the least severe message is an **debugging** message.
- Log file locations are configurable:
	- `var/log/message`
	- `var/log/syslog`

## Logging with logger
- The logger utility
- By default cretes user.notice messages.  
`logger "Message"`
- If you want to specify the facility and severity:  
`logger -p local0.info "Message"`  
Here, after `-p` specify **facility.severity** (eg.; `local0.info`)  
- If we want add our script name as tag, **which will help us to search for our script in the log file just to extract messages for our script**, use `-t scriptname`.  
`logger -t myscript -p local0.info "Message"`  
 - If you want to add **PID** or process ID use `-i` option;  
 `logger -i -t myscript "Message"`  
 - During entry to view log message on screen use `-s` option;  
 `logger -s -p local0.info "Message"`

 **To view system log in Ubuntu access system log file by following code.**  
 `cat /var/log/syslog`


We can create a function in our bash script to add log text.

 ```bash
 logit () {
	local LOG_LEVEL=$1
	shift
	MSG=$@
	TIMESTAMP=$(date +"%Y-%m-%d %T")
	if [ $LOG_LEVEL = 'ERROR' ] || $VERBOSE
	then
	 	echo "${TIMESTAMP} ${HOST}
	${PROGRAM_NAME} [${PID}]: ${LOG_LEVEL} ${MSG}"
	fi
 }
```
**Code Explanation:**  
- By `local` function we created a local variable for this function.
- Then `shift` is used to shift the positional parameter to the left. This means the special variable `$@` contains all the positional parameter except the parameter `$1` as we already used it as `$LOG_LEVEL`.
- Then, if the `$LOG_LEVEL` variable is equal to **ERROR** or, `$VERBOSE` is true then echo some message to the screen which include different information along with our log message.
- Instead of using `echo` command, we can use `logger` command to insert log message directly into `syslog`.  

**Here some example of calling this function:**
```bash
## Minimal example
logit INFO "Processing data."

## Another example
command ARGUMENT || logit ERROR "Could not fetch data from $HOST"
```
**Code Explanation:**
- In the first code, we define log level (`INFO`) and then our message.
- But, we can also this function with other command or with script.
- Here, 2nd command denotes; if first command fails `logit` function will generate this error message.

# While Loop
A while is a loop that repeats a series of commands as long as a given **CONDITION** is true.
The **CONDITION** could be;
- some sort of test such as a **VARIABLE**, certain **value**, or to check if a file exists.
- Any **command**; if the command succeed returns a zero exit status the **while** loop will be executed.

## While Loop Format
```bash
while [ CONDITION_IS_TRUE ]
do
	# Commands change the condition
	command 1
	command 2
	.........
	command N
done
```
## Infinite Loops
```bash
while [ CONDITION_IS_TRUE ]
do
	# Commands do NOT change the condition
	command N
done
```
**NB:** May be sometime you may need to intentionally creat a **Infinite Loops**.

### Example 1 - Loop 5 Times 
```bash
INDEX=1
while [ $INDEX -lt 6 ]
do
	echo "Hello this is index $INDEX"
	((INDEX++))
done
```
**Code Explanation:** Here,  
- `-lt` means less than
- `((INDEX++))` is called **Arithmatic Expansion**, where 1 will be added after each iteration.
>> When you inclose a mathmaticcal expression in double parenthesis i.e.; (()), it is called arithmatic expansion.

### Example 2 - Checking User Input
```bash
while [ "$CORRECT" != "y" ]
do
	read -p "Enter your name: " NAME
	read -p "Is ${NAME} correct? " CORRECT
done
```
**Code Explanation:**
- In this case, the code will ask user to insert name and then ask if the the name is correct.
- If the user insert **y**, the loop will be completed.
- But if the user insert anything other than **lowercase y** the loop will continue and again to enter the name and confirmation.

### Example 3 - Check the return code of a command
```bash
while ping -c 1 ge.com > /dev/null
do
	echo "ge.com is responding..."
	sleep 5
done

echo "ge.com is down, continuing the rest of the script."
```
**Code Explanation:** Here,
- We check the connectivity of `ge.com` site. If the site is pingable `while loop` will be executed and repeat the loop until the `ge.com` stops responding.
- `-c 1` means sending one data packets.
- `> /dev/null` is used to redirect ping output to dev null as we don't want to view the ping output.
- If the site doen't respong and ping received no packets then the `while loopl` will break and continue to the rest of the script.

### Example 4 - Reading a file line by line
If you directly use a `while loop` to read a file line by line, it won't work.  
You have to use `read` comand along with `while loop`.
```bash
read -e -p "Insert your file name: " FILE 

LINE_NUM=1
while read LINE
do
	echo "${LINE_NUM} :  ${LINE}"
	((LINE_NUM++))
done < $FILE
```
**Code Explanation**: Here,  
- This code will ask you to provide the file name. Then it will read each line and print in terminal.
- In first `read` command;
	- `-e` is used for auto tab completion.
	- `-p` is used to prompt the asking message in the terminal.
-  `done < $FILE` form this part `while loop` takes input.

### Example 5 - Reading more than one variable 
In the previous example `read` command reads whole line into one variable.  
- But, `read` command supports splitting the data and reads the data into multiple variable.  
- Each variable supplied to the command will store one word or one filed.
- Any lefover word or words will be assigned to the last supplied variable.
```bash
FS_NUM=1
grep ext4 /etc/fstab | while read FS MP REST
do
	echo "${FS_NUM}: file system : ${FS}"
	echo "${FS_NUM}: mount point: ${MP}"
	((FS_NUM++))
done
```
**Code Explanation:** 
- Here, at first we used `command` to extract the lines that contains the word **ext4** from `/etc/fastab` file.
- After piping the `grep` command with `while` loop we used `read` command.
- In this example the `read` command takes three VARIABLE.
	- **FS** : will store first word of the file
	- **MP**: will store second word of the file
	- **REST**: will store all words from the rest of the line.

## break
If you want to exit a loop before it's normal ending you can use the **break** statement.
- The `break` statement exit the loop but it doesn't exit the script. The script will continue after the loop.
- `break` statement can be used with other kinds of loops also.

```bash
while true
do
	read -p "1:Show disk usage. 2: Show uptime. " CHOICE
	case "$CHOICE" in
		1)
			df -h
			break
			;;
		2)
			uptime
			break
			;;
		*)
			echo "Please insert 1 or 2"
			break
			;;
	esac
done
```
**Code explanation**:  
This example creates an infinite loop using `while true`.  
- It asks the user for some input and stores in variable CHOICE.
- A `case` statement is used to take action based on user input.
- If **1** is input then `df` command will be excuted and `break` command will break the loop.
- If **2** is inserted as input `uptime` command will be executed and then `break` command will exit the loop.
- If anything other than `1` or `2` then code will ask to insert correct input and break the loop.

## continue  
Let's imagine a situation we want to update our blast databases. But, if any database is very recetnly updated we want to skip its update as each database is very large in size.  
For this purpose we can use `continue` statement in any loops (like `for loop`, `while loop`).  
- If a condition is met then `continue` statement will skip the commands and restart the next iteration.
- In other words any command that follow the `continue` statement in the loop will not be executed and restart the loop and `while` condition will be examined again.


```bash
mysql -BNe 'show databases' | while read DB
do
	do-backed-up-recently $DB
	if [ "$?" -eq "0" ]
	then
		continue
	fi
	backup $DB
done
```
**Code explanation**: Here, we loop through a list of **mysq** database.
- `-B` to desable ASCII table output, that mysql normaly displays.
- `-N` suppresses the column name in the output. This prevents the header from displayed.
- `-e` will execute the command that followed it.
- Altogether this **mysql** command will show a list of database.
- `while` will read each database name by `read` command and store it in `DB` variable.
- If the database is backed up recently `do-backed-up-recently` will return exit command `0`.
- Here, `do-backed-up-recently` and `backup` are imaginary command, we can use our required command or script.
- So, if the exit code is `0` (`"$?" -eq "0"`) then `continue` statement will skip the `backup $DB` command and restart the loop for next database.
- `$?` contains the return code of the previosuly executed command.
- If `$?` returns non-zero exit status `continue` command inside `if` statement will not be executed, and that's why `backup $DB` will be executed.

# Debugging

## Built in Debugging Help
- `-x` = Print commands as they execute
- After substitutions and expansions
- Called an **x-trace**, tracing, or print debugging
- You can add `-x` to script as follow `#!/bin/bash -x`
- If you want to use debugging from a cetain part of script add `set -x` in that part of the script
	- `set +x` to stop debugging  

A sample example that shows the use of `-x` option.
```bash
#!/bin/bash -x
TEST_VAR="test"
echo "$TEST_VAR"
```
**NB: But for some reason `#!/bin/bash -x` code doen't create result as we expected. So I added `set -x` at the beginnig of the code.**  Like as follow:
```bash
#!/bin/bash
set -x
TEST_VAR="test"
echo "$TEST_VAR"
```
The result will be as follow:
```bash
+ TEST_VAR=test
+ echo test
test
```
**Sometimes you may need to turn off the command printing as they execute add `set +x` in the script. This will stop debugging after this line.**
```bash
#!/bin/bash
set -x
TEST_VAR="test"
echo "$TEST_VAR"
set +x
hostname
```

**Another useful option that can help you to find error in your script is `-e` option**
- `-e` = Exit on error.
- It causes your script immediately if any command returns **non-zero** exit status. In simple word if any line of your code fail to run, then the script will exit.
- Can be combined with other options. Like;
	- `set -ex`
	- `set -xe`
	- `set -e -x`

**NB: To learn more about `set` use;**
```bash
help set | less
```
## Extra Debugging Tips








