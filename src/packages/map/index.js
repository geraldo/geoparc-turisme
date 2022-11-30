import OlMap from './map.vue'

OlMap.install = (Vue) =>{
    Vue.component(OlMap.name, OlMap)
}

export default OlMap