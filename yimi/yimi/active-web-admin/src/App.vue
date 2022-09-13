<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  created(){
    
  },
  mounted(){
    
  }
}
</script>
<style lang="less">
#app {
  position: absolute;
  width: 100%;
  height: 100%;
}
.tabllist{
  margin: 20px 0;
}
.el-form-item{
  .logo-uploader {
      margin-top: 20px;
      .el-upload {
          border: 1px dashed #d9d9d9;
          border-radius: 6px;
          cursor: pointer;
          position: relative;
          overflow: hidden;
          &:hover {
              border-color: #409EFF;
          }
          .avatar-uploader-icon {
              font-size: 28px;
              color: #8c939d;
              width: 178px;
              height: 178px;
              line-height: 178px;
              text-align: center;
          }
          .logo {
              width: 178px;
              height: 178px;
              display: block;
          }
      } 
  }  
}

.el-table td, .el-table th{
  text-align: center !important;
}
.el-dialog__body{
  max-height: 410px;
  overflow-y: auto;
}
.el-tree-node{
  margin: 8px 0;
}
.el-input__inner{
  overflow: hidden;
  text-overflow:ellipsis;
  white-space: nowrap;
}
.downa{
  color:#007af9;
  margin-left:10px;
}
</style>
