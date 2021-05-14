prompt --application/pages/page_00051
begin
--   Manifest
--     PAGE: 00051
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
 p_id=>51
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Edit address'
,p_alias=>'EDIT-ADDRESS'
,p_step_title=>'Edit address'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';',
'',
'function chooseAddress(street, hn, zip, city, state, x, y) {',
'  $s("P51_ADDR_STREET", hn+", "+street);',
'  $s("P51_ADDR_POSTAL_CODE", zip);',
'  $s("P51_ADDR_CITY", city);',
'  $s("P51_ADDR_STATE", state);',
'  $s("P51_LONGITUDE", x);',
'  $s("P51_LATITUDE", y);',
'  apex.event.trigger(document, "com_oracle_oramapshtml5_locsuccess");',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'CARSTEN'
,p_last_upd_yyyymmddhh24miss=>'20200821090403'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2010110766219562668)
,p_plug_name=>'&MAPSERVER_NAME.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY_3'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  id,',
'  addr_name as infotip,',
'  addr_location as geometry,',
'  ''blue'' as style',
'from eba_spatial_addresses',
'where id = :P51_ID',
'  '))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_column_width=>'width="60%"'
,p_attribute_01=>'&MAPSERVER_URL.'
,p_attribute_03=>'100,500'
,p_attribute_06=>'&DEF_MAPCENTER.'
,p_attribute_07=>'&DEF_ZOOMLEVEL.'
,p_attribute_08=>'WEST'
,p_attribute_09=>'1'
,p_attribute_13=>'OVER:MARQUEE:DISTANCE:SCALE'
,p_attribute_14=>'500'
,p_attribute_15=>'150'
,p_attribute_16=>'250'
,p_attribute_17=>'Y'
,p_attribute_18=>'N'
,p_attribute_19=>'N'
,p_attribute_20=>'&MAP_OSM_COPYRIGHT.'
,p_attribute_21=>'PERCENT'
,p_attribute_22=>'ITEM'
,p_attribute_23=>'ORACLEMAPS_UNITSYSTEM'
,p_attribute_24=>'OSM'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2957609710345323660)
,p_plug_name=>'Edit address'
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY_3'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Enter the address details and click on the Geocode button.  This will present a list of candidate addresses.  Choose one by clicking on the Street, and then the map will focus on the coordinates of the selected address.',
'</p>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(2957619109380400236)
,p_name=>'Geocoder results'
,p_template=>wwv_flow_api.id(2134510792919489250)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY_3'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'     nvl(c001, ''N/A'') as street,',
'     c002 as house_number,',
'     c003 as postal_code,',
'     c004 as settlement,',
'     c005 as builtup_area,',
'     nvl(c006,c005) as municipality,',
'     case ',
'       when c011  = ''US'' then c007  ',
'       else initcap(c007) ',
'     end as order1_area,',
'     c008 as side,',
'     c009 as error_message,',
'     c010 as match_vector,',
'     n001 as sequence,',
'     n002 as longitude,',
'     n003 as latitude,',
'     n004 as edge_id',
'from apex_collections where collection_name = ''GEOCODER_RESULTS''',
'and n002 is not null and n003 is not null',
'order by seq_id'))
,p_required_role=>wwv_flow_api.id(26534143005405384731)
,p_ajax_enabled=>'Y'
,p_fixed_header=>'NONE'
,p_query_row_template=>wwv_flow_api.id(2134522634660489284)
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'No addresses found.'
,p_query_row_count_max=>500
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
 p_id=>wwv_flow_api.id(2957619403833400250)
,p_query_column_id=>1
,p_column_alias=>'STREET'
,p_column_display_sequence=>1
,p_column_heading=>'Street'
,p_column_link=>'javascript:chooseAddress(''#STREET#'',''#HOUSE_NUMBER#'',''#POSTAL_CODE#'',''#MUNICIPALITY#'',''#ORDER1_AREA#'', ''#LONGITUDE#'', ''#LATITUDE#'')'
,p_column_linktext=>'#STREET#'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957619501877400252)
,p_query_column_id=>2
,p_column_alias=>'HOUSE_NUMBER'
,p_column_display_sequence=>2
,p_column_heading=>'House Number'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957619606842400252)
,p_query_column_id=>3
,p_column_alias=>'POSTAL_CODE'
,p_column_display_sequence=>3
,p_column_heading=>'Postal Code'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957619725561400252)
,p_query_column_id=>4
,p_column_alias=>'SETTLEMENT'
,p_column_display_sequence=>4
,p_column_heading=>'Settlement'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957619808007400252)
,p_query_column_id=>5
,p_column_alias=>'BUILTUP_AREA'
,p_column_display_sequence=>5
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957619925143400252)
,p_query_column_id=>6
,p_column_alias=>'MUNICIPALITY'
,p_column_display_sequence=>6
,p_column_heading=>'Municipality'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957620019039400252)
,p_query_column_id=>7
,p_column_alias=>'ORDER1_AREA'
,p_column_display_sequence=>7
,p_column_heading=>'State / Province'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957620118373400252)
,p_query_column_id=>8
,p_column_alias=>'SIDE'
,p_column_display_sequence=>8
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957620222056400252)
,p_query_column_id=>9
,p_column_alias=>'ERROR_MESSAGE'
,p_column_display_sequence=>9
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957620302116400252)
,p_query_column_id=>10
,p_column_alias=>'MATCH_VECTOR'
,p_column_display_sequence=>10
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957620427127400253)
,p_query_column_id=>11
,p_column_alias=>'SEQUENCE'
,p_column_display_sequence=>11
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957620526403400253)
,p_query_column_id=>12
,p_column_alias=>'LONGITUDE'
,p_column_display_sequence=>12
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957620606594400253)
,p_query_column_id=>13
,p_column_alias=>'LATITUDE'
,p_column_display_sequence=>13
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2957620699523400253)
,p_query_column_id=>14
,p_column_alias=>'EDGE_ID'
,p_column_display_sequence=>14
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2171075474627510814)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'SHOW_ON_MAP'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_image_alt=>'Show on Map'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_execute_validations=>'N'
,p_button_condition=>':P51_LONGITUDE is not null and :P51_LATITUDE is not null'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2957613928202339430)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'GEOCODE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_image_alt=>'Geocode'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_execute_validations=>'N'
,p_security_scheme=>wwv_flow_api.id(26534143005405384731)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2957610008992323670)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition=>'P51_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2957924514900719144)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2010110766219562668)
,p_button_name=>'GET_HTML5_LOCATION'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Current location'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2276914427389662373)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create Address'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P51_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2957610113710323670)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--simple:t-Button--danger'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P51_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2264979833356156806)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:52:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(2957611109157323688)
,p_branch_name=>'Back to "Addresses Overview"'
,p_branch_action=>'f?p=&APP_ID.:52:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(230692185443241435)
,p_name=>'P51_ADDR_TYPE'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Type of Address'
,p_source=>'ADDR_TYPE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Customer;CUSTOMER,Supplier;SUPPLIER'
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'5'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957611299508323695)
,p_name=>'P51_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_use_cache_before_default=>'NO'
,p_source=>'ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957611509732323716)
,p_name=>'P51_ADDR_NAME'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'ADDR_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>80
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957611720722323717)
,p_name=>'P51_ADDR_STREET'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Street address'
,p_source=>'ADDR_STREET'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>80
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957611924058323717)
,p_name=>'P51_ADDR_POSTAL_CODE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Postal Code'
,p_source=>'ADDR_POSTAL_CODE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>16
,p_cMaxlength=>20
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957612105591323717)
,p_name=>'P51_ADDR_CITY'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_use_cache_before_default=>'NO'
,p_prompt=>'City'
,p_source=>'ADDR_CITY'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>64
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957612325015323718)
,p_name=>'P51_ADDR_STATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_use_cache_before_default=>'NO'
,p_prompt=>'State or Province'
,p_source=>'ADDR_STATE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>200
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957612528841323718)
,p_name=>'P51_ADDR_COUNTRY'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_use_cache_before_default=>'NO'
,p_item_default=>'&DEF_COUNTRY.'
,p_prompt=>'Country'
,p_source=>'ADDR_COUNTRY'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_COUNTRIES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select country_name d, code r',
'from   eba_spatial_countries',
'where gcdr_supported = ''Y''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Please choose - '
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957614229118344987)
,p_name=>'P51_ADDRESS_LINES'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957692002887524294)
,p_name=>'P51_LONGITUDE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957692330048526925)
,p_name=>'P51_LATITUDE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2957925222442725255)
,p_name=>'P51_HTML5_STATUS'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(2957609710345323660)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957694097455586088)
,p_name=>'PageLoad: Hide geocoder results'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_security_scheme=>wwv_flow_api.id(26534143005405384731)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957694407796586090)
,p_event_id=>wwv_flow_api.id(2957694097455586088)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2957619109380400236)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957919799822601172)
,p_name=>'MapInit: Get address position and trigger "Location received"'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(2010110766219562668)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v("P51_ID") != ""'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.HTML5|REGION TYPE|com_oracle_oramapshtml5_mapinitialized'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957920110625601194)
,p_event_id=>wwv_flow_api.id(2957919799822601172)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P51_LONGITUDE,P51_LATITUDE'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  c.addr_location.sdo_point.x as x,',
'  c.addr_location.sdo_point.y as y',
'from eba_spatial_addresses c',
'where id = :P51_ID'))
,p_attribute_07=>'P51_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2958064530101970674)
,p_event_id=>wwv_flow_api.id(2957919799822601172)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.event.trigger(document, "com_oracle_oramapshtml5_locsuccess");'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957618519292393666)
,p_name=>'Button (GEOCODE): Perform Geocoding'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2957613928202339430)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v("P51_ADDR_COUNTRY") != ""'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957694809510597228)
,p_event_id=>wwv_flow_api.id(2957618519292393666)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'alert("Please choose a country first.")'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957920805682657083)
,p_event_id=>wwv_flow_api.id(2957618519292393666)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P51_ADDRESS_LINES'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P51_ADDR_STREET").replace(",", " ") + ',
'", " +',
'$v("P51_ADDR_CITY").replace(",", " ") + ',
'", " +',
'$v("P51_ADDR_STATE").replace(",", " ")'))
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2945143095776991637)
,p_event_id=>wwv_flow_api.id(2957618519292393666)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2957613928202339430)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957618801329393671)
,p_event_id=>wwv_flow_api.id(2957618519292393666)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ELOCGEOCODER'
,p_attribute_01=>'GEOCODER_RESULTS'
,p_attribute_02=>'DEFAULT'
,p_attribute_03=>'P51_ADDR_COUNTRY'
,p_attribute_04=>'P51_ADDRESS_LINES'
,p_attribute_05=>','
,p_attribute_08=>'NORMAL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957924729791723362)
,p_name=>'Button (GET_HTML5_LOC): Trigger "Get HTML5 Location"'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2957924514900719144)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2010456369483320952)
,p_event_id=>wwv_flow_api.id(2957924729791723362)
,p_event_result=>'TRUE'
,p_action_sequence=>5
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2957924514900719144)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957925014290723366)
,p_event_id=>wwv_flow_api.id(2957924729791723362)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC'
,p_attribute_01=>'P51_LONGITUDE'
,p_attribute_02=>'P51_LATITUDE'
,p_attribute_03=>'P51_HTML5_STATUS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2957927013401860583)
,p_name=>'HTML5 Location received: Center Map and set Marker'
,p_event_sequence=>50
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P51_LONGITUDE") != "" && $v("P51_LATITUDE") != "")'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.GETLOC|DYNAMIC ACTION|com_oracle_oramapshtml5_locsuccess'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2010455880698315709)
,p_event_id=>wwv_flow_api.id(2957927013401860583)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010110766219562668)
,p_attribute_01=>'REMOVEMARKER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957927308750860591)
,p_event_id=>wwv_flow_api.id(2957927013401860583)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010110766219562668)
,p_attribute_01=>'P51_LONGITUDE'
,p_attribute_02=>'P51_LATITUDE'
,p_attribute_03=>'WGS84'
,p_attribute_05=>'CENTER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957927518448863875)
,p_event_id=>wwv_flow_api.id(2957927013401860583)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.ORAMAPS.SETMARKER'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2010110766219562668)
,p_attribute_01=>'P51_LONGITUDE'
,p_attribute_02=>'P51_LATITUDE'
,p_attribute_03=>'WGS84'
,p_attribute_04=>'red'
,p_attribute_05=>'The Position!'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2010456564955323009)
,p_event_id=>wwv_flow_api.id(2957927013401860583)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2957924514900719144)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2010444180544152934)
,p_name=>'Geocoder successful: Show results'
,p_event_sequence=>60
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.ELOCGEOCODER|DYNAMIC ACTION|com_oracle_eloc_gcdr_done'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2010444466786152940)
,p_event_id=>wwv_flow_api.id(2010444180544152934)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2957619109380400236)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2957621721304409415)
,p_event_id=>wwv_flow_api.id(2010444180544152934)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2957619109380400236)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2945143388443995012)
,p_event_id=>wwv_flow_api.id(2010444180544152934)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2957613928202339430)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2171075698992510816)
,p_name=>'SHOW_ON_MAP clicked: Center Map to Address location'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2171075474627510814)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171075795377510817)
,p_event_id=>wwv_flow_api.id(2171075698992510816)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P51_LONGITUDE,P51_LATITUDE'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  c.addr_location.sdo_point.x as x,',
'  c.addr_location.sdo_point.y as y',
'from eba_spatial_addresses c',
'where id = :P51_ID'))
,p_attribute_07=>'P51_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2171075848874510818)
,p_event_id=>wwv_flow_api.id(2171075698992510816)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.event.trigger(document, "com_oracle_oramapshtml5_locsuccess");'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2957612908314323720)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from EBA_SPATIAL_ADDRESSES'
,p_attribute_02=>'EBA_SPATIAL_ADDRESSES'
,p_attribute_03=>'P51_ID'
,p_attribute_04=>'ID'
,p_attribute_11=>'I:U:D'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2171075567568510815)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get address coordinates'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select ',
'  c.addr_location.sdo_point.x as x,',
'  c.addr_location.sdo_point.y as y',
'into :P51_LONGITUDE, :P51_LATITUDE',
'from eba_spatial_addresses c',
'where id = :P51_ID;',
'exception ',
'  when others then null;',
'end;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2957613102505323732)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of EBA_SPATIAL_ADDRESSES'
,p_attribute_02=>'EBA_SPATIAL_ADDRESSES'
,p_attribute_03=>'P51_ID'
,p_attribute_04=>'ID'
,p_attribute_09=>'P51_ID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action performed.'
,p_return_key_into_item1=>'P51_ID'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2957692505112540967)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Lon/Lat value'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'update eba_spatial_addresses set ',
'  addr_location = eba_spatial_sample.point(:P51_LONGITUDE, :P51_LATITUDE)',
'where id = :P51_ID;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':P51_LONGITUDE is not null and :P51_LATITUDE is not null and :P51_ID is not null  and :REQUEST in (''SAVE'', ''CREATE'')'
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2957613320308323732)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2957610113710323670)
);
wwv_flow_api.component_end;
end;
/
