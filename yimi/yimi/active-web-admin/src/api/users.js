import http from './http';
import path from './path';
export default {
    //return promise(异步编程方案)
    all(query = {}) {
        return http.get(path.users, { params: query })
    },
    one(id) {
        return http.get(path.users + '/' + id)
    },
    edit(id, data) {
        return http.put(path.users + '/' + id, data)
    },
    add(data = {}) {
        return http.post(path.users, data)
    },
    del(id) {
        return http.delete(path.users + '/' + id)
    }
}