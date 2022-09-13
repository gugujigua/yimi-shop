'use strict';
const Service = require('egg').Service;
const crypto = require('crypto');

class UsersService extends Service {
  async find(options = {}) {
    return await this.app.mysql.get('users', options);
  }
  async all(options = {}) {
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
    const total = await this.app.mysql.query('select count(*)as total from users ' + term);
    const pages = Math.ceil(total[0].total / limit);
    const data = await app.mysql.query('select * from users ' + term + order + ' limit ' + offset + ',' + limit);
    return {
      total: total[0].total,
      data,
      pages,
      page,
    };
  }
  async add() {
    const { ctx, app } = this;
    const username = ctx.request.body.username;
    const shasum = crypto.createHash('sha1');
    shasum.update(String(ctx.request.body.password));
    const password = shasum.digest('hex');
    return await app.mysql.insert('users', { username, password });
  }
  async update(where = {}) {
    const { ctx, app } = this;
    return await app.mysql.update('users', ctx.request.body, { where });
  }
  async del(id) {
    return await this.app.mysql.delete('users', {
      id,
    });
  }
}

module.exports = UsersService;
