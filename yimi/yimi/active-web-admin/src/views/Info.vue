<template>
    <el-card class="box-card">
        <div class="text item">
            <el-form ref="infoform" :model="infoform" label-width="100px">
                <el-form-item label="网站名称" >
                    <el-input v-model="infoform.name"></el-input>
                </el-form-item>
                <el-form-item label="网站标题" >
                    <el-input v-model="infoform.title"></el-input>
                </el-form-item>
                <el-form-item label="关键词" >
                    <el-input v-model="infoform.keywords"></el-input>
                </el-form-item>
                <el-form-item label="描述" >
                    <el-input type="textarea" v-model="infoform.description"></el-input>
                </el-form-item>
                <el-form-item label="版权">
                    <el-input type="textarea" v-model="infoform.copyright"></el-input>
                </el-form-item>
                
                <el-form-item>
                    <el-button type="primary" @click="infosubmit()">提交</el-button>
                </el-form-item>
            </el-form>
        </div>
    </el-card>
</template>
<script>
import axios from "axios"
export default {
    data(){
        return {
            infoform:{
                name: '',
                title: '',
                keywords: '',
                description: '',
                copyright: '',
            },
        }
    },
    methods:{
        infosubmit(){
            this.$api.info.edit(this.infoform).then(res=>{
                if(res.data.code==200){
                    this.$message({
                        message: res.data.msg,
                        type: 'success'
                    });
                }
            })
        },
    },
    beforeCreate(){
        this.$api.info.one().then(res=>{
            this.infoform=res.data.data;
        })
    }
}
</script>
<style lang="less">
</style>