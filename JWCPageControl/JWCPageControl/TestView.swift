//
//  TestView.swift
//  JWCPageControl
//
//  Created by JiWuChao on 2018/7/26.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class TestView: UIView {

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
     
        let config = JWCPageNavBarConfig.init(navFrame:
            CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 44),
                                             coverBgColor: UIColor.red,
                                             coverAlpha: 0.8,
                                             coverMargin: 5,
                                             coverH: 20,
                                             coverRadius: 8,
                                             canScrollEnable: true,
                                             titleMargin: 20,
                                             firstTitleLeftMargin: 10,
                                             lastTitleRightMargin: 20,
                                             selectedColor: UIColor.white,
                                             normalColor: UIColor.black,
                                             isNeedScale: false,
                                             scaleRange: 1.2)
        return config
    }()
    
    var titles:[String] = ["COS","死亡地带","户外","尖峰时刻"]
    
    var pageControl:JWCPageControl = JWCPageControl(frame: CGRect.zero, config: JWCPageNavBarConfig())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setPageControlView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setPageControlView() {
        pageControl = JWCPageControl(frame: self.bounds, config: config)
        pageControl.backgroundColor = UIColor.white
        pageControl.delegate = self
        pageControl.dataSource = self
        addSubview(pageControl)
        pageControl.reloadData()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        pageControl.frame = self.bounds
    }

}
extension TestView :JWCPageControlDelegate {
    func pageControl(control: JWCPageControl, showIndex sIndex: Int) {
        //         print("showIndex:\(sIndex)")
    }
    
    func pageControlDidselectedLeftBar(control: JWCPageControl) {
        print("点击了左边")
    }
    
    func pageControlDidselectedRightBar(control: JWCPageControl) {
        print("点击了右边")
    }
    
}

extension TestView :JWCPageControlDataSource {
    func pageControlTitles(control: JWCPageControl) -> [String] {
        return self.titles;
    }
}



extension TestView:JWCPageNavDataSource {
    
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
