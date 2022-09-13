'use strict';

const Controller = require('egg').Controller;
const crypto = require('crypto');
class HomeController extends Controller {

  /**
   * 首页
   */
  async index() {
    const { ctx } = this;
    const theme = await ctx.service.common.theme.find(1);
    const catesGoods = await ctx.service.common.goods.indexGoods();

    // 最新新闻
    const newNews = await ctx.service.common.news.all({
      orders: [[ 'id', 'desc' ]],
      limit: theme[0].new_list_num,
    });
    // 热门新闻
    const hotNews = await ctx.service.common.news.all({
      orders: [[ 'click', 'desc' ]],
      limit: theme[0].new_rank_num,
    });
    await ctx.render('home/index.html', { cat_id: 0, newNews: newNews.data, hotNews: hotNews.data, catesGoods });
  }
  /**
   * 新闻列表页
   */
  async newsList() {
    const { ctx } = this;
    const theme = await ctx.service.common.theme.find(1);
    const cateNews = await ctx.service.common.news.all({
      orders: [[ 'id', 'desc' ]],
      where: { cat_id: ctx.params.cat_id },
      limit: theme[0].list_num
    });
    const hotNews = await ctx.service.common.news.all({
      orders: [[ 'click', 'desc' ]],
      limit: theme[0].new_rank_num,
    });
    await ctx.render('home/news-list.html', { cat_id: ctx.params.cat_id, hotNews: hotNews.data, cateNews });
  }
  /**
   * 新闻搜索列表页
   */
  async newsSearch() {
    const { ctx } = this;
    const theme = await ctx.service.common.theme.find(1);
    const cateNews = await ctx.service.common.news.all({
      orders: [[ 'id', 'desc' ]],
      where: { title: '%' + ctx.query.key + '%' },
      limit: theme[0].list_num
    });
    const hotNews = await ctx.service.common.news.all({
      orders: [[ 'click', 'desc' ]],
      limit: theme[0].new_rank_num,
    });
    await ctx.render('home/news-search.html', { cat_id: ctx.params.cat_id, hotNews: hotNews.data, cateNews });
  }
  /**
   * 新闻详情页
   */
  async newsShow() {
    const { ctx } = this;
    const theme = await ctx.service.common.theme.find(1);
    const news = await ctx.service.common.news.find();
    news[0].click += 1;
    if (news[0]) {
      await this.app.mysql.update('news', { id: news[0].id, click: news[0].click });
    }
    const prevNews = await this.app.mysql.query('select id,title from news where id<? order by id desc limit 1', [ ctx.params.id ]);
    const nextNews = await this.app.mysql.query('select id,title from news where id>? order by id asc limit 1', [ ctx.params.id ]);
    
    const hotNews = await ctx.service.common.news.all({
      orders: [['click', 'desc']],
      limit: theme[0].new_rank_num,
    });
    await ctx.render('home/news-show.html', { hotNews: hotNews.data, news: news[0] || {}, prevNews: prevNews[0] || {}, nextNews: nextNews[0] || {}, cat_id: news[0].cat_id });
  }
  /**
   * 商品分类页
   */
  async cateList() {
    const { ctx } = this;
    const cat_id = ctx.params.cat_id;
    const type = ctx.query.type || 2;
    const subGoodCates = await ctx.service.common.categoryGoods.level1({
      where: { pid: ctx.params.cat_id, is_enable: 1 },
    });
    if (subGoodCates.length > 0) {
      var sub_cat_id = ctx.query.sub_id || subGoodCates[0].id;
      var data = await ctx.service.common.goods.cateGoods(sub_cat_id);
    } else {
      var sub_cat_id = 0;
      var data = {
        data: [],
        page: 0,
        pages: 0,
      };
    }

    await ctx.render('home/cate-list.html', { subGoodCates, sub_cat_id, cat_id, data, type });
  }
  /**
   * 商品详情页
   */
  async goodsShow() {
    const { ctx } = this;
    const data = await ctx.service.common.goods.find();
    await ctx.render('home/goods-show.html', { data: data[0], specs: data[0].specs, good_id: data[0].id });
  }
  /**
   * 购物车
   */
  async car() {
    const { ctx } = this;
    await ctx.render('home/goods-car.html');
  }
  /**
   * 个人中心
   */
  async personal() {
    const { ctx } = this;
    await ctx.render('home/goods-personal.html');
  }
  /**
   * ajax login
   */
  async login() {
    const { ctx } = this;
    const data = await ctx.service.common.users.find({
      username: ctx.request.body.username,
    });
    if (data) {
      const shasum = crypto.createHash('sha1');
      shasum.update(String(ctx.request.body.password));
      const password = shasum.digest('hex');
      if (data.password === password) {
        ctx.session.isLogin = true;
        ctx.session.username = data.username;
        ctx.session.nickname = data.nickname;
        ctx.body = {
          code: 200,
          msg: '登录成功',
          data: {
            username: data.username,
            nickname: data.nickname,
          },
        };
      } else {
        ctx.body = {
          code: 404,
          msg: '密码错误',
        };
      }

    } else {
      ctx.body = {
        code: 404,
        msg: '用户不存在',
      };
    }
    ctx.status = 200;
  }
  /**
   * ajax loginout
   */
  async loginout() {
    const { ctx } = this;
    ctx.session = null;
    ctx.body = {
      code: 200,
      msg: '退出登录',
    };
    ctx.status = 200;
  }
  /**
   * ajax register
   */
  async register() {
    const { ctx } = this;
    const username = ctx.request.body.username;
    
    const data = await ctx.service.common.users.find({ username });
    if (data) {
      ctx.body = {
        code: 404,
        msg: '用户名已存在',
      };
    } else {
      if (ctx.request.body.password != ctx.request.body.repassword) {
        ctx.body = {
          code: 404,
          msg: '两次密码输入不一致',
        };
      } else {
        const result = await ctx.service.common.users.add();
        if (result.affectedRows > 0) {
          ctx.body = {
            code: 200,
            msg: '注册成功',
          };
        } else {
          ctx.body = {
            code: 404,
            msg: '注册失败',
          };
        }
      }
      
    }
    ctx.status = 200;
  }
  async orderDone() {
    const { ctx } = this;
    const data = await ctx.service.common.orders.findGoods(ctx.params.order_id);
    await ctx.render('home/goods-order.html', { data });
  }
  /**
   * 订单确认
   */
  async orderConfirm() {
    const { ctx } = this;
    const data = await ctx.service.common.orders.find(ctx.params.id);
    ctx.request.body = { id: ctx.params.id, state: 1 };
    await ctx.service.common.orders.update();
    await ctx.render('home/goods-confirm.html', { data });
  }
  async paySuccess() {
    const { ctx } = this;
    await ctx.render('home/goods-success.html');
  }
  async personalInfo() {
    const { ctx } = this;
    const user = await ctx.service.common.users.find({ username: ctx.session.username });
    await ctx.render('home/personal-info.html', { user });
  }
  async changeInfo() {
    const { ctx } = this;
    const result = await ctx.service.common.users.update({ username: ctx.session.username });

    if (result.affectedRows > 0) {
      ctx.session.nickname = ctx.request.body.nickname;
      ctx.body = {
        code: 200,
        msg: '修改成功',
        data: {
          nickname: ctx.request.body.nickname,
        },
      };
    } else {
      ctx.body = {
        code: 404,
        msg: '修改失败',
      };
    }
    ctx.status = 200;
  }
  async personalOrder() {
    const { ctx } = this;
    const states = {
      0: '已创建',
      1: '待付款',
      2: '已取消',
      3: '待发货',
      4: '已发货',
      5: '已收货',
    };
    const orders = await ctx.service.common.orders.all({
      where: {
        username: ctx.session.username,
      },
      orders: [[ 'id', 'desc' ]],
    });
    await ctx.render('home/personal-order.html', {
      orders, states,
    });
  }
  async account() {
    const { ctx } = this;
    const hotNews = await ctx.service.common.news.all({
      orders: [[ 'click', 'desc' ]],
      limit: 10,
    });
    await ctx.render('home/account.html', { hotNews: hotNews.data });
  }
  async guide() {
    const { ctx } = this;
    const hotNews = await ctx.service.common.news.all({
      orders: [[ 'click', 'desc' ]],
      limit: 10,
    });
    await ctx.render('home/guide.html', { hotNews: hotNews.data });
  }
  async orderOperation() {
    const { ctx } = this;
    const hotNews = await ctx.service.common.news.all({
      orders: [[ 'click', 'desc' ]],
      limit: 10,
    });
    await ctx.render('home/order-operation.html', { hotNews: hotNews.data });
  }
}

module.exports = HomeController;
