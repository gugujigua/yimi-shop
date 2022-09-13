import http from './http';
import path from './path';
export default {
    //return promise(异步编程方案)
    all(query = {}) {
        return http.get(path.news, { params: query })
    },
    one(id) {
        return http.get(path.news + '/' + id)
    },
    edit(id, data) {
        return http.put(path.news + '/' + id, data)
    },
    add(data = {}) {
        return http.post(path.news, data)
    },
    del(id) {
        return http.delete(path.news + '/' + id)
    }
}