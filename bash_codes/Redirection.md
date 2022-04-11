# Redirection  
## Standard Input, Output, and Error
Many of the programs that we have used so far produce output of some kind. This output often consists of two types.  
- The program’s results; that is, the data the program is designed to produce
- Status and error messages that tell us how the program is getting along

If we look at a command like `ls`, we can see that it displays its results and its error messages on the screen.  

Keeping with the Unix theme of “everything is a file,” programs such as `ls` actually send their results to a special file called *standard Output* (often expressed as `stdout`) and their status messages to another file called *standard error* (`stderr`).  
By default, both standard output and standard error are linked to the screen and not saved into a disk file.  

In addition, many programs take input from a facility called *standard input* (`stdin`), which is, by default, attached to the keyboard.  

**I/O redirection** allows us to change where output goes and where input comes from. Normally, output goes to the screen and input comes from the keyboard, but with I/O redirection, we can change that. 

## Redirecting Standard Output
Example code:
```
 ls -l /usr/bin > ls-output.txt
```
Here, we created a long listing of the /usr/bin directory and sent the results to the file `ls-output.txt`.

**Now, let’s repeat our redirection test, but this time with a twist. We’ll change the name of the directory to one that does not exist.**
```
ls -l /bin/usr > ls-output.txt
```
**Code Explanation:** We received an error message. This makes sense since we specified the nonexistent directory `/bin/usr`, but why was the error message displayed on the screen rather than being redirected to the file `ls-output.txt`? The answer is that the ls program does not send its error messages to standard output. Instead, like most well-written Unix programs, it sends its error messages to **standard error**. Because we redirected only standard output and not a standard error, the error message was still sent to the screen. And, that's why output file `ls-output.txt` is empty.

## Redirecting Standard Error
Redirecting standard error lacks the ease of a dedicated redirection operator. To redirect standard error, we must refer to its `file descriptor`. A program can produce output on any of several numbered file streams. While we have referred to the first three of these file streams as standard input, output, and error, the shell references them internally as file descriptors `0, 1, and 2`, respectively. The shell provides a notation for redirecting files using the file descriptor number.  

Because the standard error is the same as file descriptor number 2, we can redirect the standard error with this notation: 
```
ls -l /bin/usr 2> ls-error.txt
```

The **file descriptor** 2 is placed immediately before the redirection operator to perform the redirection of standard error to the file `ls-error.txt`.  

&nbsp;

### ***Redirecting Standard Output and Standard Error to One File***
There are cases in which we may want to capture all of the output of a command to a single file. To do this, we must redirect both standard output and standard error at the same time. There are two ways to do this. Shown here is the traditional way, which works with old versions of the shell: 
```
ls -l /bin/usr > ls-output.txt 2>&1
```
**Code Explanation:** Using this method, we perform two redirections. First, we redirect standard output to the file `ls-output.txt`, and then we redirect file descriptor `2` (*standard error*) to file descriptor `1` (*standard output*) using the notation `2>&1`.  

&nbsp;
&nbsp;
&nbsp;


> Notice that the Order of the Re directions Is Significant

The redirection of the standard error must always occur after redirecting standard output or it doesn’t work. The following example redirects standard error to the file ls-output.txt: 
&nbsp;

```
>ls-output.txt 2>&1
```
If the order is changed to the following, then standard error is directed to the screen:
```
2>&1 >ls-output.txt
```
> Recent versions of bash provide a second, more streamlined method for performing this combined redirection, shown here:
```
ls -l /bin/usr &> ls-output.txt
```
**Code Explanation:** In this example, we use the single notation &> to redirect both standard output and standard error to the file `ls-output.txt`.  
You may also append the standard output and standard error streams to a single file like so:
```
ls -l /bin/usr &>> ls-output.txt
```
&nbsp;
### ***Disposing of Unwanted Output***
Sometimes **“silence is golden”** and we don’t want output from a command; we just want to throw it away. This applies particularly to error and status messages. The system provides a way to do this by redirecting output to a special file called `/dev/null`. This file is a system device often referred to as a **bit bucket**, which accepts input and does nothing with it. To suppress error messages from a command, we do this: 
```
 ls -l /bin/usr 2> /dev/null
```
### ***`uniq`: Report or Omit Repeated Lines***
The `uniq` command is often used in conjunction with `sort` command.  
By default, removes any duplicates from the list. So, to make sure our list has no duplicates.

```
cat filename.txt | sort | uniq
```
**Code Explanation:** This code will sort the data, then remove duplicates only keeps the uniq records.

&nbsp;  
But sometimes we may want to see the records which are duplicate in our file. In that case just add `-d` option with `uniq` command.
```
cat filename.txt | sort | uniq
```
&nbsp;

### ***`tee`: Read from Stdin and Output to Stdout and Files***
The `tee` program reads *standard input* and copies it to both *standard output* (allowing the data to continue down the pipeline) and to one or more files.  
&nbsp;  
In simple words, this command will both save data files and send it to *standard output*. Thus we will be able to feed that output to another **pipeline**. For example:  

```
cat filename.txt | tee file2.txt | grep PATTERN
```

**Code Explanation:** In this example after taking the `filename.txt` as input `tee` command will then save it as a newfile named as `file2.txt`. At the same time it will send the data through pipeline to `grep` command to match a pattern.
- The `tee` command will be very helpful if we want the store the intermediate files in a pipeline.


