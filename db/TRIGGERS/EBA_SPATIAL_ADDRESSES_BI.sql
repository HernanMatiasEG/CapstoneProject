--------------------------------------------------------
--  DDL for Trigger EBA_SPATIAL_ADDRESSES_BI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "EBA_SPATIAL_ADDRESSES_BI" 
before insert on eba_spatial_addresses
for each row
begin
  select eba_spatial_id.nextval into :new.id from dual;
  :new.datetime := systimestamp;
end;

/
ALTER TRIGGER "EBA_SPATIAL_ADDRESSES_BI" ENABLE;
