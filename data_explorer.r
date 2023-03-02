### Data Loading ###
# Get current working directory
getwd()
# Set working directory to current directory for loading the data
setwd("/Users/yanis/Documents/ISL/Coursework 1/movies big")
# Get data using read.csv
data <- read.csv("movies.csv", header = TRUE, sep = ",")
# Create col id for later use
data$id <- 1:nrow(data) # nolint
# Check data and structure
head(data)
# Check data types
str(data)
# Check data dimensions (rows, cols)
dim(data)
# Pair plot 



### Preprocessing of the data ###
# Keep only these columns ['budget', 'year', 'score', 'votes', 'runtime', 'gross', 'rating', 'company', 'genre', 'star'] # nolint
# These columns are the ones that we will use to predict gross
to_keep <- c('budget', 'year', 'score', 'votes', 'runtime', 'rating', 'company', 'genre', 'star', 'gross') # nolint
data <- data[, to_keep]
# Drop outliers rows 6663, 7445, 5446, 3046, 7446, 7251, 5883, 6647, 7495, 6654, 6664 # nolint
data <- data[-c(6663, 7445, 5446, 3046, 7446, 7251, 5883, 6647, 7495, 6654, 6664, 7272, 6263, 6312), ] # nolint
# Drop na values in any columns as we have enough data to work with
data <- na.omit(data, na.rm = TRUE)
# Check data and its structure again 
head(data)
# Check data types
str(data)
# Convert categorical variables to factors for linear regression
data$rating <- as.factor(data$rating)
data$company <- as.factor(data$company)
data$genre <- as.factor(data$genre)
data$star <- as.factor(data$star)
# Save cleaned and preprocessed data for later use
saveRDS(data, "data.rda")


### Fitting a model ###
# Fit a Linear regression model 
fit1 <- lm(gross ~ ., data = data)
# Compute MSE
mse_1 <- mean(fit1$residuals^2)
cat("MSE: ", mse_1)
# Compute RMSE
rmse_1 <- sqrt(mse_1)
cat("RMSE: ", rmse_1)
# Compute MAE
mae_1 <- mean(abs(fit1$residuals))
cat("MAE: ", mae_1)
# Compute MAPE
mape_1 <- mean(abs(fit1$residuals / data$gross))
cat("MAPE: ", mape_1)
# Compute R2
r2_1 <- summary(fit1)$r.squared
cat("R2: ", r2_1)

# Load the glmnet package
library(glmnet)
# Create a data matrix
data_matrix <- model.matrix(gross ~ ., data = data)

# Fit a Ridge Linear model by finding the best lambda by cross validation 
fit2_cv <- cv.glmnet(data_matrix, data$gross, alpha = 0)
lambda_min <- fit2_cv$lambda.min
fit2 <- glmnet(data_matrix, data$gross, alpha = 0, lambda = lambda_min)
# Get residuals 
fit2_res <- predict(fit2, data_matrix, type = "response") - data$gross
# Compute MSE
mse_2 <- mean(fit2_res^2)
cat("MSE: ", mse_2)
# Compute RMSE
rmse_2 <- sqrt(mse_2)
cat("RMSE: ", rmse_2)
# Compute MAE
mae_2 <- mean(abs(fit2_res))
cat("MAE: ", mae_2)
# Compute MAPE
mape_2 <- mean(abs(fit2_res / data$gross))
cat("MAPE: ", mape_2)
# Compute R2
r2_2 <- 1 - (sum(fit2_res^2) / sum((data$gross - mean(data$gross))^2))
cat("R2: ", r2_2)

# Fit a Lasso Linear model by finding the best lambda by cross validation 
fit3_cv <- cv.glmnet(data_matrix, data$gross, alpha = 1)
lambda_min <- fit3_cv$lambda.min
fit3 <- glmnet(data_matrix, data$gross, alpha = 1, lambda = lambda_min)
# Get residuals
fit3_res <- predict(fit3, data_matrix, type = "response") - data$gross
# Compute MSE
mse_3 <- mean(fit3_res^2)
cat("MSE: ", mse_3)
# Compute RMSE
rmse_3 <- sqrt(mse_3)
cat("RMSE: ", rmse_3)
# Compute MAE
mae_3 <- mean(abs(fit3_res))
cat("MAE: ", mae_3)
# Compute MAPE
mape_3 <- mean(abs(fit3_res / data$gross))
cat("MAPE: ", mape_3)
# Compute R2
r2_3 <- 1 - (sum(fit3_res^2) / sum((data$gross - mean(data$gross))^2))
cat("R2: ", r2_3)

# Fit lasso for different values of lambda and plot the results
lambdas <- 10^seq(from=10, to=-2, length=100)
fit4 <- glmnet(data_matrix, data$gross, alpha = 1, lambda = lambdas)
plot(fit4, xvar="lambda")



### Model diagnostics ###
# Check model assumptions
plot(fit1)
# Check for normality of residuals
qqnorm(fit1$residuals)
qqline(fit1$residuals)
# Check for homoscedasticity  
plot(fit1$fitted.values, fit1$residuals)

# Save linear model for later use
saveRDS(fit1, "model.rda")

# Build random forest 
library(randomForest)
# Get rid of the columns with too many categories
str(data)
data_rf <- data[, -c(7, 9)]
rf <- randomForest(gross ~ ., data = data_rf)
# Plot variable importance
varImpPlot(rf)
# Get residuals
rf_res <- predict(rf, data_rf) - data$gross
# Compute MSE
mse_rf <- mean(rf_res^2)
cat("MSE: ", mse_rf)
# Compute RMSE
rmse_rf <- sqrt(mse_rf)
cat("RMSE: ", rmse_rf)
# Compute MAE
mae_rf <- mean(abs(rf_res))
cat("MAE: ", mae_rf)
# Compute MAPE
mape_rf <- mean(abs(rf_res / data$gross))
cat("MAPE: ", mape_rf)
# Compute R2
r2_rf <- 1 - (sum(rf_res^2) / sum((data$gross - mean(data$gross))^2))
cat("R2: ", r2_rf)
