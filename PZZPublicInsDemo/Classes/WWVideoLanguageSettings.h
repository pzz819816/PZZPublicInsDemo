//
//  WWVideoLanguageSettings.h
//  WWVideoFramework
//
//  Created by PZZ on 2021/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWVideoLanguageSettings : NSObject

+ (instancetype)shareInstance;

- (NSString *)localizedStringForKey:(NSString *)key withObj:(id)obj;

//目前支持20中语言，不传默认系统语言，传值可设定语言，若不在20种原因范围内，则默认英文
- (void)setUserlanguage:(NSString *)language;

- (NSString *)currentLanguage;

- (NSString *)getLangStr;

@property (nonatomic,copy) NSString *domainStr;
@property (nonatomic,copy) NSString *tokenStr;
@property (nonatomic,assign) NSInteger interfaceType;

+ (BOOL)isStyleDark;
+ (UIImage *)setImageIcon:(NSString *)imageStr;
+ (BOOL)isLoginLose:(NSError * _Nonnull)error;

@end

NS_ASSUME_NONNULL_END
