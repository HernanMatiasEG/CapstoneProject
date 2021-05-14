prompt --application/pages/page_00022
begin
--   Manifest
--     PAGE: 00022
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
 p_id=>22
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Within-Distance Search'
,p_alias=>'WITHIN-DISTANCE-SEARCH'
,p_step_title=>'Within-Distance Search'
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
 p_id=>wwv_flow_api.id(2010104865382353632)
,p_plug_name=>'&MAPSERVER_NAME.'
,p_region_name=>'SearchMap'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select ',
'  ''CIRCLE001'' as id,',
'  ''Search area'' as infotip,',
'  null as infotext,',
'   apex_spatial.circle_polygon(',
'     :P22_LON,   -- Center of the circle (longitude)',
'     :P22_LAT,   -- Center of the circle (latitude)',
'     (to_number(:P22_DISTANCE) * u.factor_b)',
'   ) as geometry,',
'  null as markersize,',
'  ''orange'' as style,',
'  0 as layer',
'  from sdo_units_of_measure u ',
'  where lower(u.short_name) = :DISTANCE_UNIT and',
'  (:P22_DISTANCE is not null and :P22_LAT is not null and :P22_LON is not null) and :P22_SHOW_CIRCLE=''Y''',
'union all (',
'select ',
'  to_char(id) as id,',
'  addr_name as infotip,',
'  ''<b>''||apex_escape.html(c.addr_name)||''</b><br/><br/>''||',
'      apex_escape.html(c.addr_street)||''<br/>''||',
'      apex_escape.html(c.addr_postal_code)||'' ''||',
'      apex_escape.html(c.addr_city)||''<br/>''||',
'      apex_escape.html(nvl(c.addr_state,''N/A''))||'', ''||',
'      apex_escape.html(cy.country_name)||''<br/>''||',
'      ''<a href="f?p=''||:APP_ID||'':51:''||:APP_SESSION||''::::P51_ID:''||id||''">[Edit] </a>''',
'    as infotext,',
'  addr_location as geometry,',
'  ''C10'' as markersize,',
'  case ',
'      when addr_type = ''CUSTOMER'' then ''red'' ',
'      when addr_type = ''SUPPLIER'' then ''blue''',
'  end as style,',
'  1 as layer',
'from eba_spatial_addresses c join eba_spatial_countries cy on (c.addr_country = cy.code)',
'where ',
'  (:P22_LON is not null and :P22_LAT is not null and :P22_DISTANCE is not null) and ',
'  sdo_within_distance(',
'    addr_location, ',
'    eba_spatial_sample.point(:P22_LON, :P22_LAT),  ',
'    ''distance=''||to_number(:P22_DISTANCE)||'' unit=''||:DISTANCE_UNIT',
'  )=''TRUE'' ',
')'))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5'
,p_ajax_items_to_submit=>'P22_LON,P22_LAT,P22_DISTANCE,P22_SHOW_CIRCLE'
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
,p_attribute_13=>'CIRCLE:OVER:MARQUEE:SCALE'
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
 p_id=>wwv_flow_api.id(2957905999421739845)
,p_name=>'Results'
,p_template=>wwv_flow_api.id(2134510792919489250)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--horizontalBorders'
,p_region_attributes=>'style="margin-right: 3px;"'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  id,',
'  ''Address'' as Type,',
'  addr_name,',
'  '' '' as rating,',
'  sdo_geom.sdo_distance(',
'    addr_location, ',
'    eba_spatial_sample.point(:P22_LON, :P22_LAT), ',
'    1, ',
'    ''unit=''||:DISTANCE_UNIT',
'  ) as distance',
'from eba_spatial_addresses',
'where (',
'  :P22_LON is not null and :P22_LAT is not null and :P22_DISTANCE is not null) and',
'  sdo_within_distance(',
'    addr_location, ',
'    eba_spatial_sample.point(:P22_LON, :P22_LAT),  ',
'    ''distance=''||to_number(:P22_DISTANCE)||'' unit=''||:DISTANCE_UNIT',
'  )=''TRUE''',
''))
,p_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page allows to perform within distance queries. This is done with the SQL function <strong>SDO_WITHIN_DISTANCE</strong></p>',
'<p>Option 1:</p>',
'<ul>',
'<li>Right click your mouse somewhere in the map. This position will be the starting point for your Within-Distance-Search</li>',
'<li>The <strong>Current Location</strong> button will use your current location (HTML5) as the starting point</li>',
'<li>Adjust the distance text field in the upper left</li>',
'<li>Choose whether to show the search circle or not</li>',
'</ul>',
'<p>Option 2:</p>',
'<ul>',
'<li>Click on the <em>Circle Tool</em> within the map toolbar (the symbol to the right)</li>',
'<li>Click into the map and drag your mouse in order to draw a circle</li>',
'<li>The drawn circle will be the Search Area. You might still want to adjust the distance slider </li>',
'</ul>',
'<p>The <strong>Store as Area Of Interest</strong> will store the circle as an <em>Area Of Interest</em> into the database.</p>'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P22_LON,P22_LAT,P22_DISTANCE'
,p_fixed_header=>'NONE'
,p_query_row_template=>wwv_flow_api.id(2134522634660489284)
,p_query_num_rows=>5
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'No objects within the given distance.'
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
 p_id=>wwv_flow_api.id(2957905999421739845)
,p_plug_column_width=>'width="30%"'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957906505398739846)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957906418003739846)
,p_query_column_id=>2
,p_column_alias=>'TYPE'
,p_column_display_sequence=>2
,p_column_heading=>'Type'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2958290423828590945)
,p_query_column_id=>3
,p_column_alias=>'ADDR_NAME'
,p_column_display_sequence=>5
,p_column_heading=>'Name or title'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2093993411970263582)
,p_query_column_id=>4
,p_column_alias=>'RATING'
,p_column_display_sequence=>3
,p_column_heading=>'Rating'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957906211369739845)
,p_query_column_id=>5
,p_column_alias=>'DISTANCE'
,p_column_display_sequence=>4
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
 p_id=>wwv_flow_api.id(2929679903875295088)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2010104865382353632)
,p_button_name=>'STORE_AS_AOI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_image_alt=>'Store as Area Of Interest'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2957969229545906212)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(2010104865382353632)
,p_button_name=>'GET_HTML5_LOCATION'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Current Location'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(2929681805062356585)
,p_branch_name=>'Circle stored as AOI: Branch to Page 61'
,p_branch_action=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.::P61_AOI_NAME:'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(2929679903875295088)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2008184413132950420)
,p_name=>'P22_CIRCLE_SRID'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2008184528287950421)
,p_name=>'P22_CIRCLE_CENTERX'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2008184668434950422)
,p_name=>'P22_CIRCLE_CENTERY'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2008184755237950423)
,p_name=>'P22_CIRCLE_RADIUS'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929678206432264736)
,p_name=>'P22_SHOW_CIRCLE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_item_default=>'Y'
,p_prompt=>'Show distance circle on map'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(2134537980450489342)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957906810532739850)
,p_name=>'P22_LON'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957907008695739855)
,p_name=>'P22_LAT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957907207041739855)
,p_name=>'P22_MAPDATA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957907420546739856)
,p_name=>'P22_DISTANCE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_item_default=>'100'
,p_prompt=>'Search objects within distance'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(2134537980450489342)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'0'
,p_attribute_02=>'1000'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957967507736841363)
,p_name=>'P22_REFRESH'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_item_default=>'1'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957970020398911513)
,p_name=>'P22_HTML5_STATUS'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957975718156018922)
,p_name=>'P22_UNIT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(2957905999421739845)
,p_use_cache_before_default=>'NO'
,p_item_default=>'km'
,p_source=>'case when :ORACLEMAPS_UNITSYSTEM = ''METRIC'' then ''km'' else ''mile'' end'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'I'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(2093993279323263580)
,p_computation_sequence=>10
,p_computation_item=>'P22_DISTANCE'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'EXPRESSION'
,p_computation_language=>'PLSQL'
,p_computation=>'round(:P22_DISTANCE)'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2929680196270299852)
,p_validation_name=>'Distance has been chosen (P22_DISTANCE)'
,p_validation_sequence=>10
,p_validation=>'P22_DISTANCE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please choose a distance'
,p_when_button_pressed=>wwv_flow_api.id(2929679903875295088)
,p_associated_item=>wwv_flow_api.id(2957907420546739856)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2929680409844308759)
,p_validation_name=>'Location has beeon chosen (P22_LON, P22_LAT)'
,p_validation_sequence=>20
,p_validation=>':P22_LON is not null and :P22_LAT is not null'
,p_validation2=>'SQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Please click a position on the map.'
,p_when_button_pressed=>wwv_flow_api.id(2929679903875295088)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929683101423417397)
,p_name=>'OnMapInit: Trigger Loc Received '
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010104865382353632)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v("P22_LON") != "" && $v("P22_LAT") != ""'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_mapinitialized'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957971499510954276)
,p_name=>'Button (GET_HTML5...): Trigger Get HTML5 Location'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2957969229545906212)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957971799663954277)
,p_event_id=>wwv_flow_api.id(2957971499510954276)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC'
,p_attribute_01=>'P22_LON'
,p_attribute_02=>'P22_LAT'
,p_attribute_03=>'P22_HTML5_STATUS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957907620629739856)
,p_name=>'Click (Map): Get "Mapdata" '
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010104865382353632)
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_mouserightclick'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957907913246739857)
,p_event_id=>wwv_flow_api.id(2957907620629739856)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETDATA'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010104865382353632)
,p_attribute_01=>'JSON'
,p_attribute_02=>'WGS84'
,p_attribute_09=>'P22_LON'
,p_attribute_10=>'P22_LAT'
,p_attribute_14=>'P22_MAPDATA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957968226859886466)
,p_name=>'ChangeSlider (P22_DISTANCE): Change P22_REFRESH'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P22_DISTANCE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957968521602886466)
,p_event_id=>wwv_flow_api.id(2957968226859886466)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P22_REFRESH'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'-$v("P22_REFRESH")'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957908228038739859)
,p_name=>'Change (P22_REFRESH): Refresh Map and Report Regions'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P22_REFRESH'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v("P22_LON") != "" && $v("P22_LAT") != "" && $v("P22_DISTANCE") != ""'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929682798784389885)
,p_event_id=>wwv_flow_api.id(2957908228038739859)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2929679903875295088)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957908521779739859)
,p_event_id=>wwv_flow_api.id(2957908228038739859)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2957905999421739845)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957908701373739859)
,p_event_id=>wwv_flow_api.id(2957908228038739859)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010104865382353632)
,p_attribute_01=>'REFRESHFOI'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929682602234388297)
,p_event_id=>wwv_flow_api.id(2957908228038739859)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2929679903875295088)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2943855715330604469)
,p_name=>'Change (P22_RATING): Change P22_REFRESH'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P22_RATING'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2943855990469604497)
,p_event_id=>wwv_flow_api.id(2943855715330604469)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P22_REFRESH'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'-$v("P22_REFRESH")'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929679200844275289)
,p_name=>'Change (P22_SHOW_CIRCLE): Refresh Map'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P22_SHOW_CIRCLE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929679499075275293)
,p_event_id=>wwv_flow_api.id(2929679200844275289)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010104865382353632)
,p_attribute_01=>'REFRESHFOI'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957970099332916391)
,p_name=>'LocationRecvd: Center Map, Set Marker, Change P22_REFRESH'
,p_event_sequence=>120
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC|DYNAMIC ACTION|com_oracle_oramapshtml5_locsuccess'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957973298986997338)
,p_event_id=>wwv_flow_api.id(2957970099332916391)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010104865382353632)
,p_attribute_01=>'P22_LON'
,p_attribute_02=>'P22_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_05=>'CENTER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2010106472573438189)
,p_event_id=>wwv_flow_api.id(2957970099332916391)
,p_event_result=>'TRUE'
,p_action_sequence=>25
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010104865382353632)
,p_attribute_01=>'REMOVEMARKER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957970413087916391)
,p_event_id=>wwv_flow_api.id(2957970099332916391)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P22_REFRESH'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'-($v("P22_REFRESH"))'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2008183967356950415)
,p_name=>'Circle finished'
,p_event_sequence=>130
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010104865382353632)
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_circlefinish'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2008184335549950419)
,p_event_id=>wwv_flow_api.id(2008183967356950415)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010104865382353632)
,p_attribute_01=>'CLEARCIRCLE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2008184088887950416)
,p_event_id=>wwv_flow_api.id(2008183967356950415)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETCIRCLE'
,p_attribute_01=>'P22_CIRCLE_CENTERX'
,p_attribute_02=>'P22_CIRCLE_CENTERY'
,p_attribute_03=>'P22_CIRCLE_RADIUS'
,p_attribute_04=>'P22_CIRCLE_SRID'
,p_attribute_05=>'WGS84'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(950818296320379012)
,p_name=>'Change (P22_MAPDATA)'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P22_MAPDATA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957908127782739859)
,p_event_id=>wwv_flow_api.id(950818296320379012)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P22_REFRESH'
,p_attribute_01=>'apex.event.trigger(document, "com_oracle_oramapshtml5_locsuccess");'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(950818402074379014)
,p_name=>'Change (P22_CIRCLE_RADIUS)'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P22_CIRCLE_RADIUS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2008184823202950424)
,p_event_id=>wwv_flow_api.id(950818402074379014)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  :P22_LON := :P22_CIRCLE_CENTERX;',
'  :P22_LAT := :P22_CIRCLE_CENTERY;',
'  ',
'  -- Maximum circle 1000 km.',
'  if :P22_CIRCLE_RADIUS > 1000000 then :P22_CIRCLE_RADIUS := 1000000; end if;',
'',
'  -- Convert to application units for report and to adjust the slider',
'  select floor(to_number(:P22_CIRCLE_RADIUS) / u.factor_b) into :P22_DISTANCE',
'  from sdo_units_of_measure u',
'  where lower(u.short_name) = :DISTANCE_UNIT and rownum = 1;',
'  if :P22_DISTANCE > 1000 then :P22_DISTANCE := 1000; end if;',
'end;'))
,p_attribute_02=>'P22_CIRCLE_CENTERX,P22_CIRCLE_CENTERY,P22_CIRCLE_RADIUS,P22_CIRCLE_SRID'
,p_attribute_03=>'P22_LAT,P22_LON,P22_DISTANCE'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2008185120421950427)
,p_event_id=>wwv_flow_api.id(950818402074379014)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'try {',
'  apex.jQuery("#P22_DISTANCE_control").slider("value", parseInt($v("P22_DISTANCE")));',
'} catch (e) {}',
'try {',
'  apex.jQuery("#P22_DISTANCE_display").text($v("P22_DISTANCE")+" &DISTANCE_UNIT.");',
'} catch (e) {}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2008184961887950425)
,p_event_id=>wwv_flow_api.id(950818402074379014)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.event.trigger(document, "com_oracle_oramapshtml5_locsuccess");'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2929681410202353678)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Button STORE_AOI Store circle as Area Of Interest'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  v_factor sdo_units_of_measure.factor_b%type;',
'begin',
'  select factor_b into v_factor',
'  from sdo_units_of_measure ',
'  where lower(short_name) = :DISTANCE_UNIT;',
'',
'  insert into eba_spatial_aoi (aoi_name, geometry, owner)',
'  values (',
'    ''New Area (''||sysdate||'')'',',
'    apex_spatial.circle_polygon(',
'      :P22_LON,   -- Center of the circle (longitude)',
'      :P22_LAT,   -- Center of the circle (latitude)',
'      (to_number(:P22_DISTANCE) * v_factor)',
'     ), ',
'    :APP_USER',
'  )',
'  returning id into :P61_AOI_ID;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2929679903875295088)
,p_process_success_message=>'Circle stored as Area Of Interest.'
);
wwv_flow_api.component_end;
end;
/
