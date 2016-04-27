//
//  TaskModel.h
//  LBS_APP
//
//  Created by msi on 16/4/11.
//  Copyright © 2016年 msi. All rights reserved.
//

#import <Foundation/Foundation.h>
//@protocol TaskModelDelegate<NSObject>;
//- (void)initTaskModel;
//@end


@interface TaskModel : NSObject

@property(nonatomic,copy)NSArray *number;
@property(nonatomic,copy)NSArray *task;
@property(nonatomic,copy)NSArray *distance;
@property(nonatomic,weak)NSString *rowValue;
//+(id)TaskModelNumber:(NSArray *)number task:(NSArray *)task distance:(NSArray *)distance;

//@property(nonatomic,retain)id<TaskModelDelegate>delegate;
@end
