'use strict';

module.exports = options => {
  return async function(ctx, next) {
    const token = ctx.request.header.token;
    let decode = '';
    // 如果 请求地址为注册或者登录 则直接下一步
    if (ctx.path === '/api/login') {
      await next();
    } else {
      if (token) {
        try {
          // 解码token
          decode = ctx.app.jwt.verify(token, options.secret);
          await next();
        } catch (error) {
          ctx.throw(401, error.message);
        }
      } else {
        ctx.throw(401, '请登录');
      }
    }
  };
};
