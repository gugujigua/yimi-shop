<template>
  <el-card>
    <el-row :gutter="20">
      <el-col :span="12">
        <div class="grid-content bg-purple">
          <el-button type="primary" @click="addGoods">添加商品</el-button>
        </div>
      </el-col>
    </el-row>
    <el-table :data="goodsData" border style="width: 100%" class="tabllist">
      <el-table-column type="expand">
      <template slot-scope="props">
        <el-table :data="props.row.specs" border style="width: 100%">
          <el-table-column prop="specs" label="规格"></el-table-column>
          <el-table-column prop="price" label="现价">
            <template slot-scope="scope">
            {{scope.row.price|currency}}
          </template>
          </el-table-column>
          <el-table-column prop="original_price" label="原价">
            <template slot-scope="scope">
            {{scope.row.original_price|currency}}
          </template>
          </el-table-column>
          <el-table-column prop="stock" label="库存"></el-table-column>
        </el-table>
      </template>
    </el-table-column>
      <el-table-column prop="id" label="ID" width="50"></el-table-column>
      <el-table-column prop="title" label="名称"></el-table-column>
      <el-table-column prop="description" label="描述"></el-table-column>
      <el-table-column prop="thumb" label="缩略图">
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
          <!-- <el-button type="text" size="small" @click="edit(scope.row)">编辑</el-button> -->
          <el-button type="text" size="small" @click.native.prevent="del(scope.row)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination background
    v-if="goodsData.length>0"
    layout="prev,pager, next,total"
    :total="total"
    :page-size.sync="limit"
    :current-page.sync="page"
    @current-change="getGoods"></el-pagination>
  </el-card>
</template>
<script>
export default {
  data() {
    return {
      limit:10,
      page:1,
      total:0,
      goodsData: [],
    }
  },
  methods: {
    //添加按钮
    addGoods() {
       this.$router.push({name: 'AddGoods'})
    },
    // 编辑商品
    edit(data){
       this.$router.push({name: 'EditNews',params: { id: data.id }})
    },
    //删除
    del(data) {
      var that = this;
      this.$confirm('此操作将永久删除该商品, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$api.goods.del(data.id).then(res => {
          if (res.data.code == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            })
            this.getGoods();
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
    getGoods() {
      this.$api.goods.all({page:this.page,limit:this.limit}).then(res => {
        if (res.data.code == 200) {
            this.total = res.data.data.total;
          this.goodsData = res.data.data.data;
        }
      })
    }
  },
  mounted() {
    this.getGoods();
  }
}
</script>
<style lang="less" scoped>

</style>