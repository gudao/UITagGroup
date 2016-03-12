//
//  UITagGroup.swift
//  TagGroup
//
//  Created by 王向辉 on 16/3/12.
//  Copyright © 2016年 gudao. All rights reserved.
//

import UIKit

protocol UITageGroupDelegate{
    func  click(tageGroup:UITagGroup, clickedButton:UIControl)
}

class UITagGroup: UIView {

    //选择的标签
    var SelectedList:[Int:String] = [:]
    var delegate:UITageGroupDelegate?
    
    private let colorNormal = UIColor.blackColor()  //字体颜色
    private let colorSelected = UIColor.blueColor()
    private let fontSize:CGFloat = 14  //字体大小
    private let spaceX:CGFloat = 5  //标签与标签的横向距离
    private let spaceY:CGFloat = 10 //行距
    /**
    初始化标签组
    - parameter frame: 位置、大小
    - parameter count: 标签个数
    - returns:
    */
    init(frame: CGRect,count:Int) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        for index in 1...count {
            let bt = UIButton()
            
            bt.setTitleColor(colorNormal, forState: .Normal)
            bt.setTitleColor(colorSelected, forState: .Selected)
            bt.tag = index
            bt.layer.borderWidth = 1
            bt.layer.cornerRadius = 5
            bt.layer.borderColor = colorNormal.CGColor
            bt.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
            bt.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(bt)
        }
        
    }
    /**
     点击方法
     - parameter sender: 按钮
     */
    func click(sender:UIControl){
        let bt = sender as! UIButton
        if !bt.selected {
            bt.selected = true
            bt.layer.borderColor = colorSelected.CGColor
            SelectedList.updateValue((bt.titleLabel?.text)!,forKey: bt.tag)
        } else {
            bt.selected = false
            bt.layer.borderColor = colorNormal.CGColor
            SelectedList.removeValueForKey(bt.tag)
        }
        
        if delegate != nil {
            self.delegate?.click(self, clickedButton: bt)
        }
    }
    
    /**
     设置标签字符数组
     - parameter list: 数组
     */
    func config(list:[String]){
        var i = 0
        for index in self.subviews{
            let bt = index as! UIButton
            bt.setTitle(list[i++], forState: UIControlState.Normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var frontX:CGFloat = 0
        var frontY:CGFloat = 0
        
        var btH:CGFloat = 0
        var btList:[UIButton] = [] //同一行的bt
        var index:Int = 0
        
        //循环设置每一个button的位置
        for btView in self.subviews {
            let bt = btView as! UIButton
            
            //计算文本的长度
            let textString = (bt.titleLabel?.text)! as NSString
            let textAttributes = [NSFontAttributeName:  UIFont.systemFontOfSize(fontSize)]
            let size =  textString.boundingRectWithSize(CGSizeMake(320, 320), options: .UsesLineFragmentOrigin, attributes: textAttributes, context: nil)
            
            let btW:CGFloat = size.size.width + 24 // 左右 padding 12
            btH = size.size.height + 24 //bt.frame.height
            
            if (frontX + btW <= self.frame.width) {
                bt.frame = CGRect(x:frontX, y: frontY, width: btW , height: btH)
                frontX = frontX + btW+spaceX //下一个按钮的x
            } else {
                //换行就把之前的重排
                for otherBt in btList{
                    otherBt.frame.origin.x +=  (self.frame.width - frontX) / 2
                }
                btList.removeAll()
                
                frontX = 0
                frontY = frontY + btH+spaceY
                bt.frame = CGRect(x: 0, y: frontY, width: btW , height: btH)
                frontX = frontX + btW+spaceX
            }
            
            //添加同一行按钮
            btList.append(bt)
            
            //如果是最后一行也重排
            if ++index == self.subviews.count {
                for otherBt in btList{
                    otherBt.frame.origin.x +=  (self.frame.width - frontX) / 2
                }
                btList.removeAll()
            }
            
        }
        
        //设置本身高度
        self.frame.size.height = frontY + btH
        
    }
}
