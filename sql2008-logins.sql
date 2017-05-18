use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'appAdmin')
CREATE LOGIN [appAdmin] WITH PASSWORD = 0x010078D465BE65DAF3B59593301B62F6199E86E70E83A542E19F HASHED, SID = 0x9243AF88BBE7B74EB83607393A9BB427, DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = [us_english]
;
use master
;
Grant CONNECT SQL TO [appAdmin]  AS [sa]
;
use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'BASE\ctrlb')
CREATE LOGIN [BASE\ctrlb] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english]
;
ALTER SERVER ROLE [sysadmin] ADD MEMBER [BASE\ctrlb]
;
use master
;
Grant CONNECT SQL TO [BASE\ctrlb]  AS [sa]
;
use [locations]
;
CREATE USER [dbo] FOR LOGIN [BASE\ctrlb] WITH DEFAULT_SCHEMA=[dbo]
;
use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'BASE\developers')
CREATE LOGIN [BASE\developers] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english]
;
ALTER SERVER ROLE [sysadmin] ADD MEMBER [BASE\developers]
;
use master
;
Grant CONNECT SQL TO [BASE\developers]  AS [sa]
;
use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'BASE\powershell')
CREATE LOGIN [BASE\powershell] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english]
;
ALTER SERVER ROLE [sysadmin] ADD MEMBER [BASE\powershell]
;
use master
;
Grant CONNECT SQL TO [BASE\powershell]  AS [sa]
;
use [dbOrphanUsers]
;
CREATE USER [BASE\powershell] FOR LOGIN [BASE\powershell] WITH DEFAULT_SCHEMA=[dbo]
;
Grant CONNECT TO [BASE\powershell]  AS [dbo]
;
use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'BASE\sqlserver')
CREATE LOGIN [BASE\sqlserver] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english]
;
use master
;
Grant CONNECT SQL TO [BASE\sqlserver]  AS [sa]
;
use [dbareports]
;
CREATE USER [base\sqlserver] FOR LOGIN [BASE\sqlserver] WITH DEFAULT_SCHEMA=[dbo]
;
ALTER ROLE [db_owner] ADD MEMBER [BASE\sqlserver]
;
Grant CONNECT TO [BASE\sqlserver]  AS [dbo]
;
use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'claudio')
CREATE LOGIN [claudio] WITH PASSWORD = 0x01007AFBE41E51C2BA13A4DCACAEF5550193D4162EC68BEC5D5C HASHED, SID = 0x7CFEA5B0AA57C1448C9C9E73FEDABB14, DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = [us_english]
;
ALTER SERVER ROLE [sysadmin] ADD MEMBER [claudio]
;
use master
;
Grant CONNECT SQL TO [claudio]  AS [sa]
;
use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'poo')
CREATE LOGIN [poo] WITH PASSWORD = 0x0100AD1724083AE1A9F1EACB5D11AF84F02381997BF04C5E08A8 HASHED, SID = 0xCDE7FE91A1C4E2439EB8CB47A8E8659B, DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = [Português]
;
use master
;
Grant CONNECT SQL TO [poo]  AS [sa]
;
use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'restoretest')
CREATE LOGIN [restoretest] WITH PASSWORD = 0x0100F1E0792D4A03F62A150400E8C56497865BAEF985B9F0D5E1 HASHED, SID = 0x2F265FC5C83A4846BA4B05B07AA2DC82, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = [us_english]
;
use master
;
Grant CONNECT SQL TO [restoretest]  AS [sa]
;
use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'ToMigrate')
CREATE LOGIN [ToMigrate] WITH PASSWORD = 0x01008C53E6DD44148957F914F696C9DC6510C95641C36D7843EB HASHED, SID = 0x1D24BEF9D9162642AFF9D87E7BED3F6C, DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = [us_english]
;
use master
;
Grant CONNECT SQL TO [ToMigrate]  AS [sa]
;
use master
;
IF NOT EXISTS (SELECT loginname from master.dbo.syslogins where name = 'UserNOTOrphan')
CREATE LOGIN [UserNOTOrphan] WITH PASSWORD = 0x0100EE636E136FE37F41874BAC9B45D39AD49E1970CEE0217EB3 HASHED, SID = 0x4098E21C1747E342A09CDAF6A55E099B, DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = [us_english]
;
use master
;
Grant CONNECT SQL TO [UserNOTOrphan]  AS [sa]
;
use [dbOrphanUsers]
;
CREATE USER [dbo] FOR LOGIN [UserNOTOrphan] WITH DEFAULT_SCHEMA=[dbo]
