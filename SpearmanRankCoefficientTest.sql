CREATE PROCEDURE SpearmanRankCoefficientTest
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
    -- Declare variable to store Spearman's rank coefficient
    DECLARE @SpearmanRankCoefficient FLOAT

    -- Compute Spearman's rank coefficient
    SELECT @SpearmanRankCoefficient = CORR(RANK(' + @DependentVariable + '), RANK(' + @IndependentVariables + '))
    FROM YOUR_TABLE
    WHERE ' + @IndependentVariables + ' IS NOT NULL
    AND ' + @DependentVariable + ' IS NOT NULL

    -- Select Spearman's rank coefficient
    SELECT @SpearmanRankCoefficient AS SpearmanRankCoefficient'

    -- Execute the dynamic SQL statement
    EXECUTE sp_executesql @SQL, N'@SpearmanRankCoefficient FLOAT OUTPUT', @SpearmanRankCoefficient OUTPUT
END
