CREATE PROCEDURE RunStatisticalTest
    @DependentVariable NVARCHAR(50),
    @IndependentVariables NVARCHAR(MAX)
AS
BEGIN
    DECLARE @DependentDataType NVARCHAR(50)
    DECLARE @IndependentDataType NVARCHAR(50)
    DECLARE @SQL NVARCHAR(MAX)

    -- Get the data type of dependent variable
    SELECT @DependentDataType = DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'YOUR_TABLE' AND COLUMN_NAME = @DependentVariable

    -- Get the data type of independent variable
    SELECT @IndependentDataType = DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'YOUR_TABLE' AND COLUMN_NAME = @IndependentVariables

    -- Check the data types and run the appropriate test
    IF @DependentDataType = 'int' OR @DependentDataType = 'float' AND @IndependentDataType = 'int' OR @IndependentDataType = 'float'
    BEGIN
        -- Run Pearson's Correlation Coefficient test
        SET @SQL = 'EXEC PearsonsCorrelationTest ' + @DependentVariable + ', ' + @IndependentVariables
        EXEC (@SQL)
    END
    ELSE IF @DependentDataType = 'int' OR @DependentDataType = 'float' AND @IndependentDataType = 'varchar' OR @IndependentDataType = 'nvarchar'
    BEGIN
        -- Run One Way ANOVA test
        SET @SQL = 'EXEC OneWayANOVA ' + @DependentVariable + ', ' + @IndependentVariables
        EXEC (@SQL)
    END
    ELSE IF @DependentDataType = 'varchar' OR @DependentDataType = 'nvarchar' AND @IndependentDataType = 'varchar' OR @IndependentDataType = 'nvarchar'
    BEGIN
        -- Run Chi Squared Goodness of Fit test
        SET @SQL = 'EXEC ChiSquaredGoodnessOfFitTest ' + @DependentVariable + ', ' + @IndependentVariables
        EXEC (@SQL)
    END
    ELSE
    BEGIN
        PRINT 'The data types of dependent and independent variables are not compatible with any of the available tests'
    END
END
