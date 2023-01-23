# Chi2_Goodness_of_Fit_Stored_Proc
This is a stored proc for running the chi2 goodness of fit test. 

This stored procedure will return the Chi-Squared statistic, the degrees of freedom, and the P-value for the test.

Note: You need to replace YOUR_TABLE with the name of your table in the stored procedure. Also you may need to adjust the data types of the input and output parameters, depending on the data type of your dependent and independent variables.

You would call this stored procedure by passing in the name of your dependent variable and a comma-separated list of independent variables. 
For example:
EXEC ChiSquaredGoodnessOfFitTest 'Gender', 'Age, Income'

This stored procedure performs a chi-squared goodness of fit test between a dependent variable and multiple independent variables. The dependent variable and independent variables are passed in as input parameters to the stored procedure.
The stored procedure uses dynamic SQL to build and execute the query that performs the chi-squared test. The query groups the data by the dependent and independent variables, counts the number of observations in each group, and calculates the expected value for each group.

Then it calculates the Chi-Squared statistic by summing the squared difference between the observed and expected values, divided by the expected values.


