//
//  TaskViewController.m
//  LBS_APP
//
//  Created by msi on 16/3/28.
//  Copyright © 2016年 msi. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskModel.h"
//获取屏幕 宽度、高度
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface TaskViewController()
{
    NSMutableArray *taskModelNumber;
}
@end

@implementation TaskViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH-60, SCREEN_HEIGHT-200) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view.backgroundColor=[UIColor whiteColor];
    tableView.backgroundColor = [UIColor clearColor];
    //让你的tableView按照 上 ,左  ,下  ,右的方向 偏移
    //让你的tableView按照 上 ,左  ,下  ,右的方向 偏移
    tableView.contentInset=UIEdgeInsetsMake(-100, 0, 0, 0);
    self.number =[NSArray arrayWithObjects:@"10001",@"10002",@"10003",@"10004",@"10005",nil];
    self.distance = [NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM",nil];
    self.task = [NSArray arrayWithObjects:@"检查播放器1是否完好",@"检查播放器2是否完好",@"检查播放器3是否完好",@"检查播放器4是否完好",@"检查播放器5是否完好",@"检查播放器1是否完好",nil];
    
    [self.view addSubview:tableView];
    
    //TaskModel *taskModel = [[TaskModel alloc]init];
    //taskModel.delegate = self;
    
    
}

#pragma mark -- delegate TaskModel
-(void)initTaskModel{
    
//    TaskModel *task10001 = [[TaskModel alloc]init];
//    task10001.number = @"10001";
//    task10001.task =@"检查播放器1是否完好";
//    task10001.distance = @"1KM";
//    
//    TaskModel *task10002 = [[TaskModel alloc]init];
//    task10001.number = @"10001";
//    task10001.task =@"检查播放器2是否完好";
//    task10001.distance = @"2KM";
//    
//    TaskModel *task10003 = [[TaskModel alloc]init];
//    task10001.number = @"10001";
//    task10001.task =@"检查播放器3是否完好";
//    task10001.distance = @"3KM";
//    
//    TaskModel *task10004 = [[TaskModel alloc]init];
//    task10001.number = @"10001";
//    task10001.task =@"检查播放器4是否完好";
//    task10001.distance = @"5KM";
//    
//    TaskModel *task10005 = [[TaskModel alloc]init];
//    task10001.number = @"10001";
//    task10001.task =@"检查播放器5是否完好";
//    task10001.distance = @"5KM";
//    
//    taskModelNumber = @[task10001,task10002,task10003,task10004,task10005];
}


#pragma mark -- delegate cell

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.number.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_HEIGHT-200)*0.25;//section高度
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0;//这个方法返回指定的 section的header view 的高度。
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    声明静态字符串型对象，用来标记重用单元格
    static NSString *cellIndentifier = @"cell";
    //    用cellIdentifier表示需要重用的单元
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    //    如果如果没有多余单元，则需要创建新的单元
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
    }
    else {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    //TaskModel *taskModel = taskModelNumber[indexPath.section];
    
    cell.textLabel.text = [self.number objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.task objectAtIndex:indexPath.row];
    //cell上的右箭头
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.font = [UIFont boldSystemFontOfSize:20];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
