<template>
<div>
    <el-card class="box-card">
        <div slot="header" class="clearfix">
            <span>商品配置</span>
        </div>
        <el-form ref="theme" :model="theme" label-width="100px">
        <el-form-item label="分类展示方式" >
            <el-radio-group v-model="theme.good_cate">
                <el-radio-button label="1">文字</el-radio-button>
                <el-radio-button label="2">图文</el-radio-button>
            </el-radio-group>
        </el-form-item>
        <el-form-item label="列表展示方式" >
            <el-radio-group v-model="theme.good_list">
                <el-radio-button label="1">卡片</el-radio-button>
                <el-radio-button label="2">列表</el-radio-button>
            </el-radio-group>
        </el-form-item>
        <el-form-item label="商品列表数量" >
            <el-slider
            v-model="theme.good_list_num"
            :min="3"
            :max="30"
            style="width:50%"
            show-stops>
            </el-slider>
        </el-form-item>
        <el-form-item label="商品详情对齐" >
            <el-radio-group v-model="theme.good_align">
                <el-radio-button label="left">居左</el-radio-button>
                <el-radio-button label="center">居中</el-radio-button>
                <el-radio-button label="right">居右</el-radio-button>
            </el-radio-group>
        </el-form-item>
        <el-form-item>
            <el-button type="primary"  @click="submit">提交</el-button>
        </el-form-item>
        </el-form>
    </el-card>
    <el-card class="box-card" style="margin:20px 0;">
        <div slot="header" class="clearfix">
            <span>新闻配置</span>
        </div>
        <el-form ref="theme" :model="theme" label-width="100px">
        <el-divider content-position="left">首页最新文章</el-divider>
        <el-form-item label="最新文章展示" >
            <el-radio-group v-model="theme.new_type">
                <el-radio-button label="1">卡片</el-radio-button>
                <el-radio-button label="2">列表</el-radio-button>
            </el-radio-group>
        </el-form-item>
        <el-form-item label="最新文章数量" >
            <el-slider
            v-model="theme.new_list_num"
            :step="3"
            :min="3"
            :max="18"
            style="width:50%"
            show-stops>
            </el-slider>
        </el-form-item>
        <el-divider content-position="left">阅读排行</el-divider>
        <el-form-item label="阅读排行展示" >
            <el-radio-group v-model="theme.new_rank">
                <el-radio-button label="1">文字</el-radio-button>
                <el-radio-button label="2">图文</el-radio-button>
            </el-radio-group>
        </el-form-item>
        <el-form-item label="阅读排行数量" >
            <el-slider
            v-model="theme.new_rank_num"
            :min="5"
            :max="20"
            style="width:50%"
            show-stops>
            </el-slider>
        </el-form-item>
        <el-divider content-position="left">新闻列表</el-divider>
        <el-form-item label="新闻列表展示" >
            <el-radio-group v-model="theme.new_list">
                <el-radio-button label="1">卡片</el-radio-button>
                <el-radio-button label="2">列表</el-radio-button>
            </el-radio-group>
        </el-form-item>
        <el-form-item label="新闻列表数量" >
            <el-slider
            v-model="theme.list_num"
            :step="3"
            :min="3"
            :max="18"
            style="width:50%"
            show-stops>
            </el-slider>
        </el-form-item>
        <el-divider content-position="left">新闻详情</el-divider>
        <el-form-item label="详情标题对齐" >
            <el-radio-group v-model="theme.title_align">
                <el-radio-button label="left">居左</el-radio-button>
                <el-radio-button label="center">居中</el-radio-button>
                <el-radio-button label="right">居右</el-radio-button>
            </el-radio-group>
        </el-form-item>
        <el-form-item label="上下页对齐" >
            <el-radio-group v-model="theme.page_align">
                <el-radio-button label="left">居左</el-radio-button>
                <el-radio-button label="center">居中</el-radio-button>
                <el-radio-button label="right">居右</el-radio-button>
            </el-radio-group>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="submit">提交</el-button>
        </el-form-item>
        
        </el-form>
    </el-card>
</div>
</template>
<script>
export default {
    data(){
        return {
            theme:{
                id:1,
                good_cate:1,
                good_list:1,
                good_list_num:5,
                good_align:'left',
                new_list:1,
                new_type:1,
                new_list_num:3,
                list_num:3,
                new_rank:1,
                new_rank_num:5,
                title_align:'left',
                page_align:'left'
            }
        }
    },
    methods:{
        submit(){
            this.$api.theme.edit(1,this.theme).then(res=>{
                if(res.data.code==200){
                    this.$message({
                        message: res.data.msg,
                        type: 'success'
                    });
                }
            })
        }
    },
    mounted(){
        this.$api.theme.one(this.theme.id).then(res=>{
            if(res.data.code==200){
                this.theme = res.data.data;
            }
        })
    }
}
</script>
<style lang="less">
</style>