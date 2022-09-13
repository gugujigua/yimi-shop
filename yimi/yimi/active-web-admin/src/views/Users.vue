<template>
  <el-card>
    
    <el-table :data="usersData" border style="width: 100%" class="tabllist">
      <el-table-column fixed prop="id" label="ID" width="50"></el-table-column>
      <el-table-column prop="username" label="账号" min-width="180" :show-overflow-tooltip="true"></el-table-column>
      <el-table-column prop="nickname" label="昵称" :show-overflow-tooltip="true"></el-table-column>
      
      <el-table-column prop="email" label="邮箱"></el-table-column>
      <el-table-column prop="phone" label="手机"></el-table-column>
      <el-table-column fixed="right" label="操作" width="150" align="center">
        <template slot-scope="scope">
          
          <el-button type="text" size="small" @click.native.prevent="delUsers(scope.row)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination background
    v-if="usersData.length>0"
    layout="prev,pager, next,total"
    :total="total"
    :page-size.sync="limit"
    :current-page.sync="page"
    @current-change="getUsers"></el-pagination>
  </el-card>
</template>
<script>
export default {
  data() {
    return {
        limit:10,
        page:1,
        total:0,
      usersData: [],
    }
  },
  methods: {
    //删除
    delUsers(data) {
      var that = this;
      this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$api.users.del(data.id).then(res => {
          if (res.data.code == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            })
            this.getUsers();
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
    getUsers() {
      this.$api.users.all({page:this.page,limit:this.limit}).then(res => {
        if (res.data.code == 200) {
            this.total = res.data.data.total;
          this.usersData = res.data.data.data;
        }
      })
    }
  },
  mounted() {
    this.getUsers();
  }
}
</script>
<style lang="less" scoped>

</style>