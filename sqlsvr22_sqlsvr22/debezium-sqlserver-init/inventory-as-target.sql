-- Create the test database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'inventory')
BEGIN
  CREATE DATABASE inventory;
END
GO
USE inventory;
GO
