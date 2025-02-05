<template>
  <div id="map" class="map"></div>
  <div class="loading"><p></p><span></span></div>

  <div id="windowLayers" class="window">
    <div class="content">
      <div id="layerSwitcher" class="layer-switcher"></div>
    </div>
    <div class="logos">
      <a class="logo1" title="Geoparc Orígens als Pirineus Catalans" href="https://www.geoparcorigens.cat/"><img src="/logo-geoparc.jpg"></a>
      <a class="logo2" title="UNESCO Global Geoparks" href="https://en.unesco.org/global-geoparks"><img src="/logo-unesco.png"></a>
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

  <!-- <div id="windowTableRutas" class="window">
    <h2>
      <i class="fa fa-map-o"></i>
      <span class="title">Rutes recomanades</span>
    </h2>
    <div class="content">
      <div id="datatable-rutas"></div>
    </div>
  </div> -->

  <div id="windowInfo" class="window">
    <h2>
      <i class="fa fa-info-circle"></i>
      <span class="title">Informació</span>
    </h2>
    <div class="content">
      <p><span class="infoLine1">El Geoparc Orígens és un territori espectacular reconegut per la UNESCO des de l'any 2018.</span><br><span class="infoLine2">Hi pots fer un autèntic viatge en el temps per descobrir els orígens i l'evolució de la Terra i de la vida.</span><br><span class="infoLine3">S'hi pot gaudir d'experiències diverses i impressionants com seguir el rastre dels últims dinosaures que van viure a Europa o recórrer espectaculars congostos com el de Mont-rebei o el de Collegats.</span></p>
      <p><span class="infoLine4">En aquest visor trobaràs els destacats del Geoparc Orígens.</span></p>
      <p><a class="logo1" title="Geoparc Orígens als Pirineus Catalans" href="https://www.geoparcorigens.cat/"><img src="/logo-geoparc.jpg"></a> 
      <a class="logo2 logox" title="UNESCO Global Geoparks" href="https://en.unesco.org/global-geoparks"><img src="/logo-unesco.png"></a> 
      <a class="logox" href="https://www.visitgeoparks.org/" target="_blank"><img decoding="async" loading="lazy" src="/Spanish GGN esp.png" alt="" height="70"></a> 
      <a class="logox" href="https://www.europeangeoparks.org/" target="_blank"><img decoding="async" loading="lazy" src="/EGN.png" alt="" height="80"></a></p>
      <h3 class="infoContact">Contacte</h3>
      <p>Orígens UNESCO Global Geopark<br>
      Carrer de Soldevila, 3<br>
      25620 Tremp (Lleida)<br>
      info@geoparcorigens.cat</p>
      <h3 class="infoSuport">Amb el suport de</h3>
      <img decoding="async" loading="lazy" src="https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-300x56.jpg" alt="" srcset="https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-300x56.jpg 300w, https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-1024x192.jpg 1024w, https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-768x144.jpg 768w, https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1-150x28.jpg 150w, https://www.geoparcorigens.cat/wp-content/uploads/2020/01/gencat1.jpg 1400w" height="42">
      <img decoding="async" loading="lazy" src="https://www.geoparcorigens.cat/wp-content/uploads/2015/05/diputacio-300x78.gif" alt="" srcset="https://www.geoparcorigens.cat/wp-content/uploads/2015/05/diputacio-300x78.gif 300w, https://www.geoparcorigens.cat/wp-content/uploads/2015/05/diputacio-150x39.gif 150w, https://www.geoparcorigens.cat/wp-content/uploads/2015/05/diputacio.gif 574w" width="300" height="78">
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
  import { Cluster, XYZ as xyzSource, Vector as VectorSource, TileWMS, VectorTile as VectorTileSource } from 'ol/source';
  import { Group as LayerGroup, Tile as TileLayer, Vector as VectorLayer, VectorTile } from 'ol/layer';
  import { ScaleLine, FullScreen, defaults as defaultControls, Control, Rotate } from 'ol/control';
  import { Point, Polygon, LineString, Geometry } from 'ol/geom';
  import { Style, Icon, Text, Circle, Fill, Stroke } from 'ol/style';
  import { createEmpty, extend, getHeight, getWidth } from 'ol/extent';
  import { get as getProjection, getPointResolution, fromLonLat, toLonLat, transformExtent, METERS_PER_UNIT } from 'ol/proj';
  import { getLength, getArea } from 'ol/sphere';
  import { unByKey } from 'ol/Observable';
  import { easeOut } from 'ol/easing';
  import { GeoJSON, MVT } from 'ol/format';
  import { Select, defaults as defaultInteractions } from 'ol/interaction';
  import { pointerMove } from 'ol/events/condition';
  import Link from 'ol/interaction/Link.js';

  import Bar from 'ol-ext/control/Bar';
  import Button from 'ol-ext/control/Button';
  import Toggle from 'ol-ext/control/Toggle';
  import Overlay from 'ol-ext/control/Overlay';
  import LayerSwitcherImage from 'ol-ext/control/LayerSwitcherImage';
  import { ol_coordinate_offsetCoords } from 'ol-ext/geom/GeomUtils';
  import GeolocationDraw from 'ol-ext/interaction/GeolocationDraw';
  import GeolocationButton from 'ol-ext/control/GeolocationButton';

  //import MapLibreLayer from '@geoblocks/ol-maplibre-layer';
  import LayerSwitcher from 'ol-layerswitcher';
  import Popup from 'ol-popup';
  //import SLDReader from '@nieuwlandgeo/sldreader';
  import $ from 'jquery';
  import Cookies from 'js-cookie';
  import i18next from 'i18next';
  import DataTable from 'datatables.net';
  import html2pdf from 'html2pdf.js';

  const tipusPoi = {
    "Epicentre": "epicentre",
    "Informació turística": "informacio_turistica",
    "Geologia": "geologia",
    "Dinosaures": "dinosaures",
    "Mirador": "mirador",
    "Arbre monumental": "arbre_monumental",
    "Jaciment arqueològic": "jaciment_arqueologic",
    "Església": "esglesia",
    "Castell": "castell",
    "Llegenda": "llegenda",
    "Exposició a l'aire lliure": "exposicio_aire_lliure",
    "Patrimoni industrial": "patrimoni_Industrial",
    "Establiment recomanat": "establiment_recomanat",
    "Àrea de lleure": "area_lleure",
    "Caiac": "caiac",
    "Parapent": "parapent",
    "Rafting": "rafting",
    "Telefèric": "telefèric",
    "Via Ferrata": "via_ferrata",
    "Vol en Globus": "vol_en_globus",
    "Zona de bany": "zona_de_bany"
  };
  const tipologiasRuta = {
    "Tren dels Llacs": "tren_dels_llacs",
    "Altres rutes": "altres_rutes",
    "El Cinquè Llac": "el_cinque_llac",
    "Georuta": "Georuta"
  };
  const nonClusterIds = [119, 5, 38, 43, 49, 59, 68, 87, 98, 105, 110, 118, 127, 144];

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
   * Location control
   *****************************************/
  class GeolocationControl extends Control {

    /**
     * @param {Object} [opt_options] Control options.
     */
    constructor(opt_options) {
      const options = opt_options || {};

      const button = document.createElement('button');
      button.className = 'ol-geolocation-false';
      button.id = 'ol-geoBtn';
      button.innerHTML = '<i class="fa fa-map-marker" aria-hidden="true"></i>';

      const element = document.createElement('div');
      element.className = 'ol-geolocation ol-unselectable ol-control';
      element.appendChild(button);

      super({
        element: element,
        target: options.target,
      });

      this.button = button;
      this.geoDraw = options.geoDraw;
      this.map = options.map;

      button.addEventListener('click', this.handleGeolocation.bind(this), false);
    }

    handleGeolocation() {
      let locate = this.button.classList.contains("ol-geolocation-false");
      //console.log("locate", locate);
      this.button.classList.toggle("ol-geolocation-false");

      if (locate) {
        this.geoDraw.start();
      }
      else {
        this.geoDraw.stop();
      }
    }
  }

  /*
   * LayerControl extended with legends
   *****************************************/
  class LayerControl extends Control {
    /**
     * @param {Object} [opt_options] Control options.
     */
    constructor(opt_options) {
      const options = opt_options || {};

      const button = document.createElement('button');
      button.innerHTML = '<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH5AUMDDgneLgzCAAAAZpJREFUOMvVkz1r21AUhg+UkmjIL0i89wdkMoL7P2xkkWzNWNzNJqPdgD8oZOhu8AfEYLvOoiVguLYRBIFyh2jRavCFK9mC+CLI26FLCG6cJlDosx0O54FzeA/Rv8IwjH3DMPbfJTFNM+u6LlzXhWma2TdJBoPBVyklADwCeJRSYjwef/kbx5HneddpmuI5aZrC87xrIjp60VCtVo9931fYge/7qlKpHG+V2LZ9ulqt8FriOIZt26dbZb1e70prvVOitUa/32+/uF6z2TyXUsZ/kiyXy7jRaJw/n/vwtCgWiz8Wi8Xler3+vtlsPmcymY9P+5zzh8lk8kkIcccY+8Y5/7ntRidKKSilVKlUOiMimk6nN3EcI4oicM5viIjK5fKZ+g0KhcLJ1rXq9boZhmGktUa73b4iIhqNRtZwOLSIiFqt1kBrjTAMo1qtZu7K0eF8Pr8FAMdx7i3L2rMsa89xnHsAmM1mt0R0+OpUdrvdiyRJEARBGgRBmiQJOp3OxZveJJ/PZ4UQEEIgl8tl3/W4jLEDxtgB/Xf8Asr2eTvgMHELAAAAAElFTkSuQmCC"/>';

      const element = document.createElement('div');
      element.className = 'layer-control ol-unselectable ol-control open';
      element.appendChild(button);

      super({
        element: element,
        target: options.target,
      });

      button.addEventListener('click', this.handleLayerControl.bind(this), false);
    }

    handleLayerControl() {
      $(".layersWindow").toggleClass("open");
      $(".layer-control").toggleClass("open");
      $(".menuBar").toggleClass("open");
    }
  }

  /*
   * LayerSwitcher extended with legends
   *****************************************/
  class LayerSwitcherWithLegend extends LayerSwitcher {
    static renderPanel(map, poisLayer, nonClusterLayer, paradesLayer, panel, options) {
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
      LayerSwitcherWithLegend.renderLayers_(map, map, poisLayer, nonClusterLayer, paradesLayer, ul, options, function render(_changedLyr) {
        LayerSwitcherWithLegend.renderPanel(map, poisLayer, nonClusterLayer, paradesLayer, panel, options);
      });
      // Create the event.
      const rendercomplete_event = new Event('rendercomplete');
      // Dispatch the event.
      panel.dispatchEvent(rendercomplete_event);
    }

    static renderLayers_(map, lyr, poisLayer, nonClusterLayer, paradesLayer, elm, options, render) {
      let lyrs = lyr.getLayers().getArray().slice();
      if (options.reverse)
        lyrs = lyrs.reverse();
      for (let i = 0, l; i < lyrs.length; i++) {
        l = lyrs[i];
        if (l.get('title')) {
            elm.appendChild(LayerSwitcherWithLegend.renderLayer_(map, poisLayer, nonClusterLayer, paradesLayer, l, i, options, render));
        }
      }
    }

    static renderLayer_(map, poisLayer, nonClusterLayer, paradesLayer, lyr, idx, options, render) {
      const li = document.createElement('li'),
            lyrTitle = lyr.get('title'),
            checkboxId = LayerSwitcher.uuid(),
            label = document.createElement('label');

      if (lyr instanceof LayerGroup && !lyr.get('combine')) {
        // group
        li.classList.add('group');
        li.classList.add(makeSafeForCSS(lyrTitle));
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
            if (lyrTitle !== "Punts de interès" || lyrTitle !== "Puntos de interés") {
              const target = e.target;
              LayerSwitcher.setVisible_(map, lyr, target.checked, options.groupSelectStyle);
              render(lyr);
              LayerSwitcherWithLegend.addPois(map, poisLayer, nonClusterLayer);
            }
          };
          li.appendChild(input);
          label.htmlFor = checkboxId;
          if (!input.checked) {
            fa += '-slash';
            li.classList.add('off');
          }
        }
        label.innerHTML =  fa + '"></i> ' + lyrTitle;
        li.appendChild(label);
        const ul = document.createElement('ul');
        li.appendChild(ul);
        LayerSwitcherWithLegend.renderLayers_(map, lyr, poisLayer, nonClusterLayer, paradesLayer, ul, options, render);
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
          LayerSwitcherWithLegend.addPois(map, poisLayer, nonClusterLayer);
          if (lyrTitle === "Tren dels Llacs")
            paradesLayer.setVisible(target.checked);
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

    static addPois(map, poisLayer, nonClusterLayer) {
      // add pois to layerswitcher
      let html = "",
          i = 0,
          layer = "principalLayer";
      for (let tipo in tipusPoi) {
        html += "<li class='" + layer + " poiLayer " + makeSafeForCSS(tipusPoi[tipo]) + "'><img class='leyenda' src='simbols/" + tipusPoi[tipo] + ".svg'/> " + i18next.t("tipusPoi."+tipusPoi[tipo]) +"</li>";
        if (i === 1) {
          html += "</ul>";
          $("#layerSwitcher li.group ul").first().append(html);
          html = '<li class="group ' + makeSafeForCSS("Cultura") + ' layer-switcher-fold layer-switcher-close"><button></button><label><i class="fa fa-eye"></i> ' + i18next.t("switcher.wfsGroupPatrimoni") + '</label><ul>';
          layer = "culturaLayer";
        }
        else if (i === 11) {
          html += "</ul></li>";
          $("#layerSwitcher li.group." + makeSafeForCSS(i18next.t("switcher.wfsGroupRuta"))).before(html);
          html = '<li class="group ' + makeSafeForCSS("Activitats") + ' layer-switcher-fold layer-switcher-close"><button></button><label><i class="fa fa-eye"></i> Activitats</label><ul>';
          layer = "activitatsLayer";
        }
        i++;
      }
      html += "</ul></li>";
      $("#layerSwitcher li.group." + makeSafeForCSS(i18next.t("switcher.wfsGroupRuta"))).before(html);

      // hide group rutes recomendades and cabezera punts de interes
      $("#layerSwitcher li.group." + makeSafeForCSS(i18next.t("switcher.wfsGroupRuta"))).hide();
      $("#layerSwitcher li.group._punts-de-inter__00e8s > label").hide();
      $("#layerSwitcher li.group._punts-de-inter__00e8s > button").hide();
      $("#layerSwitcher li.group._punts-de-inter__00e8s > input").hide();

      // turn off Cultura i Activitats
      //groupToggle($("#layerSwitcher li.group."+makeSafeForCSS("Cultura")+" label"), "culturaLayer");
      //groupToggle($("#layerSwitcher li.group."+makeSafeForCSS("Activitats")+" label"), "activitatsLayer");

      // copy fold event
      $('#layerSwitcher li.group.' + makeSafeForCSS("Cultura") + ' button').click(function() {
        $(this).parent().toggleClass("layer-switcher-close").toggleClass("layer-switcher-open");
      });
      $('#layerSwitcher li.group.' + makeSafeForCSS("Activitats") + ' button').click(function() {
        $(this).parent().toggleClass("layer-switcher-close").toggleClass("layer-switcher-open");
      });

      // interaction
      $("#layerSwitcher li.poiLayer").click(function() {
        // toggle selected initiative icons
        $(this).toggleClass("off");

        //if ($(this).hasClass("epicentre"))
          //nonClusterLayer.setVisible(!nonClusterLayer.getVisible());
        //else
          poisLayer.getSource().changed();

        // close spiderfier
        let view = map.getView();
        if (view.getResolution() <= view.getMinResolution())
          view.setZoom(view.getZoom()-0.01);
      });

      $("#layerSwitcher li.layer").click(function() {
        // toggle selected initiative icons
        $(this).toggleClass("off");
      });

      $("#layerSwitcher li.group."+makeSafeForCSS("Punts de interès")+" label").unbind("click");
      $("#layerSwitcher li.group."+makeSafeForCSS("Punts de interès")+" label").click(function() {
        groupToggle($(this), "principalLayer");
        //nonClusterLayer.setVisible(!$(this).hasClass("off"));
      });
      $("#layerSwitcher li.group."+makeSafeForCSS("Cultura")+" label").unbind("click");
      $("#layerSwitcher li.group."+makeSafeForCSS("Cultura")+" label").click(function() {
        groupToggle($(this), "culturaLayer");
      });
      $("#layerSwitcher li.group."+makeSafeForCSS("Activitats")+" label").unbind("click");
      $("#layerSwitcher li.group."+makeSafeForCSS("Activitats")+" label").click(function() {
        groupToggle($(this), "activitatsLayer");
      });

      function groupToggle(ele, layer) {
        ele.toggleClass("off");
        ele.children().eq(0).toggleClass("fa-eye");
        ele.children().eq(0).toggleClass("fa-eye-slash");
        if (ele.hasClass("off")) {
          $("#layerSwitcher li."+layer).addClass("off");
        }
        else {
          $("#layerSwitcher li."+layer).removeClass("off");
        }
        poisLayer.getSource().changed();

        // close spiderfier
        let view = map.getView();
        if (view.getResolution() <= view.getMinResolution())
          view.setZoom(view.getZoom()-0.01);
      }
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
        extent: [25000, 5100000, 200000, 5280000],
        map: null,
        mapEle: null,

        qgisServerURL: 'https://mapa.psig.es/qgisserver/cgi-bin/qgis_mapserv.fcgi',
        mapproxyServerURL: 'https://mapa.psig.es/mapproxy/service?',
        qgisProjectFile: '/home/geoparc/geoparc-turisme/geoparc-turisme.qgs',

        qgisWmsLayers: new LayerGroup({
          title: 'Capes temàtiques',
          fold: 'close'
        }),
        paradesLayer: null,
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
        
        vectorSource: null,
        clusterSource: null,
        clusterCircles: null,
        clickFeature: null,
        clickResolution: null,

        nonClusterLayer: null,
        nonClusterLayers: [],
        poisLayer: null,
        poisLayers: [],
        rutasLayers: [],

        mousePosition: null,
        rasterLayer: null,

        baseLayerOrto: new TileLayer({
          title: 'Ortofoto (ICGC)',
          baseLayer: true,
          visible: false,
          source: new xyzSource({
            maxZoom: 19,
            url: "https://geoserveis.icgc.cat/servei/catalunya/contextmaps/wmts/contextmaps-orto-estandard/MON3857NW/{z}/{x}/{y}.png",
            attributions: ["Institut Cartogràfic i Geològic de Catalunya CC-BY-SA-3"]
          })
        }),

        baseLayerContext: new TileLayer({
          title: 'Topogràfic (ICGC)',
          baseLayer: true,
          //visible: false,
          source: new xyzSource({
            maxZoom: 19,
            url: "https://geoserveis.icgc.cat/servei/catalunya/contextmaps/wmts/contextmaps-mapa-estandard/MON3857NW/{z}/{x}/{y}.png",
            attributions: ["Institut Cartogràfic i Geològic de Catalunya CC-BY-SA-3"]
          })
        }),

        /*baseLayerVector: new MapLibreLayer({
          title: 'Topogràfic (ICGC)',
          baseLayer: true,
          maplibreOptions: {
            //style: "https://geoserveis.icgc.cat/contextmaps/icgc_mapa_estandard.json",
            style: "https://betaserver2.icgc.cat/contextmaps-server/api/style/e2cc670b-1077-4e32-95ed-95a9307f9f0b"
          },
          preview: "https://geoserveis.icgc.cat/servei/catalunya/contextmaps/wmts/contextmaps-mapa-estandard/MON3857NW/10/512/349.png"
        }),*/

        /*baseLayers: new LayerGroup({
          title: 'Capes de referència',
          fold: 'close'
        }),*/

        windowLayers: null,
        windowTablePois: null,
        //windowTableRutas: null,
        windowInfo: null,

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
        /*tableToggleRutas: new Toggle({ 
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
        }),*/
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
        surveyButton: new Button({ 
          html: '<i class="fa fa-smile-o fa-lg"></i>',
          title: 'Enqueste',
          className: "survey",
          handleClick: function() {
            window.location.href = "https://docs.google.com/forms/d/e/1FAIpQLScA9OU8TstqnA4a9pLUEgUCn2jI31r90h6d5O0gp_CQeYldBA/viewform?usp=header";
          }
        }),
        caToggle: new Toggle({ 
          html: 'CA',
          className: "lang",
          title: "Català",
          active: true,
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
        enToggle: new Toggle({ 
          html: 'EN',
          className: "lang en",
          title: "English",
          onToggle: function() {
            i18next.changeLanguage('en');
          }
        }),
        frToggle: new Toggle({ 
          html: 'FR',
          className: "lang fr",
          title: "Français",
          onToggle: function() {
            i18next.changeLanguage('fr');
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

        // LineString to store the different geolocation positions. This LineString is time aware.
        // The Z dimension is actually used to store the rotation (heading).
        geoPositions: new LineString([], 'XYZM'),
        deltaMean: 500,     // the geolocation sampling period mean in ms
        geolocation: null,
        geoMarker: null,
        geoMarkerEl: null,

        geoDraw: null,
      });

      /*
       * Load QGIS Server/Mapproxy layers
       *****************************************/
      function loadWmsLayers(layersData) {
        let layers = [];

        layersData.slice().reverse().forEach(function(layer, i) {

          if (layer.vectorial) {
            if (layer.name === "origens_turisme") {
              /*for (const tipo in tipusPoi) {
                loadWfsLayerPoi(tipo);
              }*/
              loadWfsLayer(layer);
            }
            else if (layer.name === i18next.t("switcher.wfsGroupRuta")) {
              for (const tipo in tipologiasRuta) {
                loadWfsLayerRuta(tipo);
              }
            }
          }
          else if (layer.hidden) {
            let thisLayer = defineQgisLayer(layer);
            if (layer.name === "@Parades ferrocarril") {
              pageData.paradesLayer = thisLayer;
            }
            pageData.invisibleWmsLayers.push(thisLayer);
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
              //crossOrigin: 'Anonymous'
            })
          });

        if (!layer.name.startsWith("@"))
          newLayer.set("title", layer.name);

        return(newLayer);
      }

      function loadWfsLayer(layer) {
        // cargar puntos de interés para cluster
        pageData.vectorSource = new VectorSource({
          format: new GeoJSON(),
          url: 'https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.geojson?MAP=' + pageData.qgisProjectFile + '&limit=1000&visible=true'
        });
        // quitar epicentre and other POIs del cluster
        pageData.vectorSource.on("featuresloadend", function() {
          pageData.vectorSource.forEachFeature(function (feature) {
            if (nonClusterIds.includes(feature.get("id"))) {
              pageData.vectorSource.removeFeature(feature);
            }
          });
        });

        pageData.clusterSource = new Cluster({
          distance: 40,
          minDistance: 0,
          source: pageData.vectorSource
        });

        // Layer displaying the expanded view of overlapping cluster members.
        pageData.clusterCircles = new VectorLayer({
          source: pageData.clusterSource,
          style: new Style({})
        });

        pageData.poisLayer = new VectorLayer({
          title: "Punts de interès",
          vectorial: true,
          type: "layer",
          source: pageData.clusterSource,
          style: clusterStyle
        });
        pageData.poisLayers.push(pageData.poisLayer);

        // epicentre and other non cluster POIs
        let nonClusterSource = new VectorSource({
          format: new GeoJSON(),
          url: 'https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.geojson?MAP=' + pageData.qgisProjectFile + '&limit=1000&visible=true'
        });
        // quitar epicentre and other POIs del cluster
        nonClusterSource.on("featuresloadend", function() {
          nonClusterSource.forEachFeature(function (feature) {
            if (!nonClusterIds.includes(feature.get("id"))) {
              nonClusterSource.removeFeature(feature);
            }
          });
        });
        pageData.nonClusterLayer = new VectorLayer({
          type: "layer",
          source: nonClusterSource,
          style: iconStyleFunction
        });
        pageData.nonClusterLayers.push(pageData.nonClusterLayer);
      }

      /*function loadWfsLayerPoi(tipologia) {
        let tipo = tipologia;
        if (tipologia === "Exposició a l'aire lliure") tipo = tipusPoi["Exposició a l'aire lliure"];
        else if (tipologia === "Centre d'Interpretació") tipo = tipusPoi["Centre d'Interpretació"];

        let vectorLayer = new VectorLayer({
          title: tipologia,
          vectorial: true,
          type: "layer",
          source: new VectorSource({
            format: new GeoJSON(),
            url: 'https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.geojson?MAP=' + pageData.qgisProjectFile + '&limit=1000&visible=true&tipus_' + pageData.lang + '=' + tipo
          }),
          style: iconStyleFunction
        });
        pageData.poisLayers.push(vectorLayer);
      
        //fetch("js/data/origens_turisme.sld")
        //  .then(response => response.text())
        //  .then(sld => applyVectorStyle(vectorLayer, sld));
      }*/

      function loadWfsLayerRuta(tipologia) {
        let vectorLayer = new VectorLayer({
          //title: i18next.t("tipusRuta."+tipologiasRuta[tipologia]),
          title: tipologia,
          vectorial: true,
          type: "layer",
          source: new VectorSource({
            format: new GeoJSON(),
            url: 'https://mapa.psig.es/qgisserver/wfs3/collections/Rutes recomanades/items.geojson?MAP=' + pageData.qgisProjectFile + '&limit=1000&visible=true&tipologia_' + pageData.lang + '=' + tipologia
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

        pageData.mapEle = document.getElementById('map');
        pageData.map = new Map({
          target: pageData.mapEle,
          controls: defaultControls().extend([
            new FullScreen()
          ]),
          interactions: defaultInteractions({
            dragRotate: false, 
            pinchRotate: false
          }), 
          layers: [
            //pageData.baseLayers,
            pageData.baseLayerOrto,
            pageData.baseLayerContext,
            //pageData.baseLayerVector,
            pageData.qgisWmsLayers,
            pageData.qgisInvisibleWmsLayers,
            pageData.qgisWfsLayersRuta,
            pageData.qgisWfsLayersPoi,
            pageData.clusterCircles,
            pageData.nonClusterLayer
          ],
          view: new View({
            enableRotation: false,
            center: fromLonLat([pageData.center[0].lng, pageData.center[0].lat]),
            zoom: 10,
            minZoom: 9,
            maxZoom: 19,
            showFullExtent: true,
            //extent: pageData.extent
          })
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

        pageData.map.addControl(new LayerControl());

        // variables for layer switcher
        pageData.map.set("qgisServerURL", pageData.qgisServerURL);
        pageData.map.set("qgisProjectFile", pageData.qgisProjectFile);

        // add vector layers
        pageData.qgisWfsLayersPoi.setLayers(new Collection(pageData.poisLayers));
        pageData.qgisWfsLayersRuta.setLayers(new Collection(pageData.rutasLayers));
        pageData.map.addOverlay(pageData.tooltip);
        pageData.map.addOverlay(pageData.popup);

        // Draw vector layer
        let vectorDraw = new VectorLayer({
          source: new VectorSource()
        });
        pageData.map.addLayer(vectorDraw);

        // Draw interaction
        pageData.geoDraw = new GeolocationDraw({
          source: vectorDraw.getSource(),
          zoom: 15,
          followTrack: 'auto',
          type: 'Point',
          /*attributes: {
            accuracy: false,
            accuracyGeometry: false,
            heading: true,
            speed: true
          },*/
        });
        pageData.map.addInteraction(pageData.geoDraw);

        pageData.geoDraw.on("drawend", function(e) {
          console.log("stop");
        });

        pageData.map.addControl(new GeolocationControl({
          geoDraw: pageData.geoDraw,
          map: pageData.map
        }));

        let geoBtn = new GeolocationButton({
          title: "Geolocate"
        });
        pageData.map.addControl(geoBtn);

        // check of initial interactions
        const link = new Link();
        const openPopup = link.track('open'),
              popupNum = parseInt(link.track('num')),
              popupPoi = link.track('poi'),
              popupId = link.track('id');
        pageData.map.addInteraction(link);

        if (openPopup === "georuta") {
          if (popupNum === 6)
            showPopupRutaInteractive(popupPoi);
          else
            showPopupRutaById(popupId);
        }
        else if (openPopup === "poi") {
          // for now only for testing
          showPopupPoiById(popupId);
        }

        /*
         * Tooltip
         *****************************************/
        let hoverFeature;
        pageData.map.on("pointermove", (event) => {
          if (!pageData.popup.isOpened() && !$("#windowTablePois").is(':visible') && !$("#windowInfo").is(':visible')) {
            //&& !$("#windowTableRutas").is(':visible') 

            // Change the cursor style to indicate that the cluster is clickable.
            pageData.map.getTargetElement().style.cursor = pageData.map.hasFeatureAtPixel(event.pixel, {
              layerFilter: function(layer) {
                return pageData.poisLayer === layer || pageData.nonClusterLayers.includes(layer) || pageData.clusterCircles === layer || pageData.rutasLayers.includes(layer);
              },
              hitTolerance: 5
            }) ? 'pointer' : '';

            // epicentre and other non cluster POIs
            if (pageData.map.hasFeatureAtPixel(event.pixel, {
              layerFilter: function(layer) {
                return pageData.nonClusterLayers.includes(layer);
              },
              hitTolerance: 5
            })) {
              pageData.nonClusterLayer.getFeatures(event.pixel).then((features) => {
                if (features.length > 0)
                  pageData.tooltip.show(
                    event.coordinate,
                    //feature.getGeometry().getCoordinates(),
                    '<div><div class="imgDiv"><img src="fotos/' + features[0].get('imatge_1') + '"/></div><h2>' + features[0].get('nom_' + pageData.lang) + '</h2></div>'
                  );
                else
                  pageData.tooltip.hide();
              });
            }

            // rutas
            /*else if (pageData.map.hasFeatureAtPixel(event.pixel, {
              layerFilter: function(layer) {
                return pageData.rutasLayers.includes(layer);
              },
              hitTolerance: 5
            })) {
              pageData.map.forEachFeatureAtPixel(event.pixel, function (feature) {
                let title = feature.get('georuta_2_' + pageData.lang),
                    foto = feature.get('imatge_1');
                pageData.tooltip.show(event.coordinate, '<div><div class="imgDiv"><img src="fotos/' + foto + '"/></div><h2>' + title + '</h2></div>');
                return true;
              }, {
                layerFilter: function(layer) {
                  return pageData.rutasLayers.includes(layer);
                },
                hitTolerance: 5
              });
            }*/

            // POIs
            else {
              pageData.poisLayer.getFeatures(event.pixel).then((features) => {
                if (features[0] !== hoverFeature) {
                  hoverFeature = features[0];
                  pageData.tooltip.hide();
                }
                if (features.length > 0) {
                  let feature = null;
                  if (hoverFeature.get('spiderfied')) {
                    feature = pageData.vectorSource.getClosestFeatureToCoordinate(
                      event.coordinate,
                      (feature) => hoverFeature.get("features").includes(feature)
                    );
                  }
                  else if (!hoverFeature.get('cluster')) {
                    feature = hoverFeature.get("features")[0];
                  }
                  else {
                    pageData.tooltip.hide();
                    return true;
                  }

                  pageData.tooltip.show(
                    event.coordinate,
                    //feature.getGeometry().getCoordinates(),
                    '<div><div class="imgDiv"><img src="fotos/' + feature.get('imatge_1') + '"/></div><h2>' + feature.get('nom_' + pageData.lang) + '</h2></div>'
                  );
                }
                else
                  pageData.tooltip.hide();
              });
            }
          }
        });

        /*
         * Click to zoom or show popup
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

          // cluster and pois
          let feature = pageData.map.forEachFeatureAtPixel(evt.pixel, function(feature) {
            return feature;
          }, {
            hitTolerance: 5
          });

          if (feature) {
            //if (feature.get("cluster") && pageData.map.getView().getZoom() < pageData.map.getView().getMaxZoom()) {
            if (feature.get("cluster")) {

              // marker or cluster -> zoom to area
              /*pageData.map.getView().animate({
                zoom: pageData.map.getView().getZoom()+2, 
                center: evt.coordinate
              });*/

              pageData.poisLayer.getFeatures(evt.pixel).then((features) => {
                if (features.length > 0) {
                  const clusterMembers = features[0].get('features');
                  if (clusterMembers.length > 1) {
                    // Calculate the extent of the cluster members.
                    const extent = createEmpty();
                    clusterMembers.forEach((feature) =>
                      extend(extent, feature.getGeometry().getExtent())
                    );
                    const view = pageData.map.getView();
                    const resolution = view.getResolution();

                    if (view.getZoom() === view.getMaxZoom() || (getWidth(extent) < resolution && getHeight(extent) < resolution)) {
                      // Show an expanded view of the cluster members.
                      pageData.clickFeature = features[0];
                      pageData.clickResolution = resolution;
                      pageData.clusterCircles.setStyle(clusterCircleStyle);
                    } 
                    else {
                      // Zoom to the extent of the cluster members.
                      view.fit(extent, {duration: 1000, padding: [50, 50, 50, 50]});
                    }
                  }
                }
              });
            }
            else {
              // popup
              if (pageData.map.hasFeatureAtPixel(evt.pixel, {
                layerFilter: function(layer) {
                  return pageData.poisLayer === layer || pageData.nonClusterLayers.includes(layer) || pageData.clusterCircles === layer;
                },
                hitTolerance: 5
              })) {

                if (nonClusterIds.includes(feature.get("id"))) {
                  // epicentre
                  showPopupPoi(evt.coordinate, feature);
                }
                else {
                  // resto
                  pageData.poisLayer.getFeatures(evt.pixel).then((features) => {
                    if (features[0] !== hoverFeature) {
                      hoverFeature = features[0];
                      pageData.popup.hide();
                    }
                    if (features.length > 0) {
                      let feature = null;
                      if (hoverFeature.get('spiderfied')) {
                        feature = pageData.vectorSource.getClosestFeatureToCoordinate(
                          evt.coordinate,
                          (feature) => hoverFeature.get("features").includes(feature)
                        );
                      }
                      else if (!hoverFeature.get('cluster')) {
                        feature = hoverFeature.get("features")[0];
                      }
                      else {
                        pageData.popup.hide();
                        return true;
                      }

                      if (feature.get('num_ruta') === '6') {
                        let poiNum = feature.get('nom_' + pageData.lang).split("-")[0];
                        showPopupRutaInteractive(poiNum);
                      }
                      else
                        showPopupPoi(evt.coordinate, feature);
                    }
                  });
                }
              }
              else if (pageData.map.hasFeatureAtPixel(evt.pixel, {
                layerFilter: function(layer) {
                  return pageData.rutasLayers.includes(layer);
                },
                hitTolerance: 5
              })) {
                if (feature.get('georuta_2_cat') === 'Georuta 6')
                  showPopupRutaInteractive();
                else
                  showPopupRuta(feature, feature.values_, evt.coordinate);
              }
              else {
                pageData.popup.hide();
              }
            }
          }
          else {
            pageData.popup.hide();
          }
        });

        function showPopupPoi(coords, feature) {
          let title = feature.get('nom_' + pageData.lang),
              description = feature.get('descripcio_' + pageData.lang),
              foto = feature.get('imatge_1'),
              autor = feature.get('imatge1_autor'),
              web = feature.get('web_' + pageData.lang);

          let htmlStr = '<div class="padding"><h2>' + title + '</h2>';
          htmlStr += description ? '<p>' + description + '</p>' : '';
          htmlStr += web ? '<p><a class="button" target="_blank" href="' + web + '">' + i18next.t("dtRuta.link") + '</a>' : '';

          // google maps button
          let geom = feature.getGeometry().flatCoordinates;
          let lonlat = toLonLat(geom);
          //console.log(geom, lonlat);
          htmlStr += '<span class="coords"><a class="button" target="_blank" href="https://maps.google.com/?q=' + lonlat[1] + ',' + lonlat[0] + '">' + i18next.t("dtRuta.gmaps") + '</a></span></p>';

          htmlStr += foto ? '<img src="fotos/' + foto + '"/>' : '';
          htmlStr += autor ? '<p class="autor">' + i18next.t("dtRuta.autor") + ': ' + autor + '</p>' : '';
          htmlStr += '</div>';
          pageData.popup.show(coords, htmlStr);
          pageData.tooltip.hide();
        }

        function showPopupPoiById(id) {
          if (Number.isInteger(parseInt(id))) {

            // get geojson for this POI num
            $.getJSON("https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.json?MAP=" + pageData.qgisProjectFile + "&visible=true&id="+id, function() {})
            .done(function(data) {

              data.features.forEach(function(feature) {
                if (feature.id == id) {
                  let format = new GeoJSON();
                  showPopupPoi(feature.geometry.coordinates, format.readFeature(feature));
                  pageData.map.getView().animate({
                    zoom: 15, 
                    center: fromLonLat(feature.geometry.coordinates), 
                    duration: 2000
                  });
                }
              });
            });
          }
          else {
            console.log("no POI with id ", id);
          }
        }

        function showPopupRuta(feature, props, coord) {
          let title = props['georuta_2_' + pageData.lang],
              description = props['descripcio_' + pageData.lang],
              foto = props['imatge_1'],
              autor = props['imatge_1_autor'],
              distancia = props['distancia_km'] + " km",
              desnivel = props['desnivell_m'],
              tipologia = props['tipologia_' + pageData.lang],
              modalidad = props['modalitat_' + pageData.lang],
              dificultad = props['dificultat_' + pageData.lang],
              web = props['web_' + pageData.lang];

          let htmlStr = '<div class="padding"><h2>' + title + '</h2>';
          htmlStr += description ? '<p>' + description + '</p>' : '';
          htmlStr += web ? '<p><a class="button" target="_blank" href="' + web + '">' + i18next.t("dtRuta.link") + '</a>' : '<p>';

          // google maps button
          /*let geom = feature.getGeometry().getExtent();
          let lng = geom[0] + (geom[2]-geom[0])/2;
          let lat = geom[1] + (geom[3]-geom[1])/2;
          let center = toLonLat([lng, lat]);
          console.log(geom, center);
          htmlStr += '<a class="button" target="_blank" href="https://maps.google.com/?q=' + center[1] + ',' + center[0] + '">' + i18next.t("dtRuta.gmaps") + '</a> ';*/

          // gpx kml button
          let tipo = props['modalitat_cat'];
          if (tipo.indexOf("a peu") > -1) {
            htmlStr += '<span class="coords">';
            htmlStr += i18next.t("dtRuta.download") + ": ";
            htmlStr += '<a class="button" href="downloads/' + props['georuta_2_cat'] + '.gpx" download>' + i18next.t("dtRuta.gpx") + '</a> ';
            htmlStr += ' <a class="button" href="downloads/' + props['georuta_2_cat'] + '.kml" download>' + i18next.t("dtRuta.kml") + '</a></span>';
          }

          htmlStr += '</p> ';
          htmlStr += foto ? '<img src="fotos/' + foto + '"/>' : '';
          htmlStr += autor ? '<p class="autor">' + i18next.t("dtRuta.autor") + ': ' + autor + '</p>' : '';
          htmlStr += distancia ? '<p>' + i18next.t("dtRuta.distancia") + ': ' + distancia + '</br>' : '';
          htmlStr += desnivel ? i18next.t("dtRuta.desnivell") + ': ' + desnivel + '</br>' : '';
          htmlStr += tipologia ? i18next.t("dtRuta.tipologia") + ': ' + tipologia + '</br>' : '';
          htmlStr += modalidad ? i18next.t("dtRuta.modalitat") + ': ' + modalidad + '</br>' : '';
          htmlStr += dificultad ? i18next.t("dtRuta.dificultat") + ': ' + dificultad + '</p>' : '';
          htmlStr += '</div>';
          pageData.popup.show(coord, htmlStr);
          pageData.tooltip.hide();

          // zoom to ruta
          const format = new GeoJSON();
          const f = format.readFeature(feature, {
            dataProjection: 'EPSG:4326',
            featureProjection: 'EPSG:3857'
          });          
          pageData.map.getView().fit(f.getGeometry(), {
            easing: easeOut,
            duration: 2000,
            padding: [100, 100, 100, 100]
          });
        }

        function showPopupRutaById(id) {
          // get georuta by id
          $.getJSON("https://mapa.psig.es/qgisserver/wfs3/collections/Rutes recomanades/items.json?MAP=" + pageData.qgisProjectFile + "&limit=1000&visible=true&id=" + id, function() {})
          .done(function(data) {

            data.features.forEach(function(feature) {
              let coord = feature.geometry.coordinates[0][0];
              let xy = fromLonLat(coord);
              showPopupRuta(feature, feature.properties, xy);
            });
          });
        }

        function showPopupRutaInteractive(poiNum=null) {
          // get interactive "Georuta 6" (for now only number 6, but easy to activate for others)
          $.getJSON("https://mapa.psig.es/qgisserver/wfs3/collections/Rutes recomanades/items.json?MAP=" + pageData.qgisProjectFile + "&limit=1000&visible=true", function() {})
          .done(function(data) {

            data.features.forEach(function(feature) {

              if (feature.properties.georuta_cat === "Georuta 6") {

                let point = pageData.map.getPixelFromCoordinate(fromLonLat(feature.geometry.coordinates[0][0]));

                if (point) {

                  let html = '<div class="accordion" id="windowPdf">';

                  html += '<h2 id="P0" class="accordion-header"><i class="fa fa-caret-up" aria-hidden="true"></i>' + i18next.t("dtRuta.intro") + '</h2>';
                  html += '<div class="accordion-content">' + feature.properties['descripcio_' + pageData.lang] + '<button id="exportPdf" class="dt-button buttons-pdf buttons-html5" type="button"><span>' + i18next.t("dtRuta.pdf") + '</span></button>' + '</div>';

                  // get POIs from this georuta
                  $.getJSON("https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.json?MAP=" + pageData.qgisProjectFile + "&limit=1000&visible=true", function() {})
                  .done(function(data) {

                    let fs = [];
                    data.features.forEach(function(f) {
                      //if (f.properties.nom_ruta_cat === "Georuta 6") {
                      if (f.properties.num_ruta === "6") {
                        fs.push(f);
                      }
                    });

                    // sort by name to order POIs shown in accordion
                    fs.sort((f1, f2) => {
                      const nameF1 = f1.properties['nom_' + pageData.lang].toUpperCase();
                      const nameF2 = f2.properties['nom_' + pageData.lang].toUpperCase();
                      if (nameF1 < nameF2) {
                        return -1;
                      }
                      if (nameF1 > nameF2) {
                        return 1;
                      }
                      return 0;
                    });

                    fs.forEach(function(f) {
                      let poiNum = f.properties['nom_' + pageData.lang].split("-")[0];
                      html += '<h2 id="' + poiNum + '" class="accordion-header"><i class="fa fa-caret-down" aria-hidden="true"></i>' + f.properties['nom_' + pageData.lang] + '</h2>';
                      html += '<div class="accordion-content accordion-pois">' + f.properties['descripcio_' + pageData.lang] + '</div>';
                    });

                    // show popup
                    pageData.popup.show(point, html);
                    pageData.tooltip.hide();

                    $(".accordion-header").on("click", function() {
                      let open = false;
                      if ($(this).next().is(":visible"))
                        open = true;
                      $(".accordion-content").hide();
                      if (!open) {
                        $(this).next().show();
                        $(this).get(0).scrollIntoView();
                      }
                    });

                    $('#exportPdf').click(function() {
                      //$(".featurePopup").css("width", "1200px");
                      //$(".featurePopup").css("max-width", "1200px");
                      $(".accordion-content").show();
                      $('#exportPdf').hide();

                      html2pdf(document.getElementById('windowPdf'), {
                        filename: 'Georuta6.pdf',
                        image: { 
                          type: 'jpeg', 
                          quality: 0.9,
                        },
                        html2canvas:  {
                          useCORS: true,
                          scale: 1,
                        },
                        jsPDF: { 
                          format: 'a4', 
                          orientation: 'portrait', 
                          //putOnlyUsedFonts: true 
                        },
                        pagebreak: { after: '.accordion-content' }
                      });

                      console.log("not");

                      setTimeout(() => {
                        console.log("done")
                        //$(".featurePopup").css("width", "calc(100% - 200px)");
                        //$(".featurePopup").css("max-width", "860px");
                        $(".accordion-content").hide();
                        $(".accordion-header#P0").next().show();
                        $('#exportPdf').show();
                      }, 1000);
                    });

                    if (poiNum) {
                      $(".accordion-content").hide();
                      $(".accordion-header#"+poiNum).next().show();
                      $(".accordion-header#"+poiNum).get(0).scrollIntoView();
                    }
                  });
                }
              }
            });
          });
        }

        pageData.map.on('pointerdrag', function(evt) {
          pageData.geoDraw.setActive(false);
          $("#ol-geoBtn").addClass("ol-geolocation-false");
        });

        $(document).keyup(function(e) {
          if (e.keyCode === 27) { // escape
            pageData.windowTablePois.hide();
            //pageData.windowTableRutas.hide();
            pageData.windowInfo.hide();
            pageData.popup.hide();
            // turn off geolocate
            //pageData.geolocation.setTracking(false);
            if (pageData.geoMarker) {
              pageData.geoMarker.setPosition(undefined);
              document.getElementById("ol-geoBtn").classList.add("ol-geolocation-false");
            }
          }
        });

        /*
         * Pois Menu
         *****************************************/
        appendRutasMenu();
        //appendPoisMenu();

        function appendPoisMenu() {

          let html = '<div class="layer-switcher _museos"><ul><li class="group layer-switcher-fold layer-switcher-close"><button></button><label for="museos-title"><i class="fa fa-eye"></i> ' + i18next.t('gui.windowTablePoisTitle') + '</label></li>';

          $.getJSON("https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.json?MAP=" + pageData.qgisProjectFile + "&visible=true&tipus_cat=centre_interpretacio&limit=100&sortby=ordre", function() {})
            .done(function(data) {

              html += "<ul style='display:none;'>";

              data.features.forEach(function(feature) {
                const name = feature.properties["nom_" + pageData.lang];
                html += "<li class='poiLayer' data-id='" + feature.id + "'>" + name + "</li>";
              });

              html += "</ul></ul></div>";
              $("#windowLayers .content").prepend(html);

              $("._museos .poiLayer").bind("click", function() {
                console.log("poi", $(this).data("id"));
                showPopupPoiById($(this).data("id"));
              });

              $("._museos button").bind("click", function() {
                $(this).parent().next().toggle();
                $(this).parent().toggleClass("layer-switcher-close").toggleClass("layer-switcher-open");
              });
            });
        }

        function appendRutasMenu() {

          let html = '<div class="layer-switcher _rutes"><ul><li class="group layer-switcher-fold layer-switcher-close"><button></button><label for="rutas-title"><i class="fa fa-eye"></i> ' + i18next.t('gui.windowTableRutasTitle') + '</label></li>';

          $.getJSON("https://mapa.psig.es/qgisserver/wfs3/collections/Rutes recomanades/items.json?MAP=" + pageData.qgisProjectFile + "&visible=true&limit=100&sortby=ordre", function() {})
            .done(function(data) {

              html += "<ul style='display:none;'>";

              data.features.forEach(function(feature) {
                const name = feature.properties["georuta_2_" + pageData.lang];
                html += "<li class='poiLayer' data-id='" + feature.id + "'>" + name + "</li>";
              });

              html += "</ul></ul></div>";
              //html += "<script>function togglePoi() {}<script>"
              $("#windowLayers .content").prepend(html);

              console.log($("._rutes .poiLayer"));
              $("._rutes .poiLayer").bind("click", function() {
                console.log("ruta", $(this).data("id"));
                showPopupRutaById($(this).data("id"));
              });

              $("._rutes button").bind("click", function() {
                $(this).parent().next().toggle();
                $(this).parent().toggleClass("layer-switcher-close").toggleClass("layer-switcher-open");
              });

              appendPoisMenu();
            });
        }
      }


      /*
       * WFS styles
       *****************************************/
      function iconStyleFunction(feature) {
        let tipus = feature.get('tipus_cat'),
            zIndex = 0;

        if (tipus === "epicentre")
          zIndex = 1;

        return new Style({
          geometry: feature.getGeometry(),
          image: new Icon({
            scale: 0.08,
            src: "simbols/" + tipus + ".svg"
          }),
          zIndex: zIndex
        })
      }

      function rutaStyleFunction(feature, resolution) {
        if (feature.get('tipologia_cat') === 'Georuta') {
          return new Style({
            stroke: new Stroke({
              color: '#e7bd14',
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
        else if (feature.get('tipologia_cat') === 'altres rutes') {
          return new Style({
            stroke: new Stroke({
              color: '#b19395',
              lineDash: [4,4],
              width: 3
            })
          });
        }
        else if (feature.get('tipologia_cat') === 'ruta_aquatica') {
          return new Style({
            stroke: new Stroke({
              color: '#1e005d',
              lineDash: [4,4],
              width: 3
            })
          });
        }
        else if (feature.get('tipologia_cat') === 'Tren dels Llacs') {
          let offset = 5;
          return [
            new Style({
              stroke: new Stroke({
                color: '#232323',
                lineDash: [2,4],
                width: 2
              })
            })
          ]
        }
      }


      /*
       * Cluster Style function
       *****************************************/
      function clusterStyle(feature) {
        let size = 0,
            features = feature.get('features');
        //remove not selected categories
        for (var i = features.length - 1; i >= 0; --i) {
          if (!$("li.poiLayer." + makeSafeForCSS(features[i].get("tipus_cat"))).hasClass("off")) {
            size++;
          }
        }

        if (size > 1) {
          feature.set('cluster', true);
          return [
            new Style({
              image: new Circle({
                radius: 40,
                fill: new Fill({
                  color: "rgba(0, 0, 0, 0)"
                })
              })
            }),
            new Style({
              image: new Circle({
                radius: 20,
                fill: new Fill({
                  color: 'rgba(231, 221, 11, 0.3)',
                })
              })
            }),
            new Style({
              image: new Circle({
                radius: 14,
                fill: new Fill({
                  color: 'rgba(231, 221, 11, 0.7)',
                })
              }),
              text: new Text({
                text: size.toString(),
                fill: new Fill({
                  color: '#fff',
                }),
                stroke: new Stroke({
                  color: 'rgba(0, 0, 0, 0.6)',
                  width: 3,
                })
              })
            }),
          ];
        }
        else if (size > 0) {
          feature.set('cluster', false);
          for (var i = features.length - 1; i >= 0; --i) {
            if (!$("li.poiLayer." + makeSafeForCSS(features[i].get("tipus_cat"))).hasClass("off")) {
              return iconStyleFunction(features[i]);
              break;
            }
          }
        }
        return null;
      }

      /**
       * From
       * https://github.com/openlayers/openlayers/blob/main/examples/clusters-dynamic.js#L77
       * Style for clusters with features that are too close to each other, activated on click.
       * @param {Feature} cluster A cluster with overlapping members.
       * @param {number} resolution The current view resolution.
       * @return {Style} A style to render an expanded view of the cluster members.
       */
      function clusterCircleStyle(cluster, resolution) {
        if (cluster !== pageData.clickFeature || resolution !== pageData.clickResolution) {
          return;
        }
        cluster.set('cluster', false);
        cluster.set('spiderfied', true);
        const clusterMembers = cluster.get('features');
        const centerCoordinates = cluster.getGeometry().getCoordinates();
        return generatePointsCircle(
          clusterMembers.length,
          cluster.getGeometry().getCoordinates(),
          resolution
        ).reduce((styles, coordinates, i) => {
          const point = new Point(coordinates);
          const line = new LineString([centerCoordinates, coordinates]);
          styles.unshift(
            new Style({
              geometry: line,
              stroke: new Stroke({
                color: 'rgba(204, 85, 0, 1)',
                width: 1.5,
              })
            })
          );
          styles.push(
            iconStyleFunction(
              new Feature({
                ...clusterMembers[i].getProperties(),
                geometry: point
              })
            )
          );
          return styles;
        }, []);
      }

      /**
       * From
       * https://github.com/Leaflet/Leaflet.markercluster/blob/31360f2/src/MarkerCluster.Spiderfier.js#L55-L72
       * Arranges points in a circle around the cluster center, with a line pointing from the center to
       * each point.
       * @param {number} count Number of cluster members.
       * @param {Array<number>} clusterCenter Center coordinate of the cluster.
       * @param {number} resolution Current view resolution.
       * @return {Array<Array<number>>} An array of coordinates representing the cluster members.
       */
      function generatePointsCircle(count, clusterCenter, resolution) {
        const circleDistanceMultiplier = 1;
        const circleFootSeparation = 28;
        const circleStartAngle = Math.PI / 2;
        const circumference = circleDistanceMultiplier * circleFootSeparation * (2 + count);
        let legLength = circumference / (Math.PI * 2); //radius from circumference
        const angleStep = (Math.PI * 2) / count;
        const res = [];
        let angle;

        legLength = Math.max(legLength, 25) * resolution; // Minimum distance to get outside the cluster icon.

        for (let i = 0; i < count; ++i) {
          // Clockwise, like spiral.
          angle = circleStartAngle + i * angleStep;
          res.push([
            clusterCenter[0] + legLength * Math.cos(angle),
            clusterCenter[1] + legLength * Math.sin(angle),
          ]);
        }

        return res;
      }


      /*
       * Menu
       *****************************************/
      function initMenu() {
        pageData.windowLayers = new Overlay({
          closeBox : true,
          className: "slide-right window layersWindow open",
          content: document.getElementById("windowLayers")
        })
        pageData.map.addControl(pageData.windowLayers);

        LayerSwitcherWithLegend.renderPanel(pageData.map, pageData.poisLayer, pageData.nonClusterLayer, pageData.paradesLayer, document.getElementById("layerSwitcher"), { reverse: true });
        LayerSwitcherWithLegend.addPois(pageData.map, pageData.poisLayer, pageData.nonClusterLayer);

        pageData.windowTablePois = new Overlay({
          closeBox : true,
          className: "slide-right window tableWindow",
          content: document.getElementById("windowTablePois")
        })
        pageData.map.addControl(pageData.windowTablePois);

        /*pageData.windowTableRutas = new Overlay({
          closeBox : true,
          className: "slide-right window tableWindow",
          content: document.getElementById("windowTableRutas")
        })
        pageData.map.addControl(pageData.windowTableRutas);*/

        pageData.windowInfo = new Overlay({
          closeBox : true,
          className: "slide-right window infoWindow",
          content: document.getElementById("windowInfo")
        })
        pageData.map.addControl(pageData.windowInfo);

        let menuBar = new Bar({
          className: "ol-top ol-right menuBar open"
        });
        pageData.map.addControl(menuBar);

        let actionBar = new Bar({ toggleOne: true, group: true });
        menuBar.addControl(actionBar);
        actionBar.addControl(pageData.tableTogglePois);
        //actionBar.addControl(pageData.tableToggleRutas);
        actionBar.addControl(pageData.infoToggle);
        actionBar.addControl(pageData.surveyButton);

        let languageBar = new Bar({ 
          toggleOne: true, 
          group: true,
          className: "langBar"
        });
        menuBar.addControl(languageBar);
        languageBar.addControl(pageData.caToggle);
        languageBar.addControl(pageData.esToggle);
        languageBar.addControl(pageData.enToggle);
        languageBar.addControl(pageData.frToggle);
      }

      function hideWindows(activeToggle) {
        pageData.windowTablePois.hide();
        //pageData.windowTableRutas.hide();
        pageData.windowInfo.hide();
        
        if (activeToggle !== "tablePois")
          pageData.tableTogglePois.setActive(false);
        /*else if (activeToggle !== "tableRutas")
          pageData.tableToggleRutas.setActive(false);*/
        else if (activeToggle !== "info")
          pageData.infoToggle.setActive(false);
      }

      /*
       * Cookies & i18n
       *****************************************/
      function initAll(data) {
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
            //let lang = getCookies();
            let lang = 'ca';

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

            initMap(data);
            initMenu();
            pageData.windowLayers.show();
            initDtPois();
            //initDtRutes();

            if (window.mobilecheck()) {
              // close layer switcher
              setTimeout(function() {
                // close layer switcher
                $(".layersWindow").removeClass("open");
                $(".layer-control").removeClass("open");
                $(".menuBar").removeClass("open");
              }, 3000);

              // set initial position
              navigator.geolocation.getCurrentPosition((position) => {
                let myLoc = fromLonLat([position.coords.longitude, position.coords.latitude]);
                console.log(myLoc, pageData.extent);

                // is inside geoparc
                if (myLoc[0] > pageData.extent[0] && myLoc[0] < pageData.extent[2] && myLoc[1] > pageData.extent[1] && myLoc[1] > pageData.extent[3]) {
                  $(".ol-geobt button").click();
                }
              });
            }
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
        else if (lang === "en")
          pageData.enToggle.setActive(true);
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
        //initDtRutes();

        pageData.popup.hide();

        // menu
        pageData.tableTogglePois.setTitle(i18next.t('gui.windowTablePoisTitle'));
        //pageData.tableToggleRutas.setTitle(i18next.t('gui.windowTableRutasTitle'));
        pageData.infoToggle.setTitle(i18next.t('gui.windowInfoTitle'));
        $("label[for='museos-title']").html('<i class="fa fa-eye"></i> ' + i18next.t('gui.windowTablePoisTitle'));
        $("label[for='rutas-title']").html('<i class="fa fa-eye"></i> ' + i18next.t('gui.windowTableRutasTitle'));

        // windows
        $("#windowTablePois .title").text(i18next.t('gui.windowTablePoisTitle'));
        //$("#windowTableRutas .title").text(i18next.t('gui.windowTableRutasTitle'));
        $("#windowInfo .title").text(i18next.t('gui.windowInfoTitle'));

        // info
        $("#windowInfo .infoLine1").text(i18next.t('gui.infoLine1'));
        $("#windowInfo .infoLine2").text(i18next.t('gui.infoLine2'));
        $("#windowInfo .infoLine3").text(i18next.t('gui.infoLine3'));
        $("#windowInfo .infoLine4").text(i18next.t('gui.infoLine4'));
        $("#windowInfo .infoContact").text(i18next.t('gui.infoContact'));
        $("#windowInfo .infoSuport").text(i18next.t('gui.infoSuport'));

        // layerswitcher
        pageData.qgisWfsLayersPoi.set("title", i18next.t('switcher.wfsGroupPoi'));
        //pageData.qgisWfsLayersRuta.set("title", i18next.t('switcher.wfsGroupRuta'));
        pageData.qgisWmsLayers.set("title", i18next.t('switcher.wmsGroup'));
        //pageData.baseLayers.set("title", i18next.t('switcher.baseGroup'));
        //pageData.baseLayerTopo.set("title", i18next.t('switcher.baseGroupTopo'));        
        //pageData.baseLayerOrto.set("title", i18next.t('switcher.baseGroupOrto'));
        //$("#layerSwitcher .base-group ul li.layer li:span:nth-of-type(1) label").text(i18next.t('switcher.baseGroupTopo'));
        //$("#layerSwitcher .base-group ul li.layer li:span:nth-of-type(2) label").text(i18next.t('switcher.baseGroupOrto'));
        LayerSwitcherWithLegend.renderPanel(pageData.map, pageData.poisLayer, pageData.nonClusterLayer, pageData.paradesLayer, document.getElementById("layerSwitcher"), { reverse: true });
        LayerSwitcherWithLegend.addPois(pageData.map, pageData.poisLayer, pageData.nonClusterLayer);
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
            url :"https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.json?MAP=" + pageData.qgisProjectFile + "&limit=1000&visible=true", type : "GET",
            dataSrc: 'features'
          },
          columns: [
            { "data": "properties.nom_" + pageData.lang, "title" : i18next.t("dtPoi.nom"), "class": "title", "render": function ( data, type, row ) { return "<span class='link' data-coords='[" + row.geometry.coordinates + "]'>" + data + "</span>"; }},
            { "data": "properties.descripcio_" + pageData.lang, "title" : i18next.t("dtPoi.descripcio"), "class": "descripcio",},
            /*{ "data": "properties.imatge_1", "title" : i18next.t("dtPoi.imatge"), "class": "imatge", "render": function ( data, type, row ) { return data!=="" ? "<img class='link' style='max-width:300px;' src='fotos/" + data + "' data-coords='[" + row.geometry.coordinates + "]'/>" : ""; }},*/
            { "data": "properties.nom_ruta_" + pageData.lang, "title" : i18next.t("dtPoi.georuta"), "class": "ruta"},
            /*{ "data": "properties.tematica_1_" + pageData.lang, "title" : i18next.t("dtPoi.temática"), "class": "tematica"},*/
            /*{ "data": "properties.tipus_" + pageData.lang, "title" : i18next.t("dtPoi.tipus"), "class": "tipus"},*/
            /*{ "data": "properties.web_" + pageData.lang, "title" : i18next.t("dtPoi.web"), "render": function ( data, type, row ) { return data!=="" ? "<a target='_blank' href='" + data + "' title='" + data + "'><i class='fa fa-external-link' aria-hidden='true'></i></a>" : ""; }, "class": "web"},*/
          ],
        }).on( 'init.dt', function () {
          $("#datatable-pois").on("click", ".link", function() {
            $(".tableWindow").hide();
            //console.log($(this).data("coords"));
            pageData.map.getView().animate({zoom: 15, center: fromLonLat($(this).data("coords")), duration: 2000});
          });
        });
      }

      /*function initDtRutes() {
        $('#datatable-rutas').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="rutas-table"></table>');
        let datatable = $('#rutas-table').DataTable({
          info: false,
          responsible: true,
          search: true,
          ajax: { 
            url :"https://mapa.psig.es/qgisserver/wfs3/collections/Rutes recomanades/items.json?MAP=" + pageData.qgisProjectFile + "&limit=1000&visible=true", type : "GET",
            dataSrc: 'features'
          },
          columns: [
            { "data": "properties.georuta_" + pageData.lang, "title" : i18next.t("dtRuta.nom"), "class": "georuta", "render": function ( data, type, row ) { return "<span class='link' data-coords='" + JSON.stringify(row.bbox) + "'>" + data + "</span>"; }},
            { "data": "properties.descripcio_" + pageData.lang, "title" : i18next.t("dtRuta.descripcio"), "class": "descripcio"},
            { "data": "properties.desnivell_m", "title" : i18next.t("dtRuta.desnivell"), "class": "desnivell"},
            { "data": "properties.dificultat_" + pageData.lang, "title" : i18next.t("dtRuta.dificultat"), "class": "dificultat"},
            { "data": "properties.distancia_km", "title" : i18next.t("dtRuta.distancia"), "class": "distancia", "render": function ( data, type, row ) { return parseFloat(data).toLocaleString('es-ES', { decimal: ',', useGrouping: false, minimumFractionDigits: 2, maximumFractionDigits: 2 }); }},
            { "data": "properties.web_" + pageData.lang, "title" : i18next.t("dtRuta.web"), "class": "web", "render": function ( data, type, row ) { return data!=="" ? "<a target='_blank' href='" + data + "' title='" + data + "'><i class='fa fa-external-link' aria-hidden='true'></i></a>" : ""; }},
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
      }*/

      /*
       * Init
       *****************************************/
      function initGui() {
      }

      onMounted(()=>{

        // load layers configuration file
        $.getJSON( "js/data/geoparc-turisme.qgs.json", function() {})
        .done(function(data) {
          initAll(data);
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