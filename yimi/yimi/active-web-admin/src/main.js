import Vue from 'vue'
import App from './App.vue'
import router from './router'
import api from './api'
import store from './store'
import ElementUI from 'element-ui';
import 'u-reset.css'
import 'element-ui/lib/theme-chalk/index.css';
import Filter from './filter';
Vue.use(ElementUI);
Vue.use(Filter);

Vue.prototype.$api = api;
Vue.prototype.$baseUrl = "http://127.0.0.1";
Vue.config.productionTip = false


new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
