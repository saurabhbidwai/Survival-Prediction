setwd("C:/Users/DELL/Desktop/Aegis/R/Kaggle/Titanic/Data")
test=read.csv(file = "test.csv")
genderclassmodel=read.csv(file = "genderclassmodel.csv")
gendermodel=read.csv(file = "gendermodel.csv")
train=read.csv(file = "train.csv")

str(test) #gives you information such as the data types in the data frame,the number of obse., and the no. of variables.

# Your train and test set are still loaded
str(train)
str(test)

# Survival rates in absolute numbers
table(train$Survived)


# Survival rates in proportions
prop.table(table(train$Survived))

# Two-way comparison: Sex and Survived
table(train$Sex,train$Survived)


# Two-way comparison: row-wise proportions
prop.table(table(train$Sex,train$Survived),1)

# Create the column child, and indicate whether child or no child
train$Child = NA
train$Child[train$Age < 18] = 1
train$Child[train$Age >= 18] = 0


# Two-way comparison
prop.table(table(train$Child, train$Survived), 1)

# Copy of test
test_one = test

# Initialize a Survived column to 0
test_one$Survived=0

# Set Survived to 1 if Sex equals "female"
test_one <- transform(test_one, Survived = ifelse(Sex == "female", 1, Survived))

install.packages("rpart")
library(rpart)


# Build the decision tree
my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

# Visualize the decision tree using plot() and text()
plot(my_tree_two)
text(my_tree_two)

# Load in the packages to build a fancy plot
install.packages("rattle")
library(rattle)
install.packages("rpart.plot")
library(rpart.plot)
install.packages("RColorBrewer")
library(RColorBrewer)


# Time to plot your fancy tree
fancyRpartPlot(my_tree_two)