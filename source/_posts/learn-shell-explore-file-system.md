title: Linux学习之探索文件系统
date: 2015-10-28 20:57:54
tags: [shell,文件,个人学习翻译]
---

**The Linux Command Line** 学习翻译 

### ls 

With it, we can see directory contents and determine a variety of important file and directory attributes.

通过它，我们可以看见目录的内容、重要的文件和目录属性

> ~  ls
Applications   Downloads      Music          VirtualBox VMs company
Desktop        Library        Pictures       build          doc
Documents      Movies         Public         code           system
➜  ~

Besides the current working directory,we can specify the directory to list,like so:

除了当前工作目录外，还可以指定别的目录，像这样：

> ls ./code
N-chat           crawl-info       muying           npm_ref_wf_test  test
cn_admin_backend geoip-cn         node-geoip       npm_test999      tmp
cn_backend       mail_test        nodeclub         personal         zhongzhong
➜  ~

Or even specify multiple directories. In this example we will list both the user's home directory(symbolized by the "~" character) and the code directory:

甚至可以列出多个目录的内容，在这个例子中，将会列出home目录和code目录的内容：

>   ~  ls ~ ./code
./code:
N-chat           crawl-info       muying           npm_ref_wf_test  test
cn_admin_backend geoip-cn         node-geoip       npm_test999      tmp
cn_backend       mail_test        nodeclub         personal         zhongzhong

> /Users/shining3d-fyqj:
Applications   Downloads      Music          VirtualBox VMs company
Desktop        Library        Pictures       build          doc
Documents      Movies         Public         code           system
➜  ~

Most commands use options consisting of a single character preceded by a dash, for example, "-l", but many commands, including those from the GUN project, also support long options, consisting of a word preceded by two dashes. Also, many commands allow multiple short options to be strung together. In this example, the ls command is given two options, the "l" options to produce long format output, and the "t" option to sort the result by the file's modification time.

大多数命令使用的选项是使用一个中划线加一个字符组成，例如“l”，但是许多命令，包括来自于UGN项目的命令，也支持长选项，长选项是由两个中划线加一个单词组成。当然，许多命令允许使用多个短选项串一起使用。下面这个例子有两个选项，“l”产生长格式输出，“t”得到按修改时间的先后顺序排序的结果。

> ➜  ~  ls -lt
total 0
drwx------+ 50 shining3d-fyqj  staff  1700 10 28 11:13 Downloads
drwxr-xr-x   8 shining3d-fyqj  staff   272 10 27 10:38 company
drwxr-xr-x   4 shining3d-fyqj  staff   136 10 26 17:20 VirtualBox VMs
drwxr-xr-x   4 shining3d-fyqj  staff   136 10 26 16:44 system
drwx------@ 53 shining3d-fyqj  staff  1802 10 26 16:26 Library
drwxr-xr-x  18 shining3d-fyqj  staff   612 10 26 14:03 code
drwx------+  5 shining3d-fyqj  staff   170 10 21 11:07 Pictures
drwxr-xr-x   9 shining3d-fyqj  staff   306 10 20 16:35 doc
drwxr-xr-x   4 shining3d-fyqj  staff   136 10 20 14:41 build
drwx------+  4 shining3d-fyqj  staff   136 10 16 09:14 Music
drwx------+  5 shining3d-fyqj  staff   170  9 24 15:24 Desktop
drwx------+ 10 shining3d-fyqj  staff   340  9 21 14:55 Documents
drwx------   4 shining3d-fyqj  staff   136  8 17 10:31 Applications
drwx------+  3 shining3d-fyqj  staff   102  8 17 10:26 Movies
drwxr-xr-x+  5 shining3d-fyqj  staff   170  8 17 10:26 Public
➜  ~

We'll add the long option "--reverse" to reverse the order of the sort:

得到的结果中还有delete权限的信息

> ➜  ~  ls -lt -reverse
total 0
0 drwxr-xr-x+  5 shining3d-fyqj  staff   170  8 17 10:26 Public
 0: group:everyone deny delete
0 drwx------+  3 shining3d-fyqj  staff   102  8 17 10:26 Movies
 0: group:everyone deny delete
0 drwx------   4 shining3d-fyqj  staff   136  8 17 10:31 Applications
0 drwx------+ 10 shining3d-fyqj  staff   340  9 21 14:55 Documents
 0: group:everyone deny delete
0 drwx------+  5 shining3d-fyqj  staff   170  9 24 15:24 Desktop
 0: group:everyone deny delete
0 drwx------+  4 shining3d-fyqj  staff   136 10 16 09:14 Music
 0: group:everyone deny delete
0 drwxr-xr-x   4 shining3d-fyqj  staff   136 10 20 14:41 build
0 drwxr-xr-x   9 shining3d-fyqj  staff   306 10 20 16:35 doc
0 drwx------+  5 shining3d-fyqj  staff   170 10 21 11:07 Pictures
 0: group:everyone deny delete
0 drwxr-xr-x  18 shining3d-fyqj  staff   612 10 26 14:03 code
0 drwx------@ 53 shining3d-fyqj  staff  1802 10 26 16:26 Library
 0: group:everyone deny delete
0 drwxr-xr-x   4 shining3d-fyqj  staff   136 10 26 16:44 system
0 drwxr-xr-x   4 shining3d-fyqj  staff   136 10 26 17:20 VirtualBox VMs
0 drwxr-xr-x   8 shining3d-fyqj  staff   272 10 27 10:38 company
0 drwx------+ 50 shining3d-fyqj  staff  1700 10 28 11:13 Downloads
 0: group:everyone deny delete
➜  ~

### file

As we explore the system it will be useful to know what files contain. To do this we will use the file command to determine a file's type. We can invoke the file command this way:

随着探索文件系统的进行，知道文件信息是很有用的，可用file命令达此目的。我们可以这样调用：

> ➜  tmp  file server.js
server.js: UTF-8 Unicode text

















