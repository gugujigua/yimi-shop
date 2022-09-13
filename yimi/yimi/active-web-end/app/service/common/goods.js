'use strict';
const Service = require('egg').Service;

class GoodsService extends Service {
  async find() {
    const { ctx } = this;
    const specs = await this.app.mysql.select('goods_specs', { where: { gid: ctx.params.id } });
    const good = await this.app.mysql.query('select goods.*,category_goods.catename from goods left join category_goods on category_goods.id=goods.cate_id where goods.id=?', [ ctx.params.id ]);
    if (good[0]) {
      good[0].specs = specs;
    }
    return good;
  }
  async all(options = {}) {
    const { ctx, app } = this;
    const page = ctx.request.query.page || 1;
    let limit = ctx.request.query.limit || 10;
    let term = '';
    if (options.limit) {
      limit = options.limit;
    }
    const offset = (page - 1) * limit;
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
    const total = await this.app.mysql.query('select count(*)as total from goods ' + term);
    const pages = Math.ceil(total[0].total / limit);
    const data = await app.mysql.query('select goods.*,category_goods.catename from goods left join category_goods on category_goods.id=goods.cate_id ' + term + order + ' limit ' + offset + ',' + limit);
    for (const d of data) {
      d.specs = await this.app.mysql.select('goods_specs', { where: { gid: d.id } });
    }
    return {
      total: total[0].total,
      data,
      pages,
      page,
    };
  }
  async indexGoods() {
    const { ctx, app } = this;
    // 所有一级分类
    const goodsCates = await ctx.service.common.categoryGoods.level1({ where: { is_enable: 1, pid: 0 } });
    const theme = await ctx.service.common.theme.find(1);
    
    // 遍历一级分类
    for (let k = 0; k < goodsCates.length; k++) {
      const item = goodsCates[k];
      // 获取一级分类下二级
      const ids = await app.mysql.query('select id from category_goods where pid=?', [ item.id ]);
      if (ids.length > 0) {
        // 遍历二级
        const idArr = ids.map(item => item.id);
        // 获取所有二级分类商品
        const goods = await app.mysql.query('select * from goods where cate_id in (?) order by id desc limit ' + theme[0].good_list_num, [ idArr ]);
        for (let j = 0; j < goods.length; j++) {
          const specs = await this.app.mysql.select('goods_specs', { where: { gid: goods[j].id } });
          goods[j].specs = specs;
        }
        goodsCates[k].goods = goods;
      } else {
        goodsCates[k].goods = [];
      }
    }
    return goodsCates;
  }
  async cateGoods(cat_id) {
    const { ctx, app } = this;
    const page = ctx.query.page || 1;
    const theme = await ctx.service.common.theme.find(1);
    const limit = ctx.query.limit || theme[0].good_list_num;
    const type = ctx.query.type || 1;
    const offset = (page - 1) * limit;
    
    const cateAllGoods = await app.mysql.query('select * from goods where cate_id=?', [ cat_id ]);
    const pages = Math.floor(cateAllGoods.length / limit);

    var order = '';
    if (type == 1) {
      var order = ' order by id desc ';
    }
    const goods = await app.mysql.query('select * from goods where cate_id=? ' + order + 'limit ?,?', [ cat_id, offset, limit ]);
    for (let j = 0; j < goods.length; j++) {
      const specs = await this.app.mysql.select('goods_specs', { where: { gid: goods[j].id } });
      goods[j].specs = specs;
    }
    if (type == 2) {
      goods.sort(function(a, b) {
        return b.specs[0].price - a.specs[0].price;
      });
    }
    return {
      data: goods,
      page,
      pages,
    };
  }
  async add() {
    const { ctx, app } = this;
    const data = ctx.request.body;
    data.create_time = Date.now();
    data.update_time = Date.now();
    const specs = JSON.parse(JSON.stringify(data.specs));
    delete data.specs;
    const result = await app.mysql.insert('goods', ctx.request.body);

    let sql = 'insert into goods_specs ';
    let field = '(gid,';
    let insertData = '';
    for (let i = 0; i < specs.length; i++) {
      insertData += '(' + result.insertId + ',';
      for (const k in specs[i]) {
        if (i === 0) {
          field += k + ',';
        }
        insertData += '"' + specs[i][k] + '",';
      }
      insertData = insertData.slice(0, -1);
      insertData += '),';
      if (i === 0) {
        field = field.slice(0, -1);
        field += ')';
      }
    }
    insertData = insertData.slice(0, -1);
    sql += field + 'values' + insertData;
    await app.mysql.query(sql);
    return result;

  }
  async update(id) {
    const { ctx, app } = this;
    const data = ctx.request.body;
    data.update_time = Date.now();
    await this.app.mysql.delete('goods_specs', {
      gid: id,
    });
    let sql = 'insert into goods_specs ';
    let field = '(gid,';
    let insertData = '';
    for (let i = 0; i < data.specs.length; i++) {
      insertData += '(' + id + ',';
      for (const k in data.specs[i]) {
        if (i === 0) {
          field += k + ',';
        }
        insertData += data.specs[i][k] + ',';
      }
      insertData = insertData.slice(0, -1);
      insertData += '),';
      if (i === 0) {
        field = field.slice(0, -1);
        field += ')';
      }
    }
    insertData = insertData.slice(0, -1);
    sql += insertData;
    await app.mysql.query(sql);
    return await app.mysql.update('goods', ctx.request.body, { where: { id } });
  }
  async del(id) {
    await this.app.mysql.delete('goods_specs', {
      gid: id,
    });
    return await this.app.mysql.delete('goods', {
      id,
    });
  }
}

module.exports = GoodsService;
