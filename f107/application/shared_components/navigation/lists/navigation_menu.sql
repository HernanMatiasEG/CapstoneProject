prompt --application/shared_components/navigation/lists/navigation_menu
begin
--   Manifest
--     LIST: Navigation Menu
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
 p_id=>wwv_flow_api.id(2134555295693494797)
,p_name=>'Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2134555322096494804)
,p_list_item_display_sequence=>5
,p_list_item_link_text=>'Home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1,201'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2134555467851494804)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Addresses'
,p_list_item_link_target=>'f?p=&APP_ID.:52:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-hospital-o'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'51,52'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2134555694087494804)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Areas of Interest'
,p_list_item_link_target=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:61:::'
,p_list_item_icon=>'fa-compass'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'61,62'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2142348400578731755)
,p_list_item_display_sequence=>25
,p_list_item_link_text=>'Overview Map'
,p_list_item_link_target=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:21:::'
,p_list_item_icon=>'fa-map-marker'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2142663004441862336)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Within Distance Search'
,p_list_item_link_target=>'f?p=&APP_ID.:22:&SESSION.::&DEBUG.:22:::'
,p_list_item_icon=>'fa-crosshairs'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2142666196667883290)
,p_list_item_display_sequence=>35
,p_list_item_link_text=>'Nearest Neighbor'
,p_list_item_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23:::'
,p_list_item_icon=>'fa-code-fork'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2142664622713869540)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Area Of Interest Search'
,p_list_item_link_target=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:24:::'
,p_list_item_icon=>'fa-circle-o'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(509889896617413281)
,p_list_item_display_sequence=>45
,p_list_item_link_text=>'Heat Map'
,p_list_item_link_target=>'f?p=&APP_ID.:25:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-bullseye'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'25'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2149929249404634290)
,p_list_item_display_sequence=>65
,p_list_item_link_text=>'Administration'
,p_list_item_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-gear'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'3,71,2'
);
wwv_flow_api.component_end;
end;
/
