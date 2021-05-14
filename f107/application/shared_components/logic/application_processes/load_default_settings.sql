prompt --application/shared_components/logic/application_processes/load_default_settings
begin
--   Manifest
--     APPLICATION PROCESS: load default settings
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_flow_process(
 p_id=>wwv_flow_api.id(2951422693065225786)
,p_process_sequence=>1
,p_process_point=>'ON_NEW_INSTANCE'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'load default settings'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'eba_spatial_sample.get_map_defaults(',
'  :DEF_COUNTRY,',
'  :ORACLEMAPS_UNITSYSTEM,',
'  :DEF_MAPCENTER,',
'  :DEF_ZOOMLEVEL',
');',
':DISTANCE_UNIT := (case when :ORACLEMAPS_UNITSYSTEM = ''METRIC'' then ''km'' else ''mile'' end);',
'end;'))
,p_process_clob_language=>'PLSQL'
);
wwv_flow_api.component_end;
end;
/
