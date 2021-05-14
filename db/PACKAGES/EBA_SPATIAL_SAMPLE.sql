--------------------------------------------------------
--  DDL for Package EBA_SPATIAL_SAMPLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "EBA_SPATIAL_SAMPLE" is
  function get_version return varchar2;
  function geom_to_string(
    p_geom in sdo_geometry
  ) return varchar2;
  function make_shortstring(
    p_text in varchar2, 
    p_len in number
  ) return varchar2;
  function geometry_from_wkt(
    p_wkt in clob, 
    p_srid in number
  ) return sdo_geometry;
  function geometry_from_xml(
    p_sdogeom_xml in varchar2
  ) return sdo_geometry;
  function point(
    p_lon in number, 
    p_lat in number
  ) return sdo_geometry;
  procedure get_map_defaults(
    p_def_country out varchar2,
    p_unit_system out varchar2,
    p_mapcenter   out varchar2,
    p_zoomlevel   out varchar2
  );
  procedure reset_tables;
  
  function get_star_rating_html( p_stars in number ) return varchar2;
end eba_spatial_sample;

/
