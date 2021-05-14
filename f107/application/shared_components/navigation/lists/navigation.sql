prompt --application/shared_components/navigation/lists/navigation
begin
--   Manifest
--     LIST: Navigation
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
 p_id=>wwv_flow_api.id(46757784031487001770)
,p_name=>'Navigation'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2957910312237750832)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Addresses'
,p_list_item_link_target=>'f?p=&APP_ID.:52:&SESSION.::&DEBUG.:51:::'
,p_list_item_icon=>'fa-hospital-o'
,p_list_text_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Postal addresses ("Suppliers" and "Customers") can be maintained here, and you can geocode the addresses to determine their spatial coordinates.',
''))
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(2929545607670738390)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Areas Of Interest'
,p_list_item_link_target=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:61:::'
,p_list_item_icon=>'fa-compass'
,p_list_text_01=>'Create an "Area Of Interest" by clicking a polygon on a map. Use stored areas afterwards to find addresses within.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(4859547274026000890)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Overview Map'
,p_list_item_link_target=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:21:::'
,p_list_item_icon=>'fa-map-marker'
,p_list_text_01=>'A map showing the locations of stored addresses. Drag it around and observe the reports contents.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(4859547577230000890)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Within Distance Search'
,p_list_item_link_target=>'f?p=&APP_ID.:22:&SESSION.::&DEBUG.:22:::'
,p_list_item_icon=>'fa-crosshairs'
,p_list_text_01=>'Click a position on the map and find addresses within a given distance.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(4859547864220000890)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Nearest Neighbor Search'
,p_list_item_link_target=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23:::'
,p_list_item_icon=>'fa-code-fork'
,p_list_text_01=>'Choose a "Supplier" address and find closest "Customer" addresses.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(4859548158841000891)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Area Of Interest Search'
,p_list_item_link_target=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:24:::'
,p_list_item_icon=>'fa-circle-o'
,p_list_text_01=>'Choose a stored Area Of Interest and find addresses within it.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(509904571674531930)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'Heat Map'
,p_list_item_link_target=>'f?p=&APP_ID.:25:&SESSION.::&DEBUG.:25:::'
,p_list_item_icon=>'fa-bullseye'
,p_list_text_01=>'View address locations as a "Heat Map"'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.component_end;
end;
/
