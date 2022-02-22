CREATE PROCEDURE UspGetEmployee
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT * FROM Fun_EmployeeInformation1()
END
GO

EXEC UspGetEmployee