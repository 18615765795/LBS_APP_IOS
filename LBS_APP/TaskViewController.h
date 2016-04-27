//
//  TaskViewController.h
//  LBS_APP
//
//  Created by msi on 16/3/28.
//  Copyright © 2016年 msi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

//对应label的tag
#define numberTag   1
#define taskTag     2
#define distanceTag 3
#define imageTag    4

//获取屏幕 宽度、高度
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface TaskViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
//@property(retain,nonatomic)NSArray *taskData;



@end
