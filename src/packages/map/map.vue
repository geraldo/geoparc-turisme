<template>
  <div id="map" class="map"></div>
  <div class="loading"><p></p><span></span></div>

  <div id="windowLayers" class="window">
    <div class="content">
      <div id="layerSwitcher" class="layer-switcher"></div>
    </div>
  </div>

  <div id="windowTablePois" class="window">
    <h2>
      <i class="fa fa-map-marker"></i>
      <span class="title">Punts de interès</span>
    </h2>
    <div class="content">
      <div id="datatable-pois"></div>
    </div>
  </div>

  <div id="windowTableRutas" class="window">
    <h2>
      <i class="fa fa-map-o"></i>
      <span class="title">Rutes recomanades</span>
    </h2>
    <div class="content">
      <div id="datatable-rutas"></div>
    </div>
  </div>

  <div id="windowInfo" class="window">
    <h2>
      <i class="fa fa-info-circle"></i>
      <span class="title">Informació</span>
    </h2>
    <div class="content">
      <h3>Contacte</h3>
      <p>Orígens UNESCO Global Geopark<br>
      Carrer de Soldevila, 3 – 25620 Tremp (Lleida)<br>
      Tlf. +34 973 651 088 / +34 636 868 713<br>
      info@geoparcorigens.cat</p>
      <h3>Amb el soport de</h3>
      <div class="wp-block-image">
        <figure class="aligncenter size-medium is-resized"><a href="https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1.jpg"><img decoding="async" loading="lazy" src="https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-300x56.jpg" alt="" class="wp-image-6401" srcset="https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-300x56.jpg 300w, https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-1024x192.jpg 1024w, https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-768x144.jpg 768w, https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-150x28.jpg 150w, https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1.jpg 1400w" sizes="(max-width: 225px) 100vw, 225px" width="225" height="42"></a></figure>
      </div>
      <div class="wp-block-image">
        <figure class="aligncenter size-medium"><a href="https://www.geoparcorigens.cat/wp-content/uploads/2015/05/diputacio.gif"><img decoding="async" loading="lazy" src="https://www.geoparcorigens.cat/wp-content/uploads/2015/05/diputacio-300x78.gif" alt="" class="wp-image-3099" srcset="https://www.geoparcorigens.cat/wp-content/uploads/2015/05/diputacio-300x78.gif 300w, https://www.geoparcorigens.cat/wp-content/uploads/2015/05/diputacio-150x39.gif 150w, https://www.geoparcorigens.cat/wp-content/uploads/2015/05/diputacio.gif 574w" sizes="(max-width: 300px) 100vw, 300px" width="300" height="78"></a></figure>
      </div>
      <div class="wp-block-image">
        <figure class="aligncenter size-medium is-resized"><a href="https://www.geoparcorigens.cat/wp-content/uploads/2021/07/Logo-FEDER-01.jpg"><img decoding="async" loading="lazy" src="https://www.geoparcorigens.cat/wp-content/uploads/2021/07/Logo-FEDER-01-300x65.jpg" alt="" class="wp-image-13491" srcset="https://www.geoparcorigens.cat/wp-content/uploads/2021/07/Logo-FEDER-01-300x65.jpg 300w, https://www.geoparcorigens.cat/wp-content/uploads/2021/07/Logo-FEDER-01-1024x223.jpg 1024w, https://www.geoparcorigens.cat/wp-content/uploads/2021/07/Logo-FEDER-01-768x167.jpg 768w, https://www.geoparcorigens.cat/wp-content/uploads/2021/07/Logo-FEDER-01-1536x334.jpg 1536w, https://www.geoparcorigens.cat/wp-content/uploads/2021/07/Logo-FEDER-01-150x33.jpg 150w, https://www.geoparcorigens.cat/wp-content/uploads/2021/07/Logo-FEDER-01.jpg 1781w" sizes="(max-width: 300px) 100vw, 300px" width="300" height="65"></a></figure>
      </div>
      <div class="wp-block-image">
        <figure class="aligncenter size-medium is-resized" style="float: left;"><a href="https://www.visitgeoparks.org/" target="_blank"><img decoding="async" loading="lazy" src="https://www.geoparcorigens.cat/wp-content/uploads/2022/05/Global_Geoparks_Network_logo-300x209.jpg" alt="" class="wp-image-14986" srcset="https://www.geoparcorigens.cat/wp-content/uploads/2022/05/Global_Geoparks_Network_logo-300x209.jpg 300w, https://www.geoparcorigens.cat/wp-content/uploads/2022/05/Global_Geoparks_Network_logo-150x105.jpg 150w, https://www.geoparcorigens.cat/wp-content/uploads/2022/05/Global_Geoparks_Network_logo.jpg 580w" sizes="(max-width: 75px) 100vw, 75px" width="75" height="52"></a></figure>
        <figure class="wp-block-image size-medium is-resized"><a href="http://www.europeangeoparks.org/" target="_blank"><img decoding="async" loading="lazy" src="https://www.geoparcorigens.cat/wp-content/uploads/2022/05/EGNLogoNEW-292x300.jpg" alt="" class="wp-image-14990" srcset="https://www.geoparcorigens.cat/wp-content/uploads/2022/05/EGNLogoNEW-292x300.jpg 292w, https://www.geoparcorigens.cat/wp-content/uploads/2022/05/EGNLogoNEW-996x1024.jpg 996w, https://www.geoparcorigens.cat/wp-content/uploads/2022/05/EGNLogoNEW-768x790.jpg 768w, https://www.geoparcorigens.cat/wp-content/uploads/2022/05/EGNLogoNEW-146x150.jpg 146w, https://www.geoparcorigens.cat/wp-content/uploads/2022/05/EGNLogoNEW.jpg 1489w" sizes="(max-width: 73px) 100vw, 73px" width="73" height="75"></a></figure>
      </div>
    </div>
  </div>
</template>

<script>
  import 'ol/ol.css';
  import 'ol-layerswitcher/dist/ol-layerswitcher.css';
  import 'ol-ext/dist/ol-ext.css';
  import 'font-awesome/css/font-awesome.min.css';

  import { ref, reactive, shallowReactive, toRefs, toRef, onMounted, onBeforeUnmount } from 'vue';

  import { Map, View, Feature, Collection, Overlay as OverlayOL } from 'ol';
  import {
    OSM,
    Cluster,
    XYZ as xyzSource,
    Vector as VectorSource, 
    TileWMS,
    VectorTile as VectorTileSource
  } from 'ol/source';
  import {
    Group as LayerGroup,
    Tile as TileLayer, 
    Vector as VectorLayer,
    VectorTile
  } from 'ol/layer';
  import { ScaleLine, FullScreen, defaults as defaultControls } from 'ol/control';
  import { Point, Polygon, LineString, Geometry } from 'ol/geom';
  import { Style, Icon, Text, Circle, Fill, Stroke } from 'ol/style';
  //import { register } from 'ol/proj/proj4';
  import { get as getProjection, getPointResolution, fromLonLat, toLonLat, transformExtent, METERS_PER_UNIT } from 'ol/proj';
  import { getLength, getArea } from 'ol/sphere';
  import { unByKey } from 'ol/Observable';
  import { easeOut } from 'ol/easing';
  import { GeoJSON, MVT } from 'ol/format';
  import { Select } from 'ol/interaction';
  import { pointerMove } from 'ol/events/condition';

  import Bar from 'ol-ext/control/Bar';
  import Button from 'ol-ext/control/Button';
  import Toggle from 'ol-ext/control/Toggle';
  import Overlay from 'ol-ext/control/Overlay';
  import GeolocationButton from 'ol-ext/control/GeolocationButton';
  import LayerSwitcherImage from 'ol-ext/control/LayerSwitcherImage';

  //import MapLibreLayer from '@geoblocks/ol-maplibre-layer';
  import LayerSwitcher from 'ol-layerswitcher';
  import Popup from 'ol-popup';
  //import SLDReader from '@nieuwlandgeo/sldreader';
  //import proj4 from 'proj4';
  import $ from 'jquery';
  import Cookies from 'js-cookie';
  import i18next from 'i18next';
  import DataTable from 'datatables.net';

  const tipusPoi = {
    "Zona de bany": "zona_bany",
    "Vol en Globus": "globus",
    "Via Ferrata": "viaferrata",
    "Rafting": "rafting",
    "Parapent": "parapent",
    "Caiac": "caiac",
    "Telefèric": "teleferic",
    "Establiment recomanat": "establiment_recomanat_1",
    "Mirador": "mirador",
    "Exposició a l'aire lliure": "exposicio_aire_lliure", // exposicio_aire_lliure
    "Cova visitable": "cova_visitable",
    "Església": "esglesia",
    "Castell": "castell",
    "Jaciment arqueològic": "jacimentarqueologic",
    "Lloc interès Geoparc": "lloc_interes_geoparc",
    "Informació turística": "info_turistica",
    "Centre d'Interpretació": "centre_interpretacio" // centre_interpretacio
  };
  const tipologiasRuta = {
    "Ruta a peu": "Ruta a peu",
    "Ruta en bicicleta": "Ruta en bicicleta",
    "El Cinquè Llac": "El Cinquè Llac",
    "Ruta Geològica": "Ruta Geològica",
    "Georuta": "Georuta"
  };

  function makeSafeForCSS(name) {
    if (name)
      return name.replace(/[^a-z0-9\_\-]/g, function(s) {
        var c = s.charCodeAt(0);
        if (c == 32) return '-';
        if (c >= 65 && c <= 90) return '_' + s.toLowerCase();
        return '__' + ('000' + c.toString(16)).slice(-4);
      });
    else
      return "";
  }

  /*
   * LayerSwitcher extended with legends
   *****************************************/
  class LayerSwitcherWithLegend extends LayerSwitcher {
    static renderPanel(map, panel, options) {
      // Create the event.
      const render_event = new Event('render');
      // Dispatch the event.
      panel.dispatchEvent(render_event);
      options = options || {};
      options.groupSelectStyle = LayerSwitcher.getGroupSelectStyle(options.groupSelectStyle);
      LayerSwitcher.ensureTopVisibleBaseLayerShown(map, options.groupSelectStyle);
      while (panel.firstChild) {
          panel.removeChild(panel.firstChild);
      }
      // Reset indeterminate state for all layers and groups before
      // applying based on groupSelectStyle
      LayerSwitcher.forEachRecursive(map, function (l, _idx, _a) {
          l.set('indeterminate', false);
      });
      if (options.groupSelectStyle === 'children' ||
          options.groupSelectStyle === 'none') {
          // Set visibile and indeterminate state of groups based on
          // their children's visibility
          LayerSwitcher.setGroupVisibility(map);
      }
      else if (options.groupSelectStyle === 'group') {
          // Set child indetermiate state based on their parent's visibility
          LayerSwitcher.setChildVisibility(map);
      }
      const ul = document.createElement('ul');
      panel.appendChild(ul);
      // passing two map arguments instead of lyr as we're passing the map as the root of the layers tree
      LayerSwitcherWithLegend.renderLayers_(map, map, ul, options, function render(_changedLyr) {
          LayerSwitcherWithLegend.renderPanel(map, panel, options);
      });
      // Create the event.
      const rendercomplete_event = new Event('rendercomplete');
      // Dispatch the event.
      panel.dispatchEvent(rendercomplete_event);
    }

    static renderLayers_(map, lyr, elm, options, render) {
      let lyrs = lyr.getLayers().getArray().slice();
      if (options.reverse)
        lyrs = lyrs.reverse();
      for (let i = 0, l; i < lyrs.length; i++) {
        l = lyrs[i];
        if (l.get('title')) {
            elm.appendChild(LayerSwitcherWithLegend.renderLayer_(map, l, i, options, render));
        }
      }
    }

    static renderLayer_(map, lyr, idx, options, render) {
      const li = document.createElement('li'),
            lyrTitle = lyr.get('title'),
            checkboxId = LayerSwitcher.uuid(),
            label = document.createElement('label');

      if (lyr instanceof LayerGroup && !lyr.get('combine')) {
        // group
        li.classList.add('group');
        const isBaseGroup = LayerSwitcher.isBaseGroup(lyr);
        if (isBaseGroup) {
          li.classList.add('base-group');
        }
        // Group folding
        if (lyr.get('fold')) {
          li.classList.add('layer-switcher-fold');
          li.classList.add('layer-switcher-' + lyr.get('fold'));
          const btn = document.createElement('button');
          btn.onclick = function (e) {
            const evt = e || window.event;
            LayerSwitcher.toggleFold_(lyr, li);
            evt.preventDefault();
          };
          li.appendChild(btn);
        }
        let fa = '<i class="fa fa-eye';
        if (!isBaseGroup && options.groupSelectStyle != 'none') {
          const input = document.createElement('input');
          input.type = 'checkbox';
          input.id = checkboxId;
          input.checked = lyr.getVisible();
          input.indeterminate = lyr.get('indeterminate');
          input.onchange = function (e) {
            const target = e.target;
            LayerSwitcher.setVisible_(map, lyr, target.checked, options.groupSelectStyle);
            render(lyr);
          };
          li.appendChild(input);
          label.htmlFor = checkboxId;
          if (!input.checked) fa += '-slash';
        }
        label.innerHTML =  fa + '"></i> ' + lyrTitle;
        li.appendChild(label);
        const ul = document.createElement('ul');
        li.appendChild(ul);
        LayerSwitcherWithLegend.renderLayers_(map, lyr, ul, options, render);
      }
      else {
        // layer
        li.className = 'layer ' + makeSafeForCSS(lyrTitle);
        const input = document.createElement('input');
        if (lyr.get('type') === 'base') {
          input.type = 'radio';
        }
        else {
          input.type = 'checkbox';
        }
        input.id = checkboxId;
        input.checked = lyr.get('visible');
        input.indeterminate = lyr.get('indeterminate');
        input.onchange = function (e) {
          const target = e.target;
          LayerSwitcher.setVisible_(map, lyr, target.checked, options.groupSelectStyle);
          render(lyr);
        };
        li.appendChild(input);

        // show legend image
        if (lyr.get("type") === "layer") {
          let simbol = document.createElement('img');
          simbol.className = 'leyenda';
          if (!input.checked) simbol.className += ' off';
          let icon = tipusPoi[lyrTitle];
          if (icon === undefined || icon === "undefined")
            icon = lyrTitle;
          //simbol.src = 'icons/' + icon + '.png';
          simbol.src = 'simbols/' + icon + '.svg';
          li.appendChild(simbol);
        }

        label.htmlFor = checkboxId;
        if (!input.checked) label.className = 'off';
        label.innerHTML = lyrTitle;

        const rsl = map.getView().getResolution();
        if (rsl >= lyr.getMaxResolution() || rsl < lyr.getMinResolution()) {
          label.className += ' disabled';
        }
        else if (lyr.getMinZoom && lyr.getMaxZoom) {
          const zoom = map.getView().getZoom();
          if (zoom <= lyr.getMinZoom() || zoom > lyr.getMaxZoom()) {
            label.className += ' disabled';
          }
        }
        li.appendChild(label);
      }
      return li;
    }
  }


  /*
   * Webviewer
   *****************************************/
  export default {
    name: 'ol-map',
    setup(props, context){
      let pageData = reactive({
        cookieOptions: { sameSite: 'strict', secure: true },
        lang: "cat",

        center: [{
          lng: 0.88,
          lat: 42.16
        }],
        map: null,
        mapEle: null,

        qgisServerURL: 'https://mapa.psig.es/qgisserver/cgi-bin/qgis_mapserv.fcgi',
        mapproxyServerURL: 'https://mapa.psig.es/mapproxy/service?',
        qgisProjectFile: '/home/geoparc/geoparc-turisme/geoparc-turisme.qgs',

        qgisWmsLayers: new LayerGroup({
          title: 'Capes temàtiques',
          fold: 'close'
        }),
        invisibleWmsLayers: [],
        qgisInvisibleWmsLayers: new LayerGroup({}),
        qgisWfsLayersPoi: new LayerGroup({
          title: 'Punts de interès',
          fold: 'open'
        }),
        qgisWfsLayersRuta: new LayerGroup({
          title: 'Rutes recomanades',
          fold: 'close'
        }),
        poisLayers: [],
        rutasLayers: [],

        mousePosition: null,
        rasterLayer: null,

        baseSourceOrto: new TileWMS({
          //url: 'https://geoserveis.icgc.cat/icc_mapesmultibase/utm/wms/service?',
          url: 'https://geoserveis.icgc.cat/servei/catalunya/orto-territorial/wms',
          params: {
            //'LAYERS': 'ortogris',
            'LAYERS': 'ortofoto_color_provisional',
            'VERSION': '1.1.1'
          },
          attributions: ['Ortofoto 2022 de l’<a target="_blank" href="https://www.icgc.cat/">Institut Cartogràfic i Geològic de Catalunya (ICGC)</a>, sota una llicència <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/deed.ca">CC BY 4.0</a>'],
         }),
        baseLayerOrto: new TileLayer({
          title: 'Ortofoto (ICGC)',
          baseLayer: true,
          visible: false,
          preview: 'https://geoserveis.icgc.cat/servei/catalunya/orto-territorial/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&FORMAT=image%2Fpng&TRANSPARENT=true&LAYERS=ortofoto_color_provisional&WIDTH=256&HEIGHT=256&SRS=EPSG%3A3857&STYLES=&BBOX=195678.7924100496%2C5087648.602661332%2C234814.55089205984%2C5126784.361143342'
        }),
        baseLayerTopo: new LayerGroup({
          title: 'Topogràfic (ICGC)',
          baseLayer: true,
          combine: true,
          visible: false,
          layers: [
            new TileLayer({
              minZoom: 14,
              source: new xyzSource({
                url: 'https://tilemaps.icgc.cat/mapfactory/wmts/topo_suau/CAT3857/{z}/{x}/{y}.png',
                attributions: ['Cartografia topogràfica de l’<a target="_blank" href="https://www.icgc.cat/">Institut Cartogràfic i Geològic de Catalunya (ICGC)</a>, sota una llicència <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/deed.ca">CC BY 4.0</a>'],
               })
            }),
            new TileLayer({
              maxZoom: 14,
              source: new xyzSource({
                url: 'https://tilemaps.icgc.cat/mapfactory/wmts/osm_suau/CAT3857_15/{z}/{x}/{y}.png',
                attributions: ['Cartografia topogràfica de l’<a target="_blank" href="https://www.icgc.cat/">Institut Cartogràfic i Geològic de Catalunya (ICGC)</a>, sota una llicència <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/deed.ca">CC BY 4.0</a>'],
               })
            })
          ]
        }),
        /*baseLayerVector: new MapLibreLayer({
          title: 'Topogràfic (ICGC)',
          baseLayer: true,
          visible: false,
          maplibreOptions: {
            style: "https://geoserveis.icgc.cat/contextmaps/icgc_mapa_estandard.json",
          }
        }),*/
        baseLayerContext: new TileLayer({
          title: 'Topogràfic (ICGC)',
          baseLayer: true,
          source: new xyzSource({
            maxZoom: 19,
            url: "https://geoserveis.icgc.cat/servei/catalunya/contextmaps/wmts/contextmaps-mapa-estandard/{z}/{x}/{y}.png",
            attributions: ["Institut Cartogràfic i Geològic de Catalunya CC-BY-SA-3"]
            /*projection: 'EPSG:3857',
            params: {
              'LAYERS': name,
              'TRANSPARENT': true,
              'VERSION': '1.3.0',
              'MAP': pageData.qgisProjectFile
            },
            serverType: 'qgis',
            crossOrigin: 'Anonymous',*/
          })
        }),
        baseLayerOSM: new TileLayer({
          title: 'Openstreetmap',
          baseLayer: true,
          visible: false,
          source: new OSM()
        }),

        /*baseLayers: new LayerGroup({
          title: 'Capes de referència',
          fold: 'close'
        }),*/

        windowLayers: null,
        windowTablePois: null,
        windowTableRutas: null,
        windowInfo: null,

        layersToggle: new Toggle({ 
          html: '<i class="fa fa-arrow-circle-right fa-lg"></i>',
          title: 'Tancar gestor de capes',
          className: "layersToggle",
          active: true,
          onToggle: function(active) {
            if (active) {
              pageData.windowLayers.show();
              $(".layersToggle i.fa").removeClass("fa-arrow-circle-left");
              $(".layersToggle i.fa").addClass("fa-arrow-circle-right");
            }
            else {
              pageData.windowLayers.hide();
              $(".layersToggle i.fa").removeClass("fa-arrow-circle-right");
              $(".layersToggle i.fa").addClass("fa-arrow-circle-left");
            }
          }
        }),
        tableTogglePois: new Toggle({ 
          html: '<i class="fa fa-map-marker fa-lg"></i>',
          title: 'Punts de interès',
          className: "tableTogglePois",
          onToggle: function(active) {
            if (active) {
              hideWindows("tablePois");
              pageData.windowTablePois.show();
            }
            else {
              pageData.windowTablePois.hide();
              $(".tableTogglePois").removeClass("ol-active");
            }
          }
        }),
        tableToggleRutas: new Toggle({ 
          html: '<i class="fa fa-map-o fa-lg"></i>',
          title: 'Rutes recomanades',
          className: "tableToggleRutas",
          onToggle: function(active) {
            if (active) {
              hideWindows("tableRutas");
              pageData.windowTableRutas.show();
            }
            else {
              pageData.windowTableRutas.hide();
              $(".tableToggleRutas").removeClass("ol-active");
            }
          }
        }),
        infoToggle: new Toggle({ 
          html: '<i class="fa fa-info-circle fa-lg"></i>',
          title: 'Informació',
          className: "infoToggle",
          onToggle: function(active) {
            if (active) {
              hideWindows("info");
              pageData.windowInfo.show();
            }
            else {
              pageData.windowInfo.hide();
              $(".infoToggle").removeClass("ol-active");
            }
          }
        }),
        caToggle: new Toggle({ 
          html: 'CA',
          className: "lang ca",
          title: "Català",
          onToggle: function() {
            i18next.changeLanguage('ca');
          }
        }),
        esToggle: new Toggle({ 
          html: 'ES',
          className: "lang es",
          title: "Castellano",
          onToggle: function() {
            i18next.changeLanguage('es');
          }
        }),

        iconLayer: null,
        iconPoint: null,
        tooltip: new Popup({
          className: "featureTooltip"
        }),
        popup: new Popup({
          className: "featurePopup"
        }),
      });

      /*
       * Load QGIS Server/Mapproxy layers
       *****************************************/
      function loadWmsLayers(layersData) {
        let layers = [];

        layersData.slice().reverse().forEach(function(layer, i) {

          if (layer.vectorial) {
            if (layer.name === "origens_turisme") {
              for (const tipo in tipusPoi) {
                loadWfsLayerPoi(tipo);
              }
            }
            else if (layer.name === "Rutes recomanades") {
              for (const tipo in tipologiasRuta) {
                loadWfsLayerRuta(tipo);
              }
            }
          }
          else if (layer.hidden) {
            pageData.invisibleWmsLayers.push(defineQgisLayer(layer));
          }
          else {
            layers.push(defineQgisLayer(layer));
          }
        });

        return layers;
      }

      function defineQgisLayer(layer) {
        let name = null, 
          url = null;

        if (layer.mapproxy) {
          name = layer.mapproxy;  // mapproxy
          url = pageData.mapproxyServerURL;
        }
        else {
          name = layer.name;  // qgis
          url = pageData.qgisServerURL;
        }

        let newLayer = 
          new TileLayer({
            qgisname: layer.qgisname,
            mapproxy: layer.mapproxy,
            type: layer.type,
            showlegend: layer.showlegend,
            visible: layer.visible,
            hidden: layer.hidden,
            children: layer.children,
            fields: layer.fields,
            indentifiable: layer.indentifiable,
            source: new TileWMS({
              url: url,
              projection: 'EPSG:3857',
              params: {
                'LAYERS': name,
                'TRANSPARENT': true,
                'VERSION': '1.3.0',
                'MAP': pageData.qgisProjectFile
              },
              serverType: 'qgis',
              crossOrigin: 'Anonymous'
            })
          });

        if (!layer.name.startsWith("@"))
          newLayer.set("title", layer.name);

        return(newLayer);
      }

      function loadWfsLayerPoi(tipologia) {
        let tipo = tipologia;
        if (tipologia === "Exposició a l'aire lliure") tipo = tipusPoi["Exposició a l'aire lliure"];
        else if (tipologia === "Centre d'Interpretació") tipo = tipusPoi["Centre d'Interpretació"];

        let vectorLayer = new VectorLayer({
          title: tipologia,
          vectorial: true,
          type: "layer",
          source: new VectorSource({
            format: new GeoJSON(),
            url: 'https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.geojson?MAP=' + pageData.qgisProjectFile + '&limit=1000&tipus_cat=' + tipo
          }),
          style: iconStyleFunction
        });
        pageData.poisLayers.push(vectorLayer);
      
        /*fetch("js/data/origens_turisme.sld")
          .then(response => response.text())
          .then(sld => applyVectorStyle(vectorLayer, sld));*/
      }

      function loadWfsLayerRuta(tipologia) {
        let vectorLayer = new VectorLayer({
          title: tipologia,
          vectorial: true,
          type: "layer",
          source: new VectorSource({
            format: new GeoJSON(),
            url: 'https://mapa.psig.es/qgisserver/wfs3/collections/Rutes recomanades/items.geojson?MAP=' + pageData.qgisProjectFile + '&limit=1000&tipologia_cat=' + tipologia
          }),
          style: rutaStyleFunction
        });
        pageData.rutasLayers.push(vectorLayer);

        /*fetch("js/data/Rutes recomanades.sld")
          .then(response => response.text())
          .then(sld => applyVectorStyle(vectorLayer, sld));*/
      }

      /*function applyVectorStyle(vectorLayer, sld) {

        const sldObject = SLDReader.Reader(sld),
              sldLayer = SLDReader.getLayer(sldObject),
              style = SLDReader.getStyle(sldLayer);

        //console.log(sldLayer.name, style);

        if (style.hasOwnProperty("featuretypestyles") && style.featuretypestyles.length > 0) {

          const featureTypeStyle = style.featuretypestyles[0];

          vectorLayer.setStyle(SLDReader.createOlStyleFunction(featureTypeStyle, {
            // Use the convertResolution option to calculate a more accurate resolution.
            convertResolution: viewResolution => {
              const viewCenter = pageData.map.getView().getCenter();
              return getPointResolution(pageData.map.getView().getProjection(), viewResolution, viewCenter);
            },
            // If you use point icons with an ExternalGraphic, you have to use imageLoadCallback to update the vector layer when an image finishes loading.
            imageLoadedCallback: () => {
              vectorLayer.changed();
            },
          }));
        }
      }*/

      function initMap(layersData) {
        pageData.qgisWmsLayers.setLayers(new Collection(loadWmsLayers(layersData)));
        pageData.qgisInvisibleWmsLayers.setLayers(new Collection(pageData.invisibleWmsLayers));

        pageData.baseLayerOrto.setSource(pageData.baseSourceOrto);

        pageData.mapEle = document.getElementById('map');
        pageData.map = new Map({
          target: pageData.mapEle,
          controls: defaultControls().extend([
            new FullScreen(),
            new GeolocationButton({
              delay: 5000
            })
          ]),
          layers: [
            //pageData.baseLayers,
            pageData.baseLayerOrto,
            pageData.baseLayerTopo,
            pageData.baseLayerContext,
            pageData.baseLayerOSM,
            pageData.qgisWmsLayers,
            pageData.qgisInvisibleWmsLayers,
            pageData.qgisWfsLayersRuta,
            pageData.qgisWfsLayersPoi
          ],
          view: new View({
            enableRotation: false,
            center: fromLonLat([pageData.center[0].lng, pageData.center[0].lat]),
            zoom: 10,
            minZoom: 9,
            maxZoom: 20,
            showFullExtent: true,
            extent: [25000, 5100000, 200000, 5280000]
          }),
        });

        //olms(pageData.map, "https://geoserveis.icgc.cat/contextmaps/icgc_mapa_estandard.json");
        //olms(pageData.map, "./myICGCstyle.json");

        //pageData.baseLayers.setLayers(new Collection([pageData.baseLayerOrto,pageData.baseLayerTopo]));
        pageData.map.addControl(new LayerSwitcherImage({
          collapsed: false,
          displayInLayerSwitcher: function(layer) {
            return (layer.get("baseLayer")); 
          }
        }));

        pageData.map.addControl(new ScaleLine());

        // variables for layer switcher
        pageData.map.set("qgisServerURL", pageData.qgisServerURL);
        pageData.map.set("qgisProjectFile", pageData.qgisProjectFile);

        // add vector layers
        pageData.qgisWfsLayersPoi.setLayers(new Collection(pageData.poisLayers));
        pageData.qgisWfsLayersRuta.setLayers(new Collection(pageData.rutasLayers));
        pageData.map.addOverlay(pageData.tooltip);
        pageData.map.addOverlay(pageData.popup);


        /*
         * Interaction
         *****************************************/
        pageData.map.on('click', function(evt) {
          // zoom to rutas
          pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
            pageData.map.getView().fit(feature.getGeometry().getExtent(), {
              easing: easeOut,
              duration: 2000
            });
            return true;
          }, {
            layerFilter: function(layer) {
              return pageData.rutasLayers.includes(layer);
            },
            hitTolerance: 5
          });

          // popup
          if (pageData.map.hasFeatureAtPixel(evt.pixel, {
            layerFilter: function(layer) {
              return pageData.poisLayers.includes(layer);
            },
            hitTolerance: 5
          })) {
            // POIs
            let title = "",
                description = "",
                foto = "",
                autor = "",
                web = "";
            pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
              title = feature.get('nom_' + pageData.lang);
              description = feature.get('descripcio_' + pageData.lang);
              foto = feature.get('imatge_1');
              autor = feature.get('imatge1_autor');
              web = feature.get('web_' + pageData.lang);
              return true;
            }, {
              hitTolerance: 5
            });

            let htmlStr = '<div><h2>' + title + '</h2>';
            htmlStr += description ? '<p>' + description + '</p>' : '';
            htmlStr += foto ? '<img src="fotos/' + foto + '"/>' : '';
            htmlStr += autor ? '<p class="autor">' + i18next.t("dtRuta.autor") + ': ' + autor + '</p>' : '';
            htmlStr += web ? '<p><a target="_blank" href="' + web + '">' + i18next.t("dtRuta.link") + '</a></p>' : '';
            htmlStr += '</div>';
            pageData.popup.show(evt.coordinate, htmlStr);
            pageData.tooltip.hide();
          }
          else if (pageData.map.hasFeatureAtPixel(evt.pixel, {
            layerFilter: function(layer) {
              return pageData.rutasLayers.includes(layer);
            },
            hitTolerance: 5
          })) {
            // rutas
            let title = "",
                description = "",
                foto = "",
                autor = "",
                distancia = "",
                desnivel = "",
                tipologia = "",
                modalidad = "",
                dificultad = "",
                web = "";
            pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
              title = feature.get('georuta_2_' + pageData.lang);
              description = feature.get('descripcio_' + pageData.lang);
              foto = feature.get('imatge_1');
              autor = feature.get('imatge_1_autor');
              distancia = feature.get('distancia_km') + " km";
              desnivel = feature.get('desnivell_m');
              tipologia = feature.get('tipologia_' + pageData.lang);
              modalidad = feature.get('modalitat_' + pageData.lang);
              dificultad = feature.get('dificultat_' + pageData.lang);
              web = feature.get('web_' + pageData.lang);
              return true;
            }, {
              hitTolerance: 5
            });
            let htmlStr = '<div><h2>' + title + '</h2>';
            htmlStr += description ? '<p>' + description + '</p>' : '';
            htmlStr += foto ? '<img src="fotos/' + foto + '"/>' : '';
            htmlStr += autor ? '<p class="autor">' + i18next.t("dtRuta.autor") + ': ' + autor + '</p>' : '';
            htmlStr += distancia ? '<p>' + i18next.t("dtRuta.distancia") + ': ' + distancia + '</br>' : '';
            htmlStr += desnivel ? i18next.t("dtRuta.desnivell") + ': ' + desnivel + '</br>' : '';
            htmlStr += tipologia ? i18next.t("dtRuta.tipologia") + ': ' + tipologia + '</br>' : '';
            htmlStr += modalidad ? i18next.t("dtRuta.modalitat") + ': ' + modalidad + '</br>' : '';
            htmlStr += dificultad ? i18next.t("dtRuta.dificultat") + ': ' + dificultad + '</p>' : '';
            htmlStr += web ? '<p><a target="_blank" href="' + web + '">' + i18next.t("dtRuta.link") + '</a></p>' : '';
            htmlStr += '</div>';
            pageData.popup.show(evt.coordinate, htmlStr);
            pageData.tooltip.hide();
          }
          else
            pageData.popup.hide();
        });

        pageData.map.on('pointermove', function(evt) {
          if (!pageData.popup.isOpened() && !$("#windowTablePois").is(':visible') && !$("#windowTableRutas").is(':visible') && !$("#windowInfo").is(':visible')) {

            // tooltip
            pageData.map.getTargetElement().style.cursor = pageData.map.hasFeatureAtPixel(evt.pixel, {
              layerFilter: function(layer) {
                return pageData.poisLayers.includes(layer) || pageData.rutasLayers.includes(layer);
              },
              hitTolerance: 5
            }) ? 'pointer' : '';

            if (pageData.map.hasFeatureAtPixel(evt.pixel, {
              layerFilter: function(layer) {
                return pageData.poisLayers.includes(layer);
              },
              hitTolerance: 5
            })) {
              // POIs
              let title = "",
                  foto = "";
              pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
                title = feature.get('nom_' + pageData.lang);
                foto = feature.get('imatge_1');
                return true;
              }, {
                layerFilter: function(layer) {
                  return pageData.poisLayers.includes(layer);
                },
                hitTolerance: 5
              });
              pageData.tooltip.show(evt.coordinate, '<div><div class="imgDiv"><img src="fotos/' + foto + '"/></div><h2>' + title + '</h2></div>');
            }
            else if (pageData.map.hasFeatureAtPixel(evt.pixel, {
              layerFilter: function(layer) {
                return pageData.rutasLayers.includes(layer);
              },
              hitTolerance: 5
            })) {
              // rutas
              let title = "",
                  title2 = "",
                  foto = "";
              pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
                title = feature.get('georuta_2_' + pageData.lang);
                foto = feature.get('imatge_1');
                return true;
              }, {
                layerFilter: function(layer) {
                  return pageData.rutasLayers.includes(layer);
                },
                hitTolerance: 5
              });
              pageData.tooltip.show(evt.coordinate, '<div><div class="imgDiv"><img src="fotos/' + foto + '"/></div><h2>' + title + '</h2></div>');
            }
            else
              pageData.tooltip.hide();
          }
        });

        // select interaction working on "mouseover"
        /*let selectMove = new Select({
          condition: pointerMove,
          layers: pageData.poisLayers,
          style: iconHighlightStyleFunction
        });
        pageData.map.addInteraction(selectMove);*/

        $(document).keyup(function(e) {
          if (e.keyCode === 27) { // escape
            pageData.windowTablePois.hide();
            pageData.windowTableRutas.hide();
            pageData.windowInfo.hide();
          }
        });
      }


      /*
       * WFS styles
       *****************************************/
      function iconStyleFunction(feature, resolution) {
        let tipus = feature.get('tipus_cat');
        let icon = tipusPoi[tipus];
        if (tipus === "exposicio_aire_lliure") icon = "exposicio_aire_lliure";
        else if (tipus === "centre_interpretacio") icon = "centre_interpretacio";

        //console.log(feature.get('nom_cat'), tipusPoi[feature.get('tipus_cat')], feature.getGeometry().getCoordinates());
        return [
          new Style({
            image: new Circle({
              fill: new Fill({
                color: "rgba(255,255,0,0.8)"
              }),
              radius: 16
            })
          }),
          new Style({
            image: new Icon({
              //size: [20, 20],
              //src: "icons/" + icon + ".png"
              scale: 0.06,
              src: "simbols/" + icon + ".svg"
            })
          })
        ]
      }

      function iconHighlightStyleFunction(feature, resolution) {
        return new Style({
          image: new Icon({
            size: [20, 20],
            src: "icons/" + tipusPoi[feature.get('tipus_cat')] + ".png"
          })
        });
      }

      function rutaStyleFunction(feature, resolution) {
        if (feature.get('tipologia_cat') === 'Georuta') {
          return new Style({
            stroke: new Stroke({
              color: '#4f1c23',
              lineDash: [4,4],
              width: 3
            })
          });
        }
        else if (feature.get('tipologia_cat') === 'Ruta Geològica') {
          return new Style({
            stroke: new Stroke({
              color: '#b19395',
              lineDash: [4,4],
              width: 3
            })
          });
        }
        else if (feature.get('tipologia_cat') === 'El Cinquè Llac') {
          return new Style({
            stroke: new Stroke({
              color: '#cd3a37',
              lineDash: [6,6],
              width: 3
            })
          });
        }
        else if (feature.get('tipologia_cat') === 'Ruta en bicicleta') {
          return new Style({
            stroke: new Stroke({
              color: '#db1e2a',
              lineDash: [2,6],
              width: 3
            })
          });
        }
        else if (feature.get('tipologia_cat') === 'Ruta a peu') {
          return new Style({
            stroke: new Stroke({
              color: '#11b76c',
              width: 3
            })
          });
        }
      }


      /*
       * Menu
       *****************************************/
      function initMenu() {
        pageData.windowLayers = new Overlay({
          closeBox : true,
          className: "slide-right window layersWindow",
          content: document.getElementById("windowLayers")
        })
        pageData.map.addControl(pageData.windowLayers);

        LayerSwitcherWithLegend.renderPanel(pageData.map, document.getElementById("layerSwitcher"), { reverse: true });

        pageData.windowTablePois = new Overlay({
          closeBox : true,
          className: "slide-right window tableWindow",
          content: document.getElementById("windowTablePois")
        })
        pageData.map.addControl(pageData.windowTablePois);

        pageData.windowTableRutas = new Overlay({
          closeBox : true,
          className: "slide-right window tableWindow",
          content: document.getElementById("windowTableRutas")
        })
        pageData.map.addControl(pageData.windowTableRutas);

        pageData.windowInfo = new Overlay({
          closeBox : true,
          className: "slide-right window infoWindow",
          content: document.getElementById("windowInfo")
        })
        pageData.map.addControl(pageData.windowInfo);

        let menuBar = new Bar({
          className: "ol-top ol-right menuBar"
        });
        pageData.map.addControl(menuBar);

        menuBar.addControl(pageData.layersToggle);

        let actionBar = new Bar({ toggleOne: true, group: true });
        menuBar.addControl(actionBar);

        actionBar.addControl(pageData.tableTogglePois);
        actionBar.addControl(pageData.tableToggleRutas);
        actionBar.addControl(pageData.infoToggle);

        let languageBar = new Bar({ 
          toggleOne: true, 
          group: true,
          className: "langBar"
        });
        menuBar.addControl(languageBar);
        languageBar.addControl(pageData.caToggle);
        languageBar.addControl(pageData.esToggle);

        /*let logoUnescoBtn = new Button({ 
          html: '<img src="logo-unesco.png" />',
          className: "logo logo2",
          title: "UNESCO Global Geoparks",
          handleClick: function() { 
            window.location.href = "https://en.unesco.org/global-geoparks";
          }
        });
        actionBar.addControl(logoUnescoBtn);

        let logoBtn = new Button({ 
          html: '<img src="logo-geoparc.jpg" />',
          className: "logo",
          title: "Geoparc Orígens als Pirineus Catalans",
          handleClick: function() { 
            //pageData.map.getView().setCenter(coordsInit);
            //pageData.map.getView().setZoom(zoomInit);
            window.location.href = "https://www.geoparcorigens.cat/";
          }
        });
        actionBar.addControl(logoBtn);*/
      }

      function hideWindows(activeToggle) {
        pageData.windowTablePois.hide();
        pageData.windowTableRutas.hide();
        pageData.windowInfo.hide();
        
        if (activeToggle !== "tablePois")
          pageData.tableTogglePois.setActive(false);
        else if (activeToggle !== "tableRutas")
          pageData.tableToggleRutas.setActive(false);
        else if (activeToggle !== "info")
          pageData.infoToggle.setActive(false);
      }

      /*
       * Cookies & i18n
       *****************************************/
      function initCookies() {
        /*if (Cookies.get('showinfo') === undefined || Cookies.get('showinfo') === "true") {
          docsToggle.setActive(true);
          windowDocs.show();
        }
        else {
          $('#showinfo').prop('checked', true);
        }

        $('#showinfo').change(function() {
          Cookies.set('showinfo', !this.checked, pageData.cookieOptions);
        });*/

        $.ajax({
          url: './translations.json',
          dataType: 'json',
          success: function(response){
            let lang = getCookies();

            i18next.init({
              lng: lang,
              debug: true,
              resources: response
            }).then(function(t) {

              translateContent();

              i18next.on('languageChanged', () => {
                Cookies.set('lang', i18next.language, pageData.cookieOptions);
                //console.log(i18next.language, Cookies.get('lang'));

                translateContent();
              });
            });
          }
        });
      }

      function getCookies() {
        let lang = 'ca';

        if (Cookies.get('lang') === undefined) {
          /*let userLang = navigator.language || navigator.userLanguage;
          if (userLang === 'ca' || userLang == 'es') {
            lang = userLang;
          }*/
          Cookies.set('lang', lang, pageData.cookieOptions);
        }
        else {
          lang = Cookies.get('lang');
        }

        //let userLang = navigator.language || navigator.userLanguage;
        //console.log("The language is: " + lang + " (Browser language:" + userLang + ")");

        if (lang === "ca")
          pageData.caToggle.setActive(true);
        else if (lang === "es")
          pageData.esToggle.setActive(true);
        else if (lang === "fr")
          pageData.frToggle.setActive(true);
        else
          pageData.enToggle.setActive(true);

        return lang;
      }

      function translateContent() {
        // load qgis content
        if (i18next.language === "ca")
          pageData.lang = "cat";
        else
          pageData.lang = i18next.language;
        initDtPois();
        initDtRutes();

        pageData.popup.hide();

        // menu
        pageData.tableTogglePois.setTitle(i18next.t('gui.windowTablePoisTitle'));
        pageData.tableToggleRutas.setTitle(i18next.t('gui.windowTableRutasTitle'));
        pageData.infoToggle.setTitle(i18next.t('gui.windowInfoTitle'));

        // windows
        $("#windowTablePois .title").text(i18next.t('gui.windowTablePoisTitle'));
        $("#windowTableRutas .title").text(i18next.t('gui.windowTableRutasTitle'));
        $("#windowInfo .title").text(i18next.t('gui.windowInfoTitle'));

        // layerswitcher
        pageData.qgisWfsLayersPoi.set("title", i18next.t('switcher.wfsGroupPoi'));
        pageData.qgisWfsLayersRuta.set("title", i18next.t('switcher.wfsGroupRuta'));
        pageData.qgisWmsLayers.set("title", i18next.t('switcher.wmsGroup'));
        //pageData.baseLayers.set("title", i18next.t('switcher.baseGroup'));
        //pageData.baseLayerTopo.set("title", i18next.t('switcher.baseGroupTopo'));        
        //pageData.baseLayerOrto.set("title", i18next.t('switcher.baseGroupOrto'));
        //$("#layerSwitcher .base-group ul li.layer li:span:nth-of-type(1) label").text(i18next.t('switcher.baseGroupTopo'));
        //$("#layerSwitcher .base-group ul li.layer li:span:nth-of-type(2) label").text(i18next.t('switcher.baseGroupOrto'));
        LayerSwitcherWithLegend.renderPanel(pageData.map, document.getElementById("layerSwitcher"), { reverse: true });
      }

      /*
       * Datatables
       *****************************************/
      function initDtPois() {
        $('#datatable-pois').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="pois-table"></table>');
        let datatable = $('#pois-table').DataTable({
          info: false,
          responsible: true,
          search: true,
          ajax: { 
            url :"https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.json?MAP=" + pageData.qgisProjectFile + "&limit=1000", type : "GET",
            dataSrc: 'features'
          },
          columns: [
            { "data": "properties.nom_" + pageData.lang, "title" : i18next.t("dtPoi.nom"), "render": function ( data, type, row ) { return "<span class='link' data-coords='[" + row.geometry.coordinates + "]'>" + data + "</span>"; }},
            { "data": "properties.descripcio_" + pageData.lang, "title" : i18next.t("dtPoi.descripcio")},
            { "data": "properties.imatge_1", "title" : i18next.t("dtPoi.imatge"), "render": function ( data, type, row ) { return data!=="" ? "<img class='link' style='max-width:300px;' src='fotos/" + data + "' data-coords='[" + row.geometry.coordinates + "]'/>" : ""; }},
            { "data": "properties.nom_ruta_" + pageData.lang, "title" : i18next.t("dtPoi.georuta")},
            { "data": "properties.tematica_1_" + pageData.lang, "title" : i18next.t("dtPoi.temática")},
            { "data": "properties.tipus_" + pageData.lang, "title" : i18next.t("dtPoi.tipus")},
            { "data": "properties.web_" + pageData.lang, "title" : i18next.t("dtPoi.web"), "render": function ( data, type, row ) { return data!=="" ? "<a target='_blank' href='" + data + "' title='" + data + "'><i class='fa fa-external-link' aria-hidden='true'></i></a>" : ""; }},
          ],
        }).on( 'init.dt', function () {
          $("#datatable-pois").on("click", ".link", function() {
            $(".tableWindow").hide();
            //console.log($(this).data("coords"));
            pageData.map.getView().animate({zoom: 15, center: fromLonLat($(this).data("coords")), duration: 2000});
          });
        });
      }

      function initDtRutes() {
        $('#datatable-rutas').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="rutas-table"></table>');
        let datatable = $('#rutas-table').DataTable({
          info: false,
          responsible: true,
          search: true,
          ajax: { 
            url :"https://mapa.psig.es/qgisserver/wfs3/collections/Rutes recomanades/items.json?MAP=" + pageData.qgisProjectFile + "&limit=1000", type : "GET",
            dataSrc: 'features'
          },
          columns: [
            { "data": "properties.georuta_" + pageData.lang, "title" : i18next.t("dtRuta.nom"), "render": function ( data, type, row ) { return "<span class='link' data-coords='" + JSON.stringify(row.bbox) + "'>" + data + "</span>"; }},
            { "data": "properties.descripcio_" + pageData.lang, "title" : i18next.t("dtRuta.descripcio")},
            { "data": "properties.imatge_1", "title" : i18next.t("dtRuta.imatge"), "render": function ( data, type, row ) { return data!=="" ? "<img class='link' style='max-width:300px;' src='fotos/" + data + "' data-coords='" + JSON.stringify(row.bbox) + "'/>" : ""; }},
            { "data": "properties.desnivell_m", "title" : i18next.t("dtRuta.desnivell")},
            { "data": "properties.dificultat_" + pageData.lang, "title" : i18next.t("dtRuta.dificultat")},
            { "data": "properties.distancia_km", "title" : i18next.t("dtRuta.distancia"), "render": function ( data, type, row ) { return parseFloat(data).toLocaleString('es-ES', { decimal: ',', useGrouping: false, minimumFractionDigits: 2, maximumFractionDigits: 2 }); }},
            { "data": "properties.tipologia_" + pageData.lang, "title" : i18next.t("dtRuta.tipologia")},
            { "data": "properties.modalitat_" + pageData.lang, "title" : i18next.t("dtRuta.modalitat")},
            { "data": "properties.web_" + pageData.lang, "title" : i18next.t("dtRuta.web"), "render": function ( data, type, row ) { return data!=="" ? "<a target='_blank' href='" + data + "' title='" + data + "'><i class='fa fa-external-link' aria-hidden='true'></i></a>" : ""; }},
          ],
        }).on( 'init.dt', function () {
          $("#datatable-rutas").on("click", ".link", function() {
            $(".tableWindow").hide();
            //console.log($(this).data("coords"));
            pageData.map.getView().fit(transformExtent($(this).data("coords"), "EPSG:4326", "EPSG:3857"), {
              padding: [50, 250, 50, 50],
              easing: easeOut,
              duration: 2000
            });
          });
        });
      }

      /*
       * Init
       *****************************************/
      function initGui() {
        initCookies();
        initMenu();
        pageData.windowLayers.show();
      }

      onMounted(()=>{

        // load layers configuration file
        $.getJSON( "js/data/geoparc-turisme.qgs.json", function() {})
        .done(function(data) {
          initMap(data);
          initGui();
          initDtPois();
          initDtRutes();

          if (window.mobilecheck()) {
            setTimeout(function() {
              pageData.layersToggle.toggle();
              pageData.windowLayers.hide();
              $(".layersToggle i.fa").removeClass("fa-arrow-circle-right");
              $(".layersToggle i.fa").addClass("fa-arrow-circle-left");
            }, 3000);
          }
        })
        .fail(function() {
          console.log( "error loading JSON file" );
        });
      })

      onBeforeUnmount(()=>{
        //clearMap();
      })

      function clearMap() {
        document.getElementById('map').innerHTML = '';
        pageData.mapEle = null;
        pageData.map = null;
      }

      return {
        ...toRefs(pageData)
      }
    }
  }

window.mobilecheck = function() {
  var check = false;
  (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
  return check;
};
</script>