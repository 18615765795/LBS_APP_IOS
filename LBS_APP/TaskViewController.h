//
//  TaskViewController.h
//  LBS_APP
//
//  Created by msi on 16/3/28.
//  Copyright © 2016年 msi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *number;
@property (nonatomic,strong)NSArray *task;
@property (nonatomic,strong)NSArray *distance;
@end
