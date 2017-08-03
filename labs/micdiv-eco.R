# Preparing data from mothur to work with in R

library(tidyr)
library(janitor)

# read in the data
data <- read.delim("KBS_2008_2009.txt")

# see what the data looks like
nrow(data)
colnames(data)
str(data)
View(data) 

# we're going to need to transpose the data, but first let's get what we need
# want 0.03 only

data03 <- filter(data, label == 0.03)
nrow(data03)
View(data03)

# remove columns with NAs (they weren't present at the 0.03 level)
data03c <- remove_empty_cols(data03)

# now create a data frame without the label and numOtus colums

data03_filtered <- subset(data03c, select=-c(label, numOtus))
View(data03_filtered)

# Get just the samples we want to analyze
# Here we don't want the AOB row
tdata <- filter(data03_filtered, Group != "AOB")

# Get just the numerical data and 
data_num <- tdata[,-1]

# We should also normalize the data, dividing each OTU count by the number
# of sequences in each sample. This takes awhile to run though! So we're not 
# doing it here. It's commented out.
# norm_data <- data_num %>% mutate_all(funs(. / sum(.)))

# Do a quick NMDS analysis

ord <- metaMDS(data_num)
plot(ord, type = "t")

# Do a Priciple Coordinate analysis with fancier plotting

PCoA.res<-capscale(data_num~1,distance="bray")
summary(PCoA.res)
PCoA.res
anova(PCoA.res)

# Plot the PCoA

# give each treatment its own symbol
sym <- c(23,23,23,23,22,22,22,22,21,21,21,21,24,24,24,24)

# set different colors for each year
colors <- c("black", "gray", "black", "gray", "black", "gray", "black", "gray", "black", "gray", "black", "gray", "black", "gray", "black", "gray")

#pdf(file="PCoA.pdf", family="Helvetica", pointsize=8, width=3.4,height=3.6)

# Group by Treatment
# Set up the plot
plot(PCoA.res, disp="sites", type="n", xaxt="n", yaxt="n", ylab="", xlab="")
title(xlab="PCoA1", ylab="PCoA2", line=0.5, cex.lab=1)

# Plot ellipses and points
ordiellipse(PCoA.res, l4$Trt, lwd=1, kind="se", conf=0.95, col="#E6E6E6", border="#E6E6E6", draw=c("polygon"))
ordispider(PCoA.res, l4$Trt, col="black")
points(PCoA.res, disp="sites", pch=sym, col="black", bg=colors, cex=0.7)

text(0.68, 0.58, "AG")
text(-0.06, -0.76, "ES")
text(-0.19, 0.26, "SF")
text(-0.99, -0.25, "DF")





