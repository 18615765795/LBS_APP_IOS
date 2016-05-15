//
//  MainViewController.h
//  LBS_Safe
//
//  Created by msi on 16/3/26.
//  Copyright © 2016年 msi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property(strong,nonatomic)UILabel *PV;
@property(strong,nonatomic) NSArray *listData;
@property(strong,nonatomic) NSArray *imageData;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UITableViewCell *tableViewCell;

@end
