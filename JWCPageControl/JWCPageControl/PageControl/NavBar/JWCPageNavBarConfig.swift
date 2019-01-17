//
//  LZPageNavBarConfig.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/15.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

import Foundation


///MARK:由于参数比较多 细节可配置的比较多 ，所以提供两个便利构造函数 用于生成两种比较常见的样式config



public class JWCPageNavBarConfig:NSObject {
    
   public var navFrame:CGRect = CGRect.zero
    
   public var navBarBackgroundColor:UIColor = UIColor.white
    //默认选中第几个
   public var defaultSelectedIndex :Int = 0
    
    //title的view是否可以左右滚动 一般情况下当title的个数固定的时候才需要设置为false
   public var canScrollEnable :Bool = false
    //MARK:颜色
    
    //普通的Title 颜色
   public var normalColor :UIColor = UIColor.white
    //选中的Title的颜色
   public var selectedColor : UIColor = UIColor.black
    // Title的view的背景色
   public var titleNorBgColor :UIColor?
   public var titleSelectedBgColor :UIColor?
    
    //MARK:字体
    
    /// Title字体大小
   public var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    /// 滚动Title的间距
   public var titleMargin : CGFloat = 0
    /// titleView的高度
   public var titleHeight : CGFloat = 44
    //第一个title 距离左边的距离
   public var firstTitleLeftMargin : CGFloat = 0
    //最后一个title 距离右边的距离
   public var lastTitleRightMargin : CGFloat = 0
    
    //MARK:底部滚动条
    
    /// 是否显示底部滚动条
   public var isShowTrackLine : Bool = false
    /// 底部滚动条颜色
   public var trackLineColor : UIColor = UIColor.orange
    /// 底部滚动条高度
   public var trackLineH : CGFloat = 2
    /// 底部滚动条的宽度是否等宽 canScrollEnable 为 false 时有效isTrackDivide 表示宽度跟title的宽度一样
   public var isTrackDivide: Bool = false
    
    
    //MARK: bottomLine
    
   public var bottomLineColor : UIColor = UIColor.lightGray
    
    //MARK:缩进
    
    /// 是否进行缩放
   public var isNeedScale : Bool = false
   public var scaleRange : CGFloat = 1.2
    
    //MARK:遮盖
    
    /// 是否显示遮盖
   public var isShowCover : Bool = false
    /// 遮盖背景颜色
   public var coverBgColor : UIColor = UIColor.lightGray
    //遮盖的alpha值
   public var coverAlpha : CGFloat = 0.7
    /// 文字&遮盖间隙
   public var coverMargin : CGFloat = 5
    /// 遮盖的高度
   public var coverH : CGFloat = 25
    
    /// 设置圆角大小
   public var coverRadius : CGFloat = 0
    
    //MARK:左右BarItem
    
   public var leftBarItem : UIView = UIView.init(frame: CGRect.zero)
   public var rightBarItem : UIView = UIView.init(frame: CGRect.zero)
    
    
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
   public convenience init(navFrame: CGRect,isShowTrckLine:Bool,
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
   public convenience init(navFrame: CGRect,coverBgColor :UIColor,coverAlpha:CGFloat ,coverMargin:CGFloat,coverH:CGFloat,coverRadius:CGFloat,canScrollEnable:Bool, titleMargin:CGFloat, firstTitleLeftMargin:CGFloat, lastTitleRightMargin:CGFloat, selectedColor:UIColor, normalColor:UIColor, defaultSelectedIndex:Int = 0,font:UIFont = UIFont.systemFont(ofSize: 14),isNeedScale:Bool,scaleRange:CGFloat) {
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
    

    
  public convenience init(navFrame:CGRect) {
        self.init()
    }
    
    
}
