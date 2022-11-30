import OlMap from "../packages/map"

const components = [
    OlMap
]

const install = (Vue, opts = {}) => {
    components.map(component => {
        Vue.component(component.name, component)
    })
}

if( typeof window !== 'undefined' && window.Vue){
    install(window.Vue)
}

export{
    OlMap
}

export default {
    install
}