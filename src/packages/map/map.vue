<template>
  <div id="map" class="map"></div>
  <div class="loading"><p></p><span></span></div>

  <div id="windowLayers" class="window">
    <h2>
      <i class="fa fa-file-text-o"></i>
      <span class="title">Capes</span>
    </h2>
    <div class="content">
      <div id="layerSwitcher" class="layer-switcher"></div>
    </div>
  </div>

  <div id="windowSearch" class="window">
    <h2>
      <i class="fa fa-file-text-o"></i>
      <span class="title">Cercadors</span>
    </h2>
    <div class="content">
      <h3 class="titleCatastro">Cerca per referència cadastral</h3>
      <p class="introCatastro">Introduïu la referència cadastral i premeu el botó Buscar parcel·la (Ex 6307611CG2760N0001WO)</p>
      <p>
        <label class="labelReferencia" for="searchReferencia">Referència</label> <input type="text" id="searchReferencia" />
      </p>
      <p>
        <button type="button" class="btn btn-default btnReferencia" id="searchReferenciaBtn">Cercar parcel·la</button>
      </p>
      <p>
        <span id="searchMsg"></span>
      </p>
    </div>
  </div>

  <div id="windowPrint" class="window">
    <h2>
      <i class="fa fa-print"></i>
      <span class="title">Impressió</span>
    </h2>
    <div class="content">
      <p>Selecciona el paper i escala d'impressió</p>
      <p><select id="printSize" name="printSize">
        <option value="a4_hor" data-dim="[297,188]" selected="selected">DIN A4</option>
        <option value="a3_hor" data-dim="[420,275]">DIN A3</option>
      </select></p>
      <p><select id="printScale" name="printScale">
        <option value="200">1:200</option>
        <option value="500">1:500</option>
        <option value="1000" selected="selected">1:1.000</option>
        <option value="2000">1:2.000</option>
        <option value="5000">1:5.000</option>
        <option value="10000">1:10.000</option>
        <option value="25000">1:25.000</option>
        <option value="50000">1:50.000</option>
      </select></p>
      <p>
        <button type="button" class="btn btn-default btn-cancel">Cancel·lar</button> 
        <button type="button" class="btn btn-default btn-print">Imprimir</button>
      </p>
    </div>
  </div>

  <div id="windowDocs" class="window">
    <h2>
      <i class="fa fa-file-text-o"></i>
      <span class="title">Informació Planejament</span>
    </h2>
    <div class="content">
      <p>La documentació disponible en aquest lloc web no té cap valor normatiu. Només serveix de consulta i referència, i conté algunes interpretacions per poder fer la consulta telemàtica. Els únics documents amb valor normatiu són els propis expedients urbanístics aprovats definitivament i sempre i quan no hagin estat subjectes a una sentència ferma emesa per un tribunal de justícia.</p>
      <p>Els documents oficials, amb validesa normativa es troben a la Direcció General d’Urbanisme de la Generalitat de Catalunya, que disposa de l'original d’aquests documents. També es pot consultar una còpia en PDF en aquest enllaç:</p>
      <p><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=loadSenseCriteris" target="_blank"><img src="/registre.png"></a> <a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=loadSenseCriteris" target="_blank">Registre del planejament urbanístic de Catalunya</a></p>
      <p>L'Ajuntament disposa, a més, d'una còpia en PDF estructurada del contingut del POUM defintivament aprovat per a la seva consulta en aquest enllaç:</p>
      <p><a href="#" class="normativa-button"><img src="/pdf.png"></a> <a href="#" class="normativa-button">Normativa urbanística completa</a></p>
    </div>
  </div>

  <div id="windowNormativa" class="window">
    <h2>
      <i class="fa fa-file-text-o"></i>
      <span class="title">Normativa urbanística completa</span>
    </h2>
    <div class="content">
      <div class="row">
        <!--<iframe src="/geoparc-planejament/normativas/" width="100%" height="575px" frameborder="0"></iframe>-->
        <div class="tree">
          <ul>
            <li class="active"><a>Documentació aprovació definitiva</a>
              <ul>
                <!--<li><a>Generic</a></li>-->
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25001" target="rpuc">Abella de la Conca</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25002" target="rpuc">Àger</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25039" target="rpuc">Baix Pallars</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25062" target="rpuc">Camarasa</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25077" target="rpuc">Coll de Nargó</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25098" target="rpuc">Gavet de la Conca</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25115" target="rpuc">Isona i Conca Dellà</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25128" target="rpuc">Llimiana</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25161" target="rpuc">Conca de Dalt</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25171" target="rpuc">la Pobla de Segur</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25190" target="rpuc">Salàs de Pallars</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25196" target="rpuc">Sant Esteve de la Sarga</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25201" target="rpuc">Sarroca de Bellera</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25202" target="rpuc">Senterada</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25215" target="rpuc">Talarn</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25227" target="rpuc">la Torre de Cabdella</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25234" target="rpuc">Tremp</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25250" target="rpuc">Vilanova de Meià</a></li>
                <li><a href="https://dtes.gencat.cat/rpucportal/AppJava/cercaExpedient.do?reqCode=cerca&fromPage=load&municipiSel=25904" target="rpuc">Castell de Mur</a></li>
              </ul>
            </li>
          </ul>
        </div>
        <div class="rpucframe"><iframe name="rpuc" width="100%" height="575px" frameborder="0"></iframe></div>
      </div>
    </div>
  </div>

  <div id="windowFeature" class="window">
    <h2>
      <i class="fa fa-file-text-o"></i>
      <span class="title">Informació</span>
    </h2>
    <div class="content">
      <div class="content-layers"></div>
      <div class="content-catastro"></div>
      <div class="content-limits"></div>
      <div class="content-coord"></div>
    </div>
  </div>
</template>

<script>
  import 'ol/ol.css';
  import 'ol-layerswitcher/dist/ol-layerswitcher.css';
  import 'ol-ext/dist/ol-ext.css';
  import 'font-awesome/css/font-awesome.min.css';
  import 'font-gis/css/font-gis.css'

  import { ref, reactive, shallowReactive, toRefs, toRef, onMounted, onBeforeUnmount } from 'vue';

  import { Map, View, Feature, Collection, Overlay as OverlayOL } from 'ol';
  import {
    OSM, 
    XYZ as xyzSource,
    Vector as VectorSource, 
    TileWMS,
    TileArcGISRest
  } from 'ol/source';
  import {
    Group as LayerGroup,
    Tile as TileLayer, 
    Vector as VectorLayer
  } from 'ol/layer';
  import { Draw, Translate } from 'ol/interaction';
  import { ScaleLine } from 'ol/control';
  import { Point, Polygon, LineString } from 'ol/geom';
  import { Style, Icon, Text, Circle, Fill, Stroke } from 'ol/style';
  import { register } from 'ol/proj/proj4';
  import { Projection, get as getProjection, transform, fromLonLat, toLonLat, METERS_PER_UNIT } from 'ol/proj';
  import { getLength, getArea } from 'ol/sphere';
  import { unByKey } from 'ol/Observable';
  import { easeOut } from 'ol/easing';
  import { 
    GPX,
    GeoJSON,
    IGC,
    KML,
    TopoJSON,
    GML,
    WMSCapabilities,
    WKT
  } from 'ol/format';
  import GML32 from 'ol/format/GML32';

  import Bar from 'ol-ext/control/Bar';
  import Button from 'ol-ext/control/Button';
  import Toggle from 'ol-ext/control/Toggle';
  import Overlay from 'ol-ext/control/Overlay';
  import DropFile from 'ol-ext/interaction/DropFile';

  import LayerSwitcher from 'ol-layerswitcher';
  import proj4 from 'proj4';
  import $ from 'jquery';


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

      // add event for legend dropdown
      $('li.layer i').unbind("click").click(function(){
        $(this).toggleClass('fa-caret-up');
        $(this).toggleClass('fa-caret-down');
        if ($(this).hasClass('fa-caret-down')) {
          $(this).parent().parent().find('img').css("display", "none");
        } else {
          $(this).parent().parent().find('img').css("display", "block");
        }
        return false;
      });

    }

    static renderLayer_(map, lyr, idx, options, render) {
      const li = document.createElement('li');
      const lyrTitle = lyr.get('title');
      const checkboxId = LayerSwitcher.uuid();
      const label = document.createElement('label');
      if (lyr instanceof LayerGroup && !lyr.get('combine')) {
        const isBaseGroup = LayerSwitcher.isBaseGroup(lyr);
        li.classList.add('group');
        if (isBaseGroup) {
          li.classList.add(super.CSS_PREFIX + 'base-group');
        }
        // Group folding
        if (lyr.get('fold')) {
          li.classList.add(super.CSS_PREFIX + 'fold');
          li.classList.add(super.CSS_PREFIX + lyr.get('fold'));
          const btn = document.createElement('button');
          btn.onclick = function (e) {
            const evt = e || window.event;
            LayerSwitcher.toggleFold_(lyr, li);
            evt.preventDefault();
          };
          li.appendChild(btn);
        }
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
        }
        label.innerHTML = lyrTitle;
        li.appendChild(label);
        const ul = document.createElement('ul');
        li.appendChild(ul);
        LayerSwitcherWithLegend.renderLayers_(map, lyr, ul, options, render);
      }
      else {
        li.className = 'layer ' + makeSafeForCSS(lyr.get('title'));
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
        label.htmlFor = checkboxId;

        if (lyr.get('showlegend')) {
          label.innerHTML = lyrTitle + '<i class="fa fa-caret-down" aria-hidden="true"></i>';
        } else {
          label.innerHTML = lyrTitle;
        }

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

        // append legend
        if (lyr.get('children') !== undefined) {
          lyr.get('children').forEach(function(sublayer, i) {
            if (sublayer.showlegend == true) {
              // show legend
              var img = document.createElement('img');
              img.className = 'legend';
              
              //if (!sublayer.mapproxy) {
                // dynamic from qgis server
                img.src = map.get("qgisServerURL") + '?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetLegendGraphic&LAYER='+sublayer.name+'&FORMAT=image/png&SLD_VERSION=1.1.0&SYMBOLWIDTH=4&ITEMFONTSIZE=10&BOXSPACE=1&MAP='+map.get("qgisProjectFile");

                // remove image title for all but this layer
                if (lyr.get('title') !== 'Planejament urbanístic')
                  img.src += "&LAYERTITLE=false";
              /*}
              else {
                // static from directory
                img.src = "legend/"+sublayer.mapproxy+'.png';
              }*/
              
              li.appendChild(img);
            }
          });
        }

        else if (lyr.get('showlegend') || lyr.get('title') === 'Cadastre') {
          // show legend
          var img = document.createElement('img');
          img.className = 'legend';
          if (lyr.get('title') === 'Cadastre') {
            img.src = 'https://ovc.catastro.meh.es/Cartografia/WMS/simbolos.png?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetLegendGraphic&LAYER=Catastro&FORMAT=image/png&SLD_VERSION=1.1.0';
          } 
          else /*if (!lyr.get('mapproxy') && lyr.get('mapproxy') !== undefined)*/ {
            // dynamic from qgis server
            img.src = map.get("qgisServerURL") + '?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetLegendGraphic&LAYER='+lyrTitle+'&FORMAT=image/png&SLD_VERSION=1.1.0&LAYERTITLE=false&SYMBOLWIDTH=4&ITEMFONTSIZE=10&BOXSPACE=1&MAP='+map.get("qgisProjectFile");
          }
          /*else {
            // static from directory
            img.src = "legend/"+lyr.get('mapproxy')+'.png';
          }*/
          li.appendChild(document.createElement('br'));
          li.appendChild(img);
        }
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

        center: [{
          lng: 0.88,
          lat: 42.16
        }],
        map: null,
        mapEle: null,
        proj25831: new Projection({
          code: 'EPSG:25831'
        }),

        qgisServerURL: 'https://mapa.psig.es/qgisserver/cgi-bin/qgis_mapserv.fcgi',
        mapproxyServerURL: 'https://mapa.psig.es/mapproxy/service?',
        qgisProjectFile: '/home/ubuntu/geoparc-planejament/geoparc-planejament.qgs',

        qgisLayers: new LayerGroup({
          title: 'Capes temàtiques',
        }),
        qgisSources: {},
        mousePosition: null,
        rasterLayer: null,
        cadastreLayer: null,

        baseLayers: new LayerGroup({
          title: 'Capes de referència',
          layers: [
            new TileLayer({
              title: 'Fons blanc',
              type: 'base',
              source: null,
              visible: false
            }),

            new TileLayer({
              title: 'OSM',
              type: 'base',
              source: new OSM(),
              visible: false
            }),

            new TileLayer({
              title: 'Cartografia geològica (ICGC)',
              type: 'base',
              visible: false,
              source: new TileWMS({
                url: 'https://geoserveis.icgc.cat/arcgis/services/geologic/icgc_mg50m/MapServer/WMSServer?',
                params: {
                  'LAYERS': 'CNEG_LN,DANT_PA,FAPL_LN,UGEO_PA', 
                  'VERSION': '1.3.0'
                },
                attributions: ['Mapa geològic comarcal 1:50.000 de l’<a target="_blank" href="https://www.icgc.cat/">Institut Cartogràfic i Geològic de Catalunya (ICGC)</a>, sota una llicència <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/deed.ca">CC BY 4.0</a>'],
               })
            }),

            new TileLayer({
              title: 'Ortofoto (ICGC)',
              type: 'base',
              visible: false,
              source: new TileWMS({
                //url: 'https://geoserveis.icgc.cat/icc_mapesmultibase/utm/wms/service?',
                url: 'https://geoserveis.icgc.cat/servei/catalunya/orto-territorial/wms',
                params: {
                  //'LAYERS': 'ortogris',
                  'LAYERS': 'ortofoto_color_provisional',
                  'VERSION': '1.1.1'
                },
                attributions: ['Ortofoto 2022 de l’<a target="_blank" href="https://www.icgc.cat/">Institut Cartogràfic i Geològic de Catalunya (ICGC)</a>, sota una llicència <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/deed.ca">CC BY 4.0</a>'],
               })
            }),

            new TileLayer({
              title: 'Topográfic (ICGC)',
              type: 'base',
              visible: false,
              source: new TileWMS({
                url: 'https://geoserveis.icgc.cat/icc_mapesmultibase/utm/wms/service?',
                params: {
                  'LAYERS': 'topo', 
                  'VERSION': '1.1.1'
                },
                attributions: ['Cartografia topogràfica de l’<a target="_blank" href="https://www.icgc.cat/">Institut Cartogràfic i Geològic de Catalunya (ICGC)</a>, sota una llicència <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/deed.ca">CC BY 4.0</a>'],
               })
            }),

            new TileLayer({
              title: 'Topográfic gris (ICGC)',
              type: 'base',
              visible: true,
              source: new TileWMS({
                url: 'https://geoserveis.icgc.cat/icc_mapesmultibase/utm/wms/service?',
                params: {
                  'LAYERS': 'topogris', 
                  'VERSION': '1.1.1'
                },
                attributions: ['Cartografia topogràfica de l’<a target="_blank" href="https://www.icgc.cat/">Institut Cartogràfic i Geològic de Catalunya (ICGC)</a>, sota una llicència <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/deed.ca">CC BY 4.0</a>'],
               })
            }),
          ]
        }),

        generalLayers: new LayerGroup({
          title: 'Capes generals',
          layers: [
            new TileLayer({
              title: 'Mapa Urbanístic de Catalunya (qualificació, sectors)',
              visible: false,
              type: 'personal',
              source: new TileWMS({
                url: 'https://dtes.gencat.cat/webmap/MUC/service.svc/get',
                  params: {
                    'LAYERS': 'MUC_4QUAL, MUC_3SECT', 
                    'TILED': true,
                  },
                  projection: 'EPSG:25831',
                  //serverType: 'geoserver'
              })
            }),

            new TileLayer({
              title: 'Mapa Urbanístic de Catalunya (classificació)',
              visible: false,
              type: 'personal',
              source: new TileWMS({
                url: 'https://dtes.gencat.cat/webmap/MUC/service.svc/get',
                params: {
                  'LAYERS': 'MUC_2CLAS', 
                  'TILED': true,
                },
                projection: 'EPSG:25831',
                //serverType: 'geoserver'
              })
            })
          ]
        }),
        parcelSource: new VectorSource(),

        windowLayers: null,
        windowSearch: null,
        windowPrint: null,
        windowDocs: null,
        windowNormativa: null,
        windowFeature: null,
        layersToggle: new Toggle({ 
          html: '<i class="fa fa-align-justify fa-lg"></i>',
          title: 'Gestor de capes',
          className: "layersToggle",
          onToggle: function(active) {
            if (active) {
              hideWindows("layers");
              pageData.windowLayers.show();
            }
            else {
              pageData.windowLayers.hide();
              $(".layersToggle").removeClass("ol-active");
            }
          }
        }),
        searchToggle: new Toggle({ 
          html: '<i class="fa fa-search fa-lg"></i>',
          title: 'Cercadors',
          className: "searchToggle",
          onToggle: function(active) {
            if (active) {
              hideWindows("search");
              pageData.windowSearch.show();
            }
            else {
              pageData.windowSearch.hide();
            }
          }
        }),
        printToggle: new Toggle({ 
          html: '<i class="fa fa-print fa-lg"></i>',
          title: 'Impressió',
          className: "printToggle",
          onToggle: function(active) {
            if (active) {
              hideWindows("print");
              pageData.windowPrint.show();
              selectPrintTemplate();
            }
            else {
              pageData.windowPrint.hide();
              cancelPrintBox();
            }
          }
        }),
        docsToggle: new Toggle({ 
          html: '<i class="fa fa-file-text-o fa-lg"></i>',
          title: 'Informació Planejament',
          className: "docsToggle",
          onToggle: function(active) {
            if (active) {
              hideWindows("docs");
              pageData.windowDocs.show();
            }
            else {
              pageData.windowDocs.hide();
            }
          }
        }),

        iconLayer: null,
        iconPoint: null,

        // vars for print
        printSource: null,
        printLayer: null,
        translatePrintBox: null,
        printTemplate: "plantilla_DIN_A4_horitzontal",

        // vars for measure functions
        measureActive: false,
        measureSource: new VectorSource(),
        mainBar: null, 
        subBar: null, 
        mainToggle: null,
        drawInteraction: null,
        measureTooltip: null,
        measureTooltipElement: null,
        helpTooltip: null,
        helpTooltipElement: null,
        sketch: null,
      });

      /*
       * Load QGIS Server/Mapproxy layers
       *****************************************/
      function loadLayers(layersData) {
        let layers = [];

        pageData.cadastreLayer = new TileLayer({
          title: 'Cadastre',
          visible: false,
          showlegend: true,
          source: new TileWMS({
            url: 'http://ovc.catastro.meh.es/Cartografia/WMS/ServidorWMS.aspx',
            params: {
              'LAYERS': 'catastro', 
              'TILED': true,
              'SRS': 'EPSG:3857'
            }
          })
        });
        layers.push(pageData.cadastreLayer);

        layersData.slice().reverse().forEach(function(layer, i) {

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

          let layerSource = new TileWMS({
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
          });

          // save qgisSource to query layer
          pageData.qgisSources[layer.qgisname] = new TileWMS({
            url: pageData.qgisServerURL,
            projection: 'EPSG:3857',
            params: {
              'LAYERS': layer.name,
              'TRANSPARENT': true,
              'VERSION': '1.3.0',
            },
            serverType: 'qgis',
            crossOrigin: 'Anonymous'
          });

          let newLayer = 
            new TileLayer({
              qgisname: layer.qgisname,
              mapproxy: layer.mapproxy,
              type: layer.type,
              source: layerSource,
              showlegend: layer.showlegend,
              visible: layer.visible,
              hidden: layer.hidden,
              children: layer.children,
              fields: layer.fields,
              indentifiable: layer.indentifiable,
            });

          // save reference to raster layer to get pixel values
          if (layer.name === "Zones a gestionar o protegir") {
            pageData.rasterLayer = newLayer;
          }

          if (!layer.name.startsWith("@"))
            newLayer.set("title", layer.name);
          layers.push(newLayer);
        });

        return layers;
      }

      function initMap(layersData) {
        // https://epsg.io/25831
        proj4.defs("EPSG:25831","+proj=utm +zone=31 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
        register(proj4);

        pageData.qgisLayers.setLayers(new Collection(loadLayers(layersData)));

        pageData.mapEle = document.getElementById('map');
        pageData.map = new Map({
          target: pageData.mapEle,
          layers: [
            pageData.baseLayers,
            //pageData.generalLayers,
            pageData.qgisLayers,
          ],
          view: new View({
            center: fromLonLat([pageData.center[0].lng, pageData.center[0].lat]),
            zoom: 10,
            minZoom: 9,
            maxZoom: 20,
            showFullExtent: true,
            extent: [25000, 5100000, 200000, 5280000]
          }),
        });

        const scaleLine = new ScaleLine({
          bar: true
        });
        pageData.map.addControl(scaleLine);

        // variables for layer switcher
        pageData.map.set("qgisServerURL", pageData.qgisServerURL);
        pageData.map.set("qgisProjectFile", pageData.qgisProjectFile);

        // search tool
        pageData.map.addLayer(
          new VectorLayer({
            source: pageData.parcelSource,
            style: new Style({
              stroke: new Stroke({
                color: 'yellow',
              width: 2
              }),
              fill: new Fill({
                color: 'rgba(255, 255, 0, 0.1)'
              })
            })
          })
        );

        // measure tool
        pageData.map.addLayer(
          new VectorLayer({
            source: pageData.measureSource,
            style: new Style({
              fill: new Fill({
                color: 'rgba(255, 255, 255, 0.2)'
              }),
              stroke: new Stroke({
                color: '#ffcc33',
                width: 2
              }),
              image: new Circle({
                radius: 7,
                fill: new Fill({
                    color: '#ffcc33'
                })
              })
            })
          })
        );

        initMeasureBar();

        /*
         * Interaction
         *****************************************/
        pageData.map.on('click', function(evt) {
          // hide selected catastro feature
          pageData.parcelSource.clear();

          if (!pageData.measureActive) {
            selectFeatureInfo(evt.coordinate);
          }
        });

        /*
         * DropFile Interaction
         *****************************************/
        let dropFileSource = new VectorSource({ wrapX: false });
        let dropFileLayer = new VectorLayer({
          source: dropFileSource,
        });
        pageData.map.addLayer(dropFileLayer);

        let dropInteraction = new DropFile({
          formatConstructors: [
            GPX,
            GeoJSON,
            KML,
            TopoJSON,
            GML
          ],
          accept: [
            "gpx",
            "json",
            "geojson",
            "kml",
            "topojson",
            "gml"
          ]
        });
        pageData.map.addInteraction(dropInteraction);
        let loading = 0;
        
        // Drag and drop
        dropInteraction.on('loadstart', function (e) {
          if (!loading) dropFileSource.clear();
          
          loading++; 
          $(".loading").show();
          $(".loading p").html("LOADING ("+loading+")");

          // shape file
          // https://gis.stackexchange.com/a/368103/60146
          if (e.filetype === "application/zip") {
            console.log("file dropped -> loading SHP file");

            const files = event.dataTransfer.files;
            for (let i = 0, ii = files.length; i < ii; ++i) {
              const file = files.item(i);
              loadshp({url: file, encoding: 'utf-8'}, function(geojson) {
                const features = new GeoJSON().readFeatures(
                  geojson,
                  { featureProjection: pageData.map.getView().getProjection() }
                );
                const vectorSource = new VectorSource({
                  features: features
                });
                pageData.map.addLayer(
                  new VectorLayer({
                    source: vectorSource
                  })
                );
                //pageData.map.getView().fit(vectorSource.getExtent(), { padding: [100,100,100,100] });
              });
            }
            loading--;
            $(".loading").hide();
          }
        });

        dropInteraction.on('loadend', function (e) {
          if (e.file.type === "application/gml+xml") {
            console.log("file dropped -> loading GML file");

            let gmlFormat = new GML32();
            let features = gmlFormat.readFeatures(e.result, {
              dataProjection: pageData.proj25831,
              featureProjection: 'EPSG:3857'
            });
            
            const vectorSource = new VectorSource({
              features: features
            });
            pageData.map.addLayer(
              new VectorLayer({
                source: vectorSource
              })
            );
            pageData.map.getView().fit(vectorSource.getExtent(), { padding: [100,100,100,100] });

            loading--;
            $(".loading").hide();
          }
        });

        dropInteraction.on('addfeatures', function(event) {
          // geojson, KML, etc.
          console.log("file dropped -> loading Vector features from GeoJSON, KML, etc. file");

          let features = event.features;
          loading--; 

          $(".loading p").html("LOADING ("+loading+")");
          $(".loading span").html(features.length);

          setTimeout(function(){
            dropFileSource.addFeatures(features);
            
            if (!loading) $(".loading").hide();

            let vext = pageData.map.getView().getProjection().getExtent();
            let extent = dropFileSource.getExtent();
            if (extent[0]<vext[0]) extent[0] = vext[0];
            if (extent[1]<vext[1]) extent[1] = vext[1];
            if (extent[2]>vext[2]) extent[2] = vext[2];
            if (extent[3]>vext[3]) extent[3] = vext[3];
            pageData.map.getView().fit(extent, pageData.map.getSize(), { padding: [100,100,100,100] });
          },500);
        });

        $(document).keyup(function(e) {
          if (e.keyCode === 27) { // escape

            removeMeasure();

            // hide feature window
            pageData.windowFeature.hide();
            if (pageData.iconLayer) {
              pageData.iconPoint.setCoordinates([]);
            }

            // hide selected catastro feature
            pageData.parcelSource.clear();

            // hide printable area
            if (!$(".printWindow").is(':visible'))
              cancelPrintBox();
          }
        });

        $("#windowPrint").on("change", "#printSize", function(){
          selectPrintTemplate();
        });
        $("#windowPrint").on("change", "#printScale", function(){
          selectPrintTemplate();
        });
        $("#windowPrint").on("click", ".btn-cancel", function(){
          cancelPrintBox();
          pageData.windowPrint.hide();
          pageData.printToggle.setActive(false);
        });
        $(".printWindow").on("click", ".ol-closebox", function(){
          cancelPrintBox();
        });
        $("#windowPrint").on("click", ".btn-print", function(){
          printMap();
        });

        $("#windowSearch").on("click", ".btnReferencia", function(){
          if ($("#searchReferencia").val() !== "")
            searchCatastro($("#searchReferencia").val());
        });
      }

      function selectFeatureInfo(coordinates) {

        //console.log(coordinates);
        showIcon(coordinates);

        $("#windowFeature .content-layers").empty();
        $("#windowFeature .content-catastro").empty();
        $("#windowFeature .content-limits").empty();
        $("#windowFeature .content-coord").empty();

        pageData.qgisLayers.getLayers().forEach(function(layerObj) {

          //console.log(layerObj.get('qgisname'), layerObj.getVisible());

          let cssId = makeSafeForCSS(layerObj.get('qgisname'));
            
          // add link to PDF for some layers
          if (layerObj.getVisible() && (layerObj.get("qgisname") === "Zones vulnerables" || layerObj.get("qgisname") === "Exposició visual")) {

            $("#windowFeature .content-layers").append('<div class="layer-'+cssId+'"></div>');
            $("#windowFeature .content-layers .layer-"+cssId).append('<h3>'+layerObj.get('qgisname')+'</h3><ul class="list">');

            let infoLink = "";
            if (layerObj.get("qgisname") === "Zones vulnerables")
              infoLink = "https://www.geoparcorigens.cat/wp-content/uploads/2022/11/Descripcio_zones_vulnerables_exposicio_visual.pdf#page=1";
            else if (layerObj.get("qgisname") === "Exposició visual")
              infoLink = "https://www.geoparcorigens.cat/wp-content/uploads/2022/11/Descripcio_zones_vulnerables_exposicio_visual.pdf#page=6";
            $("#windowFeature .content-layers .layer-"+cssId+" .list").append('<li><span class="field-content"><a href="'+infoLink+'" target="_blank">Descripció llegenda</a></span></li>');
          }

          // getFeatureInfo for every layer/group
          if ((layerObj.getVisible() && layerObj.get("indentifiable")) || (layerObj.getVisible() && layerObj.get("type") === "group")) {

            let url = pageData.qgisSources[layerObj.get('qgisname')].getFeatureInfoUrl(
              coordinates, 
              pageData.map.getView().getResolution(), 
              pageData.map.getView().getProjection(),
              { 'INFO_FORMAT': 'text/xml' }
            );

            if (url) {
              url += "&MAP=" +pageData.qgisProjectFile;
              console.log(layerObj.get('qgisname'), url);

              fetch(url, {
                mode: 'same-origin', // no-cors, *cors, same-origin
              })
              .then((response) => response.text())
              .then((xml) => {

                let xmlDoc = $.parseXML(xml), 
                    $xml = $(xmlDoc);

                let i = 0;
                // for each Layer
                $($xml.find('Layer')).each(function(){
                  let layer = $(this),
                      layerName = layer.attr('name'),
                      htmlDiv = '<div class="layer-'+cssId+'-'+i+'"></div>',
                      htmlTitle = '<h3>'+layerName+'</h3><ul class="list">',
                      htmlLi = '';

                  // for each Feature
                  $(layer.find('Feature')).each(function(){

                    if ($(this).children().length > 0) {

                      // for each Attribute
                      $(this).find("Attribute").each(function(j, elem){
                        let name = $(elem).attr("name"),
                            value = $(elem).attr("value");

                        // only show fields which do show up in JSON
                        if (fieldIsVisible(name, layerName, layerObj)) {

                          // check if NULL
                          if (value === "NULL")
                            value = "";
                          // check if url
                          if (value && value.startsWith("http"))
                            value = '<a href="'+value+'" target="_blank">'+value+'</a>';
                          // check if float
                          if(!isNaN(parseFloat(value)))
                            // check if has decimals
                            if (value % 1 != 0)
                              value = parseFloat(value).toLocaleString('es-ES', { decimal: ',', useGrouping: false, minimumFractionDigits: 2, maximumFractionDigits: 2 });

                          if (value !== "")
                            htmlLi += '<li>'+name+': <span class="field-content">'+value+'</span></li>';
                        }
                      });
                    }
                  });

                  if (htmlLi != '' && pageData.iconPoint.getCoordinates()[0] === coordinates[0] && pageData.iconPoint.getCoordinates()[1] === coordinates[1]) {

                    // put limit layers at the bottom of the window
                    if (layerObj.get("qgisname") === "Limit administratiu") {
                      $("#windowFeature .content-limits").append(htmlDiv);
                      $("#windowFeature .content-limits .layer-"+cssId+'-'+i).append(htmlTitle);
                      $("#windowFeature .content-limits .layer-"+cssId+'-'+i+" .list").append(htmlLi);
                    }
                    else {
                      $("#windowFeature .content-layers").append(htmlDiv);
                      $("#windowFeature .content-layers .layer-"+cssId+'-'+i).append(htmlTitle);
                      $("#windowFeature .content-layers .layer-"+cssId+'-'+i+" .list").append(htmlLi);
                    }
                  }

                  i++;
                });
              });
            }
          }
        });

        if (pageData.cadastreLayer.getVisible()) {

          const url = pageData.cadastreLayer.getSource().getFeatureInfoUrl(
            coordinates,
            pageData.map.getView().getResolution(), 
            pageData.map.getView().getProjection(),
            {'INFO_FORMAT': 'text/xml'}
          );
          
          if (url) {
            //console.log(url);

            $.ajax({
              url: 'https://mapa.psig.es/geoparc-planejament/getUrlCadastre.php',
              type: 'get',
              data: {
                url: url
              },
              dataType: 'html',
              success: function(response){
                let html = "<h3>Cadastre</h3>" + response;
                $('#windowFeature .content-catastro').append(html);
              }
            });
          }
        }

        addCoordinatesInfo(coordinates);
        pageData.windowFeature.show();
      }

      function fieldIsVisible(fieldName, layerName, layerGroup) {
        if (layerGroup.get("type") === "group") {
          // group
          for (let i=0; i<layerGroup.get("children").length; i++) {
            let childLayer = layerGroup.get("children")[i];
            if (layerName === childLayer["name"] && fieldIsVisibleInLayer(fieldName, childLayer)) {
              return true;
            }
          }
          return false;
        }
        else {
          // layer
          return fieldIsVisibleInLayer(fieldName, layerGroup["values_"]);
        }
      }

      function fieldIsVisibleInLayer(fieldName, childLayer) {
        if (childLayer["indentifiable"] && childLayer.hasOwnProperty("fields")) {
          return (childLayer["fields"].find(function (element) {
            return (element.name === fieldName)
          }) !== undefined);
        }
        return false;
      }

      // add coordinates to info window
      function addCoordinatesInfo(coordinates) {
        $("#windowFeature .content-coord").append('<h3>Coordenades identificades</h3>');
        $("#windowFeature .content-coord").append('<ul class="list">');

        let coords = transform(coordinates, 'EPSG:3857', getProjection('EPSG:25831'));
      
        $("#windowFeature .content-coord .list").append('<li><em>EPSG 25831</em>: X=' + coords[0].toLocaleString('es-ES', { decimal: ',', useGrouping: false, minimumFractionDigits: 0, maximumFractionDigits: 0 }) + ' Y=' + coords[1].toLocaleString('es-ES', { decimal: ',', useGrouping: false, minimumFractionDigits: 0, maximumFractionDigits: 0 }) + '</li>');
      }

      // draw icon on coord
      function showIcon(coord) {
        if (pageData.iconLayer === null) {
          pageData.iconPoint = new Point(coord);
          pageData.iconLayer = new VectorLayer({
            source: new VectorSource({
              features: [
                new Feature({
                      geometry: pageData.iconPoint,
                })
              ]
            }),
            style: new Style({
              image: new Icon(/** @type {olx.style.IconOptions} */ ({
                anchor: [0.5, 0],
                anchorOrigin: 'bottom-left',
                color: [255,0,0,1],
                src: 'marker.png'
              }))
            })
          });
          pageData.map.addLayer(pageData.iconLayer);
        }
        else {
          pageData.iconPoint.setCoordinates(coord);
        }
      }

      /*
       * Print
       *****************************************/
      function selectPrintTemplate() {
        // select values
        let paper = $("#printSize").val(),
            dim = $("#printSize option:selected").data("dim"),
            scale = parseInt($("#printScale").val()),
            resolution = 120;

        if (paper === "a4_hor") {
          pageData.printTemplate = "plantilla_DIN_A4_horitzontal";
        }
        else if (paper === "a3_hor") {
          pageData.printTemplate = "plantilla_DIN_A3_horitzontal";
        }

        console.log(paper, dim, scale, pageData.printTemplate);

        if (pageData.printSource) {
          pageData.printSource.clear();
        }
        initPrintBox();

        return false;
      }

      // actual screen scale
      // https://gis.stackexchange.com/questions/242424/how-to-get-map-units-to-find-current-scale-in-openlayers
      function screenScale() {
        let unit = pageData.map.getView().getProjection().getUnits(),
            resolution = pageData.map.getView().getResolution(),
            inchesPerMetre = 39.3700787,
            dpi = 96;

        return resolution * METERS_PER_UNIT[unit] * inchesPerMetre * dpi;
      }

      // print map resolution in m/px
      // https://gis.stackexchange.com/questions/158435/how-to-get-current-scale-in-openlayers-3#answer-158518
      function printResolution(scale) {
        let unit = pageData.map.getView().getProjection().getUnits(),
            inchesPerMetre = 39.3700787,
            dpi = 120;

        return scale / (METERS_PER_UNIT[unit] * inchesPerMetre * dpi);
      }

      function initPrintBox() {

        let size = $("#printSize option:selected").data("dim"),
            scale = $("#printScale").val(),
            w = Number(size[0])*printResolution(scale)/screenScale()*18000,
            h = Number(size[1])*printResolution(scale)/screenScale()*18000;

        let bounds = pageData.map.getView().calculateExtent([w,h]),
            printBox = [
              [bounds[0], bounds[1]],
              [bounds[0], bounds[3]],
              [bounds[2], bounds[3]],
              [bounds[2], bounds[1]],
              [bounds[0], bounds[1]]
            ],
            printPolygon = new Polygon([printBox]),
            printFeature = new Feature(printPolygon);

        /*printFeature.on('change',function(){
          console.log('Feature Moved To:' + this.getGeometry().getCoordinates());
        },printFeature);*/

        pageData.printSource = new VectorSource({wrapX: false});
        pageData.printSource.addFeature(printFeature);

        pageData.printLayer = new VectorLayer({
          source: pageData.printSource,
          zIndex: 1000,
          style: new Style({
            fill: new Fill({
              color: 'rgba(88,38,123,0.3)' 
            }),
            stroke: new Stroke({
              color: 'rgb(88,38,123)',
              width: 2
            })
          })
        });
        pageData.map.addLayer(pageData.printLayer);

        // make box draggable
        pageData.translatePrintBox = new Translate({
          layer: [pageData.printLayer]
        });

        pageData.printLayer.setVisible(true);
        pageData.map.addInteraction(pageData.translatePrintBox);
      }

      function cancelPrintBox() {
        if (pageData.printSource) {
          pageData.map.removeInteraction(pageData.translatePrintBox);
          pageData.printSource.clear();
          pageData.printLayer.setVisible(false);
        }
      }

      function printMap() {
        // print selected area
        $(this).attr("target", "_blank");

        // get visible layers
        let visibleLayers = [];
        LayerSwitcherWithLegend.forEachRecursive(pageData.map, function(layer) {
          if (layer.getVisible()) {
            if (layer.get("qgisname"))
              visibleLayers.push(layer.get("title"));
            else if (layer.get('type') === 'base' && layer.get("title") !== 'Ningú')
              visibleLayers.push("¡" + layer.get("title"));
          }
        });

        let url = pageData.qgisServerURL + '?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetPrint&FORMAT=pdf&TRANSPARENT=true&LAYERS=' + visibleLayers.toString()+'&CRS=EPSG:3857&map0:STYLES=&map0:extent=' + pageData.printSource.getExtent()+'&TEMPLATE=' + pageData.printTemplate + '&DPI=120&map0:scale=' + $("#printScale").val() + "&MAP=" + pageData.qgisProjectFile;

        console.log(url);

        window.open(url, "Geoparc Orígens als Pirineus Catalans");
      }

      function searchCatastro(refcat) {
        let catastroUrl = 'http://ovc.catastro.meh.es/INSPIRE/wfsCP.aspx?service=wfs&version=2&request=getfeature&STOREDQUERIE_ID=GetParcel&srsname=EPSG::25831&refcat='+refcat;
        catastroUrl = 'nocors.php?url=' + encodeURIComponent(catastroUrl);

        fetch(catastroUrl)
          .then((response) => response.text())
          .then((xml) => {
            let xmlDoc = $.parseXML(xml), 
              $xml = $(xmlDoc);

            let parcel = $xml.find('cp\\:CadastralParcel');
            let coords = $(parcel.find('gml\\:posList'));

            let coordsWKT = coords.text().split(' ');

            let coordsStr = '';
            for (let i=0; i<coordsWKT.length; i+=2) {
              coordsStr += coordsWKT[i]+' '+coordsWKT[i+1]+',';
            }
            coordsStr = coordsStr.slice(0, coordsStr.length-1);

            const wkt = 'POLYGON(('+coordsStr+'))';

            let feature = new WKT().readFeature(wkt, {
              dataProjection: pageData.proj25831,
              featureProjection: 'EPSG:3857',
            });
            pageData.parcelSource.clear();
            pageData.parcelSource.addFeature(feature);

            pageData.map.getView().fit(feature.getGeometry().getExtent(), {
              padding: [200, 200, 200, 200],
              duration: 2000,
              easing: easeOut
            });

            // add reference point
            let reference = $xml.find('cp\\:referencePoint'),
                coordsRef = $(reference.find('gml\\:pos')),
                coordsArr = coordsRef.text().split(' ');
            coordsArr = [parseFloat(coordsArr[0]), parseFloat(coordsArr[1])];
            coordsArr = transform(coordsArr, getProjection('EPSG:25831'), 'EPSG:3857');
            selectFeatureInfo(coordsArr);
          });
      }

      /*
       * Measure bar
       *****************************************/
      function initMeasureBar() {
        pageData.subBar = new Bar({ 
          toggleOne: true,
          autoDeactivate: true,
          controls: [ 
            new Toggle({ 
              html:'<i class="fg-measure-line"></i>',
              onToggle: function(b) { 
                pageData.measureActive = b;
                enableInteraction(b, true);
              } 
            }),
            new Toggle({ 
              html:'<i class="fg-measure-area"></i>', 
              onToggle: function(b) { 
                pageData.measureActive = b;
                enableInteraction(b, false);
              }
            })
          ]
        });
        pageData.mainToggle = new Toggle({ 
          html: '<i class="fg-measure"></i>',
          bar: pageData.subBar,
          onToggle: function(b) {
            if (!b) {
              removeMeasure();
              //this.toggle();
            }
          }
        });
        pageData.mainBar = new Bar({ 
          autoDeactivate: true,
          controls: [pageData.mainToggle],
          className: "ol-top ol-right measureBar"
        });
        pageData.map.addControl( pageData.mainBar );
      }

      function enableInteraction(enable, distance) {
        enable ? addInteraction(distance) : removeMeasure();
      }

      function addInteraction(distance) {
        let type = (distance ? 'LineString' : 'Polygon');

        if (pageData.drawInteraction)
          pageData.map.removeInteraction(pageData.drawInteraction);

        pageData.drawInteraction = new Draw({
          source: pageData.measureSource,
          type: type,
          style: new Style({
            fill: new Fill({
              color: 'rgba(255, 255, 255, 0.2)'
            }),
            stroke: new Stroke({
              color: 'rgba(0, 0, 0, 0.5)',
              lineDash: [10, 10],
              width: 2
            }),
            image: new Circle({
              radius: 5,
              stroke: new Stroke({
                color: 'rgba(0, 0, 0, 0.7)'
              }),
              fill: new Fill({
                color: 'rgba(255, 255, 255, 0.2)'
              })
            })
          })
        });

        pageData.map.addInteraction(pageData.drawInteraction);

        createMeasureTooltip();
        createHelpTooltip();

        let listener;

        pageData.drawInteraction.on('drawstart', function(evt) {
          pageData.sketch = evt.feature;
          let tooltipCoord = evt.coordinate;

          listener = pageData.sketch.getGeometry().on('change', function(evt) {
            let geom = evt.target;
            let output;
            if (geom instanceof Polygon) {
              output = formatArea(geom);
              tooltipCoord = geom.getInteriorPoint().getCoordinates();
            } else if (geom instanceof LineString) {
              output = formatLength(geom);
              tooltipCoord = geom.getLastCoordinate();
            }
            pageData.measureTooltipElement.innerHTML = output;
            pageData.measureTooltip.setPosition(tooltipCoord);
          });
        }, this);

        pageData.drawInteraction.on('drawend', function() {
          pageData.measureTooltipElement.className = 'tooltip tooltip-static';
          pageData.measureTooltip.setOffset([0, -7]);
          pageData.sketch = null;
          pageData.measureTooltipElement = null;
          createMeasureTooltip();
          unByKey(listener);
        }, this);
      }

      function removeMeasure() {
        // hide measure tools
        pageData.measureActive = false;
        if (pageData.drawInteraction)
          pageData.map.removeInteraction(pageData.drawInteraction);
        if (pageData.measureTooltip)
          pageData.map.removeOverlay(pageData.measureTooltip);
        if (pageData.helpTooltip)
          removeHelpTooltip();
        $('.tooltip').addClass('hidden');
        pageData.mainToggle.setActive(false);
        pageData.measureSource.clear();
      }

      function createHelpTooltip() {
        removeHelpTooltip();
        pageData.helpTooltipElement = document.createElement('div');
        pageData.helpTooltipElement.className = 'tooltip hidden';
        pageData.helpTooltip = new OverlayOL({
          element: pageData.helpTooltipElement,
          offset: [15, 0],
          positioning: 'center-left'
        });
        pageData.map.addOverlay(pageData.helpTooltip);

        pageData.map.getViewport().addEventListener('mouseout', helpTooltipEventListener);
      }

      let helpTooltipEventListener = function() {
        pageData.helpTooltipElement.classList.add('hidden');
      }

      function removeHelpTooltip() {
        pageData.map.removeOverlay(pageData.helpTooltip);
        pageData.map.getViewport().removeEventListener('mouseout', helpTooltipEventListener);
      }

      function createMeasureTooltip() {
        if (pageData.measureTooltipElement) {
          pageData.measureTooltipElement.parentNode.removeChild(pageData.measureTooltipElement);
        }
        pageData.measureTooltipElement = document.createElement('div');
        pageData.measureTooltipElement.className = 'tooltip tooltip-measure';
        pageData.measureTooltip = new OverlayOL({
          element: pageData.measureTooltipElement,
          offset: [0, -15],
          positioning: 'bottom-center'
        });
        pageData.map.addOverlay(pageData.measureTooltip);
      }

      let pointerMoveHandler = function(evt) {
        if (evt.dragging) {
          return;
        }

        if (sketch) {
          let geom = (sketch.getGeometry());
          if (geom instanceof Polygon) {
            helpMsg = continuePolygonMsg;
          } else if (geom instanceof LineString) {
            helpMsg = continueLineMsg;
          }
        }

        if (helpTooltipElement && helpTooltipElement !== undefined) {
          helpTooltipElement.innerHTML = helpMsg;
          helpTooltip.setPosition(evt.coordinate);
          helpTooltipElement.classList.remove('hidden');
        }
      };

      let formatLength = function(line) {
        let length = getLength(line);
        let output;
        if (length > 100) {
          output = (Math.round(length / 1000 * 100) / 100) +
              ' ' + 'km';
        } else {
          output = (Math.round(length * 100) / 100) +
              ' ' + 'm';
        }
        return output;
      };  

      let formatArea = function(polygon) {
        let area = getArea(polygon);
        let output;
        if (area > 10000) {
          output = (Math.round(area / 1000000 * 100) / 100) +
              ' ' + 'km<sup>2</sup>';
        } else {
          output = (Math.round(area * 100) / 100) +
              ' ' + 'm<sup>2</sup>';
        }
        return output;
      };

      /*
       * Menu
       *****************************************/
      function initMenu() {
        pageData.windowLayers = new Overlay({
          closeBox : true,
          className: "slide-left window layersWindow",
          content: document.getElementById("windowLayers")
        })
        pageData.map.addControl(pageData.windowLayers);

        LayerSwitcherWithLegend.renderPanel(pageData.map, document.getElementById("layerSwitcher"), { reverse: true, groupSelectStyle: 'none' });

        pageData.windowSearch = new Overlay({
          closeBox : true,
          className: "slide-left window searchWindow",
          content: document.getElementById("windowSearch")
        })
        pageData.map.addControl(pageData.windowSearch);

        pageData.windowPrint = new Overlay({
          closeBox : true,
          className: "slide-left window printWindow",
          content: document.getElementById("windowPrint")
        })
        pageData.map.addControl(pageData.windowPrint);

        pageData.windowDocs = new Overlay({
          closeBox : true,
          className: "slide-left window docsWindow",
          content: document.getElementById("windowDocs")
        });
        pageData.map.addControl(pageData.windowDocs);

        $(".normativa-button").on("click", function(){
          pageData.windowDocs.hide();
          pageData.windowNormativa.show();
          return false;
        });

        pageData.windowNormativa = new Overlay({
          closeBox : true,
          className: "slide-left window normativaWindow",
          content: document.getElementById("windowNormativa")
        });
        pageData.map.addControl(pageData.windowNormativa);

        pageData.windowFeature = new Overlay({
          closeBox : true,
          className: "slide-right window infoWindow",
          content: document.getElementById("windowFeature")
        })
        pageData.map.addControl(pageData.windowFeature);
        pageData.windowFeature.on("change:visible", function(e) {
          if (!e.visible && pageData.iconLayer) {
            pageData.iconPoint.setCoordinates([]);
          }
        });

        let menuBar = new Bar({
          className: "ol-top ol-left menuBar"
        });
        pageData.map.addControl(menuBar);

        let actionBar = new Bar({ toggleOne: true, group: true });
        menuBar.addControl(actionBar);

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
        actionBar.addControl(logoBtn);

        let logoUnescoBtn = new Button({ 
          html: '<img src="logo-unesco.png" />',
          className: "logo logo2",
          title: "UNESCO Global Geoparks",
          handleClick: function() { 
            window.location.href = "https://en.unesco.org/global-geoparks";
          }
        });
        actionBar.addControl(logoUnescoBtn);

        actionBar.addControl(pageData.layersToggle);
        actionBar.addControl(pageData.searchToggle);
        actionBar.addControl(pageData.printToggle);
        actionBar.addControl(pageData.docsToggle);

        // normativas tree view
        $('.tree li').each( function() {
          if( $(this).children('ul').length > 0) {
            $(this).addClass('parent');
            $(this).children('ul').slideToggle('fast');
          }
        });
     
        $('.tree li.parent > a').click(function() {
          $(this).parent().toggleClass('active');
          $(this).parent().children('ul').slideToggle('fast');
        });
     
        $('#all').click(function() {
          $('.tree li').each(function() {
            $(this).toggleClass('active');
            $(this).children('ul').slideToggle('fast');
          });
        });
      }

      function hideWindows(activeToggle) {
        pageData.windowLayers.hide();
        pageData.windowSearch.hide();
        pageData.windowPrint.hide();
        pageData.windowDocs.hide();
        pageData.windowNormativa.hide();

        if (activeToggle !== "docs")
          pageData.docsToggle.setActive(false);
        else if (activeToggle !== "layers")
          pageData.layersToggle.setActive(false);
        else if (activeToggle !== "search")
          pageData.searchToggle.setActive(false);
        else if (activeToggle !== "print")
          pageData.printToggle.setActive(false);
      }

      /*
       * Init
       *****************************************/
      function init() {
        pageData.windowLayers.show();
        pageData.layersToggle.setActive(true);
      }

      onMounted(()=>{

        // load layers configuration file
        $.getJSON( "js/data/geoparc-planejament.qgs.json", function() {})
        .done(function(data) {
          initMap(data);
          initMenu();
          init();
        })
        .fail(function() {
          console.log( "error loading JSON file" );
        });
      })

      onBeforeUnmount(()=>{
        //clearMap();
      })

      function clearMap() {
        console.log("clear");
        document.getElementById('map').innerHTML = '';
        pageData.mapEle = null;
        pageData.map = null;
      }

      return {
        ...toRefs(pageData)
      }
    }
  }
</script>

<style lang="css" scoped>
#map {
  width: 100%;
  height: 100%;
}
</style>

<style lang="css">
@import '/public/fonts/font.css';

#app #map {
  margin: 0;
  height: 100%;
  font-family: graphic-regular, sans-serif;
  color: #4f1c23;
}

.ol-zoom {
  left: auto;
  right: .5em;
}

.logo button {
  width: auto;
  height: auto;
}
.logo img {
  width: 180px;
}
.logo2 img {
  width: 90px;
  margin-left: 20px;
}

.ol-control {
  padding: 0;
}
.ol-control.ol-toggle button {
  cursor: pointer;
}
.ol-control.ol-bar.ol-left .ol-group {
  margin: 0;
}
.menuBar.ol-control.ol-bar.ol-top.ol-left {
  top: .5em;
  border: 2px solid #b2b019;
  border-radius: 0;
  width: 440px;
  max-width: 95%;
}
.ol-touch .ol-control.ol-bar.ol-top.ol-left, .ol-touch .ol-control.ol-bar.ol-top.ol-right {
  top: .5em;
}
.menuBar.ol-control.ol-bar.ol-left .ol-control,
.menuBar.ol-control.ol-bar.ol-right .ol-control {
  display: inline-block;
}
.menuBar.ol-control.ol-bar .ol-control.ol-toggle {
  margin: 6px;
}
.menuBar.ol-control.ol-bar .ol-control.ol-toggle.layersToggle {
  margin-left: 20px;
}
.menuBar.ol-bar .ol-control button {
  background-color: transparent;
}
.menuBar.ol-control.ol-bar .ol-toggle.ol-active > button,
.menuBar.ol-control.ol-bar .ol-toggle.ol-active button:hover i {
  background-color: transparent;
  color: #b2b019;
}
.ol-control.ol-bar .ol-toggle.ol-active > button {
  background-color: #b2b019;
}
.ol-control button i {
  pointer-events: none;
  color: #4f1c23;
}

.ol-control button {
  cursor: pointer;
  background-color: #aaa;
  border-radius: 0;
}
.ol-control button:hover {
  background-color: #777;
}
.ol-group .ol-bar .ol-control button {
  background-color: transparent;
}
.menuBar.ol-bar .ol-control button:hover i, 
.menuBar.ol-bar .ol-control button:focus i {
  color: #b2b019;
  background-color: transparent;
}

.ol-zoom .ol-zoom-in,
.ol-zoom .ol-zoom-out {
  border-radius: 0;
}

.ol-control.ol-bar .ol-control.ol-button.twitter {
  margin-left: 15px;
}

.ol-control.ol-bar.ol-left .ol-group .ol-control:last-child > button {
  border-radius: 0;
}

.ol-overlay.window { 
  width: 444px;
  max-width: 95%;
  background: #fff;
  color: #333;
  padding: 0.5em;
  -webkit-transition: all 0.25s;
  transition: all 0.25s;
  top: 6em;
  height: auto;
  min-height: 500px;
  bottom: unset;
  border: 2px solid #b2b019;
}

.ol-overlay.window {
  left: 0.5em;
  padding: 0;
}
.ol-overlay.infoWindow {
  left: auto;
  right: 0.5em;
  padding: 0;
}
.ol-touch .ol-overlay.infoWindow {
  left: .5em;
  right: auto;
}

.ol-overlay.window .ol-closebox { 
  color: #fff;
  right: 5px;
  top: 5px;
}
.ol-overlay.window .ol-closebox:before { 
  content: "\f00d";
  font-family: FontAwesome;
}
#menu { 
  padding-top: 1.5em;
  font-size: 0.9em;
}

.window h2 {
  color: #ffffff;
  background-color: #b2b019;
  margin: 0;
  padding: .3em;
  font-size: 16px;
  font-family: graphic-semibold, sans-serif;
  text-transform: uppercase;
  position: relative;
}

h3 {
  font-size: 16px;
  font-family: graphic-semibold, sans-serif;
  border-bottom: 1px solid #4f1c23;
}

.window .content {
  padding: 20px;
}

#windowNormativa .content {
  padding: 0;
}

.window .content p {
  margin-top: 0;
}

.window .title {
  margin-left: 5px;
}

#windowDocs .label,
#windowApp .label {
  font-style: italic;
}

#windowFeature, 
#windowLayers {
  height: 550px;
}

.ol-overlay.normativaWindow {
  width: 1160px;
  height: 600px;
}

#windowFeature .content,
#windowLayers .content {
  overflow: scroll;
  height: 90%;
}

#windowFeature .label {
  text-decoration: underline;
}
#windowFeature .content .list {
  margin: 0;
  list-style: none;
  padding-left: 0;
  color: #777;
}

#windowFeature .content .list .field-content {
  color: rgb(51, 51, 51);
}

.app-icon {
  vertical-align: top;
}

.tab-left {
  padding-left: 25px;
}

.layer-switcher {
  position: relative;
  top: auto;
  right: auto;
}
.layer-switcher ul {
  margin: 0;
}
.layer-switcher ul ul {
  padding-left: 0;
}
.layer-switcher li.group + li.group {
  margin-top: 1em;
}
.layer-switcher li.group > label {
  font-family: graphic-semibold, sans-serif;
  border-bottom: 1px solid #4f1c23;;
  display: block;
  padding-left: 0;
}
.layer-switcher li.layer {
  width: 100%;
  display: table;
}
li.layer label {
  display: unset;
}
li.layer i {
  float: right;
  cursor: pointer;
}
img.legend {
  padding-left: 20px;
  display: none;
  max-width: 100%;
}

li.layer img.legend,
li.layer._nivell-de-protecci__00f3-d__2019espais-oberts img.legend:nth-of-type(2) {
  position: relative;
  margin-top: -10px;
  z-index: -1;
}
li.layer._nivell-de-protecci__00f3-d__2019espais-oberts img.legend:nth-of-type(2) {
  z-index: -2;
}
li.layer._planejament-urban__00edstic img.legend,
li.layer._cadastre img.legend {
  margin-top: 0;
}
li.layer._limit-administratiu img.legend:nth-of-type(2) {
  z-index: -2;
}
li.layer._limit-administratiu img.legend:nth-of-type(3) {
  z-index: -3;
}

.layer-switcher li input {
  left: 0;
}
.layer-switcher li label {
  padding-left: 1.5em;
}

#searchMsg {
  color: #ff0000;
}

.measureBar.ol-control.ol-bar {
  top: 4em !important;
  min-height: 1.8em !important;
}
.measureBar .ol-option-bar button {
  background-color: transparent;
}
.tooltip {
  position: relative;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 0;
  color: white;
  padding: 4px 8px;
  opacity: 0.7;
  white-space: nowrap;
}
.tooltip-measure {
  opacity: 1;
  font-weight: bold;
}
.tooltip-static {
  background-color: #ffcc33;
  color: #4f1c23;
  border: 1px solid white;
}
.tooltip-measure:before,
.tooltip-static:before {
  border-top: 6px solid rgba(0, 0, 0, 0.5);
  border-right: 6px solid transparent;
  border-left: 6px solid transparent;
  content: "";
  position: absolute;
  bottom: -6px;
  margin-left: -7px;
  left: 50%;
}
.tooltip-static:before {
  border-top-color: #ffcc33;
}
.hidden {
  display: none;
}

.loading {
  display: none;
  background: #fff;
  border: 2px solid #369;
  left: 50%;
  margin: -2em -100px;
  padding: 0.5em;
  position: fixed;
  text-align: center;
  top: 50%;
  width: 200px;
  z-index: 1;
  box-sizing: border-box;
  box-shadow: 2px 2px 4px rgba(0,0,0,0.5);
}

#printSize, #printScale {
  width: 100%;
}

.btn {
  border-radius: 0;
  box-shadow: none;
  border: none;
  background-color: #b2b019;
  color: #fff;
  margin: 2px;
  padding: 6px 12px;
}
.btn:hover {
  background-color: #868484;
  color: #fff;
  border: none;
  text-decoration: none;
  cursor: pointer;
}

/* iframe and tree view */
.rpucframe {
  width: 960px;
  margin-left: 200px;
}
.tree {
  font-size: 14px;
  width: 200px;
  float: left;
}
.tree ul {
  list-style: none outside none;
  padding: 0;
}
.tree li a {
  line-height: 16px;
}
.tree > ul > li > a {
  color: #3B4C56;
  display: block;
  font-weight: normal;
  position: relative;
  text-decoration: none;
}
.tree li.parent > a {
  padding: 0 0 0 28px;
}
.tree li.parent > a:before {
  background-image: url("/jstree.png");
  background-position: -3px -7px;
  content: "";
  display: block;
  height: 25px;
  left: 0;
  position: absolute;
  top: 2px;
  vertical-align: middle;
  width: 18px;
}
.tree ul li.active > a:before {
  background-position: -35px -7px;
}
.tree ul li ul {
  border-left: 1px solid #D9DADB;
  display: none;
  margin: 0 0 0 12px;
  overflow: hidden;
  padding: 0 0 0 25px;
}
.tree ul li ul li {
  position: relative;
}
.tree ul li ul li:before {
  border-bottom: 1px dashed #E2E2E3;
  content: "";
  left: -20px;
  position: absolute;
  top: 12px;
  width: 15px;
}

@media only screen and (max-width: 420px) {
  .menuBar.ol-control.ol-bar.ol-top.ol-left {
    max-width: 85%;
  }
  .menuBar.ol-control.ol-bar .ol-control.ol-toggle.layersToggle {
    margin-left: 20px;
  }
}
</style>