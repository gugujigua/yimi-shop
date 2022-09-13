'use strict';
const Service = require('egg').Service;

class CarsService extends Service {

  async all(options = {}) {
    const { ctx, app } = this;
    let term = '';

    if (options.where) {
      term += ' where ';
      const where = options.where;
      for (const i in where) {
        term += i + "='" + where[i] + "',";
      }
      term = term.slice(0, -1);
    }
    let order = '';
    if (options.orders) {
      order += ' order by ';
      for (const i in options.orders) {
        order += options.orders[i].join(' ') + ',';
      }
      order = order.slice(0, -1);
    }

    return await app.mysql.query('select cars.*,goods.thumb,goods.title,goods_specs.specs,goods_specs.price from cars left join goods on cars.gid=goods.id left join goods_specs on cars.specs_id=goods_specs.id ' + term + order);

  }
  /**
     * 加入购物车
     */
  async add() {
    const { ctx, app } = this;
    const data = await app.mysql.get('cars', {
      username: ctx.session.username,
      gid: ctx.request.body.gid,
      specs_id: ctx.request.body.specs_id,
    });
    if (data) {
      data.nums += 1;
      return await app.mysql.update('cars', {
        id: data.id,
        nums: data.nums,
        update_time: Date.now(),
      });
    }
    ctx.request.body.create_time = Date.now();
    ctx.request.body.update_time = Date.now();
    return await app.mysql.insert('cars', ctx.request.body);
  }
  async update(id) {
    const { ctx, app } = this;
    if (ctx.request.body.nums <= 0) {
      ctx.request.body.nums = 0;
    }
    return await app.mysql.update('cars', ctx.request.body, { where: { id } });
  }
  async del(id) {
    return await this.app.mysql.delete('cars', {
      id,
    });
  }
}

module.exports = CarsService;
