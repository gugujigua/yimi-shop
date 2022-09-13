import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'
import { Message } from 'element-ui'
Vue.use(VueRouter)

const routes = [
  {
    path: '/Login',
    name: 'Login',
    component: Login
  },
  {
    path: '/',
    name: 'Main',
    meta: { title: "主页" },
    component: () => import('../views/Main.vue'),
    redirect: { name: "Info" },
    children: [
      // 系统设置
      {
        path: 'info',
        name: 'Info',
        meta: { isShow: true, title: "系统设置", icon: "el-icon-shezhi" },
        component: () => import('../views/Info.vue')
      },
      // 动态设置
      {
        path: 'thumb',
        name: 'Thumb',
        meta: { isShow: true, title: "主题配置", icon: "el-icon-shangpin" },
        component: () => import('../views/ActiveSetting.vue')
      },
      // 轮播管理
      {
        path: 'wheel',
        name: 'Wheel',
        meta: { isShow: true, title: "轮播管理", icon: "el-icon-shouyelunbotu" },
        component: () => import('../views/Wheel.vue')
      },
      // 新闻分类
      {
        path: 'category-news',
        name: 'CategoryNews',
        meta: { isShow: true, title: "新闻分类", icon: "el-icon-fenlei" },
        component: () => import('../views/CategoryNews.vue')
      },
      // 新闻管理
      {
        path: 'news',
        name: 'News',
        meta: { isShow: true, title: "新闻管理", icon: "el-icon-xinwen" },
        component: () => import('../views/News.vue')
      },
      // 添加新闻
      {
        path: 'add-news',
        name: 'AddNews',
        meta: { isShow: false, title: "添加新闻", icon: "el-icon-setting" },
        component: () => import('../views/AddNews.vue')
      },
      // 编辑新闻
      {
        path: 'edit-news',
        name: 'EditNews',
        meta: { isShow: false, title: "编辑新闻", icon: "el-icon-setting" },
        component: () => import('../views/EditNews.vue')
      },
      // 商品分类管理
      {
        path: 'category-goods',
        name: 'CategoryGoods',
        meta: { isShow: true, title: "商品分类", icon: "el-icon-fenlei" },
        component: () => import('../views/CategoryGoods.vue')
      },
      // 商品管理
      {
        path: 'goods',
        name: 'Goods',
        meta: { isShow: true, title: "商品管理", icon: "el-icon-shangpin" },
        component: () => import('../views/Goods.vue')
      },
      {
        path: 'add-goods',
        name: 'AddGoods',
        meta: { isShow: false, title: "添加商品", icon: "el-icon-shangpin" },
        component: () => import('../views/AddGoods.vue')
      },
      // 用户管理
      {
        path: 'users',
        name: 'Users',
        meta: { isShow: true, title: "用户管理", icon: "el-icon-users" },
        component: () => import('../views/Users.vue')
      },
      // 订单管理
      {
        path: 'orders',
        name: 'Orders',
        meta: { isShow: true, title: "订单管理", icon: "el-icon-dingdan" },
        component: () => import('../views/Orders.vue')
      },
    ]
  },
  {
    path: '*',
    name: 'NotFound',
    component: () => import('../views/NotFound.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, from, next) => {
  var token = sessionStorage.getItem('token');
  if(token || to.name == 'Login'){
      next();
  } else {
      Message({
          message: '请登录',
          type: "warning",
          duration: 1000,
          onClose: () => {
              next({name: 'Login'})
          }
      })
  }
  if (to.path != '/login') {
    if (token == '' || token == null || token == undefined) {
      next({ path: '/login' })
      return
    }
  }
  if (to.name != 'Login') {
      if (token == '' || token == null || token == undefined) {
          next({path: '/Login'})
          return
      }
  }
  next();
})

export default router
