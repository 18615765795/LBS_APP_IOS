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


@end
