'use strict';

const Controller = require('egg').Controller;
const crypto = require('crypto');
class LoginController extends Controller {
  /**
     * GET 获取指定资源
     */
  async show() {

  }
  /**
     * GET 获取资源列表
     */
  async index() {
    const { ctx } = this;
    ctx.body = {

    };
    ctx.status = 200;
  }
  /**
     * POST 保存新增资源
     */
  async create() {
    const { ctx, config, app } = this;
    const user = await ctx.service.admin.login.find(ctx.request.body.username);
    if (user) {
      const hmac = crypto.createHmac('sha1', config.adminKey);
      hmac.update(ctx.request.body.password);
      const password = hmac.digest('hex');
      console.log(password);
      if (password === user.password) {
        const token = app.jwt.sign({ username: user.username }, app.config.jwt.secret);
        ctx.body = {
          code: 200,
          msg: '登录成功',
          token,
          data: {
            username: user.username,
          },
        };
      } else {
        ctx.body = {
          code: 404,
          msg: '密码错误',
        };
      }
    } else {
      ctx.body = {
        code: 404,
        msg: '用户名不存在',
      };
    }
    ctx.status = 200;
  }
  /**
     * PUT 保存更新资源
     */
  async update() {
    const { ctx, config } = this;
    const user = await ctx.service.admin.login.find(ctx.request.body.username);
    const hmac = crypto.createHmac('sha1', config.adminKey);
    hmac.update(ctx.request.body.oldpwd);
    const password = hmac.digest('hex');
    if (password === user.password) {
      const data = await ctx.service.admin.login.update();
      if (data.affectedRows > 0) {
        ctx.body = {
          code: 200,
          msg: '修改成功',
        };
      } else {
        ctx.body = {
          code: 404,
          msg: '修改失败',
        };
      }
    } else {
      ctx.body = {
        code: 404,
        msg: '密码错误',
      };
    }

    ctx.status = 200;
  }
  /**
     * DELETE 删除指定资源
     */
  async destroy() {

  }
}
module.exports = LoginController;
