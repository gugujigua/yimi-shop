'use strict';
const Service = require('egg').Service;

class NewsService extends Service {
  async find() {
    const { ctx } = this;
    return await this.app.mysql.query('select news.*,category_news.catename from news left join category_news on news.cat_id=category_news.id where news.id=' + ctx.params.id);
  }
  async all(options = { }) {
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
        if (where[i].indexOf('%') !== -1) {
          term += i + " like '" + where[i] + "',";
        } else {
          term += i + "='" + where[i] + "',";
        }

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
    const total = await this.app.mysql.query('select count(*)as total from news ' + term);
    const pages = Math.ceil(total[0].total / limit);
    const data = await app.mysql.query('select news.*,category_news.catename from news left join category_news on news.cat_id=category_news.id ' + term + order + ' limit ' + offset + ',' + limit);
    
    return {
      total: total[0].total,
      data,
      pages,
      page,
    };
  }
  async add() {
    const { ctx, app } = this;
    ctx.request.body.create_time = Date.now();
    ctx.request.body.update_time = Date.now();
    return await app.mysql.insert('news', ctx.request.body);
  }
  async update(id) {
    const { ctx, app } = this;
    ctx.request.body.update_time = Date.now();
    return await app.mysql.update('news', ctx.request.body, { where: { id } });
  }
  async del(id) {
    return await this.app.mysql.delete('news', {
      id,
    });
  }
}

module.exports = NewsService;
