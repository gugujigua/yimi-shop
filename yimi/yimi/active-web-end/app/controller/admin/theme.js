'use strict';

const Controller = require('egg').Controller;

class ThemeController extends Controller {
    /**
      * GET 获取指定资源
      */
    async show(id) {
        const { ctx } = this;
        const data = await ctx.service.common.theme.find();
        ctx.body = {
            code: 200,
            msg: '获取成功',
            data: data[0] || {},
        };
        ctx.status = 200;
    }
    /**
      * PUT 保存更新资源
      */
    async update() {
        const { ctx } = this;
        const data = await ctx.service.common.theme.update(ctx.params.id);
        if (data.affectedRows > 0) {
            ctx.body = {
                code: 200,
                msg: '修改成功',
            };
        } else {
            ctx.body = {
                code: 404,
                msg: '修改失败',
            };
        }
        ctx.status = 200;
    }
    
}
module.exports = ThemeController;
