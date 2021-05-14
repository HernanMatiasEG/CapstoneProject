prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
--   Manifest
--     MENU:  Breadcrumb
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_menu(
 p_id=>wwv_flow_api.id(46757783630288001762)
,p_name=>' Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(509890390269413312)
,p_short_name=>'Heat Map'
,p_link=>'f?p=&APP_ID.:25:&SESSION.'
,p_page_id=>25
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2145124671173611697)
,p_parent_id=>wwv_flow_api.id(2149930119225634292)
,p_short_name=>'Application Theme Style'
,p_link=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:::'
,p_page_id=>2
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2149930119225634292)
,p_short_name=>'Administration'
,p_link=>'f?p=&APP_ID.:3:&SESSION.'
,p_page_id=>3
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2174931770623172387)
,p_parent_id=>wwv_flow_api.id(2149930119225634292)
,p_short_name=>'Reset Data'
,p_link=>'f?p=&APP_ID.:99:&SESSION.'
,p_page_id=>99
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2929286490329111912)
,p_parent_id=>0
,p_short_name=>'Nearest Neighbor Search '
,p_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:::'
,p_page_id=>23
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2929311096162901441)
,p_parent_id=>0
,p_short_name=>'Area Of Interest Search'
,p_link=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:::'
,p_page_id=>24
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2929528595421424943)
,p_parent_id=>0
,p_short_name=>'Areas Of Interest'
,p_link=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:::'
,p_page_id=>61
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2950546804007316859)
,p_parent_id=>wwv_flow_api.id(46757784406573001781)
,p_short_name=>'About this application'
,p_link=>'f?p=&FLOW_ID.:201:&SESSION.'
,p_page_id=>201
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2951423410175243259)
,p_parent_id=>wwv_flow_api.id(2149930119225634292)
,p_short_name=>'Settings'
,p_link=>'f?p=&APP_ID.:71:&SESSION.::&DEBUG.:::'
,p_page_id=>71
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2957904709488736953)
,p_parent_id=>0
,p_short_name=>'Overview Map'
,p_link=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:::'
,p_page_id=>21
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2957909110126741175)
,p_parent_id=>0
,p_short_name=>'Within Distance Search'
,p_link=>'f?p=&APP_ID.:22:&SESSION.::&DEBUG.:::'
,p_page_id=>22
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2957918415183489862)
,p_parent_id=>0
,p_short_name=>'Addresses'
,p_link=>'f?p=&APP_ID.:52:&SESSION.::&DEBUG.:::'
,p_page_id=>52
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(2957924398163712283)
,p_parent_id=>wwv_flow_api.id(2957918415183489862)
,p_short_name=>'Edit Address'
,p_link=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:::'
,p_page_id=>51
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(3013436518014061271)
,p_parent_id=>wwv_flow_api.id(46757784406573001781)
,p_short_name=>'License Terms'
,p_link=>'f?p=&APP_ID.:44:&SESSION.::&DEBUG.:::'
,p_page_id=>44
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(46757784406573001781)
,p_parent_id=>0
,p_short_name=>'Home'
,p_link=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.'
,p_page_id=>1
);
wwv_flow_api.component_end;
end;
/
