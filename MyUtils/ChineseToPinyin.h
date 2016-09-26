#import <UIKit/UIKit.h>

@interface ChineseToPinyin : NSObject {
    
}
+ (NSString *) changeToPinyinString:(NSString *)string;
+ (NSString *) pinyinFromChiniseString:(NSString *)string;
+ (char) sortSectionTitle:(NSString *)string; 

@end