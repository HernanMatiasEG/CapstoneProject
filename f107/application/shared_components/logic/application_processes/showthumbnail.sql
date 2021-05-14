prompt --application/shared_components/logic/application_processes/showthumbnail
begin
--   Manifest
--     APPLICATION PROCESS: showThumbnail
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
 p_id=>wwv_flow_api.id(46757797012421331452)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'showThumbnail'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  eba_spatial_sample.show_image(',
'    p_id            => apex_application.g_x01,',
'    p_img_or_thumb  => ''T'',',
'    p_disposition   => ''inline''',
'  );',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
);
wwv_flow_api.component_end;
end;
/
