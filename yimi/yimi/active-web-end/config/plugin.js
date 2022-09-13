'use strict';

/** @type Egg.EggPlugin */
module.exports = {
  // had enabled by egg
  // static: {
  //   enable: true,
  // }
  // 模板引擎配置 egg-view-ejs
  ejs: {
    enable: true,
    package: 'egg-view-ejs',
  },
  // 验证器配置
  validate: {
    enable: true,
    package: 'egg-validate',
  },
  // 跨域配置
  cors: {
    enable: true,
    package: 'egg-cors',
  },
  // JWT配置
  jwt: {
    enable: true,
    package: 'egg-jwt',
  },
  // MySQL配置
  mysql: {
    enable: true,
    package: 'egg-mysql',
  },
};
