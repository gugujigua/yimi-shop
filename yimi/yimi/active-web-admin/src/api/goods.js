import http from './http';
import path from './path';
export default {
    //return promise(异步编程方案)
    all(query = {}) {
        return http.get(path.goods, { params: query })
    },
    one(id) {
        return http.get(path.goods + '/' + id)
    },
    edit(id, data) {
        return http.put(path.goods + '/' + id, data)
    },
    add(data = {}) {
        return http.post(path.goods, data)
    },
    del(id) {
        return http.delete(path.goods + '/' + id)
    }
}