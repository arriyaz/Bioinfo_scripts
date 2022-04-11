Each time we type a command and press the enter key, bash performs several substitutions upon the text before it carries out our command. We have seen a couple of cases of how a simple character sequence, for example `*`, can have a lot of meaning to the shell. The process that makes this happen is called expansion. With the expansion, we enter something, and it is expanded into something else before the shell acts upon it.  
&nbsp;  

Let’s take a look at the `echo` command with `*`. `echo` is a shell builtin that performs a very simple task. It prints its text
arguments on standard output.

```
$ echo *
Desktop Documents Music Pictures Public Templates Videos
```
**Code Explanation:** So what just happened? Why didn’t echo print `*`? As we recall from our work with wildcards, the `*` character means match any characters in a filename, but what we didn’t see in our original discussion was how the shell does that. The simple answer is that the shell expands the `*` into something else (in this instance, the names of the files in the current working directory) before the `echo` command is executed. When the enter key is pressed, the shell automatically expands any qualifying characters on the command line before the command is carried out, so the `echo` command never saw the `*`, only its expanded result.  

### ***Pathname Expansion***

The mechanism by which wildcards work is called **pathname expansion**.  
For example
```
$ echo [[:upper:]]*
Desktop Documents Music Pictures Public Templates Videos
```
**Code Explanation:** This code prints the contents of the current directory whose name start with a **Uppercase** letter.  
&nbsp;  
**Pathname expansion of hidden files.**  
Let's write view the hidden files.
```
echo .*
```
**Code Explanation:** By default `echo *` will not show the hidden file and folder whose name start with a `.` at the begining of the filename. But the command `echo .*` will print file and foldernames in the current directory.  
&nbsp;  
It almost works. However, if we examine the results closely, we will see that the names `.` and `..` will also appear in the results. Because these names refer to the current working directory and its parent directory, using this pattern will likely produce an incorrect result.

> The `ls` command with the `-A` option (“almost all”) will provide a correct listing of hidden files.
```
ls -A
```



### ***Arithmetic Expansion***

The shell allows arithmetic to be performed by expansion. This allows us to use the shell prompt as a calculator. 
Arithmetic expansion uses the following form:
```
$((expression))
```
where, expression is an arithmetic expression consisting of values and arithmetic operators.  

For example:
```
$echo $((2+2))
4
```
> Arithmetic expansion supports only integers (**whole numbers, no decimals**) but can perform quite a number of different operations. Following table contains a few of the supported operators.

| Operator |                                           Description                                           |
| :------: | :---------------------------------------------------------------------------------------------: |
|    +     |                                            Addition                                             |
|    -     |                                           Subtraction                                           |
|    *     |                                         Multiplication                                          |
|    /     | Division (but remember, since expansion supports only integer arithmetic, results are integers) |
|    %     |                             Modulo, which simply means “remainder”                              |
|    **    |                                         Exponentiation                                          |

- Spaces are not significant in arithmetic expressions, and expressions may be nested. For example, to multiply 5 squared by 3, we can use this:
```
$ echo $(($((5**2)) * 3))
75
```
- Single parentheses may be used to group multiple subexpressions. With this technique, we can rewrite the previous example and get the same result using a single expansion instead of two.
```
$ echo $(((5**2) * 3))
75
```
### ***Brace Expansion***
With **brace expansion**, we can create multiple text strings from a pattern containing braces.  
Here’s an example:
```
$ echo Front-{A,B,C}-Back
Front-A-Back Front-B-Back Front-C-Back
```
- Patterns to be brace expanded may contain a leading portion called a *preamble* and a trailing portion called a *postscript*.
- The brace expression itself may contain
  - a comma-separated list of strings
```
$ echo I love bash_{learning,coding}
I love bash_learning bash_coding
```
> The pattern may not contain unquoted whitespace. In simple word, don't use **space** after comma  

  - a range of integers, or a single character
```
$ echo Number_{1..5}
Number_1 Number_2 Number_3 Number_4 Number_5
```
Some examples of breace expansion:
```
$ echo {01..15}
01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
```
Here is a range of letters in reverse order:
```
$ echo {Z..A}
Z Y X W V U T S R Q P O N M L K J I H G F E D C B A
```
Brace expansions may be nested.
```
$ echo a{A{1,2},B{3,4}}b
aA1b aA2b aB3b aB4b
```
#### **Now, what is the use of brace expansion?**
The most common application is to make lists of files or directories to be created.  
&nbsp;  

For example, if we were photographers and had a large collection of images that we wanted to orga- nize into years and months, the first thing we might do is create a series of directories named in numeric “Year-Month” format. This way, the directory names would sort in chronological order. We could type out a complete list of directories, but that’s a lot of work, and it’s error-prone. Instead, we could do this: 
```
$ mkdir photos_{2020..2022}_{01..12}
$ ls
photos_2020_01  photos_2020_05  photos_2020_09  photos_2021_01  photos_2021_05  photos_2021_09  photos_2022_01  photos_2022_05  photos_2022_09
photos_2020_02  photos_2020_06  photos_2020_10  photos_2021_02  photos_2021_06  photos_2021_10  photos_2022_02  photos_2022_06  photos_2022_10
photos_2020_03  photos_2020_07  photos_2020_11  photos_2021_03  photos_2021_07  photos_2021_11  photos_2022_03  photos_2022_07  photos_2022_11
photos_2020_04  photos_2020_08  photos_2020_12  photos_2021_04  photos_2021_08  photos_2021_12  photos_2022_04  photos_2022_08  photos_2022_12
```
**Tips:** To see a list of available variables, try this:
```
printenv | less
```

### ***Command Substitution***
Command substitution allows us to use the output of a command as an expansion.
```
echo $(ls)
```
 We are not limited to just simple commands. Entire pipelines can be used
```bash
file $(ls -d /usr/bin/* | grep zip)
```
**Code Explanation:** Here, In this example, the results of the pipeline became the argument list of the file command.

- `file` command will determine file types that we will get from subsequent pipeline.
- `ls -d` will list only the directories and then grep will extract results cotaining **zip**.
> There is an alternate syntax for command substitution in older shell programs that is also supported in bash. It uses **backquotes (``)** instead of the **dollar sign and parentheses**.
```bash
 ls -l `which cp`
```
### ***Quoting***
The shell provides a mechanism called quoting to selectively suppress unwanted expansions.

#### **Double Quotes**
The first type of quoting we will look at is double quotes. If we place text inside double quotes, all the special characters used by the shell lose their special meaning and are treated as ordinary characters.
> The exceptions are **$ (dollar sign), \ (backslash), and ` (backtick)**.

- This means that **word splitting, pathname expansion, tilde expansion, and brace expansion** are suppressed

> Remember, **parameter expansion, arithmetic expansion, and command substitution** still take place within double quotes.
```bash
echo "$USER $((2+2)) $(cal)"
```
> Fun fact: the newlines are considered delimiters by the word-splitting mechanism causes an interesting, albeit subtle, effect on command substitution. Consider the following two commands: 
```bash
$ echo $(cal)
February 2020 Su Mo Tu We Th Fr Sa 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
18 19 20 21 22 23 24 25 26 27 28 29
```
```bash
$ echo "$(cal)"
     April 2022       
Su Mo Tu We Th Fr Sa  
                1  2  
 3  4  5  6  7  8  9  
10 11 12 13 14 15 16  
17 18 19 20 21 22 23  
24 25 26 27 28 29 30
```
**Code Explanation:** In the first instance, the unquoted command substitution resulted in a command line containing 38 arguments. In the second, it resulted in a command line with one argument that includes the embedded spaces and newlines.

#### **Single Quotes**
If we need to suppress all expansions, we use *single quotes*.
```bash
echo 'text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER'
```
#### **Escaping Characters**
Sometimes we want to quote only a single character. To do this, we can pre- cede a character with a *backslash*, which in this context is called the escape character. Often this is done inside double quotes to selectively prevent an expansion.
```bash
echo "The balance for user $USER is: \$5.00"
```

#### **Backslash Escape Sequences**
In addition to its role as the escape character, the backslash is used as part of a notation to represent certain special characters called control codes.  
&nbsp;  
Backslash Escape Sequences
| Escape sequence | Meaning                                                  |
| :-------------- | :------------------------------------------------------- |
| \a              | Bell (an alert that causes the computer to beep)         |
| \b              | Backspace                                                |
| \n              | Newline; on Unix-like systems, this produces a line feed |
| \r              | Carriage return                                          |
| \t              | Tab                                                      |

Adding the `-e` option to echo will enable the interpretation of escape sequences. You can also place them inside `$' '`. Here, using the `sleep` command, a simple program that just waits for the specified number of seconds and then exits, we can create a primitive countdown timer: 
```bash
sleep 10; echo -e "Time's up\a"
```
We could also do this:
```bash
sleep 10; echo "Time's up" $'\a'
```

