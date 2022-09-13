import http from './http';
import path from './path';
export default{
    //return promise(异步编程方案)
    login(data={}){
        return http.post(path.login,data)
    },
    edit(data) {
        return http.put(path.login+'/1', data)
    }
}