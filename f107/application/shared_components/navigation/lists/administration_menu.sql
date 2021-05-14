prompt --application/shared_components/navigation/lists/administration_menu
begin
--   Manifest
--     LIST: Administration Menu
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(2149923222880628191)
,p_name=>'Administration Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2149923492656628192)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Manage Settings'
,p_list_item_link_target=>'f?p=&APP_ID.:71:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-gear'
,p_list_text_01=>'Set initial map focus area and unit system.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2149923830969628193)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Theme Style'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-desktop'
,p_list_text_01=>'Set application user interface theme style for all users.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2174919806153147264)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Reset Data'
,p_list_item_link_target=>'f?p=&APP_ID.:99:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-refresh'
,p_list_text_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This application stores addresses and areas of interest in tables with the EBA_SPATIAL prefix.  Use this link to remove all rows from these tables.',
''))
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.component_end;
end;
/
