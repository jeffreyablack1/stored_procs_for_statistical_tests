CREATE PROCEDURE PearsonsCorrelationTest
    -- Declare input parameters
    -- @DependentVariable: Name of the dependent variable in the table
    -- @IndependentVariables: Comma separated list of independent variables in the table
    @DependentVariable NVARCHAR(50),
    @IndependentVariables NVARCHAR(MAX)
AS
BEGIN
    -- Declare variables to store dynamic SQL statement and parameters
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @Parms NVARCHAR(MAX)

    -- Build dynamic SQL statement
    SET @SQL = '
    -- Declare variable to store correlation coefficient
    DECLARE @CorrelationCoefficient FLOAT

    -- Compute correlation coefficient
    SELECT @CorrelationCoefficient = CORR(' + @DependentVariable + ', ' + @IndependentVariables + ')
    FROM YOUR_TABLE

    -- Select correlation coefficient
    SELECT @CorrelationCoefficient AS CorrelationCoefficient'

    -- Execute the dynamic SQL statement
    EXECUTE sp_executesql @SQL, N'@CorrelationCoefficient FLOAT OUTPUT', @CorrelationCoefficient OUTPUT
END
