suppressWarnings(library(tidyverse))
library(labelled)

d <- dplyr::tribble(~V1, ~V2, ~V3,
                    1, 2, NA,
                    2, 99, 'missing',
                    1, 2, NA,
                    1, 1, NA)

f <- dplyr::tribble(~Var, ~value, ~label,
                    'V1', 1, 'a',
                    'V1', 2, 'b',
                    'V1', 3, 'c',
                    'V2', 1, 'yes',
                    'V2', 2, 'no',
                    'V2', 99, 'missing')

# create a named list for labels
f_list <- f %>% split(.$Var) %>%
                map(~purrr::set_names(.$value, .$label))

# View f_list
f_list

val_labels(d) <- f_list

val_labels(d)


