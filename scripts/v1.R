#### Make Over Monday 
# 2016-Apr-25 
# The victims of the 21st-century slave trade

## `````````````````````````````````````````````
## Load Libraries ####
# library(dplyr)
# library(ggplot2)
# library(tidyr)
# library(scales)
# library(grid)
# library(stringr)

if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr,ggplot2,tidyr,scales,grid,stringr)
## `````````````````````````````````````````````

## `````````````````````````````````````````````
## Inspirations ####
## `````````````````````````````````````````````

## `````````````````````````````````````````````
## Read Me ####
## `````````````````````````````````````````````


## `````````````````````````````````````````````
## Read Data ####

base.path = file.path("d:", "2. Bianca", "1. Perso","14. MakeoverMonday","17. 2016 Apr 25","2. Data")

# 1. Original Data
fn.1 = "Trafficking in Persons Report.csv"

f <- file.path(base.path, c(fn.1))

# Optional argument "StringAsFactors" passed after the comma
d <- lapply(f, read.csv, stringsAsFactors = FALSE)


# Extracting out the data frames
df.original = d[[1]] 
## `````````````````````````````````````````````

## `````````````````````````````````````````````
## Data Manipulations ####
df.1 = as.data.frame(table(df.original$Year, df.original$Region,df.original$Tier))
names(df.1) = c("Year", "Region","Tier","Freq")


df.1 <- df.1 %>%
  mutate(Region2 = factor(
    Region,
    levels = levels(df.1$Region),
    labels = c("Africa", "Asia", "Europe", "N.America", "Oceania", "S.America")
  ))
## `````````````````````````````````````````````

## `````````````````````````````````````````````
## Data Visulization ####
## `````````````````````````````````````````````

g1 <- ggplot(df.1)
g1 <- g1 + geom_bar(aes(x=Year,y=Freq,fill=Region2),stat="identity",width=0.75, size=0.05)
g2 <- g1 + facet_grid(Region2~Tier)
# color scheme
# src
# http://www.colorhunter.com/
#g2 <- g2 + scale_fill_manual(values=c("#E24633","#963023","#4AA034","#966A23","#C23B66","#8F74AE"))
#http://www.colorcombos.com/color-schemes/9921/ColorCombo9921.html
g2 <- g2 + scale_fill_manual(values=c("#FEBA7B","#B13C11","#7A2949","#335D69","#67A193","#82756F"))


# aesthetics 
# http://rstudio-pubs-static.s3.amazonaws.com/3364_d1a578f521174152b46b19d0c83cbe7e.html
g3 <- g2 + theme(panel.background=element_rect(fill="#efefef", color=NA))
g3 <- g3 + theme(strip.background=element_rect(fill="#858585", color=NA))
g3 <- g3 + theme(strip.text.x=element_text(family="OpenSans-CondensedBold", size=8, color="white", hjust=0.5))
g3 <- g3 + theme(strip.text.y=element_text(family="OpenSans-CondensedBold", size=6.5, color="white", hjust=0.2))
g3 <- g3 + theme(panel.margin.x=unit(0.5, "cm"))
g3 <- g3 + theme(panel.margin.y=unit(0.5, "cm"))
g3 <- g3 + theme(legend.position="none")
g3 <- g3 + theme(panel.grid.major.y=element_line(color="#b2b2b2"))
g3 <- g3 + theme(axis.ticks = element_blank())


# Hide all the vertical gridlines
g4 <- g3 + theme(panel.grid.minor.x=element_blank(),
                 panel.grid.major.x=element_blank())

g4 <- g4 + theme(panel.grid.minor.y=element_blank())

# rotating the axis
g4 <- g4 + theme(axis.text.x = element_text(angle = 270, hjust = 1, size=7))
g4 <- g4 + theme(axis.text.y = element_text(hjust = 1, size=6))

g4

# adding title, subtitle and caption
g5 <- g4 + labs(x=NULL, y=NULL, title="Trafficking Hot Spots",
                subtitle="The victims of the 21st-century slave trade",
                caption="Source: cnbc.com")


g5 <- g5 + theme(plot.title=element_text(face="bold"))
g5 <- g5 + theme(plot.subtitle=element_text(face="italic", size=9, margin=margin(b=12)))
g5 <- g5 + theme(plot.caption=element_text(size=7, margin=margin(t=12), color="#7a7d7e"))
g5