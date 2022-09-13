'use strict';

const Controller = require('egg').Controller;

class CategoryGoodsController extends Controller {
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
    const data = await ctx.service.common.categoryGoods.all(ctx.request.query);
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
    const { ctx } = this;
    const data = await ctx.service.common.categoryGoods.add();
    if (data.affectedRows > 0) {
      ctx.body = {
        code: 200,
        msg: '添加成功',
      };
    } else {
      ctx.body = {
        code: 404,
        msg: '添加失败',
      };
    }
    ctx.status = 200;
  }
  /**
  * PUT 保存更新资源
  */
  async update() {
    const { ctx } = this;
    const data = await ctx.service.common.categoryGoods.update(ctx.params.id);
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
    ctx.status = 200;
  }
  /**
  * DELETE 删除指定资源
  */
  async destroy() {
    const { ctx } = this;
    const data = await ctx.service.common.categoryGoods.del(ctx.params.id);
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
module.exports = CategoryGoodsController;
