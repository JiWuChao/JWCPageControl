//
//  JWCPageContainer.swift
//  JWCPageControl
//
//  Created by JiWuChao on 2018/3/19.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

protocol JWCPageContainerDelegate:class{
    //从某一个fromIndex 滚动到另一个toIndex
    func pageContainer(pageContainer:JWCPageContainer, switchFromIndex fIndex:Int,toIndex tIndex:Int ,progress:CGFloat)
 
    func pageContainer(pageContainer:JWCPageContainer,showIndex sIdx:Int)
    
    func pageContainerDidStop()
}

protocol JWCPageContainerDataSource:class{
    //container中显示几个View
    func pageContainerChildrenCount(pageContainer:JWCPageContainer) -> Int
    //每个index对应的view
    func pageContainerChildren(pageContainer:JWCPageContainer, viewAtIndex atIndex:Int) -> UIView
    
}

class JWCPageContainer: UIView {
    
    fileprivate  lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView(frame: self.bounds)
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.bounces = false
        addSubview(scroll)
        return scroll
    }()
    
    fileprivate var childrenCount :Int = 0
    // 当前的index
    fileprivate var currentIndex :Int = 0
    //原index
    fileprivate var oldIndex:Int = 0
    
    fileprivate var isClickedEv :Bool = false
    
    fileprivate lazy var cache :JWCPageCache = {
       let cache = JWCPageCache()
        return cache
    }()
    
    fileprivate  var startOffsetX : CGFloat = 0
    
    weak var delegate : JWCPageContainerDelegate?
    weak var dataSource : JWCPageContainerDataSource?
    var defaultSelect :Int = 0

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI()  {
        scrollView.setNeedsLayout()
    }
    
   fileprivate func updateContenSize() {
    if childrenCount == 0 {
        return
    }
        scrollView.contentSize = CGSize(width: scrollView.bounds.size.width * CGFloat(childrenCount), height: scrollView.bounds.size.height)
    }
   
    fileprivate func addChildren(childrenView children:UIView, atIndex aIndex:Int ,superView sView:UIView)  {
        let childrenView = cache.getCacheObj(atIndex: aIndex)
        if childrenView != children {
             childrenView?.removeFromSuperview()
            children.frame = CGRect(x: sView.bounds.size.width * CGFloat(aIndex), y: 0, width: sView.bounds.size.width, height: sView.bounds.size.height)
            sView.addSubview(children)
            cache.cacheObj(cacheObj: children, atIndex: aIndex)
//            scrollView.setContentOffset(CGPoint.init(x: 0, y: sView.bounds.size.width * CGFloat(aIndex)), animated: false)
        }
    }
    
    
}


// MARK: 对外方法
extension JWCPageContainer {
    
    // 从第几个滚动到第几个
    func scrollToIndexToIndex(fromIndex fIndex:Int, toIndex tIndex:Int, withAnimated animated:Bool)  {
        isClickedEv = true
        currentIndex = tIndex
        if !cache.hasCache(subIndex: tIndex) {
            let view = dataSource?.pageContainerChildren(pageContainer: self, viewAtIndex: tIndex)
            if view != nil {
                addChildren(childrenView: view!, atIndex: tIndex, superView: scrollView)
            } else {
                fatalError("dataSource?.pageContainerChildren(pageContainer: self, viewAtIndex: tIndex) return nil ")
            }
        } else {
            let view = cache.getCacheObj(atIndex: tIndex)
            view?.frame.size.width = scrollView.frame.width
            view?.frame.size.height = scrollView.frame.height
        }
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(tIndex), y: 0), animated: animated)
        oldIndex = tIndex
    }
    
    
    // 刷新列表
    func reloadData() {
        cache.removeAll()
        childrenCount = (dataSource?.pageContainerChildrenCount(pageContainer: self)) ?? 0
        updateContenSize()
        oldIndex = defaultSelect
        if childrenCount > 0 {
            var view = cache.getCacheObj(atIndex: defaultSelect )
            if (view == nil) {
                view = dataSource?.pageContainerChildren(pageContainer: self, viewAtIndex: defaultSelect)
                if view != nil {
                    addChildren(childrenView: view!, atIndex: defaultSelect, superView: scrollView)
                }
            }
        }
        scrollToIndexToIndex(fromIndex: 0, toIndex: defaultSelect, withAnimated: false)
        
    }
    
    func reloadData(selectedIndex:Int = 0) {
        defaultSelect = selectedIndex
        reloadData()
    }
    
}

extension JWCPageContainer:UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isClickedEv = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateContentIndex(scroller: scrollView)
    }
    
    func updateContentIndex(scroller scrollerView:UIScrollView)  {
        if isClickedEv {
            return
        }
        let switchIndex = getSwitchIndexs(scrollView: scrollerView)
        let fromIndex = switchIndex.fromIndex
        let toIndex = switchIndex.toIndex
        let progress = switchIndex.progress
        
        currentIndex = toIndex
        delegate?.pageContainer(pageContainer: self, switchFromIndex: fromIndex, toIndex: toIndex, progress: progress)
        if toIndex >= 0 && toIndex < childrenCount {
            var toView = cache.getCacheObj(atIndex: toIndex)
            if(toView == nil) {
                toView = dataSource?.pageContainerChildren(pageContainer: self, viewAtIndex: toIndex)
                if (toView != nil) {
                    addChildren(childrenView: toView!, atIndex: toIndex, superView: scrollView)
                }
            }
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.pageContainerDidStop()
        print("current: \(currentIndex)")
        print("getSwitchIndexs(scrollView: scrollView).toIndex = \(getSwitchIndexs(scrollView: scrollView).toIndex)")
        delegate?.pageContainer(pageContainer: self, showIndex: getSwitchIndexs(scrollView: scrollView).toIndex)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            delegate?.pageContainerDidStop()
        }
    }
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(childrenCount), height: self.bounds.height)
        for (index,view) in cache.getAll() {
            view.frame = CGRect(x: scrollView.bounds.size.width * CGFloat(index), y: 0, width: scrollView.bounds.size.width, height: scrollView.bounds.size.height)
        }
//         scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(currentIndex), y: 0), animated: false)
        
    }
    
    func getSwitchIndexs(scrollView:UIScrollView ) -> (fromIndex:Int,toIndex:Int,progress:CGFloat) {
        // 2.定义获取需要的数据
        var progress : CGFloat = 0.0
        var fromIndex : Int = 0
        var toIndex : Int = 0
        
        // 3.判断是向左滑还是向右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            
            // 2.计算sourceIndex
            fromIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            toIndex = fromIndex + 1
            if toIndex >= childrenCount {
                toIndex = childrenCount - 1
            }
//            print("progress : "+"\(progress)")
            //4.如果完全划出去
            if currentOffsetX - startOffsetX == scrollViewW || progress == 0 {
                progress = 1
                toIndex = fromIndex
            }
            
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            toIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            fromIndex = toIndex + 1
            if fromIndex >= childrenCount {
                fromIndex = childrenCount - 1
            }
        }
        
        return (fromIndex,toIndex,progress)
    }
    
}

