<template>
  <el-card>
    <el-row :gutter="20">
      <el-col :span="12">
        <div class="grid-content bg-purple">
          <el-button type="primary" @click="addWheel">添加轮播</el-button>
        </div>
      </el-col>
    </el-row>

    <el-table :data="wheelData" border style="width: 100%" class="tabllist">
      <el-table-column fixed prop="id" label="ID" width="50"></el-table-column>
      <el-table-column prop="title" label="标题"></el-table-column>
      <el-table-column prop="thumb" label="图片"> 
        <template slot-scope="scope">
            <el-image
            style="height: 40px"
            :src="$store.state.host + scope.row.thumb"
            fit="scale-down"></el-image>
        </template>
      </el-table-column>
      <el-table-column prop="url" label="链接"></el-table-column>
      <el-table-column prop="sort" label="排序"></el-table-column>
      <el-table-column fixed="right" label="操作" width="150" align="center">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="show(scope.row)">查看</el-button>
          <el-button type="text" size="small" @click="edit(scope.row)">编辑</el-button>
          <el-button type="text" size="small" @click="del(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 查看弹窗 -->
    <el-dialog title="查看轮播" :visible.sync="showDialogVisible" width="60%">
      <el-form label-width="80px">
            <el-form-item label="标题">
              <el-input v-model="showform.title" readonly></el-input>
            </el-form-item>
            <el-form-item label="图片">
               <el-image
                style="width: 200px; height: 180px"
                :src="$store.state.host+showform.thumb"
                fit="scale-down"></el-image>
            </el-form-item>
            <el-form-item label="链接">
              <el-input v-model="showform.url" readonly></el-input>
            </el-form-item>
          <el-form-item label="排序">
              <el-input v-model="showform.sort" readonly></el-input>
            </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
                <el-button type="primary" @click="showDialogVisible = false">确 定</el-button>
            </span>
    </el-dialog>
    <!-- 添加弹窗 -->
    <el-dialog title="添加轮播" :visible.sync="addDialogVisible" width="60%">
      <el-form  ref="addform" :model="addform" label-width="80px">
            <el-form-item label="标题">
              <el-input v-model="addform.title" maxlength="100" placeholder="请输入标题"></el-input>
            </el-form-item>
            <el-form-item label="图片">
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
          <el-form-item label="链接">
              <el-input v-model="addform.url" placeholder="请输入链接地址"></el-input>
            </el-form-item>
            <el-form-item label="排序">
              <el-input v-model="addform.sort" placeholder="请输入排序"></el-input>
            </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="addSubmit">提交</el-button>
          <el-button @click="resetsub">重置</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
    <!-- 编辑弹窗 -->
    <el-dialog title="编辑轮播" :visible.sync="editDialogVisible" width="60%">
      <el-form :model="editform" label-width="80px">
        <el-form-item label="标题">
              <el-input v-model="editform.title" maxlength="100" placeholder="请输入标题"></el-input>
            </el-form-item>
            <el-form-item label="图片">
            <el-upload
            class="avatar-uploader"
            :action="$store.state.host+'/api/upload'"
            :show-file-list="false"
            :on-success="handleEditThumbSuccess"
            :before-upload="beforeThumbUpload">
            <img v-if="editform.thumb" :src="$store.state.host+editform.thumb" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
            </el-form-item>
          <el-form-item label="链接">
              <el-input v-model="editform.url" placeholder="请输入链接地址"></el-input>
            </el-form-item>
            <el-form-item label="排序">
              <el-input v-model="editform.sort" placeholder="请输入排序"></el-input>
            </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="editSubmit">提交</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </el-card>
</template>
<script>

export default {
  data() {
    return {
      wheelData:[],
      addform:{
          title:"",
          thumb:"",
          url:"",
          sort:0
      },
      editform:{
          title:"",
          thumb:"",
          url:"",
          sort:0
      },
      showform:{
          title:"",
          thumb:"",
          url:"",
          sort:0
      },
      addDialogVisible:false,
      showDialogVisible:false,
      editDialogVisible:false,
    }
  },
  methods: {
    //添加弹窗
    addWheel() {
      this.addDialogVisible = true;
    },
    //添加提交
    addSubmit() {
      var that = this;
      this.$api.wheel.add(this.addform).then(res => {
        if (res.data.code == 200) {
            this.$message({
                type: "success",
                message: res.data.msg,
                onClose() {
                  that.getWheel();
                    that.addDialogVisible = false;
                    that.$refs.addform.resetFields();
                }
            })
        }
      })
    },
    //添加重置
    resetsub() {
      this.$refs.addform.resetFields();
    },
    //查看弹窗
    show(data) {
      this.showDialogVisible = true;
      this.showform = data;
    },
    //编辑弹窗
    edit(data) {
      this.editDialogVisible = true;
      this.editform = JSON.parse(JSON.stringify(data))
    },
    //编辑提交
    editSubmit() {
      var that = this;
      this.$api.wheel.edit(this.editform.id, this.editform).then(res => {
        if (res.data.code == 200) {
          this.$message({
            type: "success",
            message: res.data.msg,
            onClose() {
              that.editDialogVisible = false;
              that.getWheel();
            }
          })
        }
      })
    },
    //删除
    del(data) {
      var that = this;
      this.$confirm('此操作将永久删除该轮播图, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$api.wheel.del(data.id).then(res => {
          if (res.data.code == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            })
            that.getWheel();
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    //查询所有
    getWheel() {
      this.$api.wheel.all().then(res => {
        if (res.data.code == 200) {
          this.wheelData = res.data.data;
          this.total = res.data.total;
        }
      });
    },
    // 添加上传图片
    handleThumbSuccess(response, file, fileList) {
      if (response.code == 200) {
        this.addform.thumb = response.data;
      } else {
        this.message.error(response.msg);
      }
    },
    // 编辑上传图片
    handleEditThumbSuccess(response, file, fileList) {
      if (response.code == 200) {
        this.editform.thumb = response.data;
      } else {
        this.message.error(response.msg);
      }
    },
    // 上传文件限制
    beforeThumbUpload(file) {
      var name = file.name.split(".");
      var type = name[name.length-1];
      var arr = ['png', 'jpeg', 'jpg', 'gif','webp'];
      if (arr.indexOf(type) == -1) {
        this.$message.error('上传文件只能是png、jpeg、jpg、gif、webp格式图片');
        return false;
      }
      return true;
    }
  },
  mounted() {
    this.getWheel();
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