//
//  JWCNAVBarVC.swift
//  JWCPageControl
//
//  Created by JiWuChao on 2018/9/4.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class JWCNAVBarVC: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(nav)
        nav.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        config.navFrame =  CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 44)
        nav.frame =  CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 44)
    }
    
}


extension JWCNAVBarVC:JWCPageNavBarDelegate {
    
    func pageNavBarDidSelected(pageNavBar: JWCPageNavBar, oldIndex oIndex: Int, oldObj: UILabel, newIndex nIndex: Int, newObj: UILabel) {
        print("old : \(oIndex) new :\(nIndex)")
    }
    
    func pageNavBarDidSelectedLeftBar(pageNavBar: JWCPageNavBar) {
        print("点击了左边")
    }
    
    func pageNavBarDidSelectedRightBar(pageNavBar: JWCPageNavBar) {
        print("点击了右边 ")
    }
    
}


extension JWCNAVBarVC:JWCPageNavDataSource {
    
    func pageNavBarTitles(pageNavBar: JWCPageNavBar) -> [String] {
        return ["第一","第haha二","第三weqewq","第四eqweqw","第五d","第六","第we七wq","第八","第九eqwewq","第十","第十一"]
    }
}
