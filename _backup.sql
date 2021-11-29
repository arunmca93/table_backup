drop function if exists _backup;
create or replace function _backup(tablename character varying, backup_type character varying) 
returns character varying
language plpgsql
as
$$

declare 

temp_backup_name character varying default '';
query character varying default '';

begin

temp_backup_name = tablename || '_' || to_char(now(),'YYYYMMDD_HH24MI_SS');

if backup_type='TAB' or backup_type='TVIW' THEN
query='create table ' || temp_backup_name || ' as select * from ' || tablename;
EXECUTE query;

END IF;

IF backup_type='VIW' or backup_type='TVIW' THEN
query='create view vw_' || temp_backup_name || ' as select * from ' || tablename;
EXECUTE query;
END IF;

raise notice '%s',query;
return 'Backuped name ' || temp_backup_name;

end;
$$


-- select _backup('YOUR_TABLE_NAME','TVIW');
