import http from './http';
import path from './path';
export default {
    //return promise(异步编程方案)
    all(query = {}) {
        return http.get(path.orders, { params: query })
    },
    one(id) {
        return http.get(path.orders + '/' + id)
    },
    edit(id, data) {
        return http.put(path.orders + '/' + id, data)
    },
    add(data = {}) {
        return http.post(path.orders, data)
    },
    del(id) {
        return http.delete(path.orders + '/' + id)
    }
}