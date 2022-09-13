'use strict';
const Service = require('egg').Service;

class CategoryGoodsService extends Service {
  async find(id) {
    return await this.app.mysql.select('category_goods', { id });
  }
  async level1(options = {}) {
    return await this.app.mysql.select('category_goods', options);
  }
  async all(where = {}) {
    const cates = await this.app.mysql.select('category_goods', {
      where,
    });
    const treeData = getTree(0);
    function getTree(pid) {
      const data = [];
      for (let i = 0; i < cates.length; i++) {
        if (cates[i].pid == pid) {
          const child = getTree(cates[i].id);
          if (child.length > 0) {
            cates[i].children = child;
          }
          data.push(cates[i]);
        }
      }
      return data;
    }
    return treeData;
  }
  async add() {
    const { ctx, app } = this;
    return await app.mysql.insert('category_goods', ctx.request.body);
  }
  async update(id) {
    const { ctx, app } = this;
    return await app.mysql.update('category_goods', ctx.request.body, { where: { id } });
  }
  async del(id) {
    await this.app.mysql.delete('category_goods', {
      pid: id,
    });
    return await this.app.mysql.delete('category_goods', {
      id,
    });
  }
}

module.exports = CategoryGoodsService;
