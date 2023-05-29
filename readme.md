# A pre-configured Theia IDE

[Theia IDE](https://theia-ide.org/) is a wonderful IDE that is entirely web-based, and I found it an indispensable part of my daily work to program remotely. This repo contains scripts to quickly set it up with pre-configured Python and Scala (the languages I happen to use) support. The repo is Debian-only (which means ubuntu to most people).

**Compiling from scratch**

```
bash install.sh compile 
```

Or **downloading and installing with my pre-packed version.**

```
bash install.sh download
```

To run theia,

```
theia start --hostname=127.0.0.1
```

And then open your web browser and go to https://127.0.0.1:3000.

# More info

The problem is simple; you want to code on a remote machine from your local laptop. This is a common scenario when you work on the cloud, have a workstation at your workplace, or use cluster computational resources. Throughout the years, I have tried and tested with so many options, but none has worked even close to what Theia IDE can offer.

Alternative options:

-   SSH into the remote machine and use vim. I only use this option for simple, quick edits because vim has a remarkbably steep learning curve and I do not like CLI-based IDEs.
-   Edit locally, then copy to remote. There are a few ways to achieve this
    -   Sync local folder with remote using rsync or something else running as a daemon. Very flaky to set up and there's an annoying lag before your newest changes can be reflected remotely. Also you cannot edit the remote files directly using vim anymore because they would be overwritten. 
    -   Edit locally, git push, then git pull at the remote. This feels safer than the above but is slow to use, and it generates tons of commits in your repo.
    -   SFTP to the remote machine with certain tools which allow you to open up a file and edit it. I used to use this option and a bunch of IDEs have built-in support for this. However, this is remarkablly un-reliable because once you lose network (now and then when you are on wifi, or when you close the lid of your laptop) something bad is bound to happen -- a file not copied to remote, the IDE complaining it couldn't find the remote directory, some file got partially updated but some didn't, etc. It's such a hassle to make sure saving every single opened file before I close the lid of my laptop. 
-   Mount the remote disk locally with NFS or equivalent. This sounds better than what it actually is. It shares tons of issues that the above methods have, plus now you need to manage the security of NFS. I do not open any port other than 22 for SSH, and I just refuse to do host anything public-facing on my remote machine. 
-   Use Jupyter Notebook to do the edits. It works but Jupyter is such a bad text editor with barely any feature an IDE should have. It's for Notebook and you shouldn't count on it for editing code text file.
-   For most of these methods, you cannot run and test your code directly from your IDE because they are not or cannot be connected to the remote runtime environment. This means no syntax check, no language server auto formatting/warnings etc. 
-   Also for the majority of these methods, you need to install/configure a bunch of stuff on your local machine. When you have multiple local machines you switch between, it is quite annoying to setup each of them and sync the environment.

**Seriously, you should just use Theia.** Theia works very similarly to Jupyter Notebook; it is hosted on the remote machine and you access it with your web-browser -- meaning you don't need anything installed on your local machine and you can do the job with any device, any os, any arch, as long as it has a web-browser. All edits are done directly on the remote machine and you never need to worry about syncing or lost connections with SFTP/NFS. Network failure is handled super nicely -- just a web refresh and I've never lost anything with Theia in these few years. 

**However, Theia is not straightforward to set up.** For some reason, it is just so painful to find a binary version of Theia that can just work-out-of-box. The entire community is IDE developer-facing but I simply want to have a working IDE and do not care about the "building my own IDE" thingy. It is also a node.js project which depends on so many packages that got constantly updated, plus the fact that node.js itself is updated so frequently and old versions reach EOL so quickly. Every once in a while I had to update stuff otherwise it won't compile. I got mad whenever some updates break backward portability.

I don't want any of that, I don't need the newest whatever features or performance optimizations the millions of dependencies provide. I just want a working IDE. And here it is, a frozen-in-time Theia that I personally use.