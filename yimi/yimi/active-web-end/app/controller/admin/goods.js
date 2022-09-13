'use strict';

const Controller = require('egg').Controller;

class GoodsController extends Controller {
  /**
    * GET 获取指定资源
    */
  async show(id) {
    const { ctx } = this;
    const data = await ctx.service.common.goods.find();
    ctx.body = {
      code: 200,
      msg: '获取成功',
      data: data[0] || {},
    };
    ctx.status = 200;
  }
  /**
    * GET 获取资源列表
    */
  async index() {
    const { ctx } = this;
    const data = await ctx.service.common.goods.all();
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
    
    const data = ctx.request.body;
    if (!data.cate_id) {
      ctx.body = {
        code: 404,
        msg: '请选择分类'
      };
      ctx.status = 200;
      return false;
    }
    if (!data.title) {
      ctx.body = {
        code: 404,
        msg: '请传入标题'
      };
      ctx.status = 200;
      return false;
    }
    if (!data.thumb) {
      ctx.body = {
        code: 404,
        msg: '请传入缩略图'
      };
      ctx.status = 200;
      return false;
    }
    
    const specs = JSON.parse(JSON.stringify(data.specs));
    if (specs.length<=0) {
      ctx.body = {
        code: 404,
        msg: '请传入商品规格'
      };
      ctx.status = 200;
      return false;
    }
    const result = await ctx.service.common.goods.add();
    if (result.affectedRows > 0) {
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
    const data = await ctx.service.common.goods.update(ctx.params.id);
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
    const data = await ctx.service.common.goods.del(ctx.params.id);
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
module.exports = GoodsController;
