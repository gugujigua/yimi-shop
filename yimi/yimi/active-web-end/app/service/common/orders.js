'use strict';
const Service = require('egg').Service;

class OrdersService extends Service {
  async find(id) {
    return await this.app.mysql.get('orders', { id });
  }
  async findGoods(order_id) {
    const data = await this.app.mysql.get('orders', { order_id });
    data.goods = await this.app.mysql.query('select order_goods.*,goods.thumb,goods.title,goods_specs.price from order_goods left join goods on goods.id=order_goods.good_id left join goods_specs on goods_specs.id=order_goods.specs_id where order_id=?', [ order_id ]);
    return data;
  }
  async allPage(options = {}) {
    const { ctx, app } = this;
    const page = ctx.request.query.page || 1;
    let limit = ctx.request.query.limit || 10;
    const offset = (page - 1) * limit;
    let term = '';
    if (options.limit) {
      limit = options.limit;
    }
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
    const total = await this.app.mysql.query('select count(*)as total from orders ' + term);
    const pages = Math.ceil(total[0].total / limit);
    const data = await app.mysql.query('select * from orders ' + term + order + ' limit ' + offset + ',' + limit);
    return {
      total: total[0].total,
      data,
      pages,
      page,
    };
  }
  async all(options) {
    return await this.app.mysql.select('orders', options);
  }
  /**
       * 生成 订单号
       * 封装订单数据
       * 插入商品数据
       * 删除购物车相关数据
       */
  async add() {
    const { ctx, app } = this;
    const insertData = {};
    // 获取订单ID
    const date = new Date();
    let order_id = '';
    order_id += date.getFullYear();
    order_id += (date.getMonth() + 1).toString().padStart(2, '0');
    order_id += date.getDate().toString().padStart(2, '0');
    order_id += Date.now();
    order_id += Math.ceil(Math.random() * 90000 + 10000);
    insertData.order_id = order_id;
    insertData.username = ctx.session.username;
    insertData.create_time = Date.now();
    insertData.update_time = Date.now();
    insertData.money = ctx.request.body.money;

    const goods = ctx.request.body.goods;
    let sql = 'insert into order_goods ';
    const field = '(order_id,good_id,specs_id,nums)';
    let insertGoods = '';
    const delCarIds = [];
    for (let i = 0; i < goods.length; i++) {
      insertGoods += '("' + order_id + '",' + goods[i].gid + ',' + goods[i].specs_id + ',' + goods[i].nums + '),';
      delCarIds.push(goods[i].id);
    }
    insertGoods = insertGoods.slice(0, -1);
    sql += field + 'values' + insertGoods;
    await app.mysql.query(sql);
    await app.mysql.query('delete from cars where id in (' + delCarIds + ')');
    const data = await app.mysql.insert('orders', insertData);
    if (data.affectedRows > 0) {
      return order_id;
    }
    return false;
  }
  async update() {
    const { ctx, app } = this;
    return await app.mysql.update('orders', ctx.request.body);
  }
  async del(id) {
    return await this.app.mysql.delete('orders', {
      id,
    });
  }
}

module.exports = OrdersService;
