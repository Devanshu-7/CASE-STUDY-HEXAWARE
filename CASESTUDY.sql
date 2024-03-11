CREATE DATABASE PAYDBX
USE PAYDBX
-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255),
    Position VARCHAR(100),
    JoiningDate DATE,
    TerminationDate DATE NULL
);

-- Payroll Table
CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY,
    EmployeeID INT,
    PayPeriodStartDate DATE,
    PayPeriodEndDate DATE,
    BasicSalary DECIMAL(10, 2),
    OvertimePay DECIMAL(10, 2),
    Deductions DECIMAL(10, 2),
    NetSalary DECIMAL(10, 2),
	 FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Tax Table
CREATE TABLE Tax (
    TaxID INT PRIMARY KEY,
    EmployeeID INT,
    TaxYear INT,
    TaxableIncome DECIMAL(10, 2),
    TaxAmount DECIMAL(10, 2),
	FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- FinancialRecord Table
CREATE TABLE FinancialRecord (
    RecordID INT PRIMARY KEY,
    EmployeeID INT,
    RecordDate DATE,
    Description VARCHAR(255),
    Amount DECIMAL(10, 2),
    RecordType VARCHAR(20),
	FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Insert data into Employee Table
	INSERT INTO Employee (EmployeeID, FirstName, LastName, DateOfBirth, Gender, Email, PhoneNumber, Address, Position, JoiningDate, TerminationDate) VALUES
	(1, 'Monkey', 'D.', '1990-05-05', 'Male', 'luffy@strawhats.com', '1234567890', 'Windmill Village', 'Captain', '2000-07-07', NULL),
	(2, 'Roronoa', 'Zoro', '1981-11-11', 'Male', 'zoro@strawhats.com', '9876543210', 'Kuraigana Island', 'Swordsman', '2000-08-07', NULL),
	(3, 'Nami', 'San', '1993-07-03', 'Female', 'nami@strawhats.com', '5555555555', 'Cocoyasi Village', 'Navigator', '2000-09-07', NULL),
	(4, 'Usopp', 'San', '1990-04-01', 'Male', 'usopp@strawhats.com', '1112223333', 'Syrup Village', 'Sniper', '2000-10-07', NULL),
	(5, 'Sanji', 'San', '1980-03-02', 'Male', 'sanji@strawhats.com', '7778889999', 'Baratie', 'Cook', '2000-11-07', NULL);

-- Insert data into Payroll Table
	INSERT INTO Payroll (PayrollID, EmployeeID, PayPeriodStartDate, PayPeriodEndDate, BasicSalary, OvertimePay, Deductions, NetSalary) VALUES
	(1, 1, '2024-03-01', '2024-03-15', 5000.00, 1000.00, 500.00, 5500.00),
	(2, 2, '2024-03-01', '2024-03-15', 6000.00, 1200.00, 600.00, 6600.00),
	(3, 3, '2024-03-01', '2024-03-15', 5500.00, 1100.00, 550.00, 6050.00),
	(4, 4, '2024-03-01', '2024-03-15', 5200.00, 1040.00, 520.00, 5720.00),
	(5, 5, '2024-03-01', '2024-03-15', 7000.00, 1400.00, 700.00, 7700.00);

-- Insert data into Tax Table
	INSERT INTO Tax (TaxID, EmployeeID, TaxYear, TaxableIncome, TaxAmount) VALUES
	(1, 1, 2024, 60000.00, 12000.00),
	(2, 2, 2024, 72000.00, 14400.00),
	(3, 3, 2024, 66000.00, 13200.00),
	(4, 4, 2024, 62400.00, 12480.00),
	(5, 5, 2024, 84000.00, 16800.00);

-- Insert data into FinancialRecord Table
	INSERT INTO FinancialRecord (RecordID, EmployeeID, RecordDate, Description, Amount, RecordType) VALUES
	(1, 1, '2024-03-01', 'Bonus', 1000.00, 'Income'),
	(2, 2, '2024-03-01', 'Overtime Pay', 200.00, 'Income'),
	(3, 3, '2024-03-01', 'Travel Expenses', 50.00, 'Expense'),
	(4, 4, '2024-03-01', 'Equipment Purchase', 30.00, 'Expense'),
	(5, 5, '2024-03-01', 'Tax Payment', 1000.00, 'Tax');


-- IEmployeeService: 
--GetEmployeeById(employeeId) 
	SELECT * FROM Employee WHERE EmployeeID = ?;

--GetAllEmployees() 
	SELECT * FROM Employee;

-- AddEmployee(employeeData) 
	INSERT INTO Employee (FirstName, LastName, DateOfBirth, Gender, Email, PhoneNumber, Address, Position, JoiningDate, TerminationDate)
	VALUES ('brook', 'lululu', '1800-02-01', 'Male', 'immortalbrook@strawhats.com', '9876234510', 'Blue Sea', 'Musician', '2000-12-07', 'Null');

--UpdateEmployee(employeeData) 
	UPDATE Employee
	SET FirstName = '', LastName = '', DateOfBirth = '', Gender = '', Email = '', PhoneNumber = '', Address = '', Position = '', JoiningDate = '', TerminationDate = ''
	WHERE EmployeeID = 0;

--RemoveEmployee(employeeId) 
	DELETE FROM Employee WHERE EmployeeID = 0;

IPayrollService: 
-- GeneratePayroll(eId, startDate, endDate) 
	SELECT 
		e.EmployeeID,
		e.FirstName,
		e.LastName,
		p.PayPeriodStartDate,
		p.PayPeriodEndDate,
		SUM(p.BasicSalary + p.OvertimePay - p.Deductions) AS TotalPayroll
	FROM 
		Employee e
	JOIN 
		Payroll p ON e.EmployeeID = p.EmployeeID
	WHERE 
		e.EmployeeID = eId AND
		p.PayPeriodStartDate >= startDate AND
		p.PayPeriodEndDate <= endDate
	GROUP BY 
		e.EmployeeID, e.FirstName, e.LastName, p.PayPeriodStartDate, p.PayPeriodEndDate;

--GetPayrollById(payrollId) 
	SELECT * FROM Payroll WHERE PayrollID = 0;

--GetPayrollsForEmployee(employeeId) 
	SELECT * FROM Payroll WHERE EmployeeID = 0;

--GetPayrollsForPeriod(startDate, endDate) 
	SELECT * FROM Payroll WHERE PayPeriodStartDate >= startDate AND PayPeriodEndDate <= endDate;


--ITaxService: 
-- CalculateTax(EId, YearOFTAX) 
	SELECT TaxAmount FROM TAX WHERE EmployeeID = EID AND TaxYear = YEAROFTAX;

--GetTaxById(taxId) 
	SELECT TAXAMOUNT FROM TAX WHERE TAXID = 0;

--GetTaxesForEmployee(employeeId) 
	SELECT * FROM Tax WHERE EmployeeID = 0;

--GetTaxesForYear(taxYear) 
	SELECT * FROM Tax WHERE TaxYear = 2024;

--IFinancialRecordService: 
--AddFinancialRecord(employeeId, description, amount, recordType) 
	INSERT INTO FinancialRecord (RecordID, EmployeeID, RecordDate, Description, Amount, RecordType) VALUES
	(6, 6, '2024-03-01', 'Bonus', 1000.00, 'Income');

--GetFinancialRecordById(recordId) 
	SELECT * FROM FinancialRecord Where RecordID = 6;

--GetFinancialRecordsForEmployee(employeeId)
	SELECT * FROM FinancialRecord Where RecordID = 6;

--GetFinancialRecordsForDate(recordDate) 
	SELECT * FROM FinancialRecord Where RecordDate = 'yyyy-mm-dd';

