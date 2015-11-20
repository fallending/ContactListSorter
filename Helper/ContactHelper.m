//
//  ContactHelper.m
//  ContactListSorter
//
//  Created by fallen.ink on 11/15/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

//  按功能写XXXHelper，不可过于零散，不可不归类

#import "ContactHelper.h"
#import "AppDelegate.h"

@interface ContactHelper () {
    NSMutableArray *_contacts;
    NSMutableArray *_contactNames;
    NSMutableArray *_contactMarks;
    NSMutableArray *_contactEngs;
}
@property (nonatomic, strong) NSMutableArray *sectionTitles;
@property (nonatomic, strong) NSMutableDictionary *dataSource;

@end

@implementation ContactHelper

#pragma mark - Initialize

- (instancetype)init {
    if (self = [super init]) {
        _contacts       = [NSMutableArray new];
        _contactNames   = [NSMutableArray new];
        _contactMarks   = [NSMutableArray new];
        _contactEngs    = [NSMutableArray new];
    }
    
    return self;
}

- (void)initCommonly {
    NSArray *nameSamples        = @[@"复仇之魂",@"众神之王",@"魅惑魔女",@"变体精灵", // 清晨酒馆
                                    @"水晶室女",@"流浪剑客",@"娜迦海妖",@"撼地神牛",
                                    @"隐形刺客",@"德鲁伊",@"秀逗魔导师",@"剑圣",
                                    
                                    @"沉默术士",@"树精卫士",@"谜团",@"光之守卫", // 旭日酒馆
                                    @"熊战士",@"食人魔魔法师",@"修补匠",@"先知",
                                    @"幻影长矛手",@"山岭巨人",@"哥布林工程师",@"圣骑士",
                                    
                                    @"月之骑士",@"矮人狙击手",@"巨魔战将",@"暗影萨满",// 曙光酒馆
                                    @"刚背兽",@"熊猫酒仙",@"半人马酋长",@"赏金猎人",
                                    @"龙骑士",@"敌法师",@"黑暗游侠",@"全能骑士",
                                    
                                    ];
    
    NSArray *markSamples        = @[@"姗德瑞拉·须木",@"宙斯",@"艾尤希莎",@"墨斐琳",
                                    @"瑞莱·克里斯提法",@"斯温",@"希里莎斯·娜迦 塞任",@"雷格·石蹄",
                                    @"竹内 丸 / 瑞基马鲁",@"塞拉比尔/塞拉",@"莉娜·因巴斯 / 莉娜·因维斯",@"尤尼路·扎伽呐塔",
                                    
                                    @"诺瑞姆",@"鲁夫崔莱恩 / 崔莱恩",@"达奇罗",@"艾扎洛",
                                    @"乌萨尔",@"阿格热·碎石者",@"波希",@"玛法里奥 / 法里奥",
                                    @"艾瑞斯 / 艾斯文",@"提尼",@"斯奎督军和斯普林",@"沈/陈",
                                    
                                    @"露娜·月牙",@"卡德尔·鹰眼",@"扎·拉卡",@"莱斯塔",
                                    @"里格瓦尔",@"曼格斯",@"布莱德沃登 / 沃登",@"甘达",
                                    @"骑士达威",@"魔法操控者 阿提玛基纳 / 玛基纳",@"翠希斯",@"普瑞斯特·雷霆之怒",
                                    
                                    
                                    ];
    
    NSArray *engSamples         = @[@"Shendelzare Silkwood",@"Zeus",@"Aiushtha the Enchantress",@"Morphling",
                                    @"Rylai Crestfall",@"Sven",@"Slithice",@"Raigor Stonehoof",
                                    @"Rikimaru",@"Syllabear",@"Lina Inverse",@"Yurnero",
                                    
                                    @"Nortrom",@"Rooftrellen",@"Darchro",@"Ezalor",
                                    @"Ulfsaar",@"Aggron Stonebreaker",@"Boush",@"Furion",
                                    @"Azwraith",@"Tiny",@"Squee和Spleen",@"Chen",
                                    
                                    @"Luna Moonfang",@"Kardel Sharpeye",@"Jah'rakal",@"Rhasta",
                                    @"Rigwarl",@"Mangix",@"Bradwarden",@"Gondar",
                                    @"Knight Davion",@"Magina",@"Traxex",@"Purist Thunderwrath",
                                    ];
    
    
    NSInteger count = [markSamples count];
    while (count -- > 0) {
        ContactModel *model = [ContactModel new];
        model.name = [nameSamples objectAtIndex:count];
        model.mark = [markSamples objectAtIndex:count];
        model.eng  = [engSamples objectAtIndex:count];
        
        [_contactNames addObject:model.name];
        [_contactMarks addObject:model.mark];
        [_contactEngs  addObject:model.eng];
        
        [_contacts addObject:model];
    }
    
    /**
     *      key : value
     
     *      first letter : name array
     
     *      @"A" : @[@"赵大头",@"陈小头"]
     */
    self.dataSource = (NSMutableDictionary *)[_contacts sortedDictionaryWithPropertyKey:@"name"];
    
    /**
     *  section indexes titles
     */
    self.sectionTitles = [[[self.dataSource allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
}

- (void)initWithPlist:(NSString *)filename {
    
}

- (NSArray *)contactTableSectionTitles {
    return self.sectionTitles;
}

- (NSDictionary *)contactTableDataSource {
    return self.dataSource;
}

@end

#pragma mark - ContactModel

@implementation ContactModel


@end

/*
 
 清晨酒馆：
 复仇之魂 Shendelzare Silkwood 姗德瑞拉·须木
 众神之王 Zeus 宙斯
 魅惑魔女 Aiushtha the Enchantress 艾尤希莎
 变体精灵 Morphling 墨斐琳
 水晶室女 Rylai Crestfall 瑞莱·克里斯提法
 流浪剑客 Sven 斯温
 娜迦海妖 Slithice 希里莎斯·娜迦 塞任
 撼地神牛 Raigor Stonehoof 雷格·石蹄
 隐形刺客 Rikimaru 竹内 丸 / 瑞基马鲁
 德鲁伊 Syllabear 塞拉比尔/塞拉
 秀逗魔导师 Lina Inverse 莉娜·因巴斯 / 莉娜·因维斯
 剑圣 Yurnero 尤尼路·扎伽呐塔
 
 旭日酒馆：
 沉默术士 Nortrom 诺瑞姆
 树精卫士 Rooftrellen 鲁夫崔莱恩 / 崔莱恩
 谜团 Darchro 达奇罗
 光之守卫 Ezalor 艾扎洛
 熊战士 Ulfsaar 乌萨尔
 食人魔魔法师 Aggron Stonebreaker 阿格热·碎石者
 修补匠 Boush 波希
 先知 Furion 玛法里奥 / 法里奥
 幻影长矛手 Azwraith 艾瑞斯 / 艾斯文
 山岭巨人 Tiny 提尼
 哥布林工程师 Squee和Spleen 斯奎督军和斯普林
 圣骑士 Chen 沈/陈
 
 曙光酒馆：
 月之骑士 Luna Moonfang 露娜·月牙
 矮人狙击手 Kardel Sharpeye 卡德尔·鹰眼
 巨魔战将 Jah'rakal 扎·拉卡
 暗影萨满 Rhasta 莱斯塔
 刚背兽 Rigwarl 里格瓦尔
 熊猫酒仙 Mangix 曼格斯
 半人马酋长 Bradwarden 布莱德沃登 / 沃登
 赏金猎人 Gondar 甘达
 龙骑士 Knight Davion 骑士达威
 敌法师 Magina 魔法操控者 阿提玛基纳 / 玛基纳
 黑暗游侠 Traxex 翠希斯
 全能骑士 Purist Thunderwrath 普瑞斯特·雷霆之怒
 
 黎明酒馆：
 兽王 Rexxar 雷克萨·雷玛
 双头龙 Jakiro 加基诺
 炼金术士 Razzil Darkbrew 拉泽尔·黑炼
 月之女祭司 Mirana Nightshade 弥拉娜·夜影
 风暴之灵 Raijin Thunderkeg 瑞金·雷暴
 神灵武士 Huskar 哈斯伽
 圣堂刺客 Lanaya 拉娜亚
 仙女龙 Puck 帕卡
 发条地精 Rattletra 拉特瑞
 船长 Kunkka 库克
 风行者 Alleria 奥蕾莉亚·风行者
 
 日落酒馆：
 蛇发女妖 Medusa 美杜沙·戈尔工
 暗夜魔王 Balanar 巴拉纳
 骷髅王 King Leoric 李奥克斯王
 末日使者 Lucifer 路西法
 地穴刺客 Anub'arak 阿努比·阿拉克 / 阿诺拉克
 鱼人守卫 Slardar 撒拉达尔 / 撒拉达
 痛苦女王 Akasha 阿伽莎
 骷髅射手 Clinkz 骸骨克林兹
 虚空假面 Darkterror 达科提瑞
 冥界亚龙 Viper 维普
 闪电幽魂 Razor 利刃拉泽尔
 食尸鬼 N'aix 纳克斯
 
 午夜酒馆：
 灵魂守卫 Terrorblade 灵魂操控者 提瑞布莱德
 受折磨的灵魂 Leshrac the Malicious 恶魂·拉席克
 巫妖 Kel'Thuzad 克尔苏加德
 死亡先知 Krobelus 卡罗碧露丝
 恶魔巫师 Lion 雷欧
 剧毒术士 Lesale Deathbringer 里塞尔·死亡降临者
 半人猛犸 Magnus 马格纳斯
 死灵飞龙 Visage 维沙基
 混沌骑士 Nessaj 耐萨基 / 耐萨
 狼人 Banehallow 巴纳哈鲁
 育母蜘蛛 Black Arachnia 布莱克·艾拉齐娜
 幻影刺客 Mortred 墨翠德 / 墨翠德·须木
 
 暮色酒馆：
 遗忘法师 Pugna 普格纳
 潮汐猎人 Leviathan 理威萨恩
 痛苦之源 Atropos 艾瑟珀斯
 死灵法师 Rotund'jere 罗图恩德·杰里
 屠夫 Pudge 普基
 裂魂人 Barathrum 灵魂撕裂者 巴拉斯鲁姆
 地穴编织者 Anub'seran 阿努比·瑟让
 影魔 Nevermore 耐维摩尔
 沙王 Crixalis 克里卡利斯
 斧王 MogulKahn 莫骨·可汗
 血魔 Strygwyr 逐血者 斯爵格雅尔
 地狱领主 Abaddon 阿巴顿
 
 黄昏酒馆：
 幽鬼 Mercurial 梅珂瑞尔
 巫医 Vol'Jin 沃金
 黑曜毁灭者 Harbinger 哈比恩格
 术士 Demnok Lannik 狄姆诺·兰里克
 地卜师 Meepo 弥珀
 暗影牧师 Dazzle 地素 / 迪祖
 深渊领主 Azgalor 阿兹加洛
 不朽尸王 Dirge 吟葬者 德兹
 黑暗贤者 Ish'kafel 伊瑟卡斐
 召唤师 Kael 卡尔
 
 */