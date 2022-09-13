<template>
  <div class="main">
    <el-container class="main-con">
      <el-aside :width="isCollapse ? 'auto' : '200px' ">
        <div class="logo" style="font-size:20px;font-weight:200;color:#fff;text-align:center;">
          <span v-if="isCollapse">{{info.name.slice(0,2)}}</span>
          <span v-else>{{info.name}}</span>
        </div>
        <el-menu :collapse="isCollapse" class="leftmenu" background-color="#4977A9" text-color="#fff" :default-active="defaultActive"
                 active-text-color="#ffd04b" :router="true">
                 
          <template v-for="v in routes" v-if="!v.children && v.meta.isShow">
            <el-menu-item :index="v.name" :route="{name:v.name}">
              <i :class="v.meta.icon"></i>
              <span slot="title">{{ v.meta.title }}</span>
            </el-menu-item>
          </template>
          <template v-else-if="v.children && v.meta.isShow" >
            <el-submenu :index="v.name">
              <template slot="title">
                <i :class="v.meta.icon"></i>
                <span slot="title">{{ v.meta.title }}</span>
              </template>
              <el-menu-item :index="val.name" :route="{name:val.name}" v-for="val in v.children" v-if="val.meta.isShow">
                {{ val.meta.title }}
              </el-menu-item>
            </el-submenu>
          </template>
          
        </el-menu>
      </el-aside>
      <el-container>
        <el-header>
          <div class="openbtn" @click="isCollapse=!isCollapse">
            <i class="el-icon-menu-1" :class="{active:!isCollapse}"></i>
          </div>
          <el-menu class="topenv" mode="horizontal" @select="subMenuChange">
            <el-submenu index="111">
              <template slot="title">
                <div class="avatar">
                  <img src="../assets/image/person.png">
                </div>
                {{ userdata.username }}
              </template>
              <el-menu-item index="editpwd" @click="dialogFormVisible = true"><i class="el-icon-lock"></i> 修改密码
              </el-menu-item>
              <el-menu-item index="loginout"><i class="el-icon-switch-button"></i> 退出登录</el-menu-item>
            </el-submenu>
          </el-menu>
        </el-header>
        <el-main>
          <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item v-for="v in breadcrumb" v-if="currentpath !== v.path" :to="{ path: v.path }">
              {{ v.meta.title }}
            </el-breadcrumb-item>
            <el-breadcrumb-item v-else>{{ v.meta.title }}</el-breadcrumb-item>
          </el-breadcrumb>
          <router-view>
          </router-view>
        </el-main>
      </el-container>
    </el-container>
    <!--修改密码-->
    <el-dialog title="修改密码" :visible.sync="dialogFormVisible" @closed="resetForm()">
      <el-form :model="editpwd" status-icon :rules="editpwdrules" ref="editpwd" label-width="120px"
               class="demo-ruleForm">
        <el-form-item label="旧密码" prop="oldpwd">
          <el-input type="password" v-model="editpwd.oldpwd" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newpwd">
          <el-input type="password" v-model="editpwd.newpwd" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="renewpwd">
          <el-input type="password" v-model="editpwd.renewpwd" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="editpwdsubmit()">提交</el-button>
          <el-button @click="resetForm()">重置</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>

export default {
  name: 'Main',
  data() {
    var validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.editpwd.newpwd) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
    };
    return {
      info:{name:""},
      defaultActive: this.$route.name,
      userdata: {},
      isCollapse: false,
      routes: [],
      breadcrumb: [],
      currentpath: "",
      dialogFormVisible: false,
      editpwd: {
        oldpwd: '',
        newpwd: '',
        renewpwd: ''
      },
      editpwdrules: {
        oldpwd: [
          {required: true, message: '请输入旧密码', trigger: 'blur'},
        ],
        newpwd: [
          {required: true, message: '请输入新密码', trigger: 'blur'}
        ],
        renewpwd: [
          {required: true, message: '请再次输入新密码', trigger: 'blur'},
          {validator: validatePass, trigger: ['blur', 'change']}
        ],
      }
    }
  },
  methods: {
    editpwdsubmit() {
      this.$refs.editpwd.validate((v) => {
        if (v) {
          let username=JSON.parse(sessionStorage.getItem("userdata"))['username'];
          this.editpwd['username']=username;
          this.$api.login.edit(this.editpwd).then(res=>{
            if(res.data.code==200){
              this.$message({
                message:res.data.msg,
                type:"success",
                duration:1000,
              })
              this.subMenuChange('loginout')
            }
            this.dialogFormVisible=false;
            this. editpwd={
                oldpwd: '',
                newpwd: '',
                renewpwd: ''
            }
          })
        } else {
          return false;
        }
      })
    },
    subMenuChange(index) {
      if (index == 'loginout') {
        sessionStorage.removeItem("userdata");
        sessionStorage.removeItem("token");
        this.$router.push('/Login');
      }
    },
    resetForm() {
      this.$refs.editpwd.resetFields();
    }
  },
  created() {
    this.userdata = JSON.parse(sessionStorage.getItem("userdata"));
    this.routes = this.$router.options.routes[1].children;
    this.breadcrumb = this.$route.matched;
    this.currentpath = this.$route.path;
    this.defaultActive = this.$route.name;
  },
  beforeUpdate() {
    this.breadcrumb = this.$route.matched;
    this.currentpath = this.$route.path;
    this.defaultActive = this.$route.name;
    
  },
  mounted(){
    this.$api.info.one().then(res=>{
        this.info.name=res.data.data.name;
    })
  }
}
</script>

<style lang="less">
@import url('../assets/less/var.less');

.main {
  width: 100%;
  height: 100%;

  .main-con {
    width: 100%;
    height: 100%;

    .el-aside {
      background-color: #4977A9;
      height: 100%;
      box-shadow: 0px 10px 10px 0px rgba(0, 0, 0, 0.5);
      transition: all 2s;

      .logo {
        height: @titleHeight;
        padding: (@titleHeight - 20px)/2 20px;
        box-sizing: border-box;

        img {
          height: 20px;
        }
      }

      .el-menu {
        height: calc(100% - @titleHeight);
        overflow-y: auto;
        overflow-x: hidden;
        border-right: 0;

        .el-menu-item i, .el-submenu i {
          color: inherit
        }
      }
    }

    .el-container {
      .el-header {
        box-shadow: 5px 0px 10px 0px rgba(0, 0, 0, 0.1);
        padding-left: 0;

        .openbtn {
          float: left;
          width: @titleHeight;
          height: @titleHeight;
          text-align: center;
          line-height: @titleHeight;

          i {
            transition: all 0.5s;
          }

          .active {
            transform: rotate(90deg);
          }
        }

        .topenv {
          float: right;
          border-bottom: 0;
        }
      }

      .el-main {
        .el-breadcrumb {
          margin-bottom: 20px;
        }
      }
    }

    .el-header {
      .avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        overflow: hidden;
        float: left;
        margin-top: 9px;
        margin-right: 5px;

        img {
          width: 100%;
          height: 100%;
          vertical-align: initial;
        }
      }
    }
  }
}
</style>
