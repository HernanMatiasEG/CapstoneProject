prompt --application/pages/page_00001
begin
--   Manifest
--     PAGE: 00001
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
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Home'
,p_alias=>'HOME'
,p_step_title=>'Home'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_step_template=>wwv_flow_api.id(2134494653367489202)
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'B&C_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210507101325'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1680589333397046593)
,p_plug_name=>'&APP_NAME.'
,p_icon_css_classes=>'app-sample-geolocation'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134505980352489239)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2942965394273381975)
,p_plug_name=>'No HTTP access to Elocation Geocoder Service'
,p_region_template_options=>'#DEFAULT#:t-Alert--defaultIcons:t-Alert--warning:t-Alert--horizontal'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134497754814489208)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div>',
'Your APEX workspace is not able to perform an HTTP connection to the Oracle Elocation Geocoder Service on <b>maps.oracle.com</b>. Refer to the <a href="f?p=&APP_ID.:71:&SESSION.">Settings Page</a> for more information.',
'</div>'))
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_query_show_nulls_as=>' - '
,p_plug_required_role=>'!'||wwv_flow_api.id(26534143005405384731)
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2957730204699411437)
,p_plug_name=>'Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Cards--featured force-fa-lg:t-Cards--4cols:t-Cards--displayIcons:u-colors:t-Cards--desc-4ln:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(2134499814373489217)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(46757784031487001770)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(2134528556815489300)
,p_plug_query_row_template=>wwv_flow_api.id(2134522634660489284)
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(3013494307106505945)
,p_branch_name=>'Branch to Message if App Requirements not met'
,p_branch_action=>'f?p=&APP_ID.:78:&SESSION.::&DEBUG.:::'
,p_branch_point=>'BEFORE_HEADER'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_branch_condition=>'REQUIREMENTS_MET'
,p_branch_condition_text=>'N'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(3013444303922158972)
,p_branch_name=>'Branch to License Terms if not Accepted'
,p_branch_action=>'f?p=&APP_ID.:44:&SESSION.::&DEBUG.:::'
,p_branch_point=>'BEFORE_HEADER'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
,p_branch_condition_type=>'EXPRESSION'
,p_branch_condition=>'nvl(:LICENSETERMS,''X'') <> ''ACCEPTED'''
,p_branch_condition_text=>'PLSQL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1113777820069305189)
,p_name=>'Check for HTML5'
,p_event_sequence=>10
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!document.createElement(''canvas'').getContext;',
''))
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1113778001915305191)
,p_event_id=>wwv_flow_api.id(1113777820069305189)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Your browser does not support HTML5. This application uses HTML5 technology for map display. If your are using Internet Explorer, make sure to use IE9 or higher.'
);
wwv_flow_api.component_end;
end;
/
