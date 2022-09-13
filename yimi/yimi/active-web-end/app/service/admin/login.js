'use strict';
const Service = require('egg').Service;
const crypto = require('crypto');
class LoginService extends Service {
  async find(username) {
    const admin = await this.app.mysql.get('admin', { username });
    return admin;
  }
  async update() {
    const { ctx, app, config } = this;
    const hmac = crypto.createHmac('sha1', config.adminKey);
    // hmac.update(123456);
    hmac.update(ctx.request.body.newpwd);
    const password = hmac.digest('hex');
    // console.log(password);
    const data = {
      password,
    };
    return await app.mysql.update('admin', data, { where: { username: ctx.request.body.username } });
  }
}

module.exports = LoginService;
