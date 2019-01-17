//
//  UIColor+Middle.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/23.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    
   open class  func getMiddleColor(percent :CGFloat,currentColor:UIColor,endColor:UIColor) -> UIColor {

        var red1 : CGFloat = 0.0
        var green1 : CGFloat = 0.0
        var blue1 : CGFloat = 0.0
        var alpha1 :CGFloat = 0.0
        
        currentColor.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        
        var red2 : CGFloat = 0.0
        var green2 : CGFloat = 0.0
        var blue2 : CGFloat = 0.0
        var alpha2 :CGFloat = 0.0
        endColor.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        let p1 = percent
        let p2 = 1.0 - percent
        
        return UIColor.init(red: red1 * p1 + red2 * p2 , green: green1 * p1 + green2 * p2, blue: blue1 * p1 + blue2 * p2, alpha: alpha1 * p1 + alpha2 * p2)
    }
    
    
}
