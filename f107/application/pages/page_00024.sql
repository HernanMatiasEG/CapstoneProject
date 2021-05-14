prompt --application/pages/page_00024
begin
--   Manifest
--     PAGE: 00024
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
 p_id=>24
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Area-Of-Interest Search'
,p_alias=>'AREA-OF-INTEREST-SEARCH'
,p_step_title=>'Area-Of-Interest Search'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'CARSTEN'
,p_last_upd_yyyymmddhh24miss=>'20200628113921'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2010108879399526211)
,p_plug_name=>'&MAPSERVER_NAME.'
,p_region_name=>'SearchMap'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  ''AOI''||ai.id as id,',
'  ai.aoi_name as infotip,',
'  null as infotext,',
'  ai.geometry,',
'  case ',
'    when mod(rownum, 4) = 1 then ''blue'' ',
'    when mod(rownum, 4) = 2 then ''red'' ',
'    when mod(rownum, 4) = 3 then ''green'' ',
'    when mod(rownum, 4) = 0 then ''orange'' ',
'  end as style,',
'  0 as layer',
'from eba_spatial_aoi ai',
'where (id = :P24_AOI_ID or :P24_AOI_ID is null) and :P24_SHOW_AOI = ''Y''',
'union all (',
'select /*+ INDEX(c EBA_SPATIAL_ADDRESSES_SX) */',
'  ''A''||c.id id ,',
'  c.addr_name as infotip,',
'  ''<b>''||apex_escape.html(c.addr_name)||''</b><br/><br/>''||',
'      apex_escape.html(c.addr_street)||''<br/>''||',
'      apex_escape.html(c.addr_postal_code)||'' ''||',
'      apex_escape.html(c.addr_city)||''<br/>''||',
'      apex_escape.html(nvl(c.addr_state,''N/A''))||'', ''||',
'      apex_escape.html(cy.country_name)',
'    as infotext,',
'   c.addr_location as geometry,',
'  case when addr_type = ''CUSTOMER'' then ''red'' ',
'       when addr_type = ''SUPPLIER'' then ''blue'' end as style,',
'   1 as layer',
'from eba_spatial_addresses c, eba_spatial_countries cy, eba_spatial_aoi ai',
'where ',
'  c.addr_country = cy.code and ',
'  (ai.id = :P24_AOI_ID  or :P24_AOI_ID is null) and ',
'  sdo_anyinteract(',
'    c.addr_location,',
'    ai.geometry',
'  )=''TRUE''',
')'))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5'
,p_ajax_items_to_submit=>'P24_AOI_ID,P24_SHOW_AOI'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_column_width=>'width="70%"'
,p_attribute_01=>'&MAPSERVER_URL.'
,p_attribute_03=>'100,500'
,p_attribute_06=>'&DEF_MAPCENTER.'
,p_attribute_07=>'&DEF_ZOOMLEVEL.'
,p_attribute_08=>'WEST'
,p_attribute_09=>'1'
,p_attribute_13=>'MARQUEE:DISTANCE:OVER:SCALE'
,p_attribute_14=>'500'
,p_attribute_15=>'280'
,p_attribute_16=>'300'
,p_attribute_17=>'Y'
,p_attribute_18=>'Y'
,p_attribute_19=>'N'
,p_attribute_20=>'&MAP_OSM_COPYRIGHT.'
,p_attribute_21=>'PERCENT'
,p_attribute_22=>'METRIC'
,p_attribute_24=>'OSM'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(2929509598046929278)
,p_name=>'Addresses'
,p_template=>wwv_flow_api.id(2134510792919489250)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select /*+ INDEX(i EBA_SPATIAL_ADDRESSES_SX) */',
'  a.id,',
'  a.datetime,',
'  initcap( addr_type ) as type,',
'  a.addr_name,',
'  ai.aoi_name,',
'eba_spatial_sample.geom_to_string(a.addr_location) as position',
'from eba_spatial_addresses a, eba_spatial_aoi ai',
'where ',
'  (ai.id = :P24_AOI_ID or :P24_AOI_ID is null) and',
'  sdo_anyinteract(',
'    a.addr_location, ',
'    ai.geometry',
'  )=''TRUE'''))
,p_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page finds addresses located within an <em>Area Of Interest</em>. ',
'An Area Of Interest is a polygon, which <a href="f?p=&APP_ID.:61:&SESSION.">can be drawn and stored into the database</a>.',
'</p>',
'<ul>',
'<li>Choose one of the stored <strong>Areas Of Interest</strong> in the select list on the left</li>',
'<li>Decide whether to display the Area Of Interest polygon or not</li>',
'</ul>',
''))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P24_AOI_ID'
,p_fixed_header=>'NONE'
,p_query_row_template=>wwv_flow_api.id(2134522634660489284)
,p_query_num_rows=>5
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'No objects within the chosen area.'
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
 p_id=>wwv_flow_api.id(2929509899636929281)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2945158990063389383)
,p_query_column_id=>2
,p_column_alias=>'DATETIME'
,p_column_display_sequence=>5
,p_column_heading=>'Datetime'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_default_sort_dir=>'desc'
,p_disable_sort_column=>'N'
,p_hidden_column=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2929510003386929281)
,p_query_column_id=>3
,p_column_alias=>'TYPE'
,p_column_display_sequence=>2
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2929510094575929281)
,p_query_column_id=>4
,p_column_alias=>'ADDR_NAME'
,p_column_display_sequence=>3
,p_column_heading=>'Name'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2171075959744510819)
,p_query_column_id=>5
,p_column_alias=>'AOI_NAME'
,p_column_display_sequence=>6
,p_column_heading=>'Within Area'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2929510215746929281)
,p_query_column_id=>6
,p_column_alias=>'POSITION'
,p_column_display_sequence=>4
,p_column_heading=>'Position'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2171073118567510791)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2010108879399526211)
,p_button_name=>'GET_HTML5_LOCATION'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Current Location'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2171073079871510790)
,p_name=>'P24_HTML5_STATUS'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(2929509598046929278)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929510995385938797)
,p_name=>'P24_AOI_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(2929509598046929278)
,p_prompt=>'Area of Interest'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_AOI'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select aoi_name d, id r',
'from   eba_spatial_aoi',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Show all -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929513994246015278)
,p_name=>'P24_LON'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(2929509598046929278)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929514190795016919)
,p_name=>'P24_LAT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(2929509598046929278)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929515114050051658)
,p_name=>'P24_SHOW_AOI'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(2929509598046929278)
,p_item_default=>'Y'
,p_prompt=>'Show Area Of Interest on map'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929511204196949928)
,p_name=>'Change (P24_AOI_ID): Refresh Reports and Map'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P24_AOI_ID'
,p_condition_element=>'P24_AOI_ID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2010328074419817202)
,p_event_id=>wwv_flow_api.id(2929511204196949928)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2929509598046929278)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929511516426949928)
,p_event_id=>wwv_flow_api.id(2929511204196949928)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2929509598046929278)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2010328271184818691)
,p_event_id=>wwv_flow_api.id(2929511204196949928)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010108879399526211)
,p_attribute_01=>'REFRESHFOI'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929514399409028054)
,p_event_id=>wwv_flow_api.id(2929511204196949928)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P24_LON,P24_LAT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with centr as (',
'  select ',
'    sdo_geom.sdo_centroid(geometry, 1) as geometry',
'    from eba_spatial_aoi ',
'    where id = :P24_AOI_ID',
')',
'select ',
'  g.geometry.sdo_point.x x,',
'  g.geometry.sdo_point.y y',
'from centr g',
'    ',
'  '))
,p_attribute_07=>'P24_AOI_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929514594449030370)
,p_event_id=>wwv_flow_api.id(2929511204196949928)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010108879399526211)
,p_attribute_01=>'P24_LON'
,p_attribute_02=>'P24_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_05=>'CENTER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929513713871006192)
,p_event_id=>wwv_flow_api.id(2929511204196949928)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010108879399526211)
,p_attribute_01=>'REFRESHFOI'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929516618105058104)
,p_name=>'Change (P24_SHOW_AOI): Refresh Map'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P24_SHOW_AOI'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929516905806058106)
,p_event_id=>wwv_flow_api.id(2929516618105058104)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010108879399526211)
,p_attribute_01=>'REFRESHFOI'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2171073217041510792)
,p_name=>'Click on GET_HTML5_LOCATION: Trigger HTML5 Location'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2171073118567510791)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171073350134510793)
,p_event_id=>wwv_flow_api.id(2171073217041510792)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC'
,p_attribute_01=>'P24_LON'
,p_attribute_02=>'P24_LAT'
,p_attribute_03=>'P24_HTML5_STATUS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2171073418000510794)
,p_name=>'Html5 Loc Received: Center Map'
,p_event_sequence=>40
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC|DYNAMIC ACTION|com_oracle_oramapshtml5_locsuccess'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171073563350510795)
,p_event_id=>wwv_flow_api.id(2171073418000510794)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010108879399526211)
,p_attribute_01=>'P24_LON'
,p_attribute_02=>'P24_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_05=>'CENTER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171073707369510797)
,p_event_id=>wwv_flow_api.id(2171073418000510794)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETMARKER'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010108879399526211)
,p_attribute_01=>'P24_LON'
,p_attribute_02=>'P24_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_04=>'red'
,p_attribute_05=>'Your Position'
);
wwv_flow_api.component_end;
end;
/
