# Admin-API

## 登录
```
POST /api/login
```
参数：
- username
- password

## 系统设置
```
get /api/info/1
put /api/info/2
```
## 轮播管理
```
get /api/wheel
post /api/wheel
put /api/wheel/ID
delete /api/wheel/ID
```
## 新闻分类
```
get /api/category-news
post /api/category-news
put /api/category-news/ID
delete /api/category-news/ID
```
## 新闻列表
```
get /api/news
post /api/news
put /api/news/ID
delete /api/news/ID
```
## 商品分类
```
get /api/category-goods
post /api/category-goods
put /api/category-goods/ID
delete /api/category-goods/ID
```
## 商品
```
get /api/goods
post /api/goods
put /api/goods/ID
delete /api/goods/ID
```