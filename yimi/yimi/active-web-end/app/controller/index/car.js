'use strict';

const Controller = require('egg').Controller;

class CarController extends Controller {
  async all() {
    const { ctx } = this;
    const data = await ctx.service.index.cars.all({
      where: { username: ctx.session.username },
    });
    ctx.body = {
      code: 200,
      msg: '获取成功',
      data,
    };
    ctx.status = 200;
  }
  async add() {
    const { ctx } = this;

    const data = await ctx.service.index.cars.add();
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
  async update() {
    const { ctx } = this;
    const data = await ctx.service.index.cars.update(ctx.params.id);
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
  async del() {
    const { ctx } = this;
    const data = await ctx.service.index.cars.del(ctx.params.id);
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
module.exports = CarController;
