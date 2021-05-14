prompt --application/pages/page_00071
begin
--   Manifest
--     PAGE: 00071
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
 p_id=>71
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_tab_set=>'TS1'
,p_name=>'Settings'
,p_alias=>'SETTINGS'
,p_step_title=>'Settings'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_nav_list_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_upd_yyyymmddhh24miss=>'20200116130020'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2951417216278094454)
,p_plug_name=>'Settings'
,p_region_template_options=>'#DEFAULT#:t-Region--hiddenOverflow:t-Region--hideHeader'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3013683195724797239)
,p_plug_name=>'Elocation Geocoder HTTP Access - More information'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134499814373489217)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
' This Application uses the Oracle Elocation Geocoding Service. The information above indicates whether your database is able to connect to the elocation service. ',
'</p>',
'<ul>',
' <li><strong>Success</strong>: The database is able to connect to the geocoder service</li>',
' <li><em>An error message</em>: There is an HTTP connection problem - Geocoding will  not be available in your application.',
'</ul>',
'<p>',
' Possible reasons for failing HTTP access are:',
'</p>',
'<ul>',
'<li><strong>Missing HTTP Network ACL</strong>: The DBA of your database needs to enable the APEX engine to connect to <strong>maps.oracle.com</strong> on <strong>port 80</strong>. The package <strong>DBMS_NETWORK_ACL_ADMIN</strong> can be used for th'
||'at</li>',
'<li><strong>Missing Proxy Server definition</strong>: If your database is behind a firewall, you need to set the proxy server either in the application settings (Shared Components) or within the APEX Instance Settings</li>',
'</ul>',
'<p>',
'After making changes to the network configuration, you will need to sign out and sign into the application again.',
'</p>',
' '))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(3013893615080850143)
,p_name=>'Oracle Elocation Geocoder HTTP Access'
,p_template=>wwv_flow_api.id(2134510792919489250)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hiddenOverflow'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--inline'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>'select eba_spatial_gcdr_pkg.check_geocoder_http_access from dual'
,p_ajax_enabled=>'Y'
,p_fixed_header=>'NONE'
,p_query_row_template=>wwv_flow_api.id(2134522634660489284)
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>1
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'no data found'
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
 p_id=>wwv_flow_api.id(3013893897552850179)
,p_query_column_id=>1
,p_column_alias=>'CHECK_GEOCODER_HTTP_ACCESS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<pre><strong>#CHECK_GEOCODER_HTTP_ACCESS#</strong></pre>'
,p_heading_alignment=>'LEFT'
,p_lov_show_nulls=>'NO'
,p_lov_display_extra=>'YES'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2264976432223156772)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save Settings'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2264980696345156814)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(2264976635723156774)
,p_branch_action=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2951417590576105340)
,p_name=>'P71_DEFAULT_COUNTRY'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2951417216278094454)
,p_prompt=>'Initial Map Focus on Country'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ALL_COUNTRIES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'  case ',
'    when gcdr_supported=''N'' then country_name || '' (Geocoding not available)''',
'    else country_name',
'  end as d, ',
'  code r',
'from   eba_spatial_countries',
'order by 1'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2951418097896117180)
,p_name=>'P71_UNITSYSTEM'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(2951417216278094454)
,p_prompt=>'Unit System'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Metric;METRIC,Imperial;IMPERIAL'
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2951589602124018057)
,p_name=>'P71_BACKTOPAGE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(2951417216278094454)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2951419802778167996)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'save settings'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'update eba_spatial_defaults set value = :P71_UNITSYSTEM',
'where param = ''UNIT_SYSTEM'';',
'update eba_spatial_defaults set value = :P71_DEFAULT_COUNTRY',
'where param = ''DEF_COUNTRY'';',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2264976432223156772)
,p_process_success_message=>'Settings changed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2951432297273469173)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'reload Defaults'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'eba_spatial_sample.get_map_defaults(',
'  :DEF_COUNTRY,',
'  :ORACLEMAPS_UNITSYSTEM,',
'  :DEF_MAPCENTER,',
'  :DEF_ZOOMLEVEL',
');',
':DISTANCE_UNIT := (case when :ORACLEMAPS_UNITSYSTEM = ''METRIC'' then ''km'' else ''mile'' end);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2951420005333178207)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Read current defaults from table'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'begin',
'  select value into :P71_UNITSYSTEM',
'  from eba_spatial_defaults',
'  where param = ''UNIT_SYSTEM'';',
'exception',
'  when NO_DATA_FOUND then :P71_UNITSYSTEM := ''METRIC'';',
'end;',
'begin',
'  select value into :P71_DEFAULT_COUNTRY',
'  from eba_spatial_defaults',
'  where param = ''DEF_COUNTRY'';',
'exception',
'  when NO_DATA_FOUND then :P71_DEFAULT_COUNTRY := ''US'';',
'end;',
'end;'))
,p_process_clob_language=>'PLSQL'
);
wwv_flow_api.component_end;
end;
/
