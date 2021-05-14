prompt --application/shared_components/user_interface/lovs/lov_addresses
begin
--   Manifest
--     LOV_ADDRESSES
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(2929290507855124862)
,p_lov_name=>'LOV_ADDRESSES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select addr_name|| '' ('' || addr_city || '')'' d, id r',
'from   eba_spatial_addresses ',
'where addr_location is not null',
'and addr_type=''SUPPLIER''',
'order by 1'))
,p_source_type=>'LEGACY_SQL'
,p_location=>'LOCAL'
);
wwv_flow_api.component_end;
end;
/
