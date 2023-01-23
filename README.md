# ChiSquaredGoodnessOfFitTest.sql
This is a stored proc for running the chi2 goodness of fit test. 

This stored procedure will return the Chi-Squared statistic, the degrees of freedom, and the P-value for the test.

Note: You need to replace YOUR_TABLE with the name of your table in the stored procedure. Also you may need to adjust the data types of the input and output parameters, depending on the data type of your dependent and independent variables.

You would call this stored procedure by passing in the name of your dependent variable and a comma-separated list of independent variables. 
For example:
EXEC ChiSquaredGoodnessOfFitTest 'Gender', 'Age, Income'

This stored procedure performs a chi-squared goodness of fit test between a dependent variable and multiple independent variables. The dependent variable and independent variables are passed in as input parameters to the stored procedure.
The stored procedure uses dynamic SQL to build and execute the query that performs the chi-squared test. The query groups the data by the dependent and independent variables, counts the number of observations in each group, and calculates the expected value for each group.

Then it calculates the Chi-Squared statistic by summing the squared difference between the observed and expected values, divided by the expected values.

This stored procedure takes two input parameters: the dependent variable and a comma-separated list of independent variables. It then constructs a dynamic SQL statement that computes the Chi-Squared statistic, degrees of freedom, and P-value for the goodness of fit test. The dynamic SQL statement uses the input parameters to select the appropriate columns from the table and perform the necessary calculations. The stored procedure then executes the dynamic SQL statement, which returns the Chi-Squared statistic, degrees of freedom, and P-value for the test.

# Pearson
This stored procedure takes two input parameters: the dependent variable and a comma-separated list of independent variables. It then constructs a dynamic SQL statement that computes the Pearsons correlation coefficient between the dependent variable and independent variables. The dynamic SQL statement uses the input parameters to select the appropriate columns from the table and perform the necessary calculations. The stored procedure then executes the dynamic SQL statement, which returns the correlation coefficient.

Please note that you need to replace YOUR_TABLE with the name of your table in the stored procedure. Also, you may need to adjust the data type of the output parameter, depending on the data type of your dependent and independent variables. If you want to compute the correlation between multiple independent variables you need to add one more column to the table, which will store the combination of all independent variables.

