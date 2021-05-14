prompt --application/shared_components/logic/application_processes/check_requirements
begin
--   Manifest
--     APPLICATION PROCESS: Check Requirements
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
 p_id=>wwv_flow_api.id(3013490218440090394)
,p_process_sequence=>1
,p_process_point=>'ON_NEW_INSTANCE'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Check Requirements'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_qres   number:= 0;',
'  l_result varchar2(1 CHAR) := ''Y'';',
'begin',
'  if dbms_db_version.ver_le_10_2 then l_result := ''N''; end if;',
'  begin',
'    select 1 into l_qres from all_types',
'    where type_name=''SDO_GEOMETRY'' and owner=''MDSYS''  and rownum = 1;',
'  exception',
'    when NO_DATA_FOUND then l_result := ''N'';',
'  end;',
' ',
'  begin',
'    select 1 into l_qres',
'    from all_objects',
'    where object_name=''WWV_FLOW_SPATIAL_API'' and object_type=''PACKAGE'' and rownum = 1;',
'  exception',
'    when NO_DATA_FOUND then l_result := ''N'';',
'  end;',
'',
'  :REQUIREMENTS_MET := l_result;',
'end;'))
,p_process_clob_language=>'PLSQL'
);
wwv_flow_api.component_end;
end;
/
