
# loading the tidyverse package

library("tidyverse")

# READING IN DATA ####

# reading in the data and creating an object 
    # use the tab ckey to auto "vervollständigen" the name of the data file

gapminder <- read_csv(file = "Data/gapminder-FiveYearData.csv")

gapminder

# EXPLORING GGPLOT ####

# plus indicates that codes continues in the second line

# mappping function connects visual properties with the data

# aes = aesthetic properties (size, color, transparency, combining)
    # aes inside: from the data set
    # aes outside: not from the data set

# geom_function = decides how the graph should look like
    # several geom_functions can be combined
 
# facet function

# + indicates that a command continues

ggplot(data = gapminder) + 
    geom_point(mapping = aes(x = gdpPercap, y = lifeExp))


ggplot(data = gapminder) + 
    geom_jitter(mapping = aes(x = gdpPercap, y = lifeExp, 
                              color = continent))

# use a log to make the scale more appropriate

ggplot(data = gapminder) + 
    geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp, 
                              color = continent, size = pop))

# alpha changes the transparency
# aes inside the brakets (differentiated by all data points)
# oustide the aes brakets -> all points get the same transparency/ colour/size

ggplot(data = gapminder) + 
    geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp), 
                              alpha = 0.1, size = 2, color = "blue")
# two beautiful line graphs

ggplot(data = gapminder) + 
    geom_line(mapping = aes(x = log(gdpPercap), y = lifeExp, 
                             group = country, color = continent))

ggplot(data = gapminder) + 
    geom_line(mapping = aes(x = year, y = lifeExp, 
                            group = country, color = continent))

# Boxplots showing how the data are distributed

ggplot(data = gapminder) + 
    geom_boxplot(mapping = aes(x = continent, y = lifeExp))

# adding another geom function
# combining boxplot and point plots

ggplot(data = gapminder) + 
    geom_jitter(mapping = aes(x = continent, y = lifeExp, color = continent)) +
    geom_boxplot(mapping = aes(x = continent, y = lifeExp, color = continent))

# in a changed order...

ggplot(data = gapminder) + 
    geom_boxplot(mapping = aes(x = continent, y = lifeExp, color = continent)) +
    geom_jitter(mapping = aes(x = continent, y = lifeExp, color = continent)) 

# simplifying the code, as all have the same mapping function
# lifting the mapping command one layer up, layering; everything that is in the
    # main function is visible to the following commands/ layers
        # geom_jitter()) +
        # geom_boxplot() are refered to as layers
  

ggplot(data = gapminder,
       mapping = aes(x = continent, y = lifeExp, color = continent)) + 
    geom_jitter()) +
    geom_boxplot()


# different linear functions were built

ggplot(data = gapminder,
       mapping = aes(x = log(gdpPercap), y = lifeExp, color = continent)) + 
    geom_jitter(alpha = 0.5) +
    geom_smooth(method = "lm")
    
# one model for all by hiding the color from the bottom layer, 
# by taking it out of the main function and place it in the layer where needed
# there is needs to be wraped in the mapping and aes function to tell the layer 
    # that continent refers to the data

ggplot(data = gapminder,
       mapping = aes(x = log(gdpPercap), y = lifeExp)) + 
    geom_jitter(mapping = aes(color = continent), alpha = 0.5) +
    geom_smooth(method = "lm")


# challenge 6

# boxplot by life expectancy per year
# result is not very helpful, as year was understood as a continious variable

ggplot(data = gapminder) + 
    geom_boxplot(mapping = aes(x = year, y = lifeExp)) 

# one boxplot per year
# as.character makes is a categorial variable

ggplot(data = gapminder) + 
    geom_boxplot(mapping = aes(x = as.character(year), y = lifeExp)) 


ggplot(data = gapminder) + 
    geom_boxplot(mapping = aes(x = as.character(year), y = log(gdpPercap))) 



ggplot(data = gapminder) + 
    geom_density2d(mapping = aes(x = lifeExp, y = log(gdpPercap))) 

                        
# non linear models 
# one model per continent
#  ~ indicating a dependency between two functions
    # here only part of the ~ function is used
# facet_grid: what do you want to have on the x and y axis? 

ggplot(data = gapminder, mapping = aes(x = log(gdpPercap), y = lifeExp)) + 
    geom_point ()+
    geom_smooth()+
    scale_x_log10()+
    facet_wrap(~ continent)

# faceting by year
# apply a linear function

ggplot(data = gapminder, mapping = aes(x = log(gdpPercap), y = lifeExp)) + 
    geom_point ()+
    geom_smooth( method = "lm")+
    scale_x_log10()+
    facet_wrap(~ year)

# FILTERING ####

# looking at a snapshot of the data, at only one year, e.g. 2007

# hidden variable "count" was chosen by R to be on the y axis
    # that happens automatically, this is the explicit version of what R is doing implicitly
    # stat = "count")

    # identity tells R: do not do anything to my data; use the data as they are

# graph includes all countries from Oceania
ggplot(data = filter(gapminder, year == 2007, continent =="Oceania")) +
    geom_bar(mapping =  aes(x = country, y = pop), stat = "identity")

ggplot(data = filter(gapminder, year == 2007, continent =="Oceania")) +
    geom_col(mapping =  aes(x = country, y = pop))

# graph includes all countries from Asia

# too many countries, unreadable    
ggplot(data = filter(gapminder, year == 2007, continent =="Asia")) +
    geom_col(mapping =  aes(x = country, y = pop))

# too many countries, unreadable - > add another layer
# switches the countries to the y axis
ggplot(data = filter(gapminder, year == 2007, continent =="Asia")) +
    geom_col(mapping =  aes(x = country, y = pop))+
    coord_flip()

# adding one more aesthetic and wrapped by year

ggplot(data = gapminder, mapping = aes(x = log(gdpPercap), y = lifeExp, 
                                       color = continent)) + 
    geom_point ()+
    geom_smooth()+
    scale_x_log10()+
    facet_wrap(~ year)

# adding one more aesthetic and wrapped by year and add size (population divided in millions)
# trying to get to a scale that makes sense

ggplot(data = gapminder, mapping = aes(x = log(gdpPercap), y = lifeExp, 
                                       color = continent, size = pop/10^6)) + 
    geom_point ()+
    geom_smooth()+
    scale_x_log10()+
    facet_wrap(~ year)+
    labs(title= "Life Expectancy vs GDP per capital",
     subtitle= " In the last 50 year life expectancy has improved",
     caption= "Source:Gapminder foundation http.gapminder.com")

# add aesthetics, how the label should be called


ggplot(data = gapminder, mapping = aes(x = log(gdpPercap), y = lifeExp, 
                                       color = continent, size = pop/10^6)) + 
    geom_point ()+
    geom_smooth()+
    scale_x_log10()+
    facet_wrap(~ year)+
    labs(title= "Life Expectancy vs GDP per capital",
         subtitle= " In the last 50 year life expectancy has improved",
         caption= "Source:Gapminder foundation http.gapminder.com",
         x = "GDP per capita, in '000 USD",
         y= "Life Expectancy in years",
         color = "Continent",
         size = "Population, in millions")

# SAVE FILE BY COMMAND

# save 
# graphs can be adapted to any format,...
# you do not need to click somewhere to save

ggsave("my_fancy_plot.png")




