var env='development';
if(env=='development'){
    var baseUrl="http://127.0.0.1:7001/api/";
}else{
    var baseUrl=""
}
export default{
    login:baseUrl+'login',
    info: baseUrl + 'info',
    wheel: baseUrl + 'wheel',
    categoryNews: baseUrl + 'category-news',
    news: baseUrl + 'news',
    categoryGoods: baseUrl + 'category-goods',
    goods: baseUrl + 'goods',
    users: baseUrl + 'users',
    orders: baseUrl + 'orders',
    theme: baseUrl + 'theme'
}