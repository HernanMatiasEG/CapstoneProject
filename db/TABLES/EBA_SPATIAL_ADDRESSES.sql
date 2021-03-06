--------------------------------------------------------
--  DDL for Table EBA_SPATIAL_ADDRESSES
--------------------------------------------------------

  CREATE TABLE "EBA_SPATIAL_ADDRESSES" ("ID" NUMBER(10,0), "ADDR_NAME" VARCHAR2(200), "ADDR_STREET" VARCHAR2(200), "ADDR_POSTAL_CODE" VARCHAR2(20), "ADDR_CITY" VARCHAR2(200), "ADDR_STATE" VARCHAR2(200), "ADDR_COUNTRY" VARCHAR2(200), "ADDR_TYPE" VARCHAR2(20), "OWNER" VARCHAR2(200), "DATETIME" TIMESTAMP (6) WITH TIME ZONE, "ADDR_LOCATION" "SDO_GEOMETRY")  VARRAY "ADDR_LOCATION"."SDO_ELEM_INFO" STORE AS SECUREFILE LOB  VARRAY "ADDR_LOCATION"."SDO_ORDINATES" STORE AS SECUREFILE LOB ;
