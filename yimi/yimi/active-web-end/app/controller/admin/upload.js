'use strict';

const Controller = require('egg').Controller;
const path = require('path');
const fs = require('fs');
const sendToWormhole = require('stream-wormhole');
class UploadController extends Controller {
  /**
    * POST 保存新增资源
    */
  async create() {
    const { ctx } = this;

    // 读取提交的文件流
    const stream = await ctx.getFileStream();

    // 获取上传的文件名  like.jpg dog.png
    const file_name = path.basename(stream.filename);
    // 获取后缀名  .jpg .png
    const ext_name = path.extname(file_name);
    // 获取唯一文件名 1617595620625
    const new_file_name = Date.now() + Math.floor(Math.random() * 8999 + 1000);
    // 创建文件夹
    const date = new Date();
    const dir_name = [
      date.getFullYear(),
      (date.getMonth() + 1).toString().padStart(2, '0'),
      date.getDate().toString().padStart(2, '0'),
    ].join('');
    let upload_path = 'app/public/uploads/' + dir_name;
    if (!fs.existsSync(upload_path)) {
      fs.mkdirSync(upload_path);
    }
    // 拼接上传路径
    upload_path = upload_path + '/' + new_file_name + ext_name;

    // 创建一个可以写入的流
    const writeStream = fs.createWriteStream(upload_path);
    try {
      // 把读取到的表单信息流写入创建的可写流
      await stream.pipe(writeStream);
    } catch (err) {
      // 上传失败销毁流
      await sendToWormhole(stream);

      ctx.body = {
        code: 404,
        msg: '上传失败',
      };
    }
    ctx.body = {
      code: 200,
      msg: '上传成功',
      data: '/public/uploads/' + dir_name + '/' + new_file_name + ext_name,
    };
    ctx.status = 200;
  }
}
module.exports = UploadController;
