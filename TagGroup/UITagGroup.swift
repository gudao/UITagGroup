//
//  MyTag.swift
//  TagGroup
//
//  Created by 王向辉 on 16/3/17.
//  Copyright © 2016年 gudao. All rights reserved.
//

import UIKit

enum TagAlignmentEnum{
    case Left
    case Center
}


class UITagGroup:UIView {
    
    var textColor:UIColor = UIColor.blackColor()
    var tagFont:UIFont = UIFont.systemFontOfSize(14)
    var spaceX:CGFloat  = 5
    var spaceY:CGFloat = 14
    var tagAlignment:TagAlignmentEnum = TagAlignmentEnum.Left


    init(frame: CGRect,dataSource:[String]) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        for index in 1...dataSource.count {
            let bt = UIButton()
            
            bt.setTitleColor(textColor, forState: .Normal)
            bt.setTitle(dataSource[index - 1], forState: .Normal)
            bt.tag = index
            bt.layer.borderWidth = 1
            bt.layer.cornerRadius = 5
            bt.layer.borderColor = textColor.CGColor
            bt.titleLabel?.font = tagFont
            //bt.enabled = false
            self.addSubview(bt)
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
            let textAttributes = [NSFontAttributeName:  tagFont]
            let size =  textString.boundingRectWithSize(CGSizeMake(320, 320), options: .UsesLineFragmentOrigin, attributes: textAttributes, context: nil)
            
            let btW:CGFloat = size.size.width + tagFont.pointSize*2 // 左右一个字符
            btH = size.size.height + tagFont.pointSize //2倍行高
            
            if (frontX + btW <= self.frame.width) {
                bt.frame = CGRect(x:frontX, y: frontY, width: btW , height: btH)
                frontX = frontX + btW+spaceX //下一个按钮的x
            } else {
                if tagAlignment == TagAlignmentEnum.Center
                {
                    //换行就把之前的重排
                    for otherBt in btList{
                        otherBt.frame.origin.x +=  (self.frame.width - frontX) / 2
                    }
                    btList.removeAll()
                }
                frontX = 0
                frontY = frontY + btH+spaceY
                bt.frame = CGRect(x: 0, y: frontY, width: btW , height: btH)
                frontX = frontX + btW+spaceX
            }
            
            if tagAlignment == TagAlignmentEnum.Center
            {
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
            
        }
        
        //设置本身高度
        self.frame.size.height = frontY + btH
    }

}

class UIButtonTagGroup:UITagGroup {
    var selectedTextColor:UIColor = UIColor.redColor()
    var selectedData:[Int:String] = [:]
    var SelectedHandler:((tagGroup:UIButtonTagGroup) -> Void)?
    
    override init(frame: CGRect, dataSource: [String]) {
        super.init(frame: frame, dataSource: dataSource)
        
        for btView in self.subviews {
            let bt = btView as! UIButton
            
            bt.setTitleColor(selectedTextColor, forState: .Selected)
            bt.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside)
        
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func click(sender:UIControl){
        let bt = sender as! UIButton
        if !bt.selected {
            bt.selected = true
            bt.layer.borderColor = selectedTextColor.CGColor
            selectedData.updateValue((bt.titleLabel?.text)!,forKey: bt.tag)
        } else {
            bt.selected = false
            bt.layer.borderColor = textColor.CGColor
            selectedData.removeValueForKey(bt.tag)
        }
        
        if SelectedHandler != nil {
            SelectedHandler!(tagGroup: self)
        }
    }
}


