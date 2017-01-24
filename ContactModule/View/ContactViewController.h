//
//  ContactViewController.h
//  ContactListSorter
//
//  Created by fallen.ink on 11/13/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactVM;

@interface ContactViewController : UIViewController

@property (nonatomic, strong) ContactVM *helper;

@end

//8. 添加搜索栏
//9. 排序依据（拼音<首字母、声母、韵母、声调>、）（位置记忆）
//10. 读取系统通讯录：https://github.com/heardrwt/RHAddressBook\https://github.com/Alterplay/APAddressBook
//11. 条目多选：http://code4app.com/ios/Contacts-Multi-Picker/5052a2396803fa8c31000000
//12. 联系人读取：https://github.com/clusterinc/CLTokenInputView、https://github.com/tristanhimmelman/THContactPicker
//13. 二维码传递联系人：http://code4app.com/ios/%E4%BA%8C%E7%BB%B4%E7%A0%81%E4%BA%92%E4%BC%A0%E9%80%9A%E8%AE%AF%E5%BD%95%E8%81%94%E7%B3%BB%E4%BA%BA/5382f49c933bf06f748b5353
//15. 一片论文: http://cslt.riit.tsinghua.edu.cn/~fzheng/PAPERS/2009/0907C_JTHU_Pinyin-indexed-method-for-approximate-match_CJ.pdf
