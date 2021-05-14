prompt --application/pages/page_00044
begin
--   Manifest
--     PAGE: 00044
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
 p_id=>44
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'License Terms'
,p_alias=>'LICENSE-TERMS'
,p_step_title=>'License Terms'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_step_template=>wwv_flow_api.id(2134489239113489192)
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_upd_yyyymmddhh24miss=>'20200116130020'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3013416811794019391)
,p_plug_name=>'License Terms'
,p_region_template_options=>'#DEFAULT#:t-Alert--defaultIcons:t-Alert--info:t-Alert--wizard'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134497754814489208)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="infoTextRegion">',
'<p>',
'The Oracle Maps and Geocoder Plug-ins within this Oracle Application Express application use the mapping and geocoding services of Oracle''s eLocation Service (maps.oracle.com). These Plug-ins must be used as-is and the services may only be accessed t'
||'hrough the included Plug-ins.  ',
'</p>',
'<p>',
'The Here (formerly Navteq) data accessible through this service is subject to Oracle Legal Notices (<a href="http://www.oracle.com/us/legal/index.html" target="_blank">http://www.oracle.com/us/legal/index.html</a>) and under these Terms of Use (<a hr'
||'ef="http://maps.oracle.com/elocation/legal.html" target="_blank">http://maps.oracle.com/elocation/legal.html</a>). ',
'</p>',
'<p>',
'These license terms are in addition to the Oracle Technology Network Development and Distribution License Agreement Terms for Oracle Application Express.',
'</p>',
'<p>You must accept the license terms by clicking the "I Accept" checkbox before proceeding.</p>',
'</div>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3013417011946019391)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(3013416811794019391)
,p_button_name=>'ACCEPT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Accept'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_css_classes=>'disabled'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3013417200974019393)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(3013416811794019391)
,p_button_name=>'DECLINE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_image_alt=>'Decline'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(3013419918780019406)
,p_branch_name=>'decline branch'
,p_branch_action=>'LOGOUT_URL'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'BRANCH_TO_URL_IDENT_BY_ITEM'
,p_branch_when_button_id=>wwv_flow_api.id(3013417200974019393)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(3013419696422019404)
,p_branch_name=>'accept branch'
,p_branch_action=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3013417411539019393)
,p_name=>'P44_ACCEPT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(3013416811794019391)
,p_source=>'LICENSETERMS'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'I ACCEPT'
,p_lov=>'.'||wwv_flow_api.id(3013420017663019406)||'.'
,p_lov_display_null=>'YES'
,p_tag_attributes=>'style="margin-left:0px;padding-left:0px;"'
,p_field_template=>wwv_flow_api.id(2134537405443489335)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(3013418089222019397)
,p_computation_sequence=>10
,p_computation_item=>'LICENSETERMS'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'ACCEPTED'
,p_compute_when=>':REQUEST = ''ACCEPT'''
,p_compute_when_text=>'PLSQL'
,p_compute_when_type=>'EXPRESSION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(3013418518046019401)
,p_validation_name=>'P44_ACCEPT'
,p_validation_sequence=>10
,p_validation=>'P44_ACCEPT'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'You must accept the license terms before proceeding.'
,p_when_button_pressed=>wwv_flow_api.id(3013417011946019391)
,p_associated_item=>wwv_flow_api.id(3013417411539019393)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3013418988549019401)
,p_name=>'enable accept button'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P44_ACCEPT'
,p_condition_element=>'P44_ACCEPT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'ACCEPTED'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3013419312897019402)
,p_event_id=>wwv_flow_api.id(3013418988549019401)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(3013417011946019391)
,p_attribute_01=>'disabled'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3013419487535019403)
,p_event_id=>wwv_flow_api.id(3013418988549019401)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(3013417011946019391)
,p_attribute_01=>'disabled'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3013418799369019401)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Track Acceptance'
,p_process_sql_clob=>':LICENSETERMS := :P44_ACCEPT;'
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(3013417011946019391)
,p_process_when=>'P44_ACCEPT'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'ACCEPTED'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3013418587466019401)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Decline'
,p_process_sql_clob=>':LICENSETERMS := ''DECLINED'';'
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(3013417200974019393)
);
wwv_flow_api.component_end;
end;
/
