<template>
  <el-card>
    <el-row :gutter="20">
      <el-col :span="12">
        <div class="grid-content bg-purple">
          <el-button type="primary" @click="addCate">添加分类</el-button>
        </div>
      </el-col>
    </el-row>
    <el-table :data="catesData" border style="width: 100%" class="tabllist">
      <el-table-column fixed prop="id" label="ID" width="50"></el-table-column>
      <el-table-column prop="catename" label="分类名称"></el-table-column>
      <el-table-column prop="is_enable" label="启用" width="100">
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
        <el-form-item label="名称：">
          <el-input v-model="addCateData.catename"></el-input>
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
        <el-form-item label="名称：">
          <el-input v-model="editCateData.catename"></el-input>
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
      catesData: [],
      editCateData:{},
      addCateData:{
        catename:"",
        is_enable:"1"
      }
    }
  },
  methods: {
    //添加按钮
    addCate() {
       this.addDialogVisible = true;
    },
    addCateSubmit(){
      this.$api.categoryNews.add(this.addCateData).then(res => {
        if (res.data.code == 200) {
          this.$message({
            type: "success",
            message: res.data.msg
          })
          this.getCate();
          this.addDialogVisible = false;
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
    },
    editCateSubmit(){
      this.$api.categoryNews.edit(this.editCateData.id,this.editCateData).then(res => {
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
      this.$confirm('此操作将永久删除该新闻分类, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$api.categoryNews.del(data.id).then(res => {
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
      this.$api.categoryNews.all().then(res => {
        if (res.data.code == 200) {
          this.catesData = res.data.data;
        }
      })
    }
  },
  mounted() {
    this.getCate();
  }
}
</script>
<style lang="less" scoped>

</style>