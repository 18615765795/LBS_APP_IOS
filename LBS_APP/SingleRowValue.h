//
//  SingleRowValue.h
//  LBS_APP
//
//  Created by msi on 16/4/25.
//  Copyright © 2016年 msi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleRowValue : NSObject

@property (nonatomic,strong)NSString *rowValue;
+(SingleRowValue *)shareData;

@end
