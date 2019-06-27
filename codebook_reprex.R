suppressPackageStartupMessages(library(reprex))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(codebook))
suppressPackageStartupMessages(library(labelled))

df <- data_frame(s1 = c("M", "M", "F"), 
                 s2 = c("1", "1", "2")) 

dict <- data_frame(variable = c("s1","s2"), 
                   label = c("gender","alive"), 
                   value_labels= c("Male=M,F=Female","Yes=1,No=2"))                                 

var_label(df) <- dict %>% select(variable, label) %>% dict_to_list()

var_label(df)

#Similarly I would like to label the values 
#instead of using my current mechanical approach as exemplified below

val_labels(df$s1) <- c("M" = "Male", "F" = "Female")
val_labels(df$s2) <- c("1" = "Male", "2" = "Female")
val_labels(df)
