import http from './http';
import path from './path';
export default{
    //return promise(异步编程方案)
    one(){
        return http.get(path.info+'/1')
    },
    edit(data){
        return http.put(path.info+'/1',data)
    }
}