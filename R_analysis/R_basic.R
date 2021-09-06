## Package manager

## install/load package from github repository
p_load_gh("reconhub/epicontacts")

## install development version of package, but not the main branch
p_install_gh("reconhub/epicontacts@timeline")

## install from URL
packageurl <- "https://cran.r-project.org/src/contrib/Archive/dsr/dsr_0.2.2.tar.gz"
install.packages(packageurl, repos=NULL, type="source")

## Install downloaded file
remotes::install_local("~/Downloads/dplyr-master.zip")

## or samething with install packages, note type = "source and repos = NULL
install.packages("~/Downloads/dplyr-master.zip", repos=NULL, type="source")

## Delete packages p_delete() from pacman, or remove.packages()

## See the dependencies of a package with p_depends(), and see which packages depend on it with p_depends_reverse()

## Detach library
detach(package:PACKAGE_NAME_HERE, unload=TRUE)

## here package roviding "relative" filepaths instead
# Import csv linelist from the data/linelist/clean/ sub-folders of an R project
linelist <- import(here("data", "clean", "linelists", "marin_country.csv"))







my_vector <- c("a", "b", "c", "d", "e", "f")  # define the vector
my_vector[5]                                  # print the 5th element

# All of the summary
summary(linelist$age)

# Just the second element of the summary, with name (using only single brackets)
summary(linelist$age)[2]

# Just the second element, without name (using double brackets)
summary(linelist$age)[[2]]

# Extract an element by name, without showing the name
summary(linelist$age)[["Median"]]

# View a specific row (2) from dataset, with all columns (don't forget the comma!)
linelist[2,]

# View all rows, but just one column
linelist[, "date_onset"]

# View values from row 2 and columns 5 through 10
linelist[2, 5:10] 

# View values from row 2 and columns 5 through 10 and 18
linelist[2, c(5:10, 18)] 

# View rows 2 through 20, and specific columns
linelist[2:20, c("date_onset", "outcome", "age")]


# View first 100 rows
linelist %>% head(100)

# Show row 5 only
linelist %>% filter(row_number() == 5)

# View rows 2 through 20, and three specific columns (note no quotes necessary on column names)
linelist %>% filter(row_number() %in% 2:20) %>% select(date_onset, outcome, age)


# define demo list
my_list <- list(
  # First element in the list is a character vector
  hospitals = c("Central", "Empire", "Santa Anna"),
  
  # second element in the list is a data frame of addresses
  addresses   = data.frame(
    street = c("145 Medical Way", "1048 Brown Ave", "999 El Camino"),
    city   = c("Andover", "Hamilton", "El Paso")
  )
)

my_list[1] # this returns the element in class "list" - the element name is still displayed

my_list[[1]] # this returns only the (unnamed) character vector

my_list[["hospitals"]] # you can also index by name of the list element

my_list[[1]][3] # this returns the third element of the "hospitals" character vector

my_list[[2]][1] # This returns the first column ("street") of the address data frame

## Remove object
rm(object_name)

## Remove all objects
rm(list = ls(all = TRUE))


# A fake example of how to bake a cake using piping syntax

cake <- flour %>%       # to define cake, start with flour, and then...
  add(eggs) %>%   # add eggs
  add(oil) %>%    # add oil
  add(water) %>%  # add water
  mix_together(         # mix together
    utensil = spoon,
    minutes = 2) %>%    
  bake(degrees = 350,   # bake
       system = "fahrenheit",
       minutes = 35) %>%  
  let_cool()            # let it cool down

# Create or overwrite object, defining as aggregate counts by age category (not printed)
linelist_summary <- linelist %>% 
  count(age_cat)

# Print the table of counts in the console, but don't save it
linelist %>% 
  count(age_cat)


linelist <- linelist %>%
  filter(age > 50)

linelist %<>% filter(age > 50)

# a fake example of how to bake a cake using this method (defining intermediate objects)
batter_1 <- left_join(flour, eggs)
batter_2 <- left_join(batter_1, oil)
batter_3 <- left_join(batter_2, water)

batter_4 <- mix_together(object = batter_3, utensil = spoon, minutes = 2)

cake <- bake(batter_4, degrees = 350, system = "fahrenheit", minutes = 35)

cake <- let_cool(cake)

# an example of combining/nesting mutliple functions together - difficult to read
cake <- let_cool(bake(mix_together(batter_3, utensil = spoon, minutes = 2), degrees = 350, system = "fahrenheit", minutes = 35))



# View rows and columns based on criteria
# *** Note the dataframe must still be named in the criteria!
linelist[linelist$age > 25 , c("date_onset", "outcome", "age")]

# Use View() to see the outputs in the RStudio Viewer pane (easier to read) 
# *** Note the capital "V" in View() function
View(linelist[2:20, "date_onset"])

# Save as a new object
new_table <- linelist[2:20, c("date_onset")] 




