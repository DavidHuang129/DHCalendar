//
//  UIImage+DHCalendar.m
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import "UIImage+DHCalendar.h"

@implementation UIImage (DHCalendar)
+ (UIImage *)resizedImageWithImage:(UIImage *)image {
    return [self resizedImageWithImage:image left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithImage:(UIImage *)image left:(CGFloat)left top:(CGFloat)top {
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
+ (UIImage *) createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
