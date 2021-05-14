--------------------------------------------------------
--  DDL for Package Body EBA_SPATIAL_SAMPLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "EBA_SPATIAL_SAMPLE" is
  function get_version return varchar2 is
  begin
    return '1.1';
  end get_version;
    
    
  function get_star_rating_html( p_stars in number ) return varchar2 is
      l_html varchar2(32767) := '';
  begin
      if p_stars is null then 
         return null;
      end if;
      for i in 1..p_stars loop
          l_html := l_html || '<span class="fa fa-star" style="color: red"></span>';
      end loop;
      for i in (p_stars + 1)..5 loop
          l_html := l_html || '<span class="fa fa-star" style="color: #e0e0e0"></span>';
      end loop;
      return l_html;
  end get_star_rating_html;
  
  function geom_to_string(
    p_geom in sdo_geometry
  ) return varchar2 is
  
    l_lonlatstring varchar2(100);
    l_num          number;
    l_rem          number;
    l_dir          char(1);
  
    function make_part(p_num in number) return varchar2 is
      l_num number;
      l_rem number;
      l_part varchar2(100);
    begin
      l_num := p_num;
      l_rem := l_num - floor(l_num);
      l_part := l_part || to_char(floor(l_num))||unistr('\00B0'); -- 00B0 is the degree sign
      l_num := l_rem * 60;
      l_rem := l_num - floor(l_num);
      l_part := l_part || to_char(floor(l_num), 'FM00')||'''';
      l_num := l_rem * 60;
      l_rem := l_num - floor(l_num);
      l_part := l_part || to_char(floor(l_num), 'FM00')||'"';
      return l_part;
    end make_part;
  begin
    if p_geom is not null then
      if p_geom.sdo_srid in (4326,8307) and p_geom.sdo_gtype in (2001, 3001, 3301) then
        if p_geom.sdo_point.x < 0 then l_dir := 'W'; else l_dir := 'E'; end if;
        l_lonlatstring := l_lonlatstring || make_part(abs(p_geom.sdo_point.x)) || ' ' || l_dir || ' - ';
        if p_geom.sdo_point.y < 0 then l_dir := 'S'; else l_dir := 'N'; end if;
        l_lonlatstring := l_lonlatstring || make_part((p_geom.sdo_point.y)) || ' ' || l_dir;
      else
        l_lonlatstring := '- NOT A POINT GEOMETRY -';
      end if;
    end if;
    return l_lonlatstring;
  end geom_to_string;   
  function make_shortstring(
    p_text in varchar2, 
    p_len in number
  ) return varchar2 is
  begin
    if length(p_text) <= p_len then
      return p_text;
    else
      return substr(p_text, 1, p_len - 4) || ' ...';
    end if;
  end make_shortstring;
  function geometry_from_wkt(p_wkt in clob, p_srid in number) return sdo_geometry is
    l_geom sdo_geometry;
  begin
    l_geom := sdo_util.rectify_geometry(sdo_geometry(p_wkt, p_srid),1);
    if p_srid != 4326 then
      l_geom := sdo_cs.transform(l_geom, 4326);
    end if;
    return l_geom;
  end geometry_from_wkt;
  function geometry_from_xml(p_sdogeom_xml in varchar2) return sdo_geometry is
    l_geom      sdo_geometry;
    l_xml       xmltype := xmltype(p_sdogeom_xml);
    l_gtype     number;
    l_srid      number;
    l_elem_info sdo_elem_info_array := sdo_elem_info_array();
    l_ordinates sdo_ordinate_array  := sdo_ordinate_array();
  begin
    select gtype, srid into l_gtype, l_srid
    from xmltable(
      '/SDO_GEOMETRY'
      passing l_xml
      columns 
        gtype number(5)  path 'SDO_GTYPE/text()',
        srid  number(10) path 'SDO_SRID/text()'
    );
    for e in (
      select elem_info
      from xmltable(
        '/SDO_GEOMETRY/SDO_ELEM_INFO/N'
        passing l_xml
        columns elem_info varchar2(100) path '/N/text()'
      )
    ) loop
        l_elem_info.extend(1);
        l_elem_info(l_elem_info.count) := 
          to_number(e.elem_info, '9999999999D999999999999999999', 'nls_numeric_characters=''.,''');
    end loop;
           
    for o in (
      select ordinate
      from xmltable(
        '/SDO_GEOMETRY/SDO_ORDINATES/N'
        passing l_xml
        columns ordinate varchar2(100) path '/N/text()'
      )
    ) loop
        l_ordinates.extend(1);
        l_ordinates(l_ordinates.count) := 
          to_number(o.ordinate, '9999999999D9999999999999999999', 'nls_numeric_characters=''.,''');
    end loop;
    l_geom := mdsys.sdo_geometry(l_gtype, l_srid, null, l_elem_info, l_ordinates);
    l_geom := sdo_util.rectify_geometry(l_geom, 1);
    if l_srid != 4326 then
      l_geom := sdo_cs.transform(l_geom, 4326);
    end if;
    if sdo_util.getnumvertices(l_geom) > 41 then
        raise_application_error(-20000, 'Polygon is too complex for this demonstration environment.');
    end if;
    return l_geom;
  end geometry_from_xml;
  function point(
    p_lon in number,
    p_lat in number
  ) return sdo_geometry is
  begin
      -- return apex_spatial.point(p_lon, p_lat);
    return sdo_geometry(2001, 4326, sdo_point_type(p_lon, p_lat, null), null, null);
  end point;
  procedure get_map_defaults(
    p_def_country out varchar2,
    p_unit_system out varchar2,
    p_mapcenter   out varchar2,
    p_zoomlevel   out varchar2
  ) is 
begin
begin
  select value into p_def_country
  from eba_spatial_defaults
  where param = 'DEF_COUNTRY';
exception when NO_DATA_FOUND then p_def_country := 'US';
end;
begin
  select value into p_unit_system
  from eba_spatial_defaults
  where param = 'UNIT_SYSTEM';
exception when NO_DATA_FOUND then p_unit_system := 'METRIC';
end;
begin
select 
  to_char(map_centerx, 'FM990D0', 'nls_numeric_characters=''.,''')||
  ','||
  to_char(map_centery, 'FM990D0', 'nls_numeric_characters=''.,'''),
  map_zoom
into p_mapcenter, p_zoomlevel
from eba_spatial_countries
where code = p_def_country;
exception
  when NO_DATA_FOUND then 
    p_zoomlevel := 1;
    p_mapcenter := '-100,38';
end;
end get_map_defaults;
procedure reset_tables
is
begin
    delete from eba_spatial_aoi;
    delete from eba_spatial_addresses;
    insert into eba_spatial_addresses (addr_name, addr_street, addr_city, addr_country, addr_type, owner)
    values ('Oracle Corporation', '500, Oracle Parkway', 'Redwood City', 'US', 'CUSTOMER', 'EBA');
    insert into eba_spatial_addresses (addr_name, addr_street, addr_postal_code, addr_city, addr_country, addr_type, owner, addr_location)
    values ('Oracle Deutschland B.V. & Co KG', 'Riesstr. 25', '80992', unistr('M\00FCnchen'), 'DE', 'CUSTOMER', 'EBA', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(11.5367, 48.1801, NULL), NULL, NULL));
    
    insert into eba_spatial_addresses (addr_name, addr_street, addr_postal_code, addr_city, addr_country, owner, addr_type, addr_location, addr_state)
    values ('Oracle UK', '510 Oracle Parkway', 'RG6 1', 'Reading', 'UK', 'EBA', 'CUSTOMER', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(-0.9382, 51.46, NULL), NULL, NULL), 'Berkshire');
    insert into eba_spatial_addresses (addr_name, addr_street, addr_postal_code, addr_city, addr_country, owner, addr_type, addr_location)
    values ('Oracle Austria', 'Wagramer Str. 17-19', '1220', 'Wien', 'AT', 'EBA', 'SUPPLIER', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(16.4201, 48.2341, NULL), NULL, NULL));
    
end reset_tables;
end eba_spatial_sample;

/
