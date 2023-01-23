CREATE PROCEDURE OneWayANOVA
    -- Declare input parameters
    -- @DependentVariable: Name of the dependent variable in the table
    -- @IndependentVariable: Name of the independent variable in the table
    @DependentVariable NVARCHAR(50),
    @IndependentVariable NVARCHAR(50)
AS
BEGIN
    -- Declare variables to store dynamic SQL statement and parameters
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @Parms NVARCHAR(MAX)

    -- Build dynamic SQL statement
    SET @SQL = '
    -- Declare variables to store F statistic and P-value
    DECLARE @FStatistic FLOAT
    DECLARE @PValue FLOAT

    -- Compute F statistic and P-value
    SELECT @FStatistic = F.FStat, @PValue = F.PValue
    FROM (
        SELECT SUM(SQUARE(AVG(CASE WHEN ' + @IndependentVariable + ' = i.' + @IndependentVariable + ' THEN ' + @DependentVariable + ' END) - AVG(' + @DependentVariable + '))) / (COUNT(DISTINCT ' + @IndependentVariable + ') - 1) AS BetweenGroup,
               SUM(SQUARE(' + @DependentVariable + ' - AVG(CASE WHEN ' + @IndependentVariable + ' = i.' + @IndependentVariable + ' THEN ' + @DependentVariable + ' END))) / (COUNT(*) - COUNT(DISTINCT ' + @IndependentVariable + ')) AS WithinGroup
        FROM YOUR_TABLE
        JOIN (SELECT DISTINCT ' + @IndependentVariable + ' FROM YOUR_TABLE) AS i
        ON ' + @IndependentVariable + ' = i.' + @IndependentVariable + '
    ) AS SS
    CROSS APPLY(VALUES(SQRT(SS.BetweenGroup / SS.WithinGroup * (COUNT(*) - COUNT(DISTINCT ' + @IndependentVariable + ')) / (COUNT(DISTINCT ' + @IndependentVariable + ') - 1)),
                    1 - F.CDF(SQRT(SS.BetweenGroup / SS.WithinGroup * (COUNT(*) - COUNT(DISTINCT ' + @IndependentVariable + ')) / (COUNT(DISTINCT ' + @IndependentVariable + ') - 1)), COUNT(DISTINCT ' + @IndependentVariable + ') - 1, COUNT(*) - COUNT(DISTINCT ' + @IndependentVariable + ')) AS F(FStat, PValue, DF_num, DF_denom)
    '

    -- Execute the dynamic SQL statement
    EXECUTE sp_executesql @SQL, N'@FStatistic FLOAT OUTPUT, @PValue FLOAT OUTPUT', @FStatistic OUTPUT, @PValue OUTPUT
END
