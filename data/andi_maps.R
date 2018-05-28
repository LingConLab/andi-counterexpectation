
# Maps of Andi (villages and neighbours)


# Preliminaries -----------------------------------------------------------


# download the latest version of lingtypology
install.packages("devtools")
devtools::install_github("ropensci/lingtypology")

# load packages

library(tidyverse)
library(lingtypology)


# Map - Andi + neighbours -------------------------------------------------


# load data - load a subset of our enormous dataframe with villages where EC languages are spoken

andic <- read_tsv("andic.csv")

# (remove duplicated villages inherited from the original large file)

andic2 <- andic[!duplicated(andic$village),]


# customize the order of elements in the legend (order is alphabetical by default)

andic2$aff <- factor(andic2$aff, levels = c("Chechen", "Avar", "Andi", "other Andic"))

# draw a map

map.feature(andic2$language, # data
            latitude = andic2$latitude, # custom coordinates
            longitude = andic2$longitude, # custom coordinates
            feature = andic2$aff, # feature to plot (in this case: language)
            legend.position = "bottomleft", # position of the legend
            title = "Language", # title of the legend
            color = c("white", "darkseagreen", "darkolivegreen1", "darkolivegreen4"), # color for the feature values
            width = 8, # size of dots on the map
            tile = c("Esri.WorldTopoMap"), # appearance of the map,
            zoom.control = T, # add zoom control
            minimap = T) %>% # pipe another map to draw a rectangle on top of the previous map
  map.feature(language = "Andi",
              opacity = 0,
              rectangle.lat = c(42.64, 42.84), # draw a rectangle
              rectangle.lng = c(46.2, 46.35), # draw a rectangle
              rectangle.color= "greenyellow", # make it a nice, brightgreen rectangle
              tile = c("Esri.WorldGrayCanvas"), # appearance of the map
              pipe.data = .)

# NB. Due to the pipe, we can use different tiles (map appearances) for the actual map (Esri.WorldGrayCanvas)
# and the minimap (Esri.WorldTopoMap)



# Map - Andi villages -----------------------------------------------------


# load data on Andi villages with census data

andivill <- read_tsv("andivill.csv")

# customize the order of elements in the legend

andivill$dialect <- factor(andivill$dialect, levels = c("upper", "lower", "x"))

# map with a large scale overview of all villages by dialect group

map.feature(andivill$language,
            latitude = andivill$lat,
            longitude = andivill$lon,
            feature = andivill$dialect,
            title = "Dialect group",
            color = c("pink", "green", "honeydew1"),
            width = 12,
            tile = c("Esri.WorldGrayCanvas"),
            zoom.control = T,
            popup = paste(andivill$village, "(", andivill$inhabitants, ",", andivill$census, ")")) # popup showing village name, number of inhabitants and the year of the census


# map with village names

map.feature(andivill$language,
            latitude = andivill$lat,
            longitude = andivill$lon,
            feature = andivill$dialect,
            title = "Dialect group",
            color = c("pink", "green", "honeydew1"),
            tile = c("Esri.WorldGrayCanvas"),
            zoom.control = T,
            label = andivill$label, # add a label to each dot showing the village name (I added empty values for the non-core villages)
            label.hide = F, # always show the label (not only on mouse-over)
            label.font = "Brill") # custom label font

