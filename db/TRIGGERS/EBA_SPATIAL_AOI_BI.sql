--------------------------------------------------------
--  DDL for Trigger EBA_SPATIAL_AOI_BI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "EBA_SPATIAL_AOI_BI" 
before insert on eba_spatial_aoi
for each row
begin
  select eba_spatial_id.nextval into :new.id from dual;
  :new.datetime := systimestamp;
end;

/
ALTER TRIGGER "EBA_SPATIAL_AOI_BI" ENABLE;
