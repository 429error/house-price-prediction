# Housing Price Prediction in King County, USA

This R project focuses on **Exploratory Data Analysis (EDA)** and **Predictive Modeling** to estimate housing prices using a real-world dataset from King County, USA. The dataset includes information about house features such as square footage, number of bedrooms and bathrooms, grade, and whether the property has waterfront access.

## Objective

The primary objective is to analyze the relationships between housing features and price, clean and engineer the data, visualize key patterns, and apply multiple regression techniques to build and compare prediction models.

## Project Highlights

- Data cleaning, handling missing values, and feature transformation
- Visualizations to explore relationships and outliers
- Creation of new features, including age and interaction terms
- Implementation of three models for comparison:
  - Linear Regression
  - Generalized Linear Model (GLM)
  - Random Forest
- Evaluation of model performance using RMSE (Root Mean Squared Error)
- Cross-validation for robust model accuracy
- Visualization of predicted vs. actual values for each model

## Technologies Used

- **Language**: R
- **Libraries**:
  - `tidyverse` (dplyr, tidyr, ggplot2)
  - `caret` (for modeling and cross-validation)
  - `randomForest` (for non-linear model)
  - `purrr` (for functional data transformation)

## Dataset

The dataset used is **King County House Sales**, which contains housing sale prices for homes in King County, including Seattle.  
Source: [Kaggle Dataset](https://www.kaggle.com/harlfoxem/housesalesprediction)

## Key Features in the Model

- `sqft_living`, `bedrooms`, `bathrooms`, `grade`, `waterfront`
- `age`: Derived feature calculated as `2023 - yr_built`
- `bedrooms_bathrooms`: An interaction term between number of bedrooms and bathrooms

## How to Run

1. Clone this repository.
2. Ensure R is installed on your system.
3. Install the required packages:
   ```r
   install.packages(c("readr", "dplyr", "tidyr", "ggplot2", "caret", "randomForest", "purrr"))

