prompt --application/shared_components/security/authorizations/license_terms_accepted
begin
--   Manifest
--     SECURITY SCHEME: License Terms Accepted
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(2193433286277507733)
,p_name=>'License Terms Accepted'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :APP_PAGE_ID in (1,44,101) or nvl(:LICENSETERMS,''X'') = ''ACCEPTED'' then',
'    return TRUE;',
'else',
'    return FALSE;',
'end if;'))
,p_error_message=>'License Terms must first be accepted.'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_api.component_end;
end;
/
