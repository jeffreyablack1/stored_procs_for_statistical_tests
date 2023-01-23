CREATE PROCEDURE ChiSquaredGoodnessOfFitTest
    -- Declare the input parameters for the stored procedure
    @DependentVariable NVARCHAR(50), -- The dependent variable for the test
    @IndependentVariables NVARCHAR(MAX) -- A comma-separated list of independent variables for the test
AS
BEGIN
    -- Declare variables to hold the dynamic SQL and parameter definitions
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @Parms NVARCHAR(MAX)

    -- Build the dynamic SQL statement
    SET @SQL = '
    -- Declare variables to hold the Chi-Squared statistic, degrees of freedom, and P-value
    DECLARE @ChiSquared FLOAT
    DECLARE @DegreesOfFreedom INT
    DECLARE @PValue FLOAT

    -- Initialize the Chi-Squared and degrees of freedom variables
    SET @ChiSquared = 0
    SET @DegreesOfFreedom = 0

    -- Perform the Chi-Squared goodness of fit test
    SELECT @ChiSquared = SUM(POWER(OBSERVED - EXPECTED, 2) / EXPECTED)
    FROM (
        SELECT ' + @DependentVariable + ' AS DEPENDENT, COUNT(*) AS OBSERVED, 
        SUM(COUNT(*)) OVER (PARTITION BY ' + @IndependentVariables + ') / COUNT(*) AS EXPECTED
        FROM YOUR_TABLE
        GROUP BY ' + @DependentVariable + ', ' + @IndependentVariables + '
    ) AS T

    -- Calculate the degrees of freedom for the test
    SET @DegreesOfFreedom = (SELECT COUNT(DISTINCT ' + @IndependentVariables + ') - 1) * (SELECT COUNT(DISTINCT ' + @DependentVariable + ') - 1)

    -- Calculate the P-value for the test
    SET @PValue = 1 - CHISQ.CDF(@ChiSquared, @DegreesOfFreedom)

    -- Return the Chi-Squared statistic, degrees of freedom, and P-value
    SELECT @ChiSquared AS ChiSquared, @DegreesOfFreedom AS DegreesOfFreedom, @PValue AS PValue
    '

    -- Execute the dynamic SQL statement and return the output parameters
    EXECUTE sp_executesql @SQL, N'@ChiSquared FLOAT OUTPUT, @DegreesOfFreedom INT OUTPUT, @PValue FLOAT OUTPUT', @ChiSquared OUTPUT, @DegreesOfFreedom OUTPUT, @PValue OUTPUT
END
