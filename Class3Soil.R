#load in data
soil <- read.csv("soil.csv")

#transform data into a matrix
soil_matrix <- data.matrix(soil)

#fit glmnet model
install.packages("glmnet")
library(glmnet)

soil_fit = glmnet(x = soil_matrix[,1:3578], y = soil_matrix[,3579], family = "gaussian")

#plot the coefficients of the fit
plot(coef(soil_fit))

#find best lambda parameneter and plot coefficients
soil_fit_cv = cv.glmnet(x = soil_matrix[,1:3578], y = soil_matrix[,3579], family = "gaussian")

lambda_min = soil_fit_cv$lambda.min
print(lambda_min)

plot(coef(soil_fit_cv, s = "lambda.min"))

best_coef <- coef(soil_fit_cv, s = "lambda.min")
best_coef <- abs(best_coef)

#ten best variable names
best_names <- rownames(best_coef)[order(best_coef, decreasing=TRUE)][1:10]
print(best_names)


