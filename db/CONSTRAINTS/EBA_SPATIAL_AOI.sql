--------------------------------------------------------
--  Constraints for Table EBA_SPATIAL_AOI
--------------------------------------------------------

  ALTER TABLE "EBA_SPATIAL_AOI" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "EBA_SPATIAL_AOI" MODIFY ("AOI_NAME" NOT NULL ENABLE);
  ALTER TABLE "EBA_SPATIAL_AOI" ADD CONSTRAINT "EBA_SPATIAL_AOI_PK" PRIMARY KEY ("ID") USING INDEX  ENABLE;
