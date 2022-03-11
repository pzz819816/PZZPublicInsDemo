//
//  TestView.m
//  WWInstructionFramework
//
//  Created by PZZ on 2022/2/24.
//

#import "TestView.h"
#import "WWVideoonry.h"
#import "WWVideoLanguageSettings.h"

@interface TestView ()
@property (nonatomic,strong) UIView *aaView;

@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.aaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.aaView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.aaView];
    [self.aaView WWVideo_makeConstraints:^(WWVideoConstraintMaker *make) {
        make.centerY.equalTo(self).offset(0);
        make.centerX.equalTo(self).offset(0);
        make.width.WWVideo_equalTo(400);
        make.height.WWVideo_equalTo(50);


    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.text = [[WWVideoLanguageSettings shareInstance]localizedStringForKey:@"WWTrackRefreshBackFooterIdleText" withObj:self];
    titleLab.textColor = [UIColor whiteColor];
    [self.aaView addSubview:titleLab];
    [titleLab WWVideo_makeConstraints:^(WWVideoConstraintMaker *make) {
        make.centerY.equalTo(self.aaView).offset(0);
        make.centerX.equalTo(self.aaView).offset(0);
    }];
}

@end
