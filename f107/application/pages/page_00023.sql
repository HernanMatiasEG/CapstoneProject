prompt --application/pages/page_00023
begin
--   Manifest
--     PAGE: 00023
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
 p_id=>23
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Nearest Neighbor Search'
,p_alias=>'NEAREST-NEIGHBOR-SEARCH'
,p_step_title=>'Nearest Neighbor Search'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'CARSTEN'
,p_last_upd_yyyymmddhh24miss=>'20200628113921'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2010107573398483369)
,p_plug_name=>'&MAPSERVER_NAME.'
,p_region_name=>'SearchMap'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  s.id,',
'  s.addr_name as infotip,',
'  ''<b>''||apex_escape.html(s.addr_name)||''</b><br/><br/>''||',
'      apex_escape.html(s.addr_street)||''<br/>''||',
'      apex_escape.html(s.addr_postal_code)||'' ''||',
'      apex_escape.html(s.addr_city)||''<br/>''||',
'      case when s.addr_state is not null then apex_escape.html(s.addr_state)||'', '' end ||',
'      apex_escape.html(cy.country_name)',
'    as infotext,',
'  addr_location as geometry,',
'  ''blue'' as style',
'from eba_spatial_addresses s join eba_spatial_countries cy on (s.addr_country = cy.code)',
'where s.id = :P23_ADDRESS',
'union all (',
'select  /*+ INDEX (i EBA_SPATIAL_ADRESSES_SX)*/',
'  20000000+c.id as id,',
'  c.addr_name as infotip,',
'  ''<b>''||apex_escape.html(c.addr_name)||''</b><br/><br/>''||',
'      apex_escape.html(c.addr_street)||''<br/>''||',
'      apex_escape.html(c.addr_postal_code)||'' ''||',
'      apex_escape.html(c.addr_city)||''<br/>''||',
'      case when c.addr_state is not null then apex_escape.html(c.addr_state)||'', '' end',
'    as infotext,',
'  c.addr_location geometry,',
'  ''red'' as style',
'from eba_spatial_addresses c, eba_spatial_addresses s',
'where sdo_nn(',
'  c.addr_location,',
'  s.addr_location,',
'  ''sdo_batch_size=0 distance=''||:P23_DISTANCE||'' unit=''||:DISTANCE_UNIT,',
'  1',
') = ''TRUE'' ',
'and s.id = :P23_ADDRESS',
'and c.addr_type = ''CUSTOMER''',
'and rownum <= :P23_MAXROWS',
')',
''))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5'
,p_ajax_items_to_submit=>'P23_DISTANCE,P23_LON,P23_LAT,P23_MAXROWS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_column_width=>'width="60%"'
,p_attribute_01=>'&MAPSERVER_URL.'
,p_attribute_03=>'100,500'
,p_attribute_06=>'&DEF_MAPCENTER.'
,p_attribute_07=>'&DEF_ZOOMLEVEL.'
,p_attribute_08=>'WEST'
,p_attribute_09=>'1'
,p_attribute_13=>'MARQUEE:OVER:DISTANCE:SCALE'
,p_attribute_14=>'500'
,p_attribute_15=>'280'
,p_attribute_16=>'300'
,p_attribute_17=>'Y'
,p_attribute_18=>'Y'
,p_attribute_19=>'N'
,p_attribute_20=>'&MAP_OSM_COPYRIGHT.'
,p_attribute_21=>'PERCENT'
,p_attribute_22=>'ITEM'
,p_attribute_23=>'ORACLEMAPS_UNITSYSTEM'
,p_attribute_24=>'OSM'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(2929283506928111825)
,p_name=>'Results'
,p_template=>wwv_flow_api.id(2134510792919489250)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_region_attributes=>'style="margin-right: 3px;"'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select /*+ INDEX (c EBA_SPATIAL_ADDRESSES_SX )*/',
'  c.id,',
'  c.addr_name,',
'  sdo_nn_distance(1) as distance',
'from eba_spatial_addresses c, eba_spatial_addresses s',
'where',
'  sdo_nn(',
'    c.addr_location,',
'    s.addr_location,',
'    ''distance=''||:P23_DISTANCE||'' unit=''||:DISTANCE_UNIT,',
'   1',
'  ) = ''TRUE'' and',
's.id = :P23_ADDRESS ',
'and c.addr_type = ''CUSTOMER''',
'and rownum <= :P23_MAXROWS',
''))
,p_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page allows you to find <em>Nearest Neighbors</em>, based on a chosen supplier address. In the database, the SQL function <strong>SDO_NN</strong> is used. </p>',
'<ul>',
'<li>Choose an address from the select list on the left. You must have addresses of the <strong>Supplier</strong> type stored in your table.</li>',
'<li>Adjust the <strong>Search within Distance</strong>. Customer addresses with a greater distance will not be returned.</li>',
'<li>Adjust the maximum nearest neighbor count.</li>',
'</ul>',
'<p>The query returns customer addresses within the specified distance The results',
'are being ordered by distance to the given supplier address in ascending order.</p>'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P23_DISTANCE,P23_LON,P23_LAT,P23_MAXROWS'
,p_fixed_header=>'NONE'
,p_query_row_template=>wwv_flow_api.id(2134522634660489284)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'No customers found within the specified distance.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
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
wwv_flow_api.set_region_column_width(
 p_id=>wwv_flow_api.id(2929283506928111825)
,p_plug_column_width=>'width="40%"'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2929283689522111831)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(230694107987241455)
,p_query_column_id=>2
,p_column_alias=>'ADDR_NAME'
,p_column_display_sequence=>3
,p_column_heading=>'Address'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:RP:P51_ID:#ID#'
,p_column_linktext=>'#ADDR_NAME#'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2929283999032111840)
,p_query_column_id=>3
,p_column_alias=>'DISTANCE'
,p_column_display_sequence=>2
,p_column_heading=>'Distance (&DISTANCE_UNIT.)'
,p_use_as_row_header=>'N'
,p_column_format=>'999G990D000'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2171072251833510782)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2010107573398483369)
,p_button_name=>'GET_HTML5_LOC'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Current Location'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2171072512569510785)
,p_name=>'P23_STATUS'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(2929283506928111825)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929284709313111870)
,p_name=>'P23_LON'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(2929283506928111825)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929284896659111870)
,p_name=>'P23_LAT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(2929283506928111825)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929285290281111871)
,p_name=>'P23_MAXROWS'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(2929283506928111825)
,p_item_default=>'10'
,p_prompt=>'Nearest Neighbor count'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(2134537980450489342)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'0'
,p_attribute_02=>'20'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929285508689111871)
,p_name=>'P23_REFRESH'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(2929283506928111825)
,p_item_default=>'1'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929285894648111871)
,p_name=>'P23_UNIT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(2929283506928111825)
,p_source=>'case when :ORACLEMAPS_UNITSYSTEM = ''METRIC'' then ''km'' else ''mile'' end'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929290703542126899)
,p_name=>'P23_ADDRESS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2929283506928111825)
,p_prompt=>'Start from Supplier Address'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ADDRESSES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select addr_name|| '' ('' || addr_city || '')'' d, id r',
'from   eba_spatial_addresses ',
'where addr_location is not null',
'and addr_type=''SUPPLIER''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Please choose -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(2134537980450489342)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929298605044399696)
,p_name=>'P23_DISTANCE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(2929283506928111825)
,p_item_default=>'100'
,p_prompt=>'Search within Distance'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(2134537980450489342)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'0'
,p_attribute_02=>'2500'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(2093993384859263581)
,p_computation_sequence=>10
,p_computation_item=>'P23_DISTANCE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'EXPRESSION'
,p_computation_language=>'PLSQL'
,p_computation=>'round(:P23_DISTANCE)'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929293101681141959)
,p_name=>'Change (P23_ADDRESS): Change P23_REFRESH'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P23_ADDRESS'
,p_condition_element=>'P23_ADDRESS'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929293809340154603)
,p_event_id=>wwv_flow_api.id(2929293101681141959)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P23_LON,P23_LAT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  a.addr_location.sdo_point.x x,',
'  a.addr_location.sdo_point.y y',
'from eba_spatial_addresses a',
'where id = :P23_ADDRESS'))
,p_attribute_07=>'P23_ADDRESS'
,p_attribute_08=>'Y'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929293411651141962)
,p_event_id=>wwv_flow_api.id(2929293101681141959)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P23_REFRESH'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'-($v("P23_REFRESH"))'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929287597346111928)
,p_name=>'Change (P23_DISTANCE): Change P23_REFRESH'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P23_DISTANCE,P23_MAXROWS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929287892043111929)
,p_event_id=>wwv_flow_api.id(2929287597346111928)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P23_REFRESH'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'-$v("P23_REFRESH")'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929288390306111929)
,p_name=>'Change (P23_REFRESH): Refresh Map and Report Regions'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P23_REFRESH'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P23_LON") != "" && $v("P23_LAT") != "")'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929288705035111929)
,p_event_id=>wwv_flow_api.id(2929288390306111929)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2929283506928111825)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929288900777111929)
,p_event_id=>wwv_flow_api.id(2929288390306111929)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010107573398483369)
,p_attribute_01=>'REFRESHFOI'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929294217307166040)
,p_event_id=>wwv_flow_api.id(2929288390306111929)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010107573398483369)
,p_attribute_01=>'P23_LON'
,p_attribute_02=>'P23_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_05=>'CENTER'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2171072309469510783)
,p_name=>'Click (GET_HTML5_LOC): Trigger HTML5 Location'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2171072251833510782)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171072490631510784)
,p_event_id=>wwv_flow_api.id(2171072309469510783)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC'
,p_attribute_01=>'P23_LON'
,p_attribute_02=>'P23_LAT'
,p_attribute_03=>'P23_STATUS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2171072607955510786)
,p_name=>'HTML5 Loc Received'
,p_event_sequence=>120
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC|DYNAMIC ACTION|com_oracle_oramapshtml5_locsuccess'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171072853442510788)
,p_event_id=>wwv_flow_api.id(2171072607955510786)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P23_ADDRESS'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171072976307510789)
,p_event_id=>wwv_flow_api.id(2171072607955510786)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETMARKER'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010107573398483369)
,p_attribute_01=>'P23_LON'
,p_attribute_02=>'P23_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_04=>'red'
,p_attribute_05=>'Your positon'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171072736011510787)
,p_event_id=>wwv_flow_api.id(2171072607955510786)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P23_REFRESH'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'-$v("P23_REFRESH")'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.component_end;
end;
/
