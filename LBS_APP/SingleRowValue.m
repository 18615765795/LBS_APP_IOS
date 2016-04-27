//
//  SingleRowValue.m
//  LBS_APP
//
//  Created by msi on 16/4/25.
//  Copyright © 2016年 msi. All rights reserved.
//

#import "SingleRowValue.h"

@implementation SingleRowValue

+(SingleRowValue *)shareData{
    static SingleRowValue *singleData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        singleData = [[SingleRowValue alloc]init];
    });
    return singleData;
}
-(id)init{
    if (self = [super init]) {
        self.rowValue = [[NSString alloc]init];
    }
    return self;
}
@end
