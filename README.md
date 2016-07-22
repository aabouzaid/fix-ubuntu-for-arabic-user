fixUbuntu (for Arabic user)
=========================================

Few years ago (2013 maybe?) I did write some scripts to support new Arabic users as part of my -Arabic- book "[Simply Ubuntu](http://simplyubuntu.com/)".<br />
I intended to rewrite these scripts in Python, but I never have time for that after the book was released.


So, what we have here is a small app (using Bash and Zenity) fixes certain issues related to Arabic language and Arabic user.


Download it!
------------
You can download latest stable version from official website for [Simply Ubuntu.](http://download.simplyubuntu.com/fixUbuntu-latest.tgz).<br />
Just download and extract it, then double click on that file with ".sh.x" extension!


Screenshots.
------------
Main window.
<p align="center">
<img src="https://1.bp.blogspot.com/-nOkQm9qMdUM/V5KLjbAfa-I/AAAAAAAACNM/G6Y9vFmBKnAkmjEbSD2GMCsYuRVgSYU6wCLcB/fixUbuntu-v.01.png" width="300">
</p>

How does it work?
------------------
You can use it directly from here, and run that fixUbuntu.sh file.

But since this app is actually for new end-users, and most of new people don't know how to deal with bash files. Especially since the default behavior in Ubuntu now is opening Bash files in a text editor even they have execution permission.
 
So I used a fork of [SHC](https://github.com/neurobin/shc) (Shell Script Compiler) to convert that bash script to bin file and archive it to make it easy to use for new users!

Bin files are build for 32-bit and 64-bit using [Travis CI](http://travis-ci.org/) and then it uploaded to official [Simply Ubuntu.](http://download.simplyubuntu.com/fixUbuntu-latest.tgz) website.


What does it do?
----------------
This app does the following:
* Set system Arabic font since the default Arabic one is too ugly!
* Set Firefox Arabic font because you will get ugly pages if you don't have MS fonts.
* Fix Lam-Alef connecting issue (I don't know why people still use ["Lam" and "Alef"](http://graphemica.com/%EF%BB%BB) as "one" character! But it's here anyway!).
* Set gedit default Arabic encoding because Windows OS is using WINDOWS-1256 instead UTF-8!
* Set Totem default encoding ... the same as in gedit.
* Enable RTL in LibreOffice which is not enabled by default.
* Install some useful packages (Mainly for ubuntu-restricted-addons/extras).


Compatibility.
--------------
This script is tested with Ubuntu 16.04. But most of fixes should work with 14.04 too (except for gedit and totem fixes).


To-do.
------
* Add more fixes?
* There is no logging yet.
* Port the app to Python? (Most probably with new version of [Simply Ubuntu](http://simplyubuntu.com/) book).
* And for sure translate the UI into Arabic!


About.
--------------
* **By:** Ahmed M. AbouZaid [http://tech.aabouzaid.com/](http://tech.aabouzaid.com/).
* **Version:** v0.1 - July 2016.
* **License:**  GPL v2.0 or later.
