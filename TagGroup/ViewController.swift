//
//  ViewController.swift
//  TagGroup
//
//  Created by 王向辉 on 16/3/12.
//  Copyright © 2016年 gudao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let tagString = ["1阳光男","2迷一样的美男子","3我靠，牛逼死了","4我就是古道","5帅到无地自容","6swift入门","7自恋自信加自虐","8完爆所有tag标签","9我要来一个无敌长的标签试试","10长？"]
        let tag = UIButtonTagGroup(frame: CGRect(x: 0, y: 100 , width: self.view.frame.size.width , height: 0),dataSource: tagString)
        tag.tagAlignment = .Center
        tag.SelectedHandler = click1
        self.view.addSubview(tag)
        

        
    }
    
    func click1(tag:UIButtonTagGroup) {
        print("selected:\(tag.selectedData)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



