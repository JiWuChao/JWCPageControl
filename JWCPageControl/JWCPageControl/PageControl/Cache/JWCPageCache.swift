//
//  JWCPageCache.swift
//  JWCPageControl
//
//  Created by JiWuChao on 2018/3/19.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class JWCPageCache: NSObject {

   fileprivate var dic = [Int : UIView]()
    
    func hasCache(subIndex index:Int) -> Bool {
        if (dic[index] != nil) {
            return true
        }
        return false
    }
    func cacheObj(cacheObj obj:UIView , atIndex index:Int)  {
        dic[index] = obj
    }
    
    func getCacheObj(atIndex index:Int) -> UIView? {
        if hasCache(subIndex: index) {
            return dic[index]
        }
        return nil
    }
    
    func getAll() -> [Int : UIView] {
        return dic
    }
    
    func removeObj(objIndex atIndex:Int)  {
        if hasCache(subIndex: atIndex) {
            dic.removeValue(forKey: atIndex)
        }
    }
    func removeAll() {
        dic.removeAll()
    }
    
}
