//
//  JWCPageControl.swift
//  JWCPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

protocol JWCPageControlDelegate:class {
    //点击了左边的bar
    func pageControlDidselectedLeftBar(control:JWCPageControl)
    //点击了右边的bar
    func pageControlDidselectedRightBar(control:JWCPageControl)
    //当前展示的第几页
    func pageControl(control:JWCPageControl,showIndex sIndex:Int )
    
}


protocol JWCPageControlDataSource:class  {
    //titles
    func pageControlTitles(control:JWCPageControl) -> [String]
    //views
    func pageControlChildren(pageControl: JWCPageControl, viewAtIndex atIndex: Int) -> UIView
    
}


class JWCPageControl: UIView {
    
   weak var delegate : JWCPageControlDelegate?
   weak var dataSource : JWCPageControlDataSource?
   fileprivate var config:JWCPageNavBarConfig = JWCPageNavBarConfig()
   fileprivate var navBar : JWCPageNavBar?
   fileprivate  var container :JWCPageContainer?
    fileprivate var lastShowIndex: Int = -1
    init(frame: CGRect,config : JWCPageNavBarConfig) {
        self.config = config
        super.init(frame: frame)
        self.backgroundColor = self.config.navBarBackgroundColor
        setupUI()
     }
   
    func reloadData() {
        self.navBar?.reloadData()
        self.container?.reloadData(selectedIndex: config.defaultSelectedIndex)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   fileprivate func setupUI()  {
        navBar = JWCPageNavBar(frame: config.navFrame, config: config)
        navBar?.delegate = self
        navBar?.dataSource = self
        addSubview(navBar!)
        navBar?.setNeedsLayout()
        container = JWCPageContainer(frame: CGRect(x: 0, y: navBar!.frame.maxY, width: self.bounds.size.width, height: self.bounds.size.height - navBar!.frame.maxY))
        container?.delegate = self
        container?.dataSource = self
        addSubview(container!)
        container?.defaultSelect = config.defaultSelectedIndex
        container?.setNeedsLayout()
    }
    
   fileprivate func titlesArray() -> [String]? {
        let titles = dataSource?.pageControlTitles(control: self)
        return titles
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        config.navFrame = CGRect.init(x: config.navFrame.origin.x, y: config.navFrame.origin.y, width: self.bounds.width, height: config.navFrame.height)
        navBar?.frame = config.navFrame
        container?.frame = CGRect(x: 0, y: navBar?.frame.maxY ?? 0, width: self.bounds.size.width, height: self.bounds.size.height - (navBar?.frame.maxY ?? 0))
    }
    
}


//对外方法
extension JWCPageControl {
    func updateIndex(scrollToIndex tIndex:Int) {
        container?.scrollToIndexToIndex(fromIndex: 0, toIndex: tIndex, withAnimated: false)
        navBar?.scrollToIndex(toIndex: tIndex)
        delegate?.pageControl(control: self, showIndex: tIndex)
    }
}


extension JWCPageControl :JWCPageNavBarDelegate {
    func pageNavBarDidSelected(pageNavBar: JWCPageNavBar, oldIndex oIndex: Int, oldObj: UILabel, newIndex nIndex: Int, newObj: UILabel) {
        let ani = abs(nIndex - oIndex) > 1
        //内部联动
        container?.scrollToIndexToIndex(fromIndex: oIndex, toIndex: nIndex, withAnimated: !ani)
        //告诉外界当前展示的是第几个页面
        delegate?.pageControl(control: self, showIndex: nIndex)
    }
  
    func pageNavBarDidSelectedLeftBar(pageNavBar: JWCPageNavBar) {
        delegate?.pageControlDidselectedLeftBar(control: self)
    }
    func pageNavBarDidSelectedRightBar(pageNavBar: JWCPageNavBar) {
        delegate?.pageControlDidselectedRightBar(control: self)
    }
}

extension JWCPageControl :JWCPageNavDataSource {
    
    func pageNavBarTitles(pageNavBar: JWCPageNavBar) -> [String] {
        if titlesArray() == nil {
            return [String]()
        }
        return titlesArray()!
    }
}




extension JWCPageControl:JWCPageContainerDelegate {
  
    func pageContainer(pageContainer: JWCPageContainer, showIndex sIdx: Int) {
        if sIdx != lastShowIndex {
            lastShowIndex = sIdx
            delegate?.pageControl(control: self, showIndex: sIdx)
        }
    }
    
    func pageContainer(pageContainer: JWCPageContainer, switchFromIndex fIndex: Int, toIndex tIndex: Int, progress: CGFloat) {
        navBar?.scrollFromIndexToIndex(fromIndex: fIndex, toIndex: tIndex, withProgress: progress)
    }
    func pageContainerDidStop() {
        navBar?.currentViewDidEndScroll()
    }
    
}

extension JWCPageControl :JWCPageContainerDataSource {
    
    func pageContainerChildren(pageContainer: JWCPageContainer, viewAtIndex atIndex: Int) -> UIView {
        
        if let view = dataSource?.pageControlChildren(pageControl: self, viewAtIndex: atIndex) {
            return view
        }
        return UIView.init()
    }
    
    func pageContainerChildrenCount(pageContainer: JWCPageContainer) -> Int {
        return (titlesArray()?.count)!
    }
}







