'use strict';
const Service = require('egg').Service;

class CategoryNewsService extends Service {
  async find(id) {
    return await this.app.mysql.select('category_news', { id });
  }
  async all(where = {}, limit = 0) {
    const term = {
      where,
    };
    if (limit) {
      term.limit = limit;
    }
    return await this.app.mysql.select('category_news', term);
  }
  async add() {
    const { ctx, app } = this;
    return await app.mysql.insert('category_news', ctx.request.body);
  }
  async update(id) {
    const { ctx, app } = this;
    return await app.mysql.update('category_news', ctx.request.body, { where: { id } });
  }
  async del(id) {
    return await this.app.mysql.delete('category_news', {
      id,
    });
  }
}

module.exports = CategoryNewsService;
