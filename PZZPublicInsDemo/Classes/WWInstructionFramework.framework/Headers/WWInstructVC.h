//
//  WWInstructVC.h
//  wanwayInternet
//
//  
/*
 版权声明
 上海万位数字技术有限公司（以下简称“本公司”）对其自行研究开发、编写编制的软件程序、代码等（以下简称“研发资料”）均受《中华人民共和国反不正当竞争法》、《中华人民共和国著作权法》、《中华人民共和国专利法》及适用之国际公约中有关著作权、专利权及/或其他财产所有权法律的保护，为本公司专属或持有。
 使用者将本公司专属或持有的研发资料用于商业、营利、广告性目的时，需事先征得本公司书面特别授权，并注明出处“上海万位数字技术有限公司”，并按照有关国际公约及中华人民共和国法律的有关规定，向本公司支付使用费。
 未经本公司事先明确的书面特别授权，任何单位或个人不得以任何形式、任何途径，通过任何渠道变更、篡改、发行、发布、散布、复制、重制、展示或利用研发资料全部或部分内容，否则以侵权论，依法追究法律责任。


 Copyright Notice
 All the software programs and codes among others (hereinafter referred to as the R&D data) solely developed and written by Shanghai Wanway Digital Technology Co., Ltd. (hereinafter referred to as the Company) are protected by the Law of the People's Republic of China against Unfair Competition, Copyright Law of the People's Republic of China, Patent Law of the People's Republic of China and provisions on laws of copyrights, patent rights and/or other property ownership in international conventions that apply and exclusive to or owned by the Company.
 While using the R&D data exclusive to or possessed by the Company for any commercial, marketing, or advertising purpose, users need ask for special authorization from the Company in writing beforehand, note the source "Shanghai Wanway Digital Technology Co., Ltd." and pay the Company royalties subject to relevant provisions in related international conventions and laws of the People's Republic of China.
 With no prior and express written special authorization from the Company, any unit or individual shall not alter, tamper, issue, release, distribute, duplicate, remake, produce or use part or all of the R&D data in any form and any way, otherwise it shall be deemed as infringement and subject to legal penalties by law.
 */
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,WWAPPType){
    RMSType            = 0  ,            //RMS应用类型
    WWTrackType        = 1  ,            //WWTrack应用类型
};

@interface WWInstructVC : UIViewController
@property (nonatomic,copy) NSString *imeiStr;
@property (nonatomic,copy) NSString *baseUrlStr;
@property (nonatomic,copy) NSString *cookieStr;
@property (nonatomic,assign) WWAPPType appType;
@end

NS_ASSUME_NONNULL_END
