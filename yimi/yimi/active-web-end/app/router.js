'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller, middleware } = app;
  const jwtHandler = middleware.jwtHandler(app.config.jwt);
  const indexCommonData = middleware.indexCommonData();
  /* ---- 客户端 -------------------------------- */
  router.get('/', indexCommonData, controller.index.home.index);
  router.get('/news-list/:cat_id', indexCommonData, controller.index.home.newsList);
  router.get('/news-show/:id', indexCommonData, controller.index.home.newsShow);
  router.get('/cate-list/:cat_id', indexCommonData, controller.index.home.cateList);
  router.get('/goods-show/:id', indexCommonData, controller.index.home.goodsShow);
  router.get('/car', indexCommonData, controller.index.home.car);
  router.post('/login', controller.index.home.login);
  router.post('/loginout', controller.index.home.loginout);
  router.post('/register', controller.index.home.register);
  router.post('/car', controller.index.car.add);
  router.get('/car-goods', controller.index.car.all);
  router.post('/car-update/:id', controller.index.car.update);
  router.post('/car-del/:id', controller.index.car.del);
  router.post('/orders-add', controller.index.orders.add);

  router.get('/orders-done/:order_id', indexCommonData, controller.index.home.orderDone);
  router.get('/orders-confirm/:id', indexCommonData, controller.index.home.orderConfirm);
  router.get('/pay-success', indexCommonData, controller.index.home.paySuccess);
  router.get('/personal', indexCommonData, controller.index.home.personalInfo);
  router.post('/personal-info', indexCommonData, controller.index.home.changeInfo);
  router.get('/personal-order', indexCommonData, controller.index.home.personalOrder);
  router.get('/account', indexCommonData, controller.index.home.account);
  router.get('/guide', indexCommonData, controller.index.home.guide);
  router.get('/order-operation', indexCommonData, controller.index.home.orderOperation);
  router.get('/search', indexCommonData, controller.index.home.newsSearch);
  /* ---- 管理端 -------------------------------- */
  router.resources('login', '/api/login', controller.admin.login);
  router.resources('info', '/api/info', controller.admin.info);
  router.resources('wheel', '/api/wheel', jwtHandler, controller.admin.wheel);
  router.resources('category-news', '/api/category-news', jwtHandler, controller.admin.categoryNews);
  router.resources('news', '/api/news', jwtHandler, controller.admin.news);
  router.resources('category-goods', '/api/category-goods', jwtHandler, controller.admin.categoryGoods);
  router.resources('goods', '/api/goods', jwtHandler, controller.admin.goods);
  router.resources('users', '/api/users', jwtHandler, controller.admin.users);
  router.resources('orders', '/api/orders', controller.admin.orders);
  router.resources('theme', '/api/theme', controller.admin.theme);
  router.resources('upload', '/api/upload', controller.admin.upload);
};
