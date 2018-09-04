//
//  ViewController.swift
//  JWCPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var btn1: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 30))
        btn.addTarget(self, action: #selector(btn1Action), for: .touchUpInside)
        btn.setTitle("pageVc", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.lightGray
        return btn
    }()
    
    
    lazy var btn2: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 100, y: 200, width: 100, height: 30))
        btn.addTarget(self, action: #selector(btn2Action), for: .touchUpInside)
        btn.setTitle("navBarVC", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.lightGray
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        
    }
    
    @objc func btn1Action() {
        let pageVC = JWCPageVC()
        self.navigationController?.pushViewController(pageVC, animated: true)
        
    }
    
    @objc func btn2Action() {
        let navVC  = JWCNAVBarVC()
        self.navigationController?.pushViewController(navVC, animated: true)
    }

}

