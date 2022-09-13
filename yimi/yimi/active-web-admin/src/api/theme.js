import http from './http';
import path from './path';
export default {
    one(id) {
        return http.get(path.theme + '/' + id)
    },
    edit(id, data) {
        return http.put(path.theme + '/' + id, data)
    }
}