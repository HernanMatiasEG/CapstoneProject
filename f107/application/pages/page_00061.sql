prompt --application/pages/page_00061
begin
--   Manifest
--     PAGE: 00061
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
 p_id=>61
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Areas of Interest'
,p_alias=>'AREAS-OF-INTEREST'
,p_step_title=>'Areas of Interest'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var gPolyVertices = 0;'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'B&C_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210507083109'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2010114263390594419)
,p_plug_name=>'&MAPSERVER_NAME.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY_3'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  id,',
'  aoi_name as infotip,',
'  geometry,',
'  ''blue'' as style',
'from eba_spatial_aoi',
'where id = nvl(:P61_AOI_ID, -1)'))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5'
,p_ajax_items_to_submit=>'P61_AOI_ID'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_column_width=>'width="60%"'
,p_attribute_01=>'&MAPSERVER_URL.'
,p_attribute_03=>'100,500'
,p_attribute_06=>'&DEF_MAPCENTER.'
,p_attribute_07=>'&DEF_ZOOMLEVEL.'
,p_attribute_08=>'WEST'
,p_attribute_09=>'1'
,p_attribute_13=>'MARQUEE:DISTANCE:REDLINE:SCALE:OVER'
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
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2929317802315140743)
,p_plug_name=>'New Area of Interest'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY_3'
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(2929413897364654660)
,p_name=>'Areas of Interest'
,p_region_name=>'REG_LIST_AOI'
,p_template=>wwv_flow_api.id(2134510792919489250)
,p_display_sequence=>70
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody'
,p_component_template_options=>'t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY_3'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  id,',
'  aoi_name,',
'  eba_spatial_sample.geom_to_string(',
'    sdo_geom.sdo_centroid(geometry,1)',
'  ) centroid,',
'  sdo_geom.sdo_area(',
'    geometry,',
'    1,',
'    ''unit=''||(case when :ORACLEMAPS_UNITSYSTEM = ''METRIC'' then ''sq_km'' else ''sq_mile'' end)',
'  ) as area',
'from eba_spatial_aoi'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P61_UNIT'
,p_fixed_header=>'NONE'
,p_query_row_template=>wwv_flow_api.id(2134522634660489284)
,p_query_num_rows=>5
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'Without AOI'
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
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2929414197729654673)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2929414289365654673)
,p_query_column_id=>2
,p_column_alias=>'AOI_NAME'
,p_column_display_sequence=>2
,p_column_heading=>'Name'
,p_use_as_row_header=>'N'
,p_column_link=>'javascript:$s(''P61_AOI_ID'',''#ID#'');'
,p_column_linktext=>'#AOI_NAME#'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_lov_show_nulls=>'NO'
,p_lov_display_extra=>'YES'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2929414406961654673)
,p_query_column_id=>3
,p_column_alias=>'CENTROID'
,p_column_display_sequence=>3
,p_column_heading=>'Center'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2929414513633654673)
,p_query_column_id=>4
,p_column_alias=>'AREA'
,p_column_display_sequence=>4
,p_column_heading=>'Area size (&P61_UNIT.)'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990D0'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_lov_show_nulls=>'NO'
,p_lov_display_extra=>'YES'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2264978388992156791)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Change Name'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2171073934609510799)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2010114263390594419)
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
 p_id=>wwv_flow_api.id(2264977840246156786)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2264978202929156790)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--simple:t-Button--danger'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(2929544012032675566)
,p_branch_name=>'Branch to same page'
,p_branch_action=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2010116279743632442)
,p_name=>'P61_SRID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(2929317802315140743)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2171073895643510798)
,p_name=>'P61_HTML5_STATUS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(2010114263390594419)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929318614994154767)
,p_name=>'P61_AOI_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(2929317802315140743)
,p_prompt=>'Name'
,p_placeholder=>'Enter the name for the Area Of Interest here ...'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>64
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929318906368158761)
,p_name=>'P61_GEOMETRY'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(2929317802315140743)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929416893210696708)
,p_name=>'P61_AOI_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(2929317802315140743)
,p_prompt=>'Show on map'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_AOI'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select aoi_name d, id r',
'from   eba_spatial_aoi',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Create new -'
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929517500019073362)
,p_name=>'P61_LON'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2010114263390594419)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929517696784074916)
,p_name=>'P61_LAT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(2010114263390594419)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2929672302723053782)
,p_name=>'P61_UNIT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(2929317802315140743)
,p_use_cache_before_default=>'NO'
,p_source=>'case when :ORACLEMAPS_UNITSYSTEM = ''METRIC'' then unistr(''km\00B2'') else ''sq mile'' end'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(2929508902995859327)
,p_computation_sequence=>10
,p_computation_item=>'P61_GEOMETRY'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2929320010453172078)
,p_validation_name=>'P61_AOI_NAME'
,p_validation_sequence=>10
,p_validation=>'P61_AOI_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'#LABEL# must have some value.'
,p_validation_condition=>':REQUEST in (''CREATE'',''SAVE'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_api.id(2929318614994154767)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2929542019174641879)
,p_validation_name=>'P61_GEOMETRY'
,p_validation_sequence=>20
,p_validation=>'P61_GEOMETRY'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Polygon for Area Of Interest must be drawn on the map.'
,p_associated_item=>wwv_flow_api.id(2929318906368158761)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929319303018164268)
,p_name=>'RedlineFinish: Get Geometry into P61_GEOMETRY'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010114263390594419)
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_redlinefinish'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929319610266164268)
,p_event_id=>wwv_flow_api.id(2929319303018164268)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETREDLIN'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GEOMETRY'
,p_attribute_01=>'WKT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2010116469607637144)
,p_event_id=>wwv_flow_api.id(2929319303018164268)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETDATA'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010114263390594419)
,p_attribute_01=>'JSON'
,p_attribute_02=>'MAP'
,p_attribute_13=>'P61_SRID'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929417290531709474)
,p_name=>'Change (P61_AOI_ID): Refresh Map'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_AOI_ID'
,p_condition_element=>'P61_AOI_ID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929518011653083203)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_AOI_NAME,P61_LON,P61_LAT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with centr as (',
'  select ',
'    aoi_name,',
'    sdo_geom.sdo_centroid(geometry, 1) as geometry',
'    from eba_spatial_aoi ',
'    where id = :P61_AOI_ID',
')',
'select ',
'  aoi_name,',
'  g.geometry.sdo_point.x x,',
'  g.geometry.sdo_point.y y',
'from centr g',
'    ',
'  '))
,p_attribute_07=>'P61_AOI_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_stop_execution_on_error=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929531317128506107)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_AOI_ID,P61_AOI_NAME,P61_GEOMETRY'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929417616534709475)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'TRUE'
,p_action_sequence=>25
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010114263390594419)
,p_attribute_01=>'REFRESHFOI'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929518206692085448)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010114263390594419)
,p_attribute_01=>'P61_LON'
,p_attribute_02=>'P61_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_05=>'CENTER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929530910455493956)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010114263390594419)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264978482183156792)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2264977840246156786)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264978782773156795)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2264977840246156786)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264978543227156793)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2264978388992156791)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264978881556156796)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'FALSE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2264978202929156790)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264978696395156794)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2264978202929156790)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264978904507156797)
,p_event_id=>wwv_flow_api.id(2929417290531709474)
,p_event_result=>'FALSE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2264978388992156791)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2929518718067105332)
,p_name=>'Change (P61_UNIT): Refresh Report'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_UNIT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2929519012829105335)
,p_event_id=>wwv_flow_api.id(2929518718067105332)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2929413897364654660)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2951444998883236067)
,p_name=>'Start Redlining: Create New really chosen?'
,p_event_sequence=>90
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010114263390594419)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v("P61_AOI_ID")!=""'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_redlinestart'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2951445310507236070)
,p_event_id=>wwv_flow_api.id(2951444998883236067)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010114263390594419)
,p_attribute_01=>'RLCLEAR'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2951450801854346114)
,p_event_id=>wwv_flow_api.id(2951444998883236067)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'gPolyVertices = 0;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2951445491806244416)
,p_event_id=>wwv_flow_api.id(2951444998883236067)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Set "Show on Map" to "Create New" before drawing a polygon.'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2951450889504356361)
,p_name=>'Point added: Finish Polygon at 101st point'
,p_event_sequence=>100
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010114263390594419)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'gPolyVertices < 100'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_redlinepoint'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2951451205506356364)
,p_event_id=>wwv_flow_api.id(2951450889504356361)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'gPolyVertices++;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2951451416722356364)
,p_event_id=>wwv_flow_api.id(2951450889504356361)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010114263390594419)
,p_attribute_01=>'RLFINISH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2951592012559219640)
,p_name=>'Redline Clear: Clear P61_GEOMETRY also'
,p_event_sequence=>120
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010114263390594419)
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_redlineclear'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2951592291438219644)
,p_event_id=>wwv_flow_api.id(2951592012559219640)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GEOMETRY'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2171074089375510800)
,p_name=>'Click on GET_HTML5_LOCATION: Trigger HTML5 Location'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2171073934609510799)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171074134407510801)
,p_event_id=>wwv_flow_api.id(2171074089375510800)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC'
,p_attribute_01=>'P61_LON'
,p_attribute_02=>'P61_LAT'
,p_attribute_03=>'P61_HTML5_STATUS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2171074223213510802)
,p_name=>'HTML5 Location Received: Center Map and Set Marker'
,p_event_sequence=>140
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC|DYNAMIC ACTION|com_oracle_oramapshtml5_locsuccess'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171074361438510803)
,p_event_id=>wwv_flow_api.id(2171074223213510802)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010114263390594419)
,p_attribute_01=>'P61_LON'
,p_attribute_02=>'P61_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_05=>'CENTER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171074410436510804)
,p_event_id=>wwv_flow_api.id(2171074223213510802)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETMARKER'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010114263390594419)
,p_attribute_01=>'P61_LON'
,p_attribute_02=>'P61_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_04=>'red'
,p_attribute_05=>'Your Position'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2264977935265156787)
,p_name=>'Click CREATE Button: Store Polygon'
,p_event_sequence=>150
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2264977840246156786)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v("P61_AOI_NAME") != ""'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264978019680156788)
,p_event_id=>wwv_flow_api.id(2264977935265156787)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264978109124156789)
,p_event_id=>wwv_flow_api.id(2264977935265156787)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Enter a name for the new Area Of Interest.'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2264979007187156798)
,p_name=>'Click on SAVE: Save new Name'
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2264978388992156791)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v("P61_AOI_NAME") != ""'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264979183426156799)
,p_event_id=>wwv_flow_api.id(2264979007187156798)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2264979245182156800)
,p_event_id=>wwv_flow_api.id(2264979007187156798)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Area Of Interest Name must not be empty.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2929540908435632479)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Button CREATE: Store Area Of Interest'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  insert into eba_spatial_aoi (aoi_name, geometry, owner)',
'  values (',
'    :P61_AOI_NAME,',
'    eba_spatial_sample.geometry_from_wkt(:P61_GEOMETRY, :P61_SRID), ',
'    :APP_USER',
'  )',
'  returning id into :P61_AOI_ID;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2264977840246156786)
,p_process_success_message=>'Area Of Interest created.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2929542204541650319)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Button SAVE: Change AOI Name'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'update eba_spatial_aoi',
'set aoi_name = :P61_AOI_NAME',
'where id = :P61_AOI_ID;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2264978388992156791)
,p_process_success_message=>'Area of interest name changed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2929543715192672313)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Button DELETE: Delete Area Of Interest'
,p_process_sql_clob=>'delete from eba_spatial_aoi where id = :P61_AOI_ID;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2264978202929156790)
,p_process_success_message=>'Area Of Interest deleted.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2929544105627679009)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'After DELETE: Reset Page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2264978202929156790)
);
wwv_flow_api.component_end;
end;
/
