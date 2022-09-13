'use strict';
module.exports = () => {
  return async function(ctx, next) {
    const info = await ctx.service.common.info.find();
    const theme = await ctx.service.common.theme.find(1);
    const cates = await ctx.service.common.categoryNews.all({ is_enable: 1 }, 10);
    const wheels = await ctx.service.common.wheel.all();
    const goodCates = await ctx.service.common.categoryGoods.level1({ where: { is_enable: 1, pid: 0 } });
    let isLogin = false;
    let username = null;
    let nickname = null;
    if (ctx.session.isLogin) {
      isLogin = true;

      username = ctx.session.username;
      nickname = ctx.session.nickname;
    }
    ctx.app.locals.dateFormat = function(val, format = 'yyyy-MM-dd') {
      if (/^\d+$/.test(val)) {
        val = String(val);
        val = val.padEnd(13, '0') * 1;
      }
      if (!isNaN(val)) {
        val *= 1;
      }
      const date = new Date(val);
      if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));
      }
      const o = {
        'M+': date.getMonth() + 1,
        'd+': date.getDate(),
        'h+': date.getHours(),
        'm+': date.getMinutes(),
        's+': date.getSeconds(),
      };
      for (const k in o) {
        if (new RegExp(`(${k})`).test(format)) {
          const str = o[k] + '';
          format = format.replace(RegExp.$1, (RegExp.$1.length === 1) ? str : ('00' + str).substr(str.length));
        }
      }
      return format;
    };
    ctx.app.locals = { info, cates, cat_id: -1, wheels, goodCates, isLogin, username, nickname,theme:theme[0] };
    await next();
  };
};
