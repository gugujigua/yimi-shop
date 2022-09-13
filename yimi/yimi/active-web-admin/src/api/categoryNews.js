import http from './http';
import path from './path';
export default {
    //return promise(异步编程方案)
    all(query = {}) {
        return http.get(path.categoryNews, { params: query })
    },
    one(id) {
        return http.get(path.categoryNews + '/' + id)
    },
    edit(id, data) {
        return http.put(path.categoryNews + '/' + id, data)
    },
    add(data = {}) {
        return http.post(path.categoryNews, data)
    },
    del(id) {
        return http.delete(path.categoryNews + '/' + id)
    }
}