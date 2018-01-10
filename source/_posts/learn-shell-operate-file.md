title: Linux学习之文件操作
date: 2015-10-31 21:01:59
tags: [linux,文件,个人学习翻译]
---

**The Linux Command Line** 学习翻译 

### mkdir

The mkdir command is used to create directories.It works like this:

mkdir命令是用来创建目录的，这样使用：

> mkdir directory...

**A note on notation:** When three periods follow an argument in the description of a command(as above),it means that the argument can be repeated,thus:

注意表示法：当遇见一个后面有三个圆点的命令（如上所示），这表示那个参数可以重复：

>   tmp  mkdir max
➜  tmp  ls
a.json                   max                      server.js

>➜  tmp  mkdir max1 max2 max3
➜  tmp  ls
a.json                   max1                     reade_file.js
clone_obj.js             max2                     server.js
getIp.js                 max3                     

### cp

The cp command copies files or directories. It can be used two different ways:

cp命令，复制文件或目录，它有两种使用方法：

> cp file1 file2

to copy the single file or directory "file1" to file or directory "file2" and :

复制单个文件或目录，和：

> cp file... directory

to copy multiple files(either files or directories)into a direcotory.

复制多个文件或目录到一个目录下。

### mv
The mv command performs both file moving and file renaming, depending on how it is used. In erther case,the original filename no longer exists after the operation. mv is used in much the same way as cp:

mv命令可执行文件移动以及文件重命名两种任务，这依赖于如何使用它。任何一种情况下，在此操作之下原始文件都将不再存在。mv命令使用方法同cp一样：

> mv file1 file2

> mv file1 file2 file3 code

### rm

The rm command is used to remove(delete) files and directories:

rm命令用来删除文件或者目录：

> rm file...

### Options
| Option | meaning |
|--------|--------|
|-r --recursive        |    recursive operation    |
|-f --force        |    force operation    |


### ln

The ln command is used to create either hard or symbolic links. It is used in one of two ways:

ln命令用来创建硬链接，也可以创建符号链接。可以用其中一种方法使用它：

> ln file link

to create a hard link, and:

创建硬链接，和：

> ln -s item link

to create a aymbolic link "item" is erther a file or a directory.

创建符号链接，“item”可以是一个文件或是一个目录。

### hard link

Hard links are the original Unix way of creating links, compared to symbolic links, which are more modern. By default, every file has a single hard link that gives the file its name. When we create a hard link, we create an additional directory entry for a file. Hard links have two important limitations:

硬链接最初是Unix创建的一种链接方式，和符号链接比起来，而符号链接更加现代.在默认方式下，每个文件有一个硬链接，这个硬链接就是文件的别名。当我们创建一个硬链接时，我们也就为这个文件创建一个额外的入口。硬链接有两个重要的局限性：

1. A hard link cannot reference a file outside its own file system. This means a link may not reference a file that is not on the same dis partition as the link itself.
2. A hard link may not reference a directory.

1. 一个硬链接不能关联一个它所在文件系统之外的文件。这是说一个链接不能关联与链接本身不再同一个磁盘分区上的文件。
2. 一个硬链接不能关联一个目录。

### symbolic link

Symbolic links were created to overcome the limitations of hard links. Symbolic links work by creating a special type of file that contains a text pointer to the referenced file or directory.In this regard, they operate in much the same way as a Windows shortcut though of course, they predate the Windows feature by many years.

符号链接的创建是为了克服硬链接的局限性。符号链接通过创建一个包含指向关联的文件或目录的文本指针的特别的文件类型来工作。在这一方面，他们和Windows的快捷方式差不多，当然，符号链接早于Windows的快捷方式很多年。

A file pointed to by a symbolic link, and the symbolic link itself are largely indistinguishable from one another. For example, if you write some something to symbolic link, the referenced file is also written to. However when you delete a symbolic link, only the link is deleted, not the file itself. If the file is deleted before the symbolic link, the link will continue to exist, but will point to nothing. In this case, the link is said to be broken. In many implementations, the ls command will display broken links in a distinguishing color, such as red, to reveal their presence.

一个符号链接指向一个文件，而这个符号链接本身与其他的符号链接几乎没有区别。比如，如果你向一个符号链接里写入一些东西，那么关联的文件也会被写入。然而当你删除一个符号链接时，仅仅这个链接被删除，不会影响到文件本身。如果这个文件在符号链接之前被删除了，这个链接将会继续存在，但不会指向任何东西。这种情况下，这个链接被称为坏链接。在许多实现中，ls命令会以可区分的颜色来显示这些坏链接，比如红色，来显示他们的存在。







