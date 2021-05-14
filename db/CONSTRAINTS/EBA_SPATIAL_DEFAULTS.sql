--------------------------------------------------------
--  Constraints for Table EBA_SPATIAL_DEFAULTS
--------------------------------------------------------

  ALTER TABLE "EBA_SPATIAL_DEFAULTS" MODIFY ("PARAM" NOT NULL ENABLE);
  ALTER TABLE "EBA_SPATIAL_DEFAULTS" MODIFY ("VALUE" NOT NULL ENABLE);
  ALTER TABLE "EBA_SPATIAL_DEFAULTS" ADD PRIMARY KEY ("PARAM") USING INDEX  ENABLE;
