# Instructions and Steps for installing different tools in Linux

In linux distributions like ubuntu many times we have to install different tools and apps. Sometimes in case of some tools it becomes challenging to install that particular tools.
That's why I created this markdown file to document the process that I use to install different apps in my Ubuntu desktop.


## Install Lyx

**Step 1**

Run update command to update package repositories and get latest package information.
```shell
sudo apt-get update -y
```
**Step 2**

Run the install command with -y flag to quickly install the packages and dependencies.
```shell
sudo apt-get install -y lyx
```
Now you have successfully installed **lyx** in your ubuntu computer. But also have to install language package for ***latex*** uses as **lyx** use latex.

**Step 3**
To install **english** language package, run the  following command. For other language you can use similar codes.

```shell
sudo apt-get install -y texlive-lang-english
```
