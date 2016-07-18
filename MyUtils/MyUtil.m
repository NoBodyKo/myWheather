
//
//  MyUtil.m
//  NET01day01
//
//  Created by 成都千锋 on 15/9/8.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyUtil.h"
#import "AFNetworking.h"
@implementation MyUtil

+(AFHTTPRequestOperationManager *) sharedRequestOperationManager{
    static AFHTTPRequestOperationManager *sharedInstance = nil;
    if (!sharedInstance) {
        //创建一个HTTP请求操作管理器对象
        sharedInstance = [AFHTTPRequestOperationManager manager];
        //AFNetworking 默认只支持application/json类型的响应
        //有一些服务器返回的可能不是JSON格式类型
        //通过下面代码可以支持其他类型
        //
        sharedInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/xml",nil];
    }
    return sharedInstance;
}

+(void) showAlsert:(NSString *) msg withVC:(UIViewController *)vc{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:okAction];
    [vc presentViewController:ac animated:YES completion:nil];
}

+(void) showAlsertWithCancel:(NSString *) msg withTitle:(NSString *) title withVC:(UIViewController *) vc{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    ac.view.backgroundColor = [UIColor colorWithRed:201 green:120 blue:60 alpha:0.6];
    UIAlertAction *canCel = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:canCel];
    [vc presentViewController:ac animated:YES completion:^{
        
    }];
    
    
    
}
+(void)setLabelWidth:(NSString *)str andLabel:(UILabel *)label andView:(UIView *)myView andLabFont:(UIFont*)myfont andFramOrignx:(float)x andFramOrigny:(float)y andMaxWidth:(float)maxwidth andMaxHeight:(float)maxheight{
    label.text = str;
    label.lineBreakMode =NSLineBreakByTruncatingTail ;
    
    
    label.font = myfont;
    CGSize size =CGSizeMake(maxwidth ,maxheight);
    NSDictionary * ttdic = [NSDictionary dictionaryWithObjectsAndKeys:myfont,NSFontAttributeName,nil];
    
    //ios7方法，获取文本需要的size，限制宽度
    
    CGSize  actualsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:ttdic context:nil].size;
    //设置新的fram
    label.frame =CGRectMake(x, y, actualsize.width, maxheight);
}

+(BOOL)StringIsNull:(NSString *) str{
    if(str == nil || [str isEqualToString: @"<null>"] || [str isEqualToString: @""] || [str isEqualToString: @"null"] || [str isEqualToString: @"NULL"] || [str isEqualToString: @"(NULL)"] || [str isEqualToString: @"(null)"] ){
        return YES;
    }else{
        return NO;
    }
}

@end
