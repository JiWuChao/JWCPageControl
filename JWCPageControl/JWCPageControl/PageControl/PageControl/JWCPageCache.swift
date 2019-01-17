//
//  JWCPageCache.swift
//  JWCPageControl
//
//  Created by JiWuChao on 2018/3/19.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

public class JWCPageCache: NSObject {

   fileprivate var dic = [Int : UIView]()
    
   public func hasCache(subIndex index:Int) -> Bool {
        if (dic[index] != nil) {
            return true
        }
        return false
    }
   public func cacheObj(cacheObj obj:UIView , atIndex index:Int)  {
        dic[index] = obj
    }
    
   public func getCacheObj(atIndex index:Int) -> UIView? {
        if hasCache(subIndex: index) {
            return dic[index]
        }
        return nil
    }
    
   public func getAll() -> [Int : UIView] {
        return dic
    }
    
   public func removeObj(objIndex atIndex:Int)  {
        if hasCache(subIndex: atIndex) {
            dic.removeValue(forKey: atIndex)
        }
    }
   public func removeAll() {
        dic.removeAll()
    }
    
}
