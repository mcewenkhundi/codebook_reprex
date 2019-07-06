suppressWarnings(library(reprex))
suppressWarnings(library(dplyr))
suppressWarnings(library(codebook))
suppressWarnings(library(labelled))

df <- data_frame(s1 = c("M", "M", "F"), 
                 s2 = c(1, 1, 2)) 

dict <- data_frame(variable = c("s1","s2"), 
                   label = c("gender","alive"), 
                   value_labels= c("Male=M,Female=F","Yes=1,No=2"))                                 

var_label(df) <- dict %>% select(variable, label) %>% dict_to_list()

var_label(df)

#Similarly I would like to label the values 
#instead of using my current mechanical approach as exemplified below

val_labels(df$s1) <- c("M" = "Male", "F" = "Female")
val_labels(df$s2) <- c("1" = "Male", "2" = "Female")
val_labels(df)

#Solution
dict_labels <- dict %>%
               select(variable,value_labels) %>%
               separate(value_labels, c("var1", "var2"), ",") %>%
               gather("value","label", -variable) %>%
               select(variable, label) %>%
               separate(label, c("label", "value"), "=") %>%
               select(variable,value,label)

v_list <- dict_labels %>% split(.$variable) %>%
  map(~purrr::set_names(.$value, .$label))

df <- df %>%
        map_at(names(v_list),as.character) %>%
        as_tibble()

val_labels(df) <- v_list

val_labels(df)

look_for(df, details = TRUE)
df
