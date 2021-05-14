prompt --application/shared_components/security/authorizations/has_http_access
begin
--   Manifest
--     SECURITY SCHEME: HAS_HTTP_ACCESS
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
 p_id=>wwv_flow_api.id(26534143005405384731)
,p_name=>'HAS_HTTP_ACCESS'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    return upper(eba_spatial_gcdr_pkg.check_geocoder_http_access) = ''SUCCESS'';',
'exception',
'    when others then ',
'        return false;',
'end;'))
,p_error_message=>'No HTTP outbound access to "maps.oracle.com" - check PL/SQL ACL and/or proxy server definitions.'
,p_caching=>'BY_USER_BY_SESSION'
);
wwv_flow_api.component_end;
end;
/
