# SELECTION ####

# DATA ####
gapminder <- read_csv("Data/gapminder-FiveYearData.csv")



#rep==== repeat

rep("This is an example", times=3)
"This is an exmpl" %>% rep(times=3)

year_country_gdp <- select(gapminder, year, country, gdpPercap)
head(year_country_gdp)

year_country_gdp <- gapminder %>% select(year, country, gdpPercap)
head(year_country_gdp)

# whenever the year equals to 2002, select the row
gapminder %>%
    filter(year==2002) %>%
    ggplot(mapping = aes(x = continent, y= pop))+
    geom_boxplot()


# select the data even further

# piping parapmeter:  %> 

# says that only a selected part of the data set shall be worked with 

year_country_gdp <- gapminder %>%
    filter(continent=="Europe") %>%
    select(year, country, gdpPercap)

year_country_gdp_euro

country_lifeExp_Norway <- gapminder %>%
    filter(country == "Norway")
    select(year, lifeExp,gdpPercap)
    country_lifeExp_Norway
    
 # introducing a group variable
    # creating one group for each value in variable a
    # group_by(a)
    
gapminder %>%
    group_by(continent)

# get the mean of the groups
gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap =mean(gdpPercap))

gapminder %>%
    summarize(mean_gdpPercap =mean(gdpPercap))

gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap =mean(gdpPercap))  %>%
    ggplot(mapping = aes(x = continent, y= mean_gdpPercap))+
    geom_point()

# Challenge 2

gapminder %>%
    filter(continent == "Asia") %>%
    group_by(country) %>%
    summarize(mean_lifeExp = mean(lifeExp))%>%
    filter(mean_lifeExp == min(mean_lifeExp)|mean_lifeExp == max(mean_lifeExp))    

# coord_flip(); changes the y and x axis

gapminder %>%
    filter(continent == "Asia") %>%
    group_by(country) %>%
    summarize(mean_lifeExp = mean(lifeExp))%>%
    ggplot(mapping = aes(x = country, y= mean_lifeExp))+  
    geom_point()+
    coord_flip()
    
gapminder %>%
    mutate(gpd_billion=gdpPercap*pop/10^9)%>%
    head()

gapminder %>%
    mutate(gpd_billion=gdpPercap*pop/10^9)%>%
    group_by(continent,year) %>%
    summarize(mean_gdp_billion=mean(gpd_billion))

# USING MAPS PACKAGE####

# creating object that is the input for the map function

gapminder_country_summary <- gapminder %>%
    group_by(country) %>%
    summarize(mean_lifeExp = mean(lifeExp))

library(maps)

map_data("world") %>%
    head()

# rename the variable region to country
# this way we can merge it with another data frame

map_data("world") %>%
    rename(country=region) %>%
    
#  merge data frames by function left_join
    
# draw a map of the world
    
    map_data("world") %>%
    rename(country=region) %>%
    left_join(gapminder_country_summary, by="country") %>%
    # send this to ggplot
    ggplot()+
    geom_polygon(aes(x=long, y=lat, group=group, fill = mean_lifeExp))+
    # which colors to be used for the gradients
    scale_fill_gradient(low = "blue", high = "red")+
    coord_equal()
    
