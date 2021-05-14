prompt --application/shared_components/user_interface/lovs/view_options
begin
--   Manifest
--     VIEW OPTIONS
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(2430119217531199555)
,p_lov_name=>'VIEW OPTIONS'
,p_lov_query=>'.'||wwv_flow_api.id(2430119217531199555)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(2430119539505199563)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Cards'
,p_lov_return_value=>'C'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(2430119987893199573)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Interactive Report'
,p_lov_return_value=>'I'
);
wwv_flow_api.component_end;
end;
/
