# JWCPageControl

&emsp;在2018 年初的时候开始做这个组件，在项目中用了半年，目前已知的bug都已修复，当然现在还有一些问题，正在优化中。此组支持很多样式，每一种的样式细节都是可以调的
## 特点
1. 支持样式多
2. 使用方便灵活，类似于collectionView 和TableView的使用方式
3. 对页面有缓存，不会多次生成，滑动流畅
4. 整个组件分两部分组成，可以单独使用也可以组合使用

## 主要类
### 配置类 JWCPageNavBarConfig
&emsp; 主要配置JWCPageNavBar 的显示样式
 

```
class JWCPageNavBarConfig {
    
    var navFrame:CGRect = CGRect.zero
    
    var navBarBackgroundColor:UIColor = UIColor.white
    //默认选中第几个
    var defaultSelectedIndex :Int = 0
    
    //title的view是否可以左右滚动 一般情况下当title的个数固定的时候才需要设置为false
    var canScrollEnable :Bool = false
    //MARK:颜色
    
    //普通的Title 颜色
    var normalColor :UIColor = UIColor.white
    //选中的Title的颜色
    var selectedColor : UIColor = UIColor.black
    // Title的view的背景色
    var titleNorBgColor :UIColor?
    var titleSelectedBgColor :UIColor?
    
    //MARK:字体
    
    /// Title字体大小
    var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    /// 滚动Title的间距
    var titleMargin : CGFloat = 0
    /// titleView的高度
    var titleHeight : CGFloat = 44
    //第一个title 距离左边的距离
    var firstTitleLeftMargin : CGFloat = 0
    //最后一个title 距离右边的距离
    var lastTitleRightMargin : CGFloat = 0
    
    //MARK:底部滚动条
    
    /// 是否显示底部滚动条
    var isShowTrackLine : Bool = false
    /// 底部滚动条颜色
    var trackLineColor : UIColor = UIColor.orange
    /// 底部滚动条高度
    var trackLineH : CGFloat = 2
    /// 底部滚动条的宽度是否等宽 canScrollEnable 为 false 时有效isTrackDivide 表示宽度跟title的宽度一样
    var isTrackDivide: Bool = false
    
    
    //MARK: bottomLine
    
    var bottomLineColor : UIColor = UIColor.lightGray
    
    //MARK:缩进
    
    /// 是否进行缩放
    var isNeedScale : Bool = false
    var scaleRange : CGFloat = 1.2
    
    //MARK:遮盖
    
    /// 是否显示遮盖
    var isShowCover : Bool = false
    /// 遮盖背景颜色
    var coverBgColor : UIColor = UIColor.lightGray
    //遮盖的alpha值
    var coverAlpha : CGFloat = 0.7
    /// 文字&遮盖间隙
    var coverMargin : CGFloat = 5
    /// 遮盖的高度
    var coverH : CGFloat = 25
    
    /// 设置圆角大小
    var coverRadius : CGFloat = 0
    
    //MARK:左右BarItem
    
    var leftBarItem : UIView = UIView.init(frame: CGRect.zero)
    var rightBarItem : UIView = UIView.init(frame: CGRect.zero)
    
    
    /// 普通的样式
    ///
    /// - Parameters:
    ///   - navFrame: frame
    ///   - isShowTrckLine: 是否显示底部的跟踪线
    ///   - canScrollEnable:是否可以左右滑动（如果不设置为false，scrollView.contentSize = scrollView.bounds.size 不能左右滑动title）
    ///   - titleMargin: title的间距
    ///   - firstTitleLeftMargin: 第一个title 距离leftBarItem的距离
    ///   - lastTitleRightMargin: 最后一个title 距离rightBarItem的距离
    ///   - selectedCorlor: title选中的字体颜色
    ///   - normalColor: 正常的字体颜色
    ///   - defaultSelectedIndex:  默认选中第几个
    ///   - font: title字体大小
    convenience init(navFrame: CGRect,isShowTrckLine:Bool,
                     canScrollEnable:Bool,
                     titleMargin:CGFloat,
                     firstTitleLeftMargin:CGFloat,
                     lastTitleRightMargin:CGFloat,
                     selectedCorlor:UIColor,
                     normalColor:UIColor,
                     defaultSelectedIndex:Int = 0,font:UIFont = UIFont.systemFont(ofSize: 14)) {
        self.init()
        self.navFrame = navFrame
        self.isShowTrackLine = isShowTrckLine
        self.canScrollEnable = canScrollEnable
        self.titleMargin = titleMargin
        self.firstTitleLeftMargin = firstTitleLeftMargin
        self.selectedColor = selectedCorlor
        self.normalColor = normalColor
        self.isShowCover = false
        self.font = font
    }
    
    
    /// 遮罩样式
    ///
    /// - Parameters:
    ///   - navFrame: frame
    ///   - coverBgColor: 遮罩背景颜色
    ///   - coverAlpha: 遮罩的alpha
    ///   - coverMargin: 遮罩的间距
    ///   - coverH: 遮罩的高度
    ///   - coverRadius: 遮罩的圆角
    ///   - canScrollEnable: 是否可以左右滑动（如果不设置为false，scrollView.contentSize = scrollView.bounds.size 不能左右滑动title）
    ///   - titleMargin: title的间距
    ///   - firstTitleLeftMargin: 第一个title 距离leftBarItem的距离
    ///   - lastTitleRightMargin: 最后一个title 距离rightBarItem的距离
    ///   - selectedColor: title选中的字体颜色
    ///   - normalColor: title 正常的字体颜色
    ///   - defaultSelectedIndex: 默认选中第几个
    ///   - font: title字体大小
    ///   - isNeedScale: 是否需要选中有放大/缩小的效果
    ///   - scaleRange: 放大/缩小的比例 ：只有在isNeedScale = true时才有效
    convenience init(navFrame: CGRect,coverBgColor :UIColor,coverAlpha:CGFloat ,coverMargin:CGFloat,coverH:CGFloat,coverRadius:CGFloat,canScrollEnable:Bool, titleMargin:CGFloat, firstTitleLeftMargin:CGFloat, lastTitleRightMargin:CGFloat, selectedColor:UIColor, normalColor:UIColor, defaultSelectedIndex:Int = 0,font:UIFont = UIFont.systemFont(ofSize: 14),isNeedScale:Bool,scaleRange:CGFloat) {
        self.init()
        self.isShowCover = true
        self.navFrame = navFrame
        self.coverBgColor = coverBgColor
        self.coverAlpha = coverAlpha
        self.coverMargin = coverMargin
        self.coverH = coverH
        self.coverRadius = coverRadius
        self.canScrollEnable = canScrollEnable
        self.titleMargin = titleMargin
        self.firstTitleLeftMargin = firstTitleLeftMargin
        self.lastTitleRightMargin = lastTitleRightMargin
        self.selectedColor = selectedColor
        self.normalColor = normalColor
        self.defaultSelectedIndex = defaultSelectedIndex
        self.font = font
        self.isNeedScale = isNeedScale
        self.scaleRange = scaleRange
    }
    

    
   convenience init(navFrame:CGRect) {
        self.init()
    }
    
    
}

```

### title显示样式类 JWCPageNavBar


```
protocol JWCPageNavBarDelegate : class {
    //选中了某一个title Select
    func pageNavBarDidSelected(pageNavBar:JWCPageNavBar ,oldIndex oIndex:Int ,oldObj:UILabel,newIndex nIndex:Int ,newObj:UILabel)

    //选中了左边的bar
    func pageNavBarDidSelectedLeftBar(pageNavBar:JWCPageNavBar)
    //选中了右边的bar
    func pageNavBarDidSelectedRightBar(pageNavBar:JWCPageNavBar)

}
// 默认实现
extension JWCPageNavBarDelegate {
   func pageNavBarDidSelectedLeftBar(pageNavBar:JWCPageNavBar) {
    
    }
    
    func pageNavBarDidSelectedRightBar(pageNavBar:JWCPageNavBar) {
        
    }
    
}

//数据源类 
protocol JWCPageNavDataSource :class {
    //返回title数组
    func pageNavBarTitles(pageNavBar:JWCPageNavBar) -> [String]
    
}


// 刷新数据源 
func reloadData() 

//滚动到第几个 有progress
func scrollFromIndexToIndex(fromIndex fIndex :Int , toIndex tIndex:Int , withProgress progress:CGFloat) 

//滚动到第几个 无progress
 func scrollToIndex(toIndex tIdx:Int) 
 
 // 滚动停止 
 func currentViewDidEndScroll() 
 
```



### 管理类 JWCPageControl
&emsp;管理JWCPageContainer （pageControl的下半部分）和JWCPageNavBar （pageControl的title显示）的交互与控制


## 使用：部分样式如下
&emsp;只列举部分样式
### 单独使用JWCPageNavBar


```
 lazy var config:JWCPageNavBarConfig = {
        
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftBtn.backgroundColor = UIColor.red
        leftBtn.setTitle("left", for: .normal)
        leftBtn.setTitleColor(UIColor.white, for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightBtn.backgroundColor = UIColor.red
        rightBtn.setTitle("right", for: .normal)
        rightBtn.setTitleColor(UIColor.white, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        let config = JWCPageNavBarConfig.init(navFrame: CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 44), isShowTrckLine: true, canScrollEnable: true, titleMargin: 10, firstTitleLeftMargin: 10, lastTitleRightMargin: 10, selectedCorlor: UIColor.orange, normalColor: UIColor.black)
        //        config.leftBarItem = leftBtn
        config.rightBarItem = rightBtn
        //        config.isTrackDivide = true
        return config
    }()
    
    lazy var nav :JWCPageNavBar = {
        let navBar = JWCPageNavBar(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 44), config: config)
        navBar.dataSource = self
        navBar.delegate = self
        return navBar
    }()
    
```
![image](https://github.com/JiWuChao/JWCPageControl/blob/master/style/style2.gif?raw=true)


### 综合使用有嵌套


```
 lazy var config:JWCPageNavBarConfig = {
        
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftBtn.backgroundColor = UIColor.red
        leftBtn.setTitle("left", for: .normal)
        leftBtn.setTitleColor(UIColor.white, for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightBtn.backgroundColor = UIColor.red
        rightBtn.setTitle("right", for: .normal)
        rightBtn.setTitleColor(UIColor.white, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        let config = JWCPageNavBarConfig.init(navFrame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 44), isShowTrckLine: false, canScrollEnable: true, titleMargin: 25, firstTitleLeftMargin: 20, lastTitleRightMargin: 50, selectedCorlor: UIColor.init(red: 255/255, green: 126/255, blue: 0/255, alpha: 1), normalColor: UIColor.init(red: 45/255, green: 60/255, blue: 78/255, alpha: 0.3))
        config.isNeedScale = true
        config.scaleRange = 1.4
        config.rightBarItem = rightBtn
        config.leftBarItem = leftBtn
        config.defaultSelectedIndex = 0
        return config
    }()
    
```


```
pageControl.reloadData()
```


```
extension JWCPageVC :JWCPageControlDelegate {
    func pageControl(control: JWCPageControl, showIndex sIndex: Int) {
        print("showIndex:\(sIndex)")
    }
    
    func pageControlDidselectedLeftBar(control: JWCPageControl) {
        print("点击了左边")
    }
    
    func pageControlDidselectedRightBar(control: JWCPageControl) {
        print("点击了右边")
    }
    
}

extension JWCPageVC :JWCPageControlDataSource {
    func pageControlTitles(control: JWCPageControl) -> [String] {
        return self.titles;
    }
}



extension JWCPageVC:JWCPageNavDataSource {
    
    func pageNavBarTitles(pageNavBar: JWCPageNavBar) -> [String] {
        return titles
    }
    func pageControlChildren(pageControl: JWCPageControl, viewAtIndex atIndex: Int) -> UIView {
        
        if atIndex == 1 {
            let test = TestView.init(frame: self.view.bounds)
            return test
            
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let lbl = UILabel(frame: view.bounds)
        lbl.text = "第\(atIndex + 1)个"
        lbl.textAlignment = .center
        view.addSubview(lbl)
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return view
    }
}

```

![image](https://github.com/JiWuChao/JWCPageControl/blob/master/style/style1.gif?raw=true)


### 无嵌套无放大作用


```
class JWCPageVC: UIViewController {

    lazy var config:JWCPageNavBarConfig = {
        
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftBtn.backgroundColor = UIColor.red
        leftBtn.setTitle("left", for: .normal)
        leftBtn.setTitleColor(UIColor.white, for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightBtn.backgroundColor = UIColor.red
        rightBtn.setTitle("right", for: .normal)
        rightBtn.setTitleColor(UIColor.white, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        let config = JWCPageNavBarConfig.init(navFrame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 44), isShowTrckLine: true, canScrollEnable: true, titleMargin: 25, firstTitleLeftMargin: 20, lastTitleRightMargin: 50, selectedCorlor: UIColor.init(red: 255/255, green: 126/255, blue: 0/255, alpha: 1), normalColor: UIColor.init(red: 45/255, green: 60/255, blue: 78/255, alpha: 0.3))
        config.defaultSelectedIndex = 0
        return config
    }()
    
    

  var titles:[String] = ["文学","历史","美术","军事帝国","英雄联盟","作家园地","网络小说","小道野史"]
    
    
    var pageControl:JWCPageControl = JWCPageControl(frame: CGRect.zero, config: JWCPageNavBarConfig())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        setPageControlView()
    
        
    }
    
    func setPageControlView() {
        pageControl = JWCPageControl(frame: self.view.bounds, config: config)
        pageControl.backgroundColor = UIColor.white
        pageControl.delegate = self
        pageControl.dataSource = self
        view.addSubview(pageControl)
        pageControl.reloadData()
    }
    
    
    override func viewWillLayoutSubviews() {
        pageControl.frame = self.view.bounds
    }
    
    
    
    
}


extension JWCPageVC :JWCPageControlDelegate {
    func pageControl(control: JWCPageControl, showIndex sIndex: Int) {
        print("showIndex:\(sIndex)")
    }
    
    func pageControlDidselectedLeftBar(control: JWCPageControl) {
        print("点击了左边")
    }
    
    func pageControlDidselectedRightBar(control: JWCPageControl) {
        print("点击了右边")
    }
    
}

extension JWCPageVC :JWCPageControlDataSource {
    func pageControlTitles(control: JWCPageControl) -> [String] {
        return self.titles;
    }
}



extension JWCPageVC:JWCPageNavDataSource {
    
    func pageNavBarTitles(pageNavBar: JWCPageNavBar) -> [String] {
        return titles
    }
    func pageControlChildren(pageControl: JWCPageControl, viewAtIndex atIndex: Int) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let lbl = UILabel(frame: view.bounds)
        lbl.text = "第\(atIndex + 1)个"
        lbl.textAlignment = .center
        view.addSubview(lbl)
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return view
    }
}

```

![image](https://github.com/JiWuChao/JWCPageControl/blob/master/style/style4.gif?raw=true)

### 其他

![image](https://github.com/JiWuChao/JWCPageControl/blob/master/style/other3.gif?raw=true)

### 支持的样式 不止以上几种，根据自己需要配置
## 持续完善中。。。