CREATE PROCEDURE UspInsertEmployee(@EmployeeDetails [UT_Employees1]ReadOnly)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--insert query
	INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth)
	SELECT * FROM @EmployeeDetails

	
END
GO

EXEC UspInsertEmployee
