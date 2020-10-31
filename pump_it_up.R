library(rpart)
library(rattle)
library(rpart.plot)

train_values <- read.csv("https://raw.githubusercontent.com/sergiosilvarubio/pump-it-up/master/dataset/training_set_values.csv")
train_labels <- read.csv("https://raw.githubusercontent.com/sergiosilvarubio/pump-it-up/master/dataset/training_set_labels.csv")
train_data <- merge(train_values, train_labels, by="id")

test_values <- read.csv("https://raw.githubusercontent.com/sergiosilvarubio/pump-it-up/master/dataset/test_set_values.csv")

decision_tree <- rpart(formula = as.factor(status_group) ~ quantity + construction_year + region_code + region + gps_height + payment + extraction_type_class + source + waterpoint_type, data = train_data, method = 'class')
View(decision_tree)
fancyRpartPlot(decision_tree)

table(train_data$status_group)
prop.table(table(train_data$status_group))

predict_tree <-predict(decision_tree, type = 'class')
data_pred <- cbind(train_data, predict_tree)
pred <- predict(object = decision_tree, data = test_values, type = 'class')
plot(pred)
