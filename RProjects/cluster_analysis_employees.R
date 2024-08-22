# Business question:
# “How can our company effectively target strategies to improve employee satisfaction to specific groups of employees based on their characteristics and performance?"

# load libraries
library(tidyverse)
library(cluster)
library(fpc)
library(factoextra)
library(janitor)

# read in data
empdf<-read.csv("Employees.csv")
head(empdf)

# Create a data frame with only continuous variables - Age, 
# Value.of.Investments,Number.of.Transactions, Household.Income - 
# by removing columns 2, 3, 6, and 8
keydf<-empdf[c(1,16,20,25)]
View(keydf)

# normalize each variable
keydfn<-scale(keydf)
head(keydfn)

# set random number seed in order to replicate the analysis
set.seed(42)

# create a function to calculate total within-cluster sum of squared deviations 
# to use in elbow plot
wss<-function(k){kmeans(keydfn, k, nstart=10)} $tot.withinss

# range of k values for elbow plot
k_values<- 1:10

# run the function to create the range of values for the elbow plot
wss_values<-map_dbl(k_values, wss)

# create a new data frame containing both k_values and wss_values
elbowdf<- data.frame(k_values, wss_values)

# graph the elbow plot
ggplot(elbowdf, mapping = aes(x = k_values, y = wss_values)) +
  geom_line() + geom_point()

# run k-means clustering with 4 clusters (k=4) and 1000 random restarts
k4<-kmeans(keydfn, 4, nstart=1000)

# display the structure of the 4-means clustering object
str(k4)

# display information on 4-means clustering
k4

# display cluster statistics
cluster.stats(dist(keydfn, method="euclidean"), k4$cluster)

# combining each observation's cluster assignment with unscaled data frame
keydfk4<-cbind(keydf, clusterID=k4$cluster)
View(keydfk4)

# write data frame to CSV file to analyze in Excel
write.csv(keydfk4, "employees_kmeans_4clusters.csv")

# calculate variable averages for all non-normalized observations
summarize_all(keydf, mean)

# Calculate variable averages for each cluster
k_emp <- keydfk4 %>%
  group_by(clusterID) %>%
  summarize_all(mean)


# HIERARCHICAL CLUSTER ANALYSIS

head(keydf)

# calculate distance between each pair of observations using the dist function 
# and euclidean distance
match_dist<-dist(scale(keydf), method="euclidean")


# run hierarchical clustering with the hclust function and ward linkage
cl_ward<-hclust(match_dist, method="ward.D")

# plot the dendrogram
plot(cl_ward)

# Create 4 clusters using the cutree function
cl_ward_4<-cutree(cl_ward, k=4)

# display vector of cluster assignments for each observation
cl_ward_4

# visualize clusters on the dendrogram
rect.hclust(cl_ward, k=4, border=2:4)

# link cluster assignments to original categorical data frame
keyhcldf<-cbind(keydf, clusterID=cl_ward_4)

# write data frame to CSV file to analyze in Excel
#write.csv(keyhcldf, "magazine_hier4_clusters.csv")

head(keyhcldf)

# display number of observations in each cluster
keyhcldf%>%
  group_by(clusterID) %>%
  summarize(n())

# display averages for each variable
summarize_all(keydf, mean)

# display averages for all variables within each cluster
hier_emp <- keyhcldf %>%
  group_by(clusterID) %>%
  summarize_all(mean)

k_emp
hier_emp
