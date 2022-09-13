<template>
  <el-card>
    
    <el-table :data="ordersData" border style="width: 100%" class="tabllist">
      <el-table-column fixed prop="id" label="ID" width="50"></el-table-column>
      <el-table-column prop="order_id" label="订单号" min-width="180" :show-overflow-tooltip="true"></el-table-column>
      <el-table-column prop="money" label="金额">
          <template slot-scope="scope">
            {{scope.row.money|currency}}
          </template>
      </el-table-column>
      
      <el-table-column prop="email" label="订单状态">
          <template slot-scope="scope">
              {{states[scope.row.state]}}
          </template>
      </el-table-column>
      <el-table-column prop="create_time" label="创建时间">
          <template slot-scope="scope">
            {{scope.row.create_time|date('yyyy-MM-dd hh:mm:ss')}}
            </template>
      </el-table-column>
      <el-table-column prop="update_time" label="修改时间">
          <template slot-scope="scope">
          {{scope.row.update_time|date('yyyy-MM-dd hh:mm:ss')}}
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="150" align="center">
        <template slot-scope="scope">
          
          <el-button type="text" size="small" @click.native.prevent="delorders(scope.row)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination background
    v-if="ordersData.length>0"
    layout="prev,pager, next,total"
    :total="total"
    :page-size.sync="limit"
    :current-page.sync="page"
    @current-change="getorders"></el-pagination>
  </el-card>
</template>
<script>
export default {
  data() {
    return {
        limit:10,
        page:1,
        total:0,
        ordersData: [],
        states : {
            0: '已创建',
            1: '待付款',
            2: '已取消',
            3: '待发货',
            4: '已发货',
            5: '已收货',
        }
    }
  },
  methods: {
    //删除
    delorders(data) {
      var that = this;
      this.$confirm('此操作将永久删除该订单, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$api.orders.del(data.id).then(res => {
          if (res.data.code == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            })
            this.getorders();
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
    getorders() {
      this.$api.orders.all({page:this.page,limit:this.limit}).then(res => {
        if (res.data.code == 200) {
            this.total = res.data.data.total;
          this.ordersData = res.data.data.data;
        }
      })
    }
  },
  mounted() {
    this.getorders();
  }
}
</script>
<style lang="less" scoped>

</style>