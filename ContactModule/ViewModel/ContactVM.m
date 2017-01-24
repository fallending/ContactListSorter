//
//  ContactVM.m
//  kata
//
//  Created by fallen.ink on 24/01/2017.
//  Copyright © 2017 fallenink. All rights reserved.
//

//  按功能写XXXHelper，不可过于零散，不可不归类

#import "ContactVM.h"
#import "AppDelegate.h"

@interface ContactVM () {
    NSMutableArray *_contacts;
    NSMutableArray *_contactNames;
    NSMutableArray *_contactMarks;
    NSMutableArray *_contactEngs;
}
@property (nonatomic, strong) NSMutableArray *sectionTitles;
@property (nonatomic, strong) NSMutableDictionary *dataSource;

@end

@implementation ContactVM
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

