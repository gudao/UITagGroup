# UITagGroup
UITagGroup是自定义的标签按钮组，无限标签个数，根据标签文字自动计算长度，自动换行，自动屏幕居中
##使用方式
最简单的用法 

```

	let tagString = ["1阳光男","2迷一样的美男子","3我靠，牛逼死了","4我就是古道","5帅到无地自容","6swift入门","7自恋自信加自虐","8完爆所有tag标签","9我要来一个无敌长的标签试试","10长？"] 
	 
    let tag = UITagGroup(frame: CGRect(x: 0, y: 100 , width: self.view.frame.size.width , height: 0), count: tagString.count)
    tag.config(tagString)
    self.view.addSubview(tag) 
        
    print(tag.SelectedList)//打印当前选中的tag
    
        
```


如果需要自定点击事件可以使用 UITageGroupDelegate

``` 
 let tagString = ["1阳光男","2迷一样的美男子","3我靠，牛逼死了","4我就是古道","5帅到无地自容","6swift入门","7自恋自信加自虐","8完爆所有tag标签","9我要来一个无敌长的标签试试","10长？"] 
 
let tag = UITagGroup(frame: CGRect(x: 0, y: 100 , width: self.view.frame.size.width , height: 0), count: tagString.count)
        tag.config(tagString)
        tag.delegate = self
        self.view.addSubview(tag) 
        
        //在对应的viewcontroller里加上代理扩展
        extension ViewController:UITageGroupDelegate{
    func click(tageGroup: UITagGroup, clickedButton: UIControl) {
        print(tageGroup.SelectedList)
    }
}

        
```
当然也可以不使用delegate,直接使用tag.SelecedList获取当前选中的tag。