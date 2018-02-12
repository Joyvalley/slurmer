setwd("~/slurm/slurmer")
suppressPackageStartupMessages(require(dplyr))

i_am <- Sys.info()[6]


my_bla <- read.table(".file1")
rownames(my_bla) <- NULL
coln <- unlist(unname(my_bla[1,]))
colnames(my_bla)  <- coln
my_bla <- my_bla[-1,]
my_bla <- my_bla[,-9]
bla <- my_bla


my_blub <- unique(my_bla[,c(2,5)])
my_blub <- cbind(my_blub,matrix(nrow = dim(my_blub)[1], ncol = 3))
colnames(my_blub)[3:5] <- c("JOBS", "MEM", "CPUS")


for(i in 1:dim(my_blub)[1]){

    my_blub[i,3] <- (filter(my_bla, my_bla[,2] == my_blub[i,1] & my_bla[,5]== my_blub[i,2]) %>% dim())[1]

    my_blub[i,4] <- strsplit(as.character(filter(my_bla, my_bla$USER == my_blub[i,1] & my_bla[,5] == my_blub[i,2])$MIN_MEMORY),"M")   %>% unlist() %>% as.numeric() %>% sum(na.rm = TRUE)

    my_blub[i,5] <- filter(my_bla, my_bla[,2] == my_blub[i,1] & my_bla[,5] == my_blub[i,2])$CPUS %>% as.numeric() %>%  sum(na.rm = TRUE) 
}

my_blub$MEM <- trunc((my_blub$MEM)*0.001)
my_blub


my_jobs <- filter(my_bla, my_bla$USER == i_am)
cat(" ","\n", "My Jobs\n" , "\n")
my_jobs
