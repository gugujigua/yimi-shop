'use strict';
const Service = require('egg').Service;

class WheelService extends Service {
  async find(id) {
    return await this.app.mysql.select('wheel', { id });
  }
  async all(where = { }) {
    return await this.app.mysql.select('wheel', {
      where,
    });
  }
  async add() {
    const { ctx, app } = this;
    return await app.mysql.insert('wheel', ctx.request.body);
  }
  async update(id) {
    const { ctx, app } = this;
    return await app.mysql.update('wheel', ctx.request.body, { where: { id } });
  }
  async del(id) {
    return await this.app.mysql.delete('wheel', {
      id,
    });
  }
}

module.exports = WheelService;
