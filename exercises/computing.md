# MicDiv2017: Using External Compute Resources for Analyzing Large Sequencing Data Files

[Lisa Johnson](https://twitter.com/monsterbashseq)
July 10, 2017

Last week, [Dr. Tracy Teal](http://www.datacarpentry.org/people/) taught [UNIX commandline skills for automation and scripting](https://github.com/mblmicdiv/course2017/blob/master/labs/command-line-workflows.md). Today, we will apply those skills on the mbl server.

By the end of today, you will:
* be able to ssh login
* load pre-installed software modules
* install software in your local directory
* transfer files with `scp` onto and off of a server
* download files from the internet with `wget` and `curl`
* know how to run some processes

## Login
You have accounts on the mbl server!

On Mac, open terminal and type:

```
 ssh lcohen@class.mbl.edu
```
NOTE: you will need to substitute `ljcohen` for your username!

On Windows, open [mobaxterm](http://mobaxterm.mobatek.net/) and enter server info into window.

(**I will show you your password information during class.**)

If you are on OS X, we can get you setup with so you don't have to type your password each time. If you are not on OS X, sorry.

```
cd ~/.ssh
ssh-keygen
```
Press `Enter` through each prompt. DO NOT ENTER A PASSWORD!!!

```
cat id_rsa.pub
```
Copy the output from this. On the server:
```
cd ~/.ssh
nano authorized_keys
```
Paste the output into this file and save.

On your local computer:

```
cd ~/.ssh
nano config
```

Enter this information

```
Host class??
        User chnguyen
        ProxyCommand ssh ljcohen@class.mbl.edu -W %h:%p
```

Otherwise, when you login to `@class.mbl.edu`, you will secondarily have to login to `ssh class10`, or `class08`, etc.

## Load Pre-Installed Software Modules

Software is pre-installed on the whole system for everyone to use. To access the list of available software tools, type:
```
module avail
```

If you are looking for a one in particular, type (for example):
```
module avail samtools
```

## Getting files to and from server, download locally:

This is the format for secure copy protocol (scp):

```
scp origin destination
```

If your files are located locally and you want to transfer to the server, use this:
```
scp /path/to/file/origin ljcohen@class.mbl.edu:/path/to/file/destination/
```

Or, if your files are located on the server and you want to download locally, use this:
```
scp ljcohen@class.mbl.edu:/path/to/file/destination/ /path/to/file/origin
```

If you want to transfer an entire directory, use the `-r` argument to recursively copy. Like this:
```
scp -r ljcohen@class.mbl.edu:/path/to/file/destination/dir /path/to/file/origin/
```



Let's get some files onto and off of the server. Let's grab a practice file:

Download the Ectocoolest genome annoations to your local machine (in your directory of choice, don't forget where you are located!):
https://osf.io/hypzu/

On the server, download the Ectocooler genome annotations:
```
curl -L -o anno.ectocooler.tar.gz https://osf.io/3ebwc/download
```

Now, we will switch these files. Put the Ectocoolest annotations on the server and download the Ectocooler annotations to your local computer.

## Downloading files from the internet

Download Ectocooler reads, MinION sequencing from 2016:

```
wget https://s3.amazonaws.com/ngs2016/ectocooler_all_2D.fastq
```

Download metagenome assembly files from Cedar Swamp or Trunk River:
* [Cedar Swamp, OSF (2017)](https://osf.io/y2n4z/)
* [Trunk River, OSF (2015)](https://osf.io/9bytm/)

```
curl -L -o trunk_assembly.500.fa.gz https://osf.io/tnc8h/download
```

## Let's compute something!

http://angus.readthedocs.io/en/2017/genome-assembly.html

First, load the module:
```
module load megahit/1.0.6
```
What happens when you type:
```
megahit
```
???

Download some data:
```
mkdir ~/work
cd ~/work
curl -O -L https://s3.amazonaws.com/public.ged.msu.edu/ecoli_ref-5m.fastq.gz
```

Assemble!
```
megahit --12 ecoli_ref-5m.fastq.gz -o ecoli
```

(This will take about 3 minutes.) You should see something like:

```
--- [STAT] 117 contigs, total 4577284 bp, min 220 bp, max 246618 bp, avg 39122 bp, N50 105708 bp
--- [Fri Feb 10 14:33:59 2017] ALL DONE. Time elapsed: 342.060158 seconds ---
at the end.
```
Questions while we’re waiting:

* how many reads are there?
* how long are they?
* are they paired end or single-ended?
* are they trimmed?
...and how would we find out?

Also, what expectation do we have for this genome in terms of size, content, etc?

Copy the assembly file. This is the only file you care about!
```
cp ~/work/ecoli/final.contigs.fa ~/ecoli-assembly.fa
```
What does it look like?
```
head ~/ecoli-assembly.fa
```

(Bonus, how would you download this to your local computer?)

## Install Quast

Let's install some software that is not already a module. We want to evaluate our assembly with quast. What happens when you type:

```
module avail quast
```
???

Right. So, we will have to install it ourselves.

First, let's change the directory to `home`.

```
cd ~/
```

Let's make a directory in our home directory called `bin`. 
```
mkdir bin
```
From now on, we will use `bin` to install local software.

```
cd ~/bin
git clone https://github.com/ablab/quast.git -b release_4.5
export PYTHONPATH=$(pwd)/quast/libs/
```

### Run Quast

```
cd ~/work
~/bin/quast/quast.py ecoli-assembly.fa -o ecoli_report
```

and now take a look at the report:

```
cat ecoli_report/report.txt
```

You should see something like:
```
All statistics are based on contigs of size >= 500 bp, unless otherwise noted (e.g., "# contigs (>= 0 bp)" and "Total length (>= 0 bp)" include all contigs).

Assembly                    ecoli-assembly
# contigs (>= 0 bp)         117           
# contigs (>= 1000 bp)      91            
# contigs (>= 5000 bp)      69            
# contigs (>= 10000 bp)     64            
# contigs (>= 25000 bp)     52            
# contigs (>= 50000 bp)     32            
Total length (>= 0 bp)      4577548       
Total length (>= 1000 bp)   4565216       
Total length (>= 5000 bp)   4508381       
Total length (>= 10000 bp)  4471170       
Total length (>= 25000 bp)  4296203       
Total length (>= 50000 bp)  3578898       
# contigs                   101           
Largest contig              246618        
Total length                4572094       
GC (%)                      50.75         
N50                         105709        
N75                         53842         
L50                         15            
L75                         30            
# N's per 100 kbp           0.00  
```

This is a set of summary stats about your assembly. Are they good? Bad? How would you know?

## Sourmash

This is where sourmash is located on the mbl server (see [Titus' tutorial from last week](https://github.com/mblmicdiv/course2017/blob/master/exercises/sourmash.md)):
```
. /class/stamps-shared/sourmash/load.sh
```

## Interested in using XSEDE computing resources?

* Free!
* Easy to use!

[XSEDE](https://www.xsede.org/) = Extreme Science and Engineering Discovery Environment Create account: https://portal.xsede.org/web/xup/my-xsede#/guest

Here are the steps for requesting a startup allocation: https://www.xsede.org/group/xup/allocation-request-steps

HPC resources available on XSEDE: https://www.xsede.org/high-performance-computing

Jetstream info (blank cloud instances, like AWS): http://jetstream-cloud.org/

Examples of successful XSEDE applications: 
* https://github.com/ljcohen/jetstream-xsede-illo/tree/master/xsede_applications
* http://ivory.idyll.org/blog/2017-dibsi-xsede-request.html


### Other resources:
* Get to know your HPC admin at your local institution! They're friendly, and like getting to know the HPC users!
* http://www.datacarpentry.org/cloud-genomics/discuss/
* http://2017-dibsi-metagenomics.readthedocs.io/en/latest/
* http://angus.readthedocs.io/en/2017/
* http://ivory.idyll.org/dibsi/
