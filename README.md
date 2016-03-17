# UITagGroup
UITagGroup是自定义的标签按钮组，无限标签个数，根据标签文字自动计算长度，自动换行，自动屏幕居中


![image](https://github.com/gudao/UITagGroup/blob/master/0.png)
##使用方式
最简单的用法（不可点击只用作显示） 

```

	let tagString = ["1阳光男","2迷一样的美男子","3我靠，牛逼死了","4我就是古道","5帅到无地自容","6swift入门","7自恋自信加自虐","8完爆所有tag标签","9我要来一个无敌长的标签试试","10长？"] 
	 
    let tag1 = UITagGroup(frame: CGRect(x: -50, y: 50 , width: self.view.frame.size.width + 100 , height: 0),dataSource: tagString)
    //tag1.tagAlignment = .Center //默认左对齐
    self.view.addSubview(tag1)        
    print(tag.SelectedList)//打印当前选中的tag
    
        
```


需要点击事件的情况，使用子类UIButtonTagGroup 

``` 
 let tagString = ["1阳光男","2迷一样的美男子","3我靠，牛逼死了","4我就是古道","5帅到无地自容","6swift入门","7自恋自信加自虐","8完爆所有tag标签","9我要来一个无敌长的标签试试","10长？"] 
 
 let tag = UIButtonTagGroup(frame: CGRect(x: 0, y: 250 , width: self.view.frame.size.width , height: 0),dataSource: tagString)
 tag.SelectedHandler = click1 //自定义事件名称,如果没有自定义可以不设置SelectedHandler 
 self.view.addSubview(tag)    
     
//如果需要自定义事件的需要添加对应的func
func click1(tag:UIButtonTagGroup) {
        print("selected:\(tag.selectedData)")
}

        
```
