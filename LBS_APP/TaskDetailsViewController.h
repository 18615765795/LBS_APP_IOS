//
//  TaskDetailsViewController.h
//  LBS_APP
//
//  Created by msi on 16/4/15.
//  Copyright © 2016年 msi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TaskDetailsViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *taskDetailsBG;
@property (strong, nonatomic) IBOutlet UIView *scrollBG;
@property (strong, nonatomic) IBOutlet UIView *taskRpBG;

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;//编号
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;//距离
@property (strong, nonatomic) IBOutlet UILabel *taskDetailsLabel;//任务详情
@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;//任务名称
@property (strong, nonatomic) IBOutlet UILabel *taskStatusLabel;//任务状态

@end
