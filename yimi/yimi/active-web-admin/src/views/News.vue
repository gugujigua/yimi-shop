<template>
  <el-card>
    <el-row :gutter="20">
      <el-col :span="12">
        <div class="grid-content bg-purple">
          <el-button type="primary" @click="addNews">添加新闻</el-button>
        </div>
      </el-col>
    </el-row>
    <el-table :data="newsData" border style="width: 100%" class="tabllist">
      <el-table-column fixed prop="id" label="ID" width="50"></el-table-column>
      <el-table-column prop="title" label="新闻标题" min-width="180" :show-overflow-tooltip="true"></el-table-column>
      <el-table-column prop="description" label="新闻描述" :show-overflow-tooltip="true"></el-table-column>
      <el-table-column prop="thumb" label="新闻缩略图">
        <template slot-scope="scope">
            <el-image
            style="height: 50px"
            :src="$store.state.host + scope.row.thumb"
            fit="scale-down"></el-image>
        </template>
      </el-table-column>
      <el-table-column prop="catename" label="分类名称"></el-table-column>
      <el-table-column prop="create_time" label="发布时间" width="100">
        <template slot-scope="scope">
          {{scope.row.create_time|date}}
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="150" align="center">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="editNews(scope.row)">编辑</el-button>
          <el-button type="text" size="small" @click.native.prevent="delNews(scope.row)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination background
    v-if="newsData.length>0"
    layout="prev,pager, next,total"
    :total="total"
    :page-size.sync="limit"
    :current-page.sync="page"
    @current-change="getNews"></el-pagination>
  </el-card>
</template>
<script>
export default {
  data() {
    return {
        limit:10,
        page:1,
        total:0,
      newsData: [],
    }
  },
  methods: {
    //添加按钮
    addNews() {
       this.$router.push({name: 'AddNews'})
    },
    // 编辑新闻
    editNews(data){
       this.$router.push({name: 'EditNews',params: { id: data.id }})
    },
    //删除
    delNews(data) {
      var that = this;
      this.$confirm('此操作将永久删除该新闻, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$api.news.del(data.id).then(res => {
          if (res.data.code == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            })
            this.getNews();
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
    getNews() {
      this.$api.news.all({page:this.page,limit:this.limit}).then(res => {
        if (res.data.code == 200) {
            this.total = res.data.data.total;
          this.newsData = res.data.data.data;
        }
      })
    }
  },
  mounted() {
    this.getNews();
  }
}
</script>
<style lang="less" scoped>

</style>