<template>
  <div class="login">
    <div class="login-container">
      <div class="logo">
        <span>欢迎登录</span>
        <span class="title" style="color:#EF8E25">{{info.name}}</span>
      </div>
      <el-form ref="loginform" :model="loginform" :rules="loginrule" label-width="50px">
        <el-form-item label="账号" prop="username">
          <el-input v-model="loginform.username" placeholder="请输入账号"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="loginform.password" show-password placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="loginsubmit()">登录</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name:'Login',
  data(){
    return {
      info:{name:""},
      userdata:{},
      loginform:{
        username:"",
        password:""
      },
      loginrule: {
          username: [
            { required: true, message: '请输入账号', trigger: 'blur' },
          ],
          password: [
            { required: true, message: '请输入密码', trigger: 'blur' },
          ],
      }
    }
  },
  methods:{
    loginsubmit(){
      this.$refs.loginform.validate((v)=>{
        if(v){
          this.$api.login.login(this.loginform).then(res=>{
            if(res.data.code==200){
              sessionStorage.setItem('token',res.data.token);
              sessionStorage.setItem('userdata',JSON.stringify(res.data.data));
              this.$message({
                message:res.data.msg,
                type:"success",
                duration:1000,
                onClose:()=>{
                  this.$router.push({name: "Main"})
                }
              })
            }
          })
        }else{
          return false;
        }
      })
    }
  },
  mounted(){
    this.$api.info.one().then(res=>{
        this.info.name=res.data.data.name;
    })
  }
}
</script>

<style lang="less">
.login{
  width: 100%;
  height: 100%;
  background: url('../assets/image/login-bg.jpeg') center center/cover no-repeat;
  .login-container{
    padding: 40px;
    width: 440px;
    position: absolute;
    left: 0;
    right: 0;
    top: 50%;
    margin: auto;
    transform: translateY(-50%);
    background-color: #fff;
    .logo{
      text-align: left;
      margin-bottom: 30px;
      span{
        font-size: 20px;
        vertical-align: bottom;
        margin-right: 30px;
      }
      img{
        height: 40px;
        vertical-align: bottom;
      }
    }
    .el-form{
      .el-button{
        width: 100%;
      }
    }
  }
}
</style>