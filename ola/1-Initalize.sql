DECLARE @CreateJobs nvarchar(max)
DECLARE @BackupDirectory nvarchar(max)
DECLARE @CleanupTime int
DECLARE @OutputFileDirectory nvarchar(max)
DECLARE @LogToTable nvarchar(max)
DECLARE @Version numeric(18,10)
DECLARE @Error int

SET @CreateJobs          = 'Y'          -- Specify whether jobs should be created.
SET @BackupDirectory     = N'C:\Backup' -- Specify the backup root directory.
SET @CleanupTime         = NULL         -- Time in hours, after which backup files are deleted. If no time is specified, then no backup files are deleted.
SET @OutputFileDirectory = NULL         -- Specify the output file directory. If no directory is specified, then the SQL Server error log directory is used.
SET @LogToTable          = 'Y'          -- Log commands to a table.

SET @Error = 0

SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))

IF IS_SRVROLEMEMBER('sysadmin') = 0
BEGIN
  RAISERROR('You need to be a member of the SysAdmin server role to install the solution.',16,1)
  SET @Error = @@ERROR
END

IF OBJECT_ID('tempdb..#Config') IS NOT NULL DROP TABLE #Config

CREATE TABLE #Config ([Name] nvarchar(max),
                      [Value] nvarchar(max))

IF @CreateJobs = 'Y' AND @OutputFileDirectory IS NULL AND SERVERPROPERTY('EngineEdition') <> 4 AND @Version < 12
BEGIN
  IF @Version >= 11
  BEGIN
    SELECT @OutputFileDirectory = [path]
    FROM sys.dm_os_server_diagnostics_log_configurations
  END
  ELSE
  BEGIN
    SELECT @OutputFileDirectory = LEFT(CAST(SERVERPROPERTY('ErrorLogFileName') AS nvarchar(max)),LEN(CAST(SERVERPROPERTY('ErrorLogFileName') AS nvarchar(max))) - CHARINDEX('\',REVERSE(CAST(SERVERPROPERTY('ErrorLogFileName') AS nvarchar(max)))))
  END
END

IF @CreateJobs = 'Y' AND RIGHT(@OutputFileDirectory,1) = '\' AND SERVERPROPERTY('EngineEdition') <> 4
BEGIN
  SET @OutputFileDirectory = LEFT(@OutputFileDirectory, LEN(@OutputFileDirectory) - 1)
END

INSERT INTO #Config ([Name], [Value])
VALUES('CreateJobs', @CreateJobs)

INSERT INTO #Config ([Name], [Value])
VALUES('BackupDirectory', @BackupDirectory)

INSERT INTO #Config ([Name], [Value])
VALUES('CleanupTime', @CleanupTime)

INSERT INTO #Config ([Name], [Value])
VALUES('OutputFileDirectory', @OutputFileDirectory)

INSERT INTO #Config ([Name], [Value])
VALUES('LogToTable', @LogToTable)

INSERT INTO #Config ([Name], [Value])
VALUES('DatabaseName', DB_NAME(DB_ID()))

INSERT INTO #Config ([Name], [Value])
VALUES('Error', CAST(@Error AS nvarchar))

IF OBJECT_ID('[dbo].[DatabaseBackup]') IS NOT NULL DROP PROCEDURE [dbo].[DatabaseBackup]
IF OBJECT_ID('[dbo].[DatabaseIntegrityCheck]') IS NOT NULL DROP PROCEDURE [dbo].[DatabaseIntegrityCheck]
IF OBJECT_ID('[dbo].[IndexOptimize]') IS NOT NULL DROP PROCEDURE [dbo].[IndexOptimize]
IF OBJECT_ID('[dbo].[CommandExecute]') IS NOT NULL DROP PROCEDURE [dbo].[CommandExecute]
