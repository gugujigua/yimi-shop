<template>
  <el-card>
    <el-row :gutter="20">
      <el-col :span="12">
        <div class="grid-content bg-purple">
          <el-button type="primary" @click="$router.go(-1)">返回</el-button>
        </div>
      </el-col>
    </el-row>
    <el-form ref="addform" :model="addform"  label-width="80px" style="margin-top:20px;">
      <el-form-item label="父级：">
            <el-cascader
            :options="selectCatesData"
            :props="{ checkStrictly: false,label:'catename',value:'id',emitPath:false }"
            v-model="addform.cate_id"
            clearable></el-cascader>
        </el-form-item>
      <el-form-item label="标题" prop="title">
        <el-input v-model="addform.title" placeholder="最多输入50个字符" maxlength="50"></el-input>
      </el-form-item>
      <el-form-item label="副标题" prop="sub_title">
        <el-input v-model="addform.sub_title" placeholder="最多输入50个字符" maxlength="50"></el-input>
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
      <el-form-item label="规格">
        <div>
            <el-button type="primary" @click="addSpecs">添加规格</el-button>
        </div>
        <el-table
            :data="addform.specs"
            border
            style="width: 100%;margin-top:20px ;">
            <el-table-column
            prop="specs"
            label="规格">
            <template slot-scope="scope">
                    <el-input v-model="scope.row.specs"></el-input>
                </template>
            </el-table-column>
            <el-table-column
            prop="original_price"
            label="原价">
                <template slot-scope="scope">
                    <el-input v-model="scope.row.original_price"></el-input>
                </template>
            </el-table-column>
            <el-table-column
            prop="price"
            label="现价">
            <template slot-scope="scope">
                <el-input v-model="scope.row.price"></el-input>
                </template>
            </el-table-column>
            <el-table-column
            prop="stock"
            label="库存">
                <template slot-scope="scope">
                <el-input v-model="scope.row.stock"></el-input>
                </template>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width="150" align="center">
                <template slot-scope="scope">
                <el-button type="text" size="small" @click.native.prevent="delSpces(scope.$index)">删除
                </el-button>
                </template>
            </el-table-column>
        </el-table>
      </el-form-item>
      <el-form-item label="内容" prop="content">
        <div id="content" style="z-index:1;position:relative">
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
      selectCatesData:[],
      uploadfile: null,
      editor: null,
      cates:[],
      specs:[],
      addspecs:{},
      addform: {
        title: '',
        description: '',
        thumb: '',
        content: '',
        cate_id:'',
        specs:[]
      }
    }
  },
  mounted() {
    var that = this;
    // 获取分类
    this.$api.categoryGoods.all().then(res => {
    if (res.data.code == 200) {
        this.selectCatesData = res.data.data;
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
      addSpecs(){
          this.addform.specs.push({
              specs:"",
              price:0,
              original_price:0,
              stock:0
          })
      },
      delSpces(index){
          this.addform.specs.splice(index,1)
      },
    addsubmit() {
        var that = this;
      this.$api.goods.add(this.addform).then(res => {
        if (res.data.code == 200) {
            this.$message({
                type: "success",
                message: res.data.msg,
                onClose() {
                    that.$router.push({name: 'Goods'})
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