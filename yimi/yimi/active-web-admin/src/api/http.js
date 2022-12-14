import axios from 'axios';
import {Message} from 'element-ui'
import router from '../router'
const instance = axios.create({
})
instance.interceptors.request.use(
    config => {
        config.headers.token = sessionStorage.getItem("token")//将接口返回的token信息配置到接口请求中
        return config;
    },
    error => {
        return Promise.reject(error);
    }
);
instance.interceptors.response.use(    
    response => {   
        // 如果返回的状态码为200，说明接口请求成功，可以正常拿到数据     
        // 否则的话抛出错误
        if (response.status === 200) {
            if(response.data.code ==404){
                Message({
                    message:response.data.msg,
                    type:"error"
                })
            }else if(response.data.code ==401){
                sessionStorage.removeItem('token');
                sessionStorage.removeItem('userdata');
                Message({
                    message:response.data.msg,
                    type:"error",
                    duration:1000,
                    onClose(){
                        router.push({name:'Login'})
                    }
                }) 
            }           
            return Promise.resolve(response);        
        } else {            
            return Promise.reject(response);        
        }    
    },
    err => {
        if (err && err.response) {
            switch (err.response.status) {
                case 400: err.message = '请求错误(400)' ; break;
                case 401: err.message = '未授权，请重新登录(401)'; break;
                case 403: err.message = '拒绝访问(403)'; break;
                case 404: err.message = '请求出错(404)'; break;
                case 408: err.message = '请求超时(408)'; break;
                case 500: err.message = '服务器错误(500)'; break;
                case 501: err.message = '服务未实现(501)'; break;
                case 502: err.message = '网络错误(502)'; break;
                case 503: err.message = '服务不可用(503)'; break;
                case 504: err.message = '网络超时(504)'; break;
                case 505: err.message = 'HTTP版本不受支持(505)'; break;
                default: err.message = `连接出错(${err.response.status})!`;
            }
        }else{
            err.message = '连接服务器失败!'
        }
        Message({
            message:err.message,
            type:"error"
        })
        return Promise.reject(err);
    }
)
export default instance;