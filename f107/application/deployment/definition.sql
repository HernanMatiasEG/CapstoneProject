prompt --application/deployment/definition
begin
--   Manifest
--     INSTALL: 107
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_install(
 p_id=>wwv_flow_api.id(46757835926195345171)
,p_welcome_message=>'This application installer will guide you through the process of creating your database objects and seed data. '
,p_configuration_message=>'You can configure the following attributes of your application.'
,p_build_options_message=>'You can choose to include the following build options.'
,p_validation_message=>'The following validations will be performed to ensure your system is compatible with this application.'
,p_install_message=>'Please confirm that you would like to install this application''s supporting objects.'
,p_install_success_message=>'Your application''s supporting objects have been installed.'
,p_install_failure_message=>'Installation of database objects and seed data has failed.'
,p_upgrade_message=>'The application installer has detected that this application''s supporting objects were previously installed.  This wizard will guide you through the process of upgrading these supporting objects.'
,p_upgrade_confirm_message=>'Please confirm that you would like to install this application''s supporting objects.'
,p_upgrade_success_message=>'Your application''s supporting objects have been installed.'
,p_upgrade_failure_message=>'Installation of database objects and seed data has failed.'
,p_deinstall_success_message=>'Deinstallation complete.'
,p_deinstall_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'drop table eba_spatial_addresses cascade constraints',
'/',
'',
'drop table eba_spatial_aoi cascade constraints',
'/',
'    ',
'drop table eba_spatial_countries cascade constraints',
'/',
'',
'drop table eba_spatial_defaults cascade constraints;',
'/',
'',
'drop package eba_spatial_sample ',
'/',
'',
'drop package eba_spatial_gcdr_pkg ',
'/',
'',
'drop sequence eba_spatial_id',
'/',
'    ',
'begin',
'  apex_spatial.delete_geom_metadata(',
'    p_table_name => ''EBA_SPATIAL_ADDRESSES'',',
'    p_column_name => ''ADDR_LOCATION''',
'  );',
'end;',
'/',
'',
'begin',
'  apex_spatial.delete_geom_metadata(',
'    p_table_name => ''EBA_SPATIAL_AOI'',',
'    p_column_name => ''GEOMETRY''',
'  );',
'end;',
'/',
'    ',
'',
'    ',
'',
'',
''))
,p_required_free_kb=>100
,p_required_sys_privs=>'CREATE PROCEDURE:CREATE SEQUENCE:CREATE TABLE:CREATE TRIGGER:CREATE VIEW'
,p_required_names_available=>'EBA_SPATIAL_ADDRESSES:EBA_SPATIAL_ADDRESSES_BI:EBA_SPATIAL_AOI:EBA_SPATIAL_AOI_BI:EBA_SPATIAL_COUNTRIES:EBA_SPATIAL_DEFAULTS:EBA_SPATIAL_ID:EBA_SPATIAL_SAMPLE:EBA_SPATIAL_GCDR_PKG'
);
wwv_flow_api.component_end;
end;
/
