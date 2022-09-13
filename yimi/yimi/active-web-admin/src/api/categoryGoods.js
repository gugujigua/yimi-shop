import http from './http';
import path from './path';
export default {
    //return promise(异步编程方案)
    all(query = {}) {
        return http.get(path.categoryGoods, { params: query })
    },
    one(id) {
        return http.get(path.categoryGoods + '/' + id)
    },
    edit(id, data) {
        return http.put(path.categoryGoods + '/' + id, data)
    },
    add(data = {}) {
        return http.post(path.categoryGoods, data)
    },
    del(id) {
        return http.delete(path.categoryGoods + '/' + id)
    }
}