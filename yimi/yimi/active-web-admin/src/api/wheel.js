import http from './http';
import path from './path';
export default {
    //return promise(异步编程方案)
    all(query = {}) {
        return http.get(path.wheel, { params: query })
    },
    one(id) {
        return http.get(path.wheel + '/' + id)
    },
    edit(id, data) {
        return http.put(path.wheel + '/' + id, data)
    },
    add(data = {}) {
        return http.post(path.wheel, data)
    },
    del(id) {
        return http.delete(path.wheel + '/' + id)
    }
}