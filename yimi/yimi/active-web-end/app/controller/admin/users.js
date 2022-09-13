'use strict';

const Controller = require('egg').Controller;

class UsersController extends Controller {
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
    const data = await ctx.service.common.users.all();
    ctx.body = {
      code: 200,
      msg: '获取成功',
      data,
    };
    ctx.status = 200;
  }
  /**
       * POST 保存新增资源
       */
  async create() {

  }
  /**
       * PUT 保存更新资源
       */
  async update() {

  }
  /**
       * DELETE 删除指定资源
       */
  async destroy() {
    const { ctx } = this;
    const data = await ctx.service.common.users.del(ctx.params.id);
    if (data.affectedRows > 0) {
      ctx.body = {
        code: 200,
        msg: '删除成功',
      };
    } else {
      ctx.body = {
        code: 404,
        msg: '删除失败',
      };
    }
    ctx.status = 200;
  }
}
module.exports = UsersController;
