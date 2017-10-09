# FancyMovie

**Keyword: MVVM, RxSwift**

Swift 练手项目，仿Cineast, 查看热门影视剧明星等信息，API来源[The Movie Database API](https://developers.themoviedb.org/3/authentication)

###### 项目结构
 * APPDelegate 无需多说
 * RootViewController 继承自TabBarController，包含Sections下的三个部分
 * General中东西略杂：APIService 所有的网络请求都在此文件中实现，NavigatorService 实现页面之间的跳转，其他的为工具类
 * Marco中只有一个文件，定义了一些常用的东东
 * Sections中每个部分都包含Models，ViewControllers，ViewModels和Views四个部分。

###### 截图
![image.png](http://upload-images.jianshu.io/upload_images/2992566-602462c765f5685c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/420) ![image.png](http://upload-images.jianshu.io/upload_images/2992566-1bcb1c8cffd9be4c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/420) ![image.png](http://upload-images.jianshu.io/upload_images/2992566-46a0a023058f5460.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/420) ![image.png](http://upload-images.jianshu.io/upload_images/2992566-1fdc0c9c6fb71672.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/420)

如有疑问欢迎指出！
