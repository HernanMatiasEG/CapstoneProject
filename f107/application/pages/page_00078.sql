prompt --application/pages/page_00078
begin
--   Manifest
--     PAGE: 00078
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
 p_id=>78
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Application Prerequisites Not Met'
,p_alias=>'APPLICATION-PREREQUISITES-NOT-MET'
,p_step_title=>'Application Prerequisites Not Met'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_step_template=>wwv_flow_api.id(2134480622714489164)
,p_page_template_options=>'#DEFAULT#'
,p_nav_list_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_upd_yyyymmddhh24miss=>'20200116130020'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3013489405561036739)
,p_plug_name=>'This application can not run in your Database'
,p_region_template_options=>'#DEFAULT#:t-Alert--defaultIcons:t-Alert--warning:t-Alert--horizontal'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134497754814489208)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY_3'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The Sample Geolocation Showcase application has the following requirements:</p>',
'<ul>',
'<li>Database Version must be <b>11.2 or higher</b></li>',
'<li>APEX Version must be at least <b>19.1</b></li>',
'<li>Make sure that <b>Oracle Locator</b> is installed in your database - the SDO_GEOMETRY data type must be present.</li>',
'</ul>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.component_end;
end;
/
