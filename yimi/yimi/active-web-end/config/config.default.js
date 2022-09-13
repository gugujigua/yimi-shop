/* eslint valid-jsdoc: "off" */

'use strict';

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = appInfo => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = exports = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1616561948534_9702';

  // add your middleware config here
  config.middleware = [ 'errorHandler' ];
  config.errorHandler = {
    match: '/api',
  };

  // add your user config here
  const userConfig = {
    // myAppName: 'egg',
    adminKey: 'yimi2021',
  };
  // 配置模板引擎
  config.view = {
    mapping: {
      '.html': 'ejs',
    },
  };
  // 安全配置
  config.security = {
    // 关闭 csrf
    csrf: {
      enable: false,
    },
    // 允许白名单域名列表
    domainWhiteList: [ 'http://localhost:7001' ],
  };
  config.cors = {
    origin: '*',
    allowMethods: 'GET,PUT,POST,DELETE,OPTIONS',
  };
  // JWT配置
  config.jwt = {
    secret: '123456', // 自定义token的加密条件字符串，可按各自的需求填写
  };

  // MySQL配置
  config.mysql = {
    // 单数据库信息配置
    client: {
      // host
      host: 'localhost',
      // 端口号
      port: '3306',
      // 用户名
      user: 'root',
      // 密码
      password: '123456',
      // 数据库名
      database: 'yimi',
    },
    // 是否加载到 app 上，默认开启
    app: true,
    // 是否加载到 agent 上，默认关闭
    agent: false,
  };
  return {
    ...config,
    ...userConfig,
  };
};
