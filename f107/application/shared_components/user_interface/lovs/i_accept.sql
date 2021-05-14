prompt --application/shared_components/user_interface/lovs/i_accept
begin
--   Manifest
--     I ACCEPT
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
 p_id=>wwv_flow_api.id(3013420017663019406)
,p_lov_name=>'I ACCEPT'
,p_lov_query=>'.'||wwv_flow_api.id(3013420017663019406)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(3013420292653019406)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>' I Accept'
,p_lov_return_value=>'ACCEPTED'
);
wwv_flow_api.component_end;
end;
/
