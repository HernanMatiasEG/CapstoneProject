prompt --application/pages/page_00021
begin
--   Manifest
--     PAGE: 00021
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_page(
 p_id=>21
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Overview Map'
,p_alias=>'OVERVIEW-MAP'
,p_step_title=>'Overview Map'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'CARSTEN'
,p_last_upd_yyyymmddhh24miss=>'20200628113921'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(230692326169241437)
,p_name=>'Suppliers'
,p_template=>wwv_flow_api.id(2134510792919489250)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--horizontalBorders'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  id,',
'  addr_name as title, ',
'  datetime',
'from eba_spatial_addresses',
'where sdo_anyinteract(',
'  addr_location, ',
'  sdo_geometry(',
'    2003, ',
'    4326, ',
'    null, ',
'    sdo_elem_info_array(1,1003,3), ',
'    sdo_ordinate_array(:P21_MINX, :P21_MINY, :P21_MAXX, :P21_MAXY)',
'  )',
')=''TRUE''',
'and addr_type = ''SUPPLIER'''))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P21_MINX,P21_MINY,P21_MAXX,P21_MAXY'
,p_query_row_template=>wwv_flow_api.id(2134522634660489284)
,p_query_num_rows=>5
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'No addresses on map area.  Drag the map around to refresh.'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(230692465316241438)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(230692555397241439)
,p_query_column_id=>2
,p_column_alias=>'TITLE'
,p_column_display_sequence=>2
,p_column_heading=>'Name'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:RP:P51_ID:#ID#'
,p_column_linktext=>'#TITLE#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(230692635024241440)
,p_query_column_id=>3
,p_column_alias=>'DATETIME'
,p_column_display_sequence=>3
,p_column_heading=>'Created'
,p_use_as_row_header=>'N'
,p_column_format=>'&APP_DATE_TIME_FORMAT.'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_default_sort_dir=>'desc'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2010100963519993515)
,p_plug_name=>'&MAPSERVER_NAME.'
,p_region_name=>'SearchMap'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    c.id,',
'    c.addr_name as infotip,',
'      ''<b>''||apex_escape.html(c.addr_name)||''</b><br><br>''||',
'      apex_escape.html(c.addr_street)||''<br>''||',
'      apex_escape.html(c.addr_postal_code)||'' ''||',
'      apex_escape.html(c.addr_city)||''<br>''||',
'      case when c.addr_state is not null then apex_escape.html(c.addr_state)||'', '' end ||',
'      apex_escape.html(cy.country_name)||''<br/>''||',
'      ''<a href="f?p=''||:APP_ID||'':51:''||:APP_SESSION||''::::P51_ID:''||id||''">[Edit] </a>''',
'    as infotext,',
'    c.addr_location as geometry,',
'    ''c'' || round(dbms_random.value(10,30))  as markersize,',
'    datetime,',
'    case ',
'        when addr_type = ''CUSTOMER'' then ''red'' ',
'        when addr_type = ''SUPPLIER'' then ''blue''',
'    end as style',
'from eba_spatial_addresses c join eba_spatial_countries cy on (c.addr_country = cy.code)',
'order by datetime asc',
''))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5'
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_column_width=>'width="70%"'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attribute_01=>'&MAPSERVER_URL.'
,p_attribute_03=>'100,500'
,p_attribute_06=>'&DEF_MAPCENTER.'
,p_attribute_07=>'&DEF_ZOOMLEVEL.'
,p_attribute_08=>'WEST'
,p_attribute_09=>'1'
,p_attribute_13=>'OVER:MARQUEE:DISTANCE:SCALE'
,p_attribute_14=>'500'
,p_attribute_15=>'150'
,p_attribute_16=>'400'
,p_attribute_17=>'Y'
,p_attribute_18=>'Y'
,p_attribute_19=>'N'
,p_attribute_20=>'&MAP_OSM_COPYRIGHT.'
,p_attribute_21=>'PERCENT'
,p_attribute_22=>'METRIC'
,p_attribute_24=>'OSM_DARK'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(2957901513240728815)
,p_name=>'Customers'
,p_template=>wwv_flow_api.id(2134510792919489250)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--horizontalBorders'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  id,',
'  addr_name as title, ',
'  datetime',
'from eba_spatial_addresses',
'where sdo_anyinteract(',
'  addr_location, ',
'  sdo_geometry(',
'    2003, ',
'    4326, ',
'    null, ',
'    sdo_elem_info_array(1,1003,3), ',
'    sdo_ordinate_array(:P21_MINX, :P21_MINY, :P21_MAXX, :P21_MAXY)',
'  )',
')=''TRUE''',
'and addr_type = ''CUSTOMER'''))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P21_MINX,P21_MINY,P21_MAXX,P21_MAXY'
,p_fixed_header=>'NONE'
,p_query_row_template=>wwv_flow_api.id(2134522634660489284)
,p_query_num_rows=>5
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'No addresses on map area.  Drag the map around to refresh.'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_query_asc_image=>'apex/builder/dup.gif'
,p_query_asc_image_attr=>'width="16" height="16" alt="" '
,p_query_desc_image=>'apex/builder/ddown.gif'
,p_query_desc_image_attr=>'width="16" height="16" alt="" '
,p_plug_query_strip_html=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957901707138728815)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957901811668728817)
,p_query_column_id=>2
,p_column_alias=>'TITLE'
,p_column_display_sequence=>2
,p_column_heading=>'Name'
,p_column_link=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:RP:P51_ID:#ID#'
,p_column_linktext=>'#TITLE#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957901927600728817)
,p_query_column_id=>3
,p_column_alias=>'DATETIME'
,p_column_display_sequence=>3
,p_column_heading=>'Created'
,p_use_as_row_header=>'N'
,p_column_format=>'&APP_DATE_TIME_FORMAT.'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_default_sort_dir=>'desc'
,p_disable_sort_column=>'N'
,p_lov_show_nulls=>'NO'
,p_lov_display_extra=>'YES'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2171074876206510808)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2010100963519993515)
,p_button_name=>'GET_HTML5_LOCATION'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Current Location'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2276914197154662370)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'NEW_ADDRESS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add New Address'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:RP,51::'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(2957903528553728821)
,p_branch_action=>'f?p=&APP_ID.:21:&APP_SESSION.::&DEBUG.'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(230692807614241442)
,p_name=>'P21_MINX'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(2010100963519993515)
,p_item_default=>'-180'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(230692915310241443)
,p_name=>'P21_MINY'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(2010100963519993515)
,p_item_default=>'-90'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(230693019341241444)
,p_name=>'P21_MAXX'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(2010100963519993515)
,p_item_default=>'180'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(230693163233241445)
,p_name=>'P21_MAXY'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(2010100963519993515)
,p_item_default=>'90'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(230693846214241452)
,p_name=>'P21_MAPDATA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(2010100963519993515)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2171074596549510805)
,p_name=>'P21_LON'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2010100963519993515)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2171074609091510806)
,p_name=>'P21_LAT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(2010100963519993515)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2171074725060510807)
,p_name=>'P21_HTML5_STATUS'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(2010100963519993515)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957962918221685300)
,p_name=>'MapInit: get "mapdata"'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010100963519993515)
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_mapinitialized'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957963200874685300)
,p_event_id=>wwv_flow_api.id(2957962918221685300)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETDATA'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010100963519993515)
,p_attribute_01=>'JSON'
,p_attribute_02=>'WGS84'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957902408548728817)
,p_name=>'MapChanged: get "mapdata"'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010100963519993515)
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_mapchanged'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957902708202728819)
,p_event_id=>wwv_flow_api.id(2957902408548728817)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETDATA'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010100963519993515)
,p_attribute_01=>'JSON'
,p_attribute_02=>'WGS84'
,p_attribute_03=>'P21_MINX'
,p_attribute_04=>'P21_MINY'
,p_attribute_05=>'P21_MAXX'
,p_attribute_06=>'P21_MAXY'
,p_attribute_14=>'P21_MAPDATA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957962126055678052)
,p_name=>'Change (P21_REFRESH): Refresh reports'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P21_REFRESH,P21_MAPDATA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957962424953678052)
,p_event_id=>wwv_flow_api.id(2957962126055678052)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2957901513240728815)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2944005008694198641)
,p_name=>'Change (P21_RATING): Change P21_REFRESH'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P21_RATING'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2944005620943203902)
,p_event_id=>wwv_flow_api.id(2944005008694198641)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010100963519993515)
,p_attribute_01=>'REFRESHFOI'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2944005299441198642)
,p_event_id=>wwv_flow_api.id(2944005008694198641)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P21_REFRESH'
,p_attribute_01=>'$s("P21_REFRESH", -$v("P21_REFRESH"));'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2171074909585510809)
,p_name=>'Click on GET_HTML5_LOCATION: Trigger HTML5 Location'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2171074876206510808)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171075007266510810)
,p_event_id=>wwv_flow_api.id(2171074909585510809)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC'
,p_attribute_01=>'P21_LON'
,p_attribute_02=>'P21_LAT'
,p_attribute_03=>'P21_HTML5_STATUS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2171075131910510811)
,p_name=>'HTML5 Location Received: Recenter Map and Refresh '
,p_event_sequence=>90
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC|DYNAMIC ACTION|com_oracle_oramapshtml5_locsuccess'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171075213895510812)
,p_event_id=>wwv_flow_api.id(2171075131910510811)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010100963519993515)
,p_attribute_01=>'P21_LON'
,p_attribute_02=>'P21_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_05=>'CENTER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171075387264510813)
,p_event_id=>wwv_flow_api.id(2171075131910510811)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETMARKER'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010100963519993515)
,p_attribute_01=>'P21_LON'
,p_attribute_02=>'P21_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_04=>'red'
,p_attribute_05=>'Your Position'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(230693889053241453)
,p_name=>'Refresh Reports'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P21_MAPDATA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(230693265098241446)
,p_event_id=>wwv_flow_api.id(230693889053241453)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2957901513240728815)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(230693377725241447)
,p_event_id=>wwv_flow_api.id(230693889053241453)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(230692326169241437)
);
wwv_flow_api.component_end;
end;
/
