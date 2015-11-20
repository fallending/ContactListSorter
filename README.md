
## 感谢
1. 原始项目：[youran1024/HTLetterManger](https://github.com/youran1024/HTLetterManger)
2.1 引用项目：[gdavis/GDIIndexBar](https://github.com/gdavis/GDIIndexBar)
2.2 引用项目：[PinYin4Objc](https://github.com/kimziv/PinYin4Objc)
3. 参考项目 1：[zhxnlai/ZLPeoplePickerViewController](https://github.com/zhxnlai/ZLPeoplePickerViewController)

## 基于原始项目做了什么？

1. 重建了原始project
2. 重新梳理了文件（但保留了部分文件的命名）
3. 重新命名了类名
4. 修改并扩展了部分实现
5. 创建了TableView通讯录列表
6. 将通讯录数据处理的独立：ContactHelper，便于做额外的数据操作
7. 引入索引侧边栏

## 项目原文件介绍：

* HTLetter/HTLetter.h：该模块的汇总头文件
* HTLetter/Pinyin.h
* HTLetter/Pinyin.m：拼音相关实现
* HTLetter/extension/NSArray+HTLetter.h
* HTLetter/extension/NSArray+HTLetter.m：该文件，提供从名字数组，或，联系人Model出发，构建TableView的数据源
* HTLetter/extension/NSString+HTLetter.h
* HTLetter/extension/NSString+HTLetter.m：字符串处理

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
9. 排序依据（拼音<首字母、声母、韵母、声调>、）（位置记忆）
10. 读取系统通讯录：https://github.com/heardrwt/RHAddressBook\https://github.com/Alterplay/APAddressBook
11. 条目多选：http://code4app.com/ios/Contacts-Multi-Picker/5052a2396803fa8c31000000
12. 联系人读取：https://github.com/clusterinc/CLTokenInputView、https://github.com/tristanhimmelman/THContactPicker
13. 二维码传递联系人：http://code4app.com/ios/%E4%BA%8C%E7%BB%B4%E7%A0%81%E4%BA%92%E4%BC%A0%E9%80%9A%E8%AE%AF%E5%BD%95%E8%81%94%E7%B3%BB%E4%BA%BA/5382f49c933bf06f748b5353
15. 一片论文: http://cslt.riit.tsinghua.edu.cn/~fzheng/PAPERS/2009/0907C_JTHU_Pinyin-indexed-method-for-approximate-match_CJ.pdf

