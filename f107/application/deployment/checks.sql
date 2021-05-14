prompt --application/deployment/checks
begin
--   Manifest
--     INSTALL CHECKS: 107
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_install_check(
 p_id=>wwv_flow_api.id(1500342370282943785)
,p_install_id=>wwv_flow_api.id(46757835926195345171)
,p_name=>'Has Oracle Spatial Been Installed Yet?'
,p_sequence=>10
,p_check_type=>'FUNCTION_BODY'
,p_check_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_type_name varchar2(30);',
'begin',
'    select TYPE_NAME into l_type_name from sys.all_types where owner = ''MDSYS'' and type_name = ''SDO_GEOMETRY'';',
'    return true;',
'exception',
'    when no_data_found then',
'        return false;',
'end;'))
,p_check_condition2=>'PLSQL'
,p_condition_type=>'ALWAYS'
,p_failure_message=>'This database requires the "Oracle Locator" feature or the "Oracle Spatial" database option before this application can be installed. Please contact your database administrator.'
);
wwv_flow_api.component_end;
end;
/
