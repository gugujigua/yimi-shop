<template>
  <el-card>
    <el-row :gutter="20">
      <el-col :span="12">
        <div class="grid-content bg-purple">
          <el-button type="primary" @click="addCate">添加分类</el-button>
        </div>
      </el-col>
    </el-row>
    <el-table :data="catesData" border style="width: 100%" row-key="id"
    default-expand-all
    :tree-props="{children: 'children', hasChildren: 'hasChildren'}" class="tabllist">
      <el-table-column fixed prop="id" label="ID" width="120"></el-table-column>
      <el-table-column prop="catename" label="分类名称"></el-table-column>
      <el-table-column prop="is_enable" label="启用" width="120">
        <template slot-scope="scope">
          {{scope.row.is_enable == 1? '启用' : "禁用"}}
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="150" align="center">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="editCate(scope.row)">编辑</el-button>
          <el-button type="text" size="small" @click.native.prevent="delCate(scope.row)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 添加分类弹窗 -->
    <el-dialog title="添加分类" :visible.sync="addDialogVisible" width="60%">
      <el-form label-width="80px">
          <el-form-item label="父级：">
              <el-cascader
                :options="selectCatesData"
                :props="{ checkStrictly: true,label:'catename',value:'id',emitPath:false }"
                v-model="addCateData.pid"
                clearable></el-cascader>
          </el-form-item>
        <el-form-item label="名称：">
          <el-input v-model="addCateData.catename"></el-input>
        </el-form-item>
        <el-form-item label="图片">
            <el-upload
            class="avatar-uploader"
            :action="$store.state.host+'/api/upload'"
            :show-file-list="false"
            :on-success="handleThumbSuccess"
            :before-upload="beforeThumbUpload">
            <img v-if="addCateData.thumb" :src="$store.state.host+addCateData.thumb" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
        </el-form-item>
        <el-form-item label="启用：">
            <el-switch
            v-model="addCateData.is_enable"
            active-color="#ffd04b"
            active-text="启用"
            inactive-text="禁用"
            active-value="1"
            inactive-value="0">
          </el-switch>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
          <el-button @click="addDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="addCateSubmit">确 定</el-button>
      </span>
    </el-dialog>
    <!-- 编辑分类弹窗 -->
    <el-dialog title="编辑分类" :visible.sync="editDialogVisible" width="60%">
      <el-form label-width="80px">
          <el-form-item label="父级：">
              <el-cascader
                :options="selectCatesData"
                :props="{ checkStrictly: true,label:'catename',value:'id',emitPath:false }"
                v-model="editCateData.pid"
                clearable></el-cascader>
          </el-form-item>
        <el-form-item label="名称：">
          <el-input v-model="editCateData.catename"></el-input>
        </el-form-item>
        <el-form-item label="图片">
            <el-upload
            class="avatar-uploader"
            :action="$store.state.host+'/api/upload'"
            :show-file-list="false"
            :on-success="handleEditThumbSuccess"
            :before-upload="beforeThumbUpload">
            <img v-if="editCateData.thumb" :src="$store.state.host+editCateData.thumb" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
        </el-form-item>
        <el-form-item label="启用：">
            <el-switch
            v-model="editCateData.is_enable"
            active-color="#ffd04b"
            active-text="启用"
            inactive-text="禁用"
            :active-value="1"
            :inactive-value="0">
          </el-switch>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
          <el-button @click="editDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="editCateSubmit">确 定</el-button>
      </span>
    </el-dialog>
  </el-card>
</template>
<script>
export default {
  data() {
    return {
      addDialogVisible:false,
      editDialogVisible:false,
      selectCatesData:[{
          id:0,
          catename:'一级分类'
      }],
      catesData: [],
      editCateData:{},
      addCateData:{
        catename:"",
        thumb:"",
        is_enable:"1",
        pid:[0]
      }
    }
  },
  methods: {
    //添加按钮
    addCate() {
       this.addDialogVisible = true;
    },
    addCateSubmit(){
        var data = JSON.parse(JSON.stringify(this.addCateData))
        // data.pid = this.addCateData.pid[this.addCateData.pid.length-1];
      this.$api.categoryGoods.add(data).then(res => {
        if (res.data.code == 200) {
          this.$message({
            type: "success",
            message: res.data.msg
          })
          this.getCate();
          this.addDialogVisible = false;
          this.addCateData = {
                catename:"",
                is_enable:"1",
                pid:0
            }
        }else{
          this.$message({
            type: "error",
            message: res.data.msg
          })
        }
      })
    },
    //编辑按钮
    editCate(data) {
      this.editDialogVisible = true;
      this.editCateData = JSON.parse(JSON.stringify(data));
      this.editCateData.pid = [data.pid]
    },
    editCateSubmit(){
      delete this.editCateData.children;
      this.editCateData.pid = this.editCateData.pid[this.editCateData.pid.length-1]
      this.$api.categoryGoods.edit(this.editCateData.id,this.editCateData).then(res => {
        if (res.data.code == 200) {
          this.$message({
            type: "success",
            message: res.data.msg
          })
          this.getCate();
          this.editDialogVisible = false;
        }else{
          this.$message({
            type: "error",
            message: res.data.msg
          })
        }
      })
    },
    //删除
    delCate(data) {
      var that = this;
      this.$confirm('此操作将永久删除该商品分类, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$api.categoryGoods.del(data.id).then(res => {
          if (res.data.code == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            })
            this.getCate();
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
    getCate() {
      this.$api.categoryGoods.all().then(res => {
        if (res.data.code == 200) {
            this.selectCatesData = [{
              id:0,
              catename:'一级分类'
            }].concat(res.data.data)
          this.catesData = res.data.data;
        }
      })
    },
    // 添加上传图片
    handleThumbSuccess(response, file, fileList) {
      if (response.code == 200) {
        this.addCateData.thumb = response.data;
      } else {
        this.message.error(response.msg);
      }
    },
    // 编辑上传图片
    handleEditThumbSuccess(response, file, fileList) {
      if (response.code == 200) {
        this.editCateData.thumb = response.data;
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
    this.getCate();
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