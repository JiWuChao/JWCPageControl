//
//  JWCPageVC.swift
//  JWCPageControl
//
//  Created by JiWuChao on 2018/9/4.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

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
        
        let config = JWCPageNavBarConfig.init(navFrame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 44), isShowTrckLine: false, canScrollEnable: true, titleMargin: 25, firstTitleLeftMargin: 20, lastTitleRightMargin: 50, selectedCorlor: UIColor.init(red: 255/255, green: 126/255, blue: 0/255, alpha: 1), normalColor: UIColor.init(red: 45/255, green: 60/255, blue: 78/255, alpha: 0.3))
        config.isNeedScale = true
        config.scaleRange = 1.4
        config.rightBarItem = rightBtn
        config.leftBarItem = leftBtn
        config.defaultSelectedIndex = 0
        return config
    }()
    
    
    //    lazy var nav :JWCPageNavBar = {
    //        let navBar = JWCPageNavBar(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 44), config: config)
    //            navBar.dataSource = self
    //            navBar.delegate = self
    //        return navBar
    //    }()
    //
    var titles:[String] = ["女神大作战","热门","绝地求生","秀场","英雄联盟","绝地求生2","秀场2","英雄联盟2","绝地求生3","秀场4","英雄联盟5"]
    
    
    var pageControl:JWCPageControl = JWCPageControl(frame: CGRect.zero, config: JWCPageNavBarConfig())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        setPageControlView()
        
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
        //            self.titles = ["第1个","第2个","第3个","第4个"]
        //            self.pageControl.reloadData()
        //        }
        
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
