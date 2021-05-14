prompt --application/pages/page_00025
begin
--   Manifest
--     PAGE: 00025
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
 p_id=>25
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Heat Map'
,p_alias=>'HEAT-MAP'
,p_step_title=>'Heat Map'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'CARSTEN'
,p_last_upd_yyyymmddhh24miss=>'20200628113921'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(509890990195420496)
,p_plug_name=>'&MAPSERVER_NAME.'
,p_region_name=>'HeatMap'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  ''A''||id as id,',
'  addr_location as geometry,',
'  '''' as infotext,',
'  ''red'' as style,',
'  ''heat'' as layer',
'from eba_spatial_addresses'))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5'
,p_ajax_items_to_submit=>'P25_RATING'
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
,p_attribute_13=>'SCALE'
,p_attribute_14=>'500'
,p_attribute_15=>'280'
,p_attribute_16=>'250'
,p_attribute_17=>'Y'
,p_attribute_18=>'Y'
,p_attribute_19=>'N'
,p_attribute_20=>'&MAP_OSM_COPYRIGHT.'
,p_attribute_21=>'PERCENT'
,p_attribute_22=>'METRIC'
,p_attribute_24=>'OSM'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(509893619049440574)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(509890990195420496)
,p_button_name=>'RECT_ZOOM'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_image_alt=>'Rectangle Zoom'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(509891240964420500)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(509890990195420496)
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
 p_id=>wwv_flow_api.id(509891630133420507)
,p_name=>'P25_LON'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(509890990195420496)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(509892013732420512)
,p_name=>'P25_LAT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(509890990195420496)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(509892477871420513)
,p_name=>'P25_HTML5_STATUS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(509890990195420496)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(509893274637440570)
,p_name=>'Button Click: Get HTML5 Location'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(509891240964420500)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(509893392774440571)
,p_event_id=>wwv_flow_api.id(509893274637440570)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC'
,p_attribute_01=>'P25_LON'
,p_attribute_02=>'P25_LAT'
,p_attribute_03=>'P25_HTML5_STATUS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(509893413738440572)
,p_name=>'HTML5 Location received: Recenter Map'
,p_event_sequence=>20
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC|DYNAMIC ACTION|com_oracle_oramapshtml5_locsuccess'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(509893558285440573)
,p_event_id=>wwv_flow_api.id(509893413738440572)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(509890990195420496)
,p_attribute_01=>'P25_LON'
,p_attribute_02=>'P25_LAT'
,p_attribute_03=>'WGS84'
,p_attribute_05=>'CENTER'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(509893741689440575)
,p_name=>'Click on Rect Button: Activate Rectangle Zoom'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(509893619049440574)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(509893816196440576)
,p_event_id=>wwv_flow_api.id(509893741689440575)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(509890990195420496)
,p_attribute_01=>'RECTZOOM'
);
wwv_flow_api.component_end;
end;
/
