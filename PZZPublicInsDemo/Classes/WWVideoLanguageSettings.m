//
//  WWVideoLanguageSettings.m
//  WWVideoFramework
//
//  Created by PZZ on 2021/12/13.
//

#import "WWVideoLanguageSettings.h"

@interface WWVideoLanguageSettings ()
@property (nonatomic,copy) NSString *curLanguage;

@end

@implementation WWVideoLanguageSettings

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static WWVideoLanguageSettings *languageSettings = nil;
    dispatch_once(&onceToken, ^{
        languageSettings = [[WWVideoLanguageSettings alloc] init];
    });
    
    return languageSettings;
}

//设置语言
- (void)setUserlanguage:(NSString *)language {
    if (![[self currentLanguage] isEqualToString:language]) {
        [self saveLanguage:language];
    }
}


//保存语言
- (void)saveLanguage:(NSString *)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:language forKey:@"WWInstructLanguage"];
    [defaults synchronize];
}

//获取语言
- (NSString *)currentLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *language = [defaults objectForKey:@"WWInstructLanguage"];
    return language;
}


//获取当前语种下的内容
- (NSString *)localizedStringForKey:(NSString *)key withObj:(id)obj {
//    NSString *currentLanguage = [self currentLanguage];
//    if (!currentLanguage) {
//        currentLanguage = [self getSystemLanguage];
//        [self setUserlanguage:currentLanguage];
//    }
//    currentLanguage = [self languageFormat:currentLanguage];
//

    NSString *currentLanguage = @"zh-Hans";
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[obj class]] pathForResource:@"WWResource" ofType:@"bundle"]];
    NSBundle *fileBundle = [NSBundle bundleWithPath:[bundle pathForResource:currentLanguage ofType:@"lproj"]];
    NSString * value = [fileBundle localizedStringForKey:key value:nil table:@"Localizable"];
    //NSLog(@"localizedStringForKey--%@--%@--%@--%@--%@",bundle,fileBundle,key,value,[[NSBundle mainBundle] localizedStringForKey:key value:value table:@"Localizable"]);
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:@"Localizable"];
}


- (void)getCurLanguage {
    NSString *curLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
    if ([curLanguage containsString:@"zh-Hans"]) {
        //简体中文
        self.curLanguage = @"zh-Hans";
        
    } else if([curLanguage containsString:@"zh-Hant"]){
        //繁体中文
        self.curLanguage = @"zh-Hant";
    } else {
        //
        self.curLanguage = @"en";
    }
    
    
    self.curLanguage = [self languageFormat:self.curLanguage];
}


- (NSString *)getSystemLanguage {
    NSString *curLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];

    if ([curLanguage containsString:@"zh-Hans"]) {
    //简体中文
        return @"zh-Hans-CN";
    } else if([curLanguage containsString:@"Hant"]){
        //繁体中文 同简体中文
        return @"zh-Hans-CN";
    } else if([curLanguage containsString:@"vi"]){
        //越南
        return @"vi-CN";
    } else if([curLanguage containsString:@"ru"]){
        //俄罗斯
        return @"ru-CN";
    } else if([curLanguage containsString:@"mn"]){
        //蒙古
        return @"mn-CN";
    } else if([curLanguage containsString:@"es"]){
        //西班牙
        return @"es-CN";
    } else if([curLanguage containsString:@"ar"]){
        //阿拉伯
        return @"ar-CN";
    } else if([curLanguage containsString:@"pt-PT"]||[curLanguage containsString:@"pt-BR"]){
        //葡萄牙
        return @"pt-CN";
    } else if([curLanguage containsString:@"sq-XK"]){
        //阿尔巴尼亚
        return @"sq-XK-CN";
    } else if([curLanguage containsString:@"tr-TR"]){
        //土耳其
        return @"tr-TR-CN";
    } else if([curLanguage containsString:@"fa"]){
        //波斯语
        return @"fa-CN";
    } else if([curLanguage containsString:@"fr"]){
        //法语
        return @"fr-CN";
    } else if([curLanguage containsString:@"th"]){
        //泰国
        return @"th-CN";
    } else if([curLanguage containsString:@"pl"]){
        //波兰
        return @"pl-CN";
    } else if([curLanguage containsString:@"de"]){
        //德国
        return @"de-CN";
    } else if([curLanguage containsString:@"it"]){
        //意大利
        return @"it-CN";
    } else if([curLanguage containsString:@"km-KH"]){
        //柬埔寨
        return @"km-KH-CN";
    } else if([curLanguage containsString:@"hu"]){
        //匈牙利
        return @"hu-CN";
    } else if([curLanguage containsString:@"id"]){
        //印尼
        return @"id-CN";
    }else {
        return @"en-CN";
    }
}
//语言和语言对应的.lproj的文件夹前缀不一致时在这里做处理
- (NSString *)languageFormat:(NSString*)language {
    if([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
        return @"zh-Hans";
    } else if([language rangeOfString:@"zh-Hant"].location != NSNotFound) {
        return @"zh-Hant";
    } else {
        //字符串查找
        if([language rangeOfString:@"-"].location != NSNotFound) {
            //除了中文以外的其他语言统一处理@"ru_RU" @"ko_KR"取前面一部分
            NSArray *ary = [language componentsSeparatedByString:@"-"];
            if (ary.count > 1) {
                NSString *str = ary[0];
                return str;
            }
        }
    }
    return language;
}


- (NSString *)getLangStr {
    return @"zh";
    NSString *str = @"";
    if ([[self currentLanguage] containsString:@"zh-Hans"]) {
        str = @"zh";
    } else if ([[self currentLanguage] containsString:@"zh-Hant"]) {
        str = @"zh";
    } else if ([[self currentLanguage] containsString:@"vi-CN"]) {
        str = @"vi";
    } else if([[self currentLanguage] containsString:@"ru-CN"]) {
        str = @"ru";
    } else if ([[self currentLanguage] containsString:@"mn-CN"]) {
        str = @"mn";
    } else if ([[self currentLanguage] containsString:@"es-CN"]) {
        str = @"es";
    } else if([[self currentLanguage] containsString:@"ar-CN"]) {
        str = @"ar";
    } else if ([[self currentLanguage] containsString:@"pt-CN"]) {
        str = @"pt";
    } else if ([[self currentLanguage] containsString:@"sq-XK-CN"]) {
        str = @"sq";
    } else if ([[self currentLanguage] containsString:@"tr-TR-CN"]) {
        str = @"tr";
    } else if ([[self currentLanguage] containsString:@"fa-CN"]) {
        str = @"fa";
    } else if ([[self currentLanguage] containsString:@"fr-CN"]) {
        str = @"fr";
    } else if ([[self currentLanguage] containsString:@"th-CN"]) {
           str = @"th";
    } else if ([[self currentLanguage] containsString:@"de-CN"]) {
        str = @"de";
    } else if ([[self currentLanguage] containsString:@"pl-CN"]) {
        str = @"pl";
    } else if ([[self currentLanguage] containsString:@"km-KH-CN"]) {
        str = @"kh";
    } else if ([[self currentLanguage] containsString:@"it-CN"]) {
        str = @"it";
    } else if ([[self currentLanguage] containsString:@"id-CN"]) {
        str = @"id";
    } else if ([[self currentLanguage] containsString:@"hu-CN"]) {
        str = @"hu";
    } else {
        str = @"en";
    }
    return str;
}


+ (BOOL)isStyleDark {
    return NO;
    if (@available(iOS 13.0, *)) {
        return UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    return NO;
}

+ (void)blackStatusBar {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        if (@available(iOS 13.0, *)) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
        } else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    }
}

+ (void)whiteStatusBar {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}


+ (UIImage *)setImageIcon:(NSString *)imageStr {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"WWResource" ofType:@"bundle"];
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:imageStr];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
