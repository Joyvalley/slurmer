#!/bin/bash/
cd ~/slurm/slurmer/

squeue --noconvert -o "%.8j %.8u %.2t %.10M %R %.6D %A %C %D  %m" > .file1

R --vanilla --slave --no-save < ~/slurm/slurmer/bla.r 


printf "\n\n"

##paste <(sinfo -o %all | cut -d "|" -f  22,30,31 | sed 1d) <(scontrol show node $node | grep Memory | cut -d \  -f 5,6 )
sinfo --Node -o "%C | %N | %O | %m | %e" | sed 's/^\|$/|/g;1a \ |:-|-|-:|-:|-:|'


exit 0
