
## `for loop` Syntax
```bash
for VARIABLE in 1 2 3 4 5 .. N
do
    command1
    command2
    commandN
done
```
OR
```bash
for VARIABLE in file1 file2 file3
do
    command1 on $VARIABLE
    command2
    commandN
done
```
OR
```bash
for OUTPUT in $(Linux-Or-Unix-Command-Here)
do
    command1 on $OUTPUT
    command2 on $OUTPUT
    commandN
done
```

## Examples

### loop by count
```bash
#!/bin/bash
for i in 1 2 3 4 5
do
   echo "Welcome $i times"
done
```

Sometimes you may need to set a step value (allowing one to count by two’s or to count backwards for instance).  
**Bash v4.0+ has inbuilt support for setting up a step value using `{START..END..INCREMENT}` syntax:**
```bash
#!/bin/bash
echo "Bash version ${BASH_VERSION}..."
for i in {0..10..2}
do
  echo "Welcome $i times"
done
```
Sample outputs:
```
Bash version 5.1.16(1)-release...
Welcome 0 times
Welcome 2 times
Welcome 4 times
Welcome 6 times
Welcome 8 times
Welcome 10 times
```
We can also use `seq` command in this purpose. There is no good reason to use an external command such as seq to count and increment numbers in the for loop, hence it is recommend that you avoid using seq. **The builtin command are fast.**
```bash
#!/bin/bash
for i in $(seq 1 2 20)
do
   echo "Welcome $i times"
done
```
>> NB: The seq command print a sequence of numbers and it is here due to historical reasons. The following examples is only recommend for older bash version. All users (bash v3.x+) are recommended to use the above syntax.


### Three-expression bash for loops syntax 
This type of for loop share a common heritage with the C programming language. It is characterized by a three-parameter loop control expression; consisting of an initializer (EXP1), a loop-test or condition (EXP2), and a counting expression/step (EXP3).

```bash
for (( EXP1; EXP2; EXP3 ))
do
    command1
    command2
    command3
done
```
**The C-style Bash for loop**
```bash
for (( initializer; condition; step ))
do
  shell_COMMANDS
done
```
**A representative three-expression example in bash as follows:**
```bash
#!/bin/bash
# set counter 'c' to 1 and condition 
# c is less than or equal to 5
for (( c=1; c<=5; c++ ))
do 
   echo "Welcome $c times"
done
```
Sample output:
```
Welcome 1 times
Welcome 2 times
Welcome 3 times
Welcome 4 times
Welcome 5 times
```
#### Creating infinite loop
Infinite for loop can be created with empty expressions, such as:
```bash
#!/bin/bash
for (( ; ; ))
do
   echo "infinite loops [ hit CTRL+C to stop]"
done
```
