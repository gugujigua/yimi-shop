'use strict';
const Service = require('egg').Service;

class InfoService extends Service {
  async find() {
    return await this.app.mysql.get('info', { id: 1 });
  }
  async update(data) {
    const options = {
      where: {
        id: 1,
      },
    };
    return await this.app.mysql.update('info', data, options);
  }
}

module.exports = InfoService;
