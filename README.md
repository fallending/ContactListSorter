
## 感谢
1. 原始项目：[youran1024/HTLetterManger](https://github.com/youran1024/HTLetterManger)
2. 引用项目：[gdavis/GDIIndexBar](https://github.com/gdavis/GDIIndexBar)

## 基于原始项目做了什么？

1. 重建了原始project
2. 重新梳理了文件（但保留了部分文件的明明
3. 重新命名了类名
4. 修改并扩展了部分实现
5. 创建了TableView可视化通讯录列表
6. 将通讯录的独立出去ContactHelper，便于做额外的数据操作
7. 引入侧边栏，快速选择器

## 项目原文件介绍：

HTLetter/HTLetter.h：该模块的汇总头文件
HTLetter/Pinyin.h
HTLetter/Pinyin.m：拼音相关实现
HTLetter/extension/NSArray+HTLetter.h
HTLetter/extension/NSArray+HTLetter.m：该文件，提供从名字数组，或，联系人Model出发，构建TableView的数据源
HTLetter/extension/NSString+HTLetter.h
HTLetter/extension/NSString+HTLetter.m：字符串处理

## 如何使用？
1. 引入相关文件

2. 准备好联系人 model 数组：contacts，构建数据源
```objc
/**
*      key : value

*      first letter : name array

*      @"A" : @[@"赵大头",@"陈小头"]
*/
self.dataSource = (NSMutableDictionary *)[contacts sortedDictionaryWithPropertyKey:@"name"];

/**
*  section indexes titles
*/
self.sectionTitles = [[[self.dataSource allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
```

3. 对tableView整合IndexBar
```objc
- (GDIIndexBar *)indexBar {
if (!_indexBar) {
_indexBar                       = [[GDIIndexBar alloc] initWithTableView:self.tableView];
_indexBar.delegate              = self;
_indexBar.barBackgroundColor    = [UIColor clearColor];
_indexBar.textColor             = [UIColor blackColor];
_indexBar.textFont              = [UIFont boldSystemFontOfSize:9.f];
}

return _indexBar;
}
```

## 还有什么没有做？

8. 添加搜索栏
