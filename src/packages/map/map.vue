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
      <span class="title">Llistat POIs</span>
    </h2>
    <div class="content">
      <div id="datatable-pois"></div>
    </div>
  </div>

  <div id="windowTableRutas" class="window">
    <h2>
      <i class="fa fa-map-o"></i>
      <span class="title">Llistat Georutes</span>
    </h2>
    <div class="content">
      <div id="datatable-rutas"></div>
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
  import { ScaleLine, FullScreen, defaults as defaultControls } from 'ol/control';
  import { Point, Polygon, LineString } from 'ol/geom';
  import { Style, Icon, Text, Circle, Fill, Stroke } from 'ol/style';
  import { register } from 'ol/proj/proj4';
  import { Projection, get as getProjection, getPointResolution, transform, fromLonLat, toLonLat, METERS_PER_UNIT } from 'ol/proj';
  import { getLength, getArea } from 'ol/sphere';
  import { unByKey } from 'ol/Observable';
  import { easeOut } from 'ol/easing';
  import { 
    GeoJSON,
  } from 'ol/format';
  import { Select } from 'ol/interaction';
  import { pointerMove } from 'ol/events/condition';

  import Bar from 'ol-ext/control/Bar';
  import Button from 'ol-ext/control/Button';
  import Toggle from 'ol-ext/control/Toggle';
  import Overlay from 'ol-ext/control/Overlay';
  import GeolocationButton from 'ol-ext/control/GeolocationButton';

  import LayerSwitcher from 'ol-layerswitcher';
  import Popup from 'ol-popup';
  import SLDReader from '@nieuwlandgeo/sldreader';
  import proj4 from 'proj4';
  import $ from 'jquery';
  import Cookies from 'js-cookie';
  import i18next from 'i18next';
  import DataTable from 'datatables.net';

  const tipusPoi = {
    "Centre d'Interpretació": "centre_interpretacio",
    "Informació turística": "info_turistica",
    "Caiac": "caiac",
    "Castell": "castell",
    "Cova visitable": "cova_visitable",
    "Església": "esglesia",
    "Establiment recomanat": "establiment_recomanat_1",
    "Exposició a l'aire lliure": "establiment_recomanat_2",
    "Lloc interès Geoparc": "lloc_interes_geoparc",
    "Jaciment arqueològic": "jacimentarqueologic",
    "Mirador": "mirador",
    "Parapent": "parapent",
    "Rafting": "rafting",
    "Telefèric": "teleferic",
    "Via Ferrata": "viaferrata",
    "Vol en Globus": "globus",
    "Zona de bany": "zona_bany"
  };
  const tipologiasRuta = {
    "Georuta": "Georuta",
    "Ruta Geològica": "Ruta Geològica",
    "El Cinquè Llac": "El Cinquè Llac"
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

        // show legend image
        if (lyr.get("type") !== "base") {
          let simbol = document.createElement('img');
          simbol.className = 'leyenda';
          let icon = tipusPoi[lyrTitle];
          if (icon === undefined || icon === "undefined")
            icon = lyr.get('title');
          simbol.src = 'simbols/' + icon + '.svg'
          li.appendChild(simbol);
        }

        label.htmlFor = checkboxId;
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
        qgisProjectFile: '/home/geoparc/geoparc-turisme/geoparc-turisme.qgs',

        qgisWmsLayers: new LayerGroup({
          title: 'Capes temàtiques'
        }),
        qgisWfsLayersPoi: new LayerGroup({
          title: 'Punts de interès'
        }),
        qgisWfsLayersRuta: new LayerGroup({
          title: 'Georutes'
        }),
        poisLayers: [],
        rutasLayers: [],

        qgisSources: {},
        mousePosition: null,
        rasterLayer: null,

        baseLayers: new LayerGroup({
          title: 'Capes de referència',
          layers: [

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

            new LayerGroup({
              title: 'Topogràfic (ICGC)',
              type: 'base',
              combine: true,
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
            })
          ]
        }),

        windowLayers: null,
        windowTablePois: null,
        windowTableRutas: null,
        layersToggle: new Toggle({ 
          html: '<i class="fa fa-arrow-circle-right fa-lg"></i>',
          title: 'Tancar gestor de capes',
          className: "layersToggle",
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
          title: 'Llistat POIs',
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
          title: 'Llistat Georutes',
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
            else if (layer.name === "Georutes") {
              for (const tipo in tipologiasRuta) {
                loadWfsLayerRuta(tipo);
              }
            }
          }
          else {
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

            if (!layer.name.startsWith("@"))
              newLayer.set("title", layer.name);
            layers.push(newLayer);
          }
        });

        return layers;
      }

      function loadWfsLayerPoi(tipologia) {
        let vectorLayer = new VectorLayer({
          title: tipologia,
          vectorial: true,
          source: new VectorSource({
            format: new GeoJSON(),
            url: 'https://mapa.psig.es/qgisserver/wfs3/collections/origens_turisme/items.geojson?MAP=' + pageData.qgisProjectFile + '&limit=1000&tipus_cat=' + tipologia
          })
        });
        pageData.poisLayers.push(vectorLayer);
        fetch("js/data/origens_turisme.sld")
          .then(response => response.text())
          .then(sld => applyVectorStyle(vectorLayer, sld));
      }

      function loadWfsLayerRuta(tipologia) {
        let vectorLayer = new VectorLayer({
          title: tipologia,
          vectorial: true,
          source: new VectorSource({
            format: new GeoJSON(),
            url: 'https://mapa.psig.es/qgisserver/wfs3/collections/Georutes/items.geojson?MAP=' + pageData.qgisProjectFile + '&limit=1000&tipologia_cat=' + tipologia
          })
        });
        pageData.rutasLayers.push(vectorLayer);
        fetch("js/data/Georutes.sld")
          .then(response => response.text())
          .then(sld => applyVectorStyle(vectorLayer, sld));
      }

      function applyVectorStyle(vectorLayer, sld) {

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
      }

      function initMap(layersData) {
        // https://epsg.io/25831
        proj4.defs("EPSG:25831","+proj=utm +zone=31 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
        register(proj4);

        pageData.qgisWmsLayers.setLayers(new Collection(loadWmsLayers(layersData)));

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
            pageData.baseLayers,
            pageData.qgisWmsLayers,
            pageData.qgisWfsLayersRuta,
            pageData.qgisWfsLayersPoi
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

        // add vector layers
        pageData.qgisWfsLayersPoi.setLayers(new Collection(pageData.poisLayers));
        pageData.qgisWfsLayersRuta.setLayers(new Collection(pageData.rutasLayers));
        pageData.map.addOverlay(pageData.tooltip);
        pageData.map.addOverlay(pageData.popup);


        /*
         * Interaction
         *****************************************/
        pageData.map.on('click', function(evt) {
          pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
            pageData.map.getView().fit(feature.getGeometry().getExtent(), {
              easing: easeOut,
              duration: 2000
            });
            return true;
          }, {
            layerFilter: function(layer) {
              return layer === pageData.rutasLayers;
            },
            hitTolerance: 5
          });

          if (pageData.map.hasFeatureAtPixel(evt.pixel, {
            layerFilter: function(layer) {
              return pageData.poisLayers.includes(layer);
            },
            hitTolerance: 5
          })) {
            let title = "",
                description = "",
                foto = "",
                autor = "";
            pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
              title = feature.get('nom_cat');
              description = feature.get('descripcio_cat');
              foto = feature.get('imatge_1');
              autor = feature.get('autor');
              return true;
            }, {
              hitTolerance: 5
            });
            pageData.popup.show(evt.coordinate, '<div><h2>' + title + '</h2><p>' + description + '</p><img src="fotos/' + foto + '"/><p>' + autor + '</p></div>');
            pageData.tooltip.hide();
          }
          else if (pageData.map.hasFeatureAtPixel(evt.pixel, {
            layerFilter: function(layer) {
              return layer === pageData.rutasLayers;
            },
            hitTolerance: 5
          })) {
            let title = "",
                description = "",
                distancia = "",
                desnivel = "",
                tipologia = "",
                modalidad = "",
                dificultad = "";
            pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
              title = feature.get('georuta_cat');
              description = feature.get('descripcio_cat');
              distancia = feature.get('distancia_km') + " km";
              desnivel = feature.get('desnivell_m');
              tipologia = feature.get('tipologia_cat');
              modalidad = feature.get('modalitat_cat');
              dificultad = feature.get('dificultat_cat');
              return true;
            }, {
              hitTolerance: 5
            });
            pageData.popup.show(evt.coordinate, '<div><h2>Georuta: ' + title + '</h2><p>' + description + '</p><p>' + distancia + '</p><p>' + desnivel + '</p><p>' + tipologia + '</p><p>' + modalidad + '</p><p>' + dificultad + '</p></div>');
            pageData.tooltip.hide();
          }
          else
            pageData.popup.hide();
        });

        pageData.map.on('pointermove', function(evt) {
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
            let title = "",
                foto = "";
            pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
              title = feature.get('nom_cat');
              foto = feature.get('imatge_1');
              return true;
            }, {
              hitTolerance: 5
            });
            pageData.tooltip.show(evt.coordinate, '<div><div class="imgDiv"><img src="fotos/' + foto + '"/></div><h2>' + title + '</h2></div>');
          }
          else if (pageData.map.hasFeatureAtPixel(evt.pixel, {
            layerFilter: function(layer) {
              return layer === pageData.rutasLayers;
            },
            hitTolerance: 5
          })) {
            let title = "";
            pageData.map.forEachFeatureAtPixel(evt.pixel, function (feature) {
              title = feature.get('georuta_cat');
              return true;
            }, {
              hitTolerance: 5
            });
            pageData.tooltip.show(evt.coordinate, '<div><h2>Georuta: ' + title + '</h2></div>');
          }
          else
            pageData.tooltip.hide();
        });

        // select interaction working on "mouseover"
        let selectMove = new Select({
          condition: pointerMove,
          layers: pageData.poisLayers,
          //style: iconHighlightStyleFunction
        });
        pageData.map.addInteraction(selectMove);

        $(document).keyup(function(e) {
          if (e.keyCode === 27) { // escape
            pageData.windowTablePois.hide();
            pageData.windowTableRutas.hide();
          }
        });
      }


      /*
       * Icon styles
       *****************************************/
      function iconStyleFunction(feature, resolution) {
        return new Style({
          image: new Icon({
            //size: [20, 20],
            scale: 0.1,
            src: "icons/" + feature.get('tipus_cat') + ".png"
          })
        });
      }

      function iconHighlightStyleFunction(feature, resolution) {
        let style = feature.getStyle();
        try {
          console.log(style.getImage());
          return style.getImage().setScale(style.getImage().getScale()*2);
        }
        catch(e) {}

        /*return new Style({
          image: new Icon({
            //size: [20, 20],
            scale: 0.2,
            src: "icons/" + feature.get('tipus_cat') + ".png"
          })
        });*/
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

        LayerSwitcherWithLegend.renderPanel(pageData.map, document.getElementById("layerSwitcher"), { reverse: true, groupSelectStyle: 'none' });

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

        let menuBar = new Bar({
          className: "ol-top ol-right menuBar"
        });
        pageData.map.addControl(menuBar);

        menuBar.addControl(pageData.layersToggle);

        let actionBar = new Bar({ toggleOne: true, group: true });
        menuBar.addControl(actionBar);

        actionBar.addControl(pageData.tableTogglePois);
        actionBar.addControl(pageData.tableToggleRutas);

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
        
        if (activeToggle !== "tablePois")
          pageData.tableTogglePois.setActive(false);
        else if (activeToggle !== "tableRutas")
          pageData.tableToggleRutas.setActive(false);
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
        // menu
        pageData.tableTogglePois.setTitle(i18next.t('gui.windowTablePoisTitle'));
        pageData.tableToggleRutas.setTitle(i18next.t('gui.windowTableRutasTitle'));

        // windows
        $("#windowTablePois .title").text(i18next.t('gui.windowTablePoisTitle'));
        $("#windowTableRutas .title").text(i18next.t('gui.windowTableRutasTitle'));

        // layerswitcher
        pageData.qgisWmsLayers.set("title", i18next.t('switcher.wmsGroup'));
        pageData.qgisWfsLayersPoi.set("title", i18next.t('switcher.wfsGroupPoi'));
        pageData.qgisWfsLayersRuta.set("title", i18next.t('switcher.wfsGroupRuta'));
        LayerSwitcherWithLegend.renderPanel(pageData.map, document.getElementById("layerSwitcher"), { reverse: true, groupSelectStyle: 'none' });
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
            { "data": "properties.nom_cat", "title" : "Nom"},
            { "data": "properties.descripcio_cat", "title" : "Descripció"},
            { "data": "properties.imatge_1", "title" : "Imatge", "render": function ( data, type, row ) { return data!=="" ? "<img style='max-width:300px;' src='fotos/" + data + "'/>" : ""; }},
            { "data": "properties.nom_ruta_cat", "title" : "Georuta"},
            { "data": "properties.tematica_1_cat", "title" : "Temática"},
            { "data": "properties.tipus_cat", "title" : "Tipus"},
          ],
        })
      }

      function initDtRutes() {
        $('#datatable-rutas').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="rutas-table"></table>');
        let datatable = $('#rutas-table').DataTable({
          info: false,
          responsible: true,
          search: true,
          ajax: { 
            url :"https://mapa.psig.es/qgisserver/wfs3/collections/Georutes/items.json?MAP=" + pageData.qgisProjectFile + "&limit=1000", type : "GET",
            dataSrc: 'features'
          },
          columns: [
            { "data": "properties.georuta_cat", "title" : "Nom"},
            { "data": "properties.descripcio_cat", "title" : "Descripció"},
            { "data": "properties.desnivell_m", "title" : "Desnivell [m]"},
            { "data": "properties.dificultat_cat", "title" : "Dificultat"},
            { "data": "properties.distancia_km", "title" : "Distancia [km]", "render": function ( data, type, row ) { return parseFloat(data).toLocaleString('es-ES', { decimal: ',', useGrouping: false, minimumFractionDigits: 2, maximumFractionDigits: 2 }); }},
            { "data": "properties.tipologia_cat", "title" : "Tipología"},
            { "data": "properties.modalitat_cat", "title" : "Modalitat"},
          ],
        })
      }

      /*
       * Init
       *****************************************/
      function initGui() {
        initMenu();
        initCookies();
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

.ol-zoom,
.ol-geobt,
.ol-full-screen,
.ol-attribution {
  left: .5em;
}

.ol-zoom {
  top: 4.5em;
}

.ol-geobt,
.ol-full-screen,
.ol-attribution {
  right: auto;
}

.ol-attribution {
  bottom: 3em;
}

.ol-geobt {
  left: .5em !important;
  right: auto !important;
  top: 2.5em !important;
  bottom: auto !important;
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
.ol-control.ol-bar.ol-right .ol-group {
  margin: 0;
}
.menuBar.ol-control.ol-bar.ol-top.ol-right {
  top: 0;
  right: 0;
  border: 2px solid #b2b019;
  border-radius: 0;
  width: 340px;
  max-width: 95%;
  background: #b2b019;
}
.ol-touch .ol-control.ol-bar.ol-top.ol-right, .ol-touch .ol-control.ol-bar.ol-top.ol-right {
  top: .5em;
}
.menuBar.ol-control.ol-bar.ol-right .ol-control,
.menuBar.ol-control.ol-bar.ol-right .ol-control {
  display: inline-block;
}
.menuBar.ol-control.ol-bar .ol-control.ol-toggle {
  margin: 6px;
}
.menuBar.ol-bar .ol-control button {
  background-color: transparent;
}
.menuBar.ol-control.ol-bar .ol-toggle.ol-active > button,
.menuBar.ol-control.ol-bar .ol-toggle.ol-active button:hover i {
  background-color: transparent;
  color: white;
}
.ol-control.ol-bar .ol-toggle.ol-active > button {
  background-color: white;
}
.ol-control button i {
  pointer-events: none;
  color: #4f1c23;
}

.langBar {
  float: right;
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
  color: white;
  background-color: transparent;
}

.ol-zoom .ol-zoom-in,
.ol-zoom .ol-zoom-out {
  border-radius: 0;
}

.ol-control.ol-bar.ol-right .ol-group .ol-control:last-child > button {
  border-radius: 0;
}

.ol-overlay.window { 
  width: 344px;
  max-width: 95%;
  background: #fff;
  color: #333;
  padding: 0.5em;
  -webkit-transition: all 0.25s;
  transition: all 0.25s;
  top: 2em;
  height: auto;
  min-height: 500px;
  max-height: 100%;
  bottom: unset;
  border: 2px solid #b2b019;
}

.ol-overlay.window {
  right: 0;
  left: auto;
  padding: 0;
}
.ol-overlay.infoWindow {
  left: 3em;
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
.ol-overlay.window.layersWindow .ol-closebox { 
  display: none;
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

.window .content p {
  margin-top: 0;
}

.window .title {
  margin-left: 5px;
}

.window.layersWindow {
  height: calc(100% - 35px);
  overflow: scroll;
}

#windowLayers {
  height: 100%;
}

.window.tableWindow {
  width: 90%;
  top: 100px;
  right: 50px;
}
#pois-table,
#rutas-table {
  width: 100% !important;
}
.window.tableWindow .content {
  overflow: scroll;
  max-height: 600px;
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

.lang button {
  color: black;
}

.ol-popup {
    display: none;
    position: absolute;
    background-color: white;
    padding: 15px;
    border: 1px solid #cccccc;
    bottom: 12px;
    left: -50px;
}

.ol-popup:after, .ol-popup:before {
    top: 100%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
    pointer-events: none;
}

.ol-popup:after {
    border-top-color: white;
    border-width: 10px;
    left: 48px;
    margin-left: -10px;
}

.ol-popup:before {
    border-top-color: #cccccc;
    border-width: 11px;
    left: 48px;
    margin-left: -11px;
}

.ol-popup-content {
    min-width: 300px;
    max-height: 450px;
    overflow-x: auto;
}

.ol-popup-content h2 {
  text-align: center;
  line-height: 1;
  margin: 0;
}

.featurePopup {
  z-index: 2;
}
.featureTooltip {
  z-index: 3;
}

.featurePopup img {
  max-width: 500px;
}
.featureTooltip .imgDiv {
  display: inline-block;
  position: relative;
  width: 300px;
  height: 300px;
  overflow: hidden;
  border-radius: 50%;
}
.featureTooltip img {
  width: auto;
  height: 100%;
}

.featurePopup .ol-popup-content {
    min-width: 570px;
    max-height: 400px;
    overflow-x: auto;
    overflow-y: scroll;
}

.featurePopup .ol-popup-closer {
    position: absolute;
    top: 2px;
    right: 2px;
    font-size: 150%;
    padding: 0 4px;
    color: gray;
    text-decoration: none;
}

.featurePopup .ol-popup-closer:after {
    content: "\2716";
}

.ol-popup div.infoResult {
    min-width: 130px;
}

.ol-popup div.infoResult p {
    padding: 0.1em;
    margin: 0;
}

.ol-popup-content h3 {
    margin: 0.25em 0;
}

.ol-popup.marker {
    margin-bottom: 30px;
}

.leyenda {
  width: 20px;
  height: 20px;
  margin: 0 -20px 0 30px;
}

@media only screen and (max-width: 420px) {
  .menuBar.ol-control.ol-bar.ol-top.ol-right {
    max-width: 85%;
  }
}
</style>