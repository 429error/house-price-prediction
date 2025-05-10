# R project 21 October 2024
#Exploratory Data Analysis and Predictive Modeling for Housing Prices
library(readr) # For reading data from CSV files
library(dplyr) # For data manipulation and transformation
library(tidyr) # For tidying the data (reshaping, etc.)
library(ggplot2) # For creating visualizations
library(caret) # For model training and evaluation
library(randomForest) # For implementing Random Forest algorithm
library(purrr) # For functional programming capabilities

# Loading the dataset
df <- read.csv("king_country_houses_aa.csv")
# View the loaded dataset
print(df)

# Displaying the summary statistics and checking for missing values
summary(df)
colSums(is.na(df))

# Data cleaning by selecting columns,removing missing values and manipulation
df_clean_1 <- df %>%
  dplyr::select(price,bedrooms,bathrooms,sqft_living,sqft_lot,grade,waterfront,yr_built) %>%
  filter(!is.na(price)) %>%  #filtering out the rows where price is NA 
  mutate(age = 2024 - yr_built)  # Calculating and creating a new column for house age

print(df_clean_1) #printing cleaned dataset for verification

df_clean_2 <- df_clean_1 %>%
  mutate(bedrooms_bathrooms = bedrooms * bathrooms) 
print(df_clean_2)

# EDA using ggplot2
# Scatter plot to visualise the relationship house prices vs. living area
ggplot(df_clean_2, aes(x = sqft_living, y = price)) +
  geom_point() + #adding points to. the plot
  geom_smooth(method = "lm", se = FALSE, color = "blue") + #adding a linear regression line
  labs(title = "House Prices vs Living Area", x = "Living Area (sqft)", y = "Price")

# Boxplot to visualise house prices by number of bedrooms
ggplot(df_clean_2, aes(x = as.factor(bedrooms), y = price)) +
  geom_boxplot() + #creating a boxplot to visualise price distribution
  labs(title = "House Price by Number of Bedrooms", x = "Number of Bedrooms", y = "Price")

#Regression Models
#Linear Regression model to predict house prices based on selected features
model_lm <- lm(price ~ sqft_living + bedrooms + bathrooms + waterfront + grade, data = df_clean)
summary(model_lm)  # Displaying the summary of the linear model summary

#Fit a random forest model for price prediction
set.seed(123) #set seed for reproducibility
model_rf <- randomForest(price ~ sqft_living + bedrooms + bathrooms + waterfront + grade, data = df_clean)
print(model_rf)  # Output the summary of Random Forest model details

#fit the generalised linear model(GLM) for price prediction
model_glm <- glm(price ~ sqft_living + bedrooms + bathrooms + waterfront + grade, family = gaussian(), data = df_clean)
summary(model_glm)  # Displaying the summary of the Generalised Linear Model summary

# Evaluation of model
# Function to calculate RMSE(Root Mean Square Error)
rmse <- function(actual, predicted) {
  sqrt(mean((actual - predicted)^2)) #calculate and return RMSE
}

# Generate predictions using Linear Regression Model
prediction_linear_model <- predict(model_lm, df_clean)

# Generate predictions using Random Forest Model
prediction_random_forest <- predict(model_rf, df_clean)

# Generate predictions using Generalised Linear Model
prediction_generalised_linear_model <- predict(model_glm, df_clean)

# Calculating RMSE for all models to assess performnace
rmse_lm <- rmse(df_clean$price, prediction_linear_model)
rmse_rf <- rmse(df_clean$price, prediction_random_forest)
rmse_glm <- rmse(df_clean$price, prediction_generalised_linear_model)

#Printing RMSE for model comparison
cat(" RMSE for Linear Regression:",rmse_lm, "\n")
cat(" RMSE for Random Forest:",rmse_rf, "\n")
cat(" RMSE for GLM:",rmse_glm, "\n")

# Visualization of Predictions
# Plotting actual vs predicted for Linear Regression Model
ggplot(df_clean_2, aes(x = price, y = prediction_linear_model)) +
  geom_point() + # Scatter plot of actual vs predicted prices
  geom_abline(slope = 1, intercept = 0, color = "red") + # Reference line for perfect prediction
  labs(title = "Linear Regression: Predicted vs Actual", x = "Actual Price", y = "Predicted Price")

# Plotting actual vs predicted for Random Forest Model
ggplot(df_clean_2, aes(x = price, y = prediction_random_forest)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, color = "blue") +
  labs(title = "Random Forest: Predicted vs Actual", x = "Actual Price", y = "Predicted Price")

# Plotting actual vs predicted for Generalised Linear Model
ggplot(df_clean_2, aes(x = price, y = prediction_generalised_linear_model)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, color = "green") +
  labs(title = "Generalised Linear Model: Predicted vs Actual", x = "Actual Price", y = "Predicted Price")

