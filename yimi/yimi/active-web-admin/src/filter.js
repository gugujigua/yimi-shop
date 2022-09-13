export default{
    install(Vue, options) {
        Vue.filter("currency", function (value = '0', currencyType = '￥', limit = 2) {
            let res;
            value = value.toFixed(limit);
            let prev = value.toString().split('.')[0]; //获取整数部分
            let next = value.toString().split('.')[1];
            res = prev.toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,') + '.' + next;
            return currencyType + res
        })
        Vue.filter("date", function (val, format = 'yyyy-MM-dd') {
            if (/^\d+$/.test(val)) {
                val = String(val)
                val = val.padEnd(13, '0') * 1;
            }
            if (!isNaN(val)) {
                val *= 1;
            }
            var date = new Date(val);
            if (/(y+)/.test(format)) {
                format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length))
            }
            let o = {
                'M+': date.getMonth() + 1,
                'd+': date.getDate(),
                'h+': date.getHours(),
                'm+': date.getMinutes(),
                's+': date.getSeconds()
            };
            for(let k in o){
                if (new RegExp(`(${k})`).test(format)) {
                    let str = o[k] + '';
                    format = format.replace(RegExp.$1, (RegExp.$1.length === 1) ? str : ('00' + str).substr(str.length));
                }
            }
            return format;
        })
    }
}