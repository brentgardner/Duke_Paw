EXECUTE sp_addrolemember @rolename = N'db_datareader', @membername = N'TIGERNATURALGAS\MyTiger_GasControlUsers';


GO
EXECUTE sp_addrolemember @rolename = N'db_datawriter', @membername = N'TIGERNATURALGAS\MyTiger_GasControlUsers';

