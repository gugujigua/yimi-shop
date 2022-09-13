<template>
  <el-card class="box-card">
    <el-button type="primary" @click="$router.go(-1)">返回</el-button>
    <el-form ref="addform" :model="addform"  label-width="80px">
      <el-form-item label="分类" prop="cat_id">
        <el-select v-model="addform.cat_id" placeholder="请选择分类">
            <el-option
            v-for="item in cates"
            :key="item.id"
            :label="item.catename"
            :value="item.id">
            </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="标题" prop="title">
        <el-input v-model="addform.title" placeholder="最多输入50个字符" maxlength="50"></el-input>
      </el-form-item>
      <el-form-item label="描述" prop="description">
        <el-input type="textarea" v-model="addform.description" maxlength="200" placeholder="最多输入200个字符"></el-input>
      </el-form-item>
      <el-form-item label="缩略图">
          <el-upload
            class="avatar-uploader"
            :action="$store.state.host+'/api/upload'"
            :show-file-list="false"
            :on-success="handleThumbSuccess"
            :before-upload="beforeThumbUpload">
            <img v-if="addform.thumb" :src="$store.state.host+addform.thumb" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
      </el-form-item>
      <el-form-item label="内容" prop="content">
        <div id="content">
        </div>
      </el-form-item>
      
      <el-form-item>
        <el-button type="primary" @click="addsubmit">提交</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>
<script>
import wangEditor from 'wangeditor'

export default {
  data() {
    return {
      uploadfile: null,
      editor: null,
      cates:[],
      addform: {
        title: '',
        description: '',
        thumb: '',
        content: '',
        cat_id:1
      }
    }
  },
  mounted() {
    var that = this;
    // 获取分类
    this.$api.categoryNews.all({is_enable:1}).then(res=>{
        if(res.data.code == 200){
            this.cates = res.data.data;
        }
    })
    // 富文本编辑器
    const editor = new wangEditor('#content')
    // 配置 onchange 回调函数，将数据同步到 vue 中
    editor.config.onchange = (newHtml) => {
      this.addform.content = newHtml;
    };
    // 配置 server 接口地址
    editor.config.uploadImgServer = this.$store.state.host + '/api/upload'
    editor.config.uploadFileName = 'image'
    editor.config.uploadImgHooks = {
      // 例如服务器端返回的不是 { errno: 0, data: [...] } 这种格式，可使用 customInsert
      customInsert: function(insertImgFn, result) {
          // result 即服务端返回的接口

          // insertImgFn 可把图片插入到编辑器，传入图片 src ，执行函数即可
          insertImgFn(that.$store.state.host +result.data)
      }
    }
    // 创建编辑器
    editor.create();
    this.editor = editor;
  },
  methods: {
    addsubmit() {
        var that = this;
      this.$api.news.add(this.addform).then(res => {
        if (res.data.code == 200) {
            this.$message({
                type: "success",
                message: res.data.msg,
                onClose() {
                    that.$router.push({name: 'News'})
                }
            })
        }
      })
    },
    handleThumbSuccess(response, file, fileList) {
      if (response.code == 200) {
        this.addform.thumb = response.data;
      } else {
        this.message.error(response.msg);
      }
    },
    // 上传文件限制
    beforeThumbUpload(file) {
      var name = file.name.split(".");
      var type = name[name.length-1];
      var arr = ['png', 'jpeg', 'jpg', 'gif'];
      if (arr.indexOf(type) == -1) {
        this.$message.error('上传文件只能是png、jpeg、jpg、gif格式图片');
        return false;
      }
      return true;
    }
  },
  beforeDestroy() {
    // 调用销毁 API 对当前编辑器实例进行销毁
    this.editor.destroy()
    this.editor = null
  }
}
</script>
<style lang="less">
.avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 200px;
    height: 150px;
    line-height: 150px;
    text-align: center;
  }
  .avatar {
    width: 200px;
    height: 150px;
    display: block;
  }
</style>