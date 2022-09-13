'use strict';
const Service = require('egg').Service;

class ThemeService extends Service { 
    async find(id) {
        return await this.app.mysql.select('theme', { id });
    }
    async update(id) {
        const { ctx, app } = this;
        return await app.mysql.update('theme', ctx.request.body, { where: { id } });
    }
}

module.exports = ThemeService;