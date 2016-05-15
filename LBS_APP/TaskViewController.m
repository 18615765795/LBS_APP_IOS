//
//  TaskViewController.m
//  LBS_APP
//
//  Created by msi on 16/3/28.
//  Copyright © 2016年 msi. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskDetailsViewController.h"
#import "SingleRowValue.h"
@interface TaskViewController ()
{
    NSString *_plistPath;
    NSArray *_dataArray;
    NSArray *_keyArray;
    NSArray *_boolArray;
    NSDictionary *_data;
    NSInteger _row;
    NSString *row1;
}
-(void)test;
@end

@implementation TaskViewController

//@synthesize taskData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITableView *tableView = [[UITableView alloc]initWithFrame:SCREEN_FRAME style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    
   
//    //初始化TaskData
//    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys: @"10001",@"number",@"检查播放器1是否完好",@"task", @"1KM", @"distance",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/未选择.png",@"image0",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/已选择.png",@"image",@"YES",@"boolean",nil];
//    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys: @"10002",@"number",@"检查播放器2是否完好",@"task", @"2KM", @"distance",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/未选择.png",@"image0",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/已选择.png",@"image",@"YES",@"boolean",nil];
//    NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys: @"10003",@"number",@"检查播放器3是否完好",@"task", @"3KM", @"distance",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/未选择.png",@"image0",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/已选择.png",@"image",@"YES",@"boolean",nil];
//    NSDictionary *dic4 = [[NSDictionary alloc]initWithObjectsAndKeys: @"10004",@"number",@"检查播放器4是否完好",@"task", @"4KM", @"distance",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/未选择.png",@"image0",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/已选择.png",@"image",@"YES",@"boolean",nil];
//    NSDictionary *dic5 = [[NSDictionary alloc]initWithObjectsAndKeys: @"10005",@"number",@"检查播放器5是否完好",@"task", @"5KM", @"distance",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/未选择.png",@"image0",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/已选择.png",@"image",@"NO",@"boolean",nil];
//    _taskData = [[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic5,nil];
    
    
    //读取taskDetails.plist
    _plistPath = [[NSBundle mainBundle]pathForResource:@"taskDetails" ofType:@"plist"];
    _data = [NSDictionary dictionaryWithContentsOfFile:_plistPath];
    //NSLog(@"_data =  %@",_data);
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.allKeys.count-1;
}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//定义分区的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"任务列表";
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, 100, 30)];
    UILabel *headerLabel = [[UILabel alloc]init];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor orangeColor];
    headerLabel.font =[UIFont boldSystemFontOfSize:25];
    headerLabel.highlightedTextColor = [UIColor redColor];
    //headerLabel.opaque = NO;
    headerLabel.text = @"任务列表";
    headerLabel.frame = CGRectMake(30, 20, 100, 30);
    [customView addSubview:headerLabel];
    return customView;
}
//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    //调用customCellWithOutXib方法
    cell = [self customCellWithOutXib:tableView withIndexPath:indexPath];
    
    return cell;
}

#pragma mark -- 页面跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     //rowValue是点击的哪行
    _row = [indexPath row];
    NSLog(@"YOU clicked row: %ld",(long)_row+1);
    
    //强制转型
    row1 = [[NSNumber numberWithInteger:_row+10000]stringValue];
    
   //获取任务编号
    NSDictionary *dic1 = [_data objectForKey:row1];
    NSString *taskNumber = [dic1 objectForKey:@"number"];
    
    //使用单例
    SingleRowValue *value = [SingleRowValue shareData];
    value.rowValue = taskNumber;
    
    //跳转到storyboard页面
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *view= [story instantiateViewControllerWithIdentifier:@"TaskDetailsViewController"];
    [self.navigationController pushViewController:view animated:YES];

}

-(UITableViewCell *)customCellWithOutXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    //定义标识符
    static NSString *customCellIndentifier = @"CustomCellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIndentifier];
    
    //定义新的cell
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCellIndentifier];
        //编号
        CGRect numberRect = CGRectMake(88, 15, 100, 25);
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:numberRect];
        numberLabel.font = [UIFont boldSystemFontOfSize:20];
        numberLabel.tag = numberTag;//设置tag，以便后面的定位
        numberLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:numberLabel];
        
        //任务
        CGRect taskTipRect = CGRectMake(88, 40, 100, 20);
        UILabel *taskTipLabel = [[UILabel alloc]initWithFrame:taskTipRect];
        taskTipLabel.text = @"任务:";
        taskTipLabel.font = [UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:taskTipLabel];
        
        
        CGRect taskRect = CGRectMake(188, 40, 200, 20);
        UILabel *taskLabel = [[UILabel alloc]initWithFrame:taskRect];
        taskLabel.tag = taskTag;
        taskLabel.font = [UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:taskLabel];
        
        //距离
        CGRect distanceTipRect = CGRectMake(88, 60, 100, 20);
        UILabel *distanceTipLabel = [[UILabel alloc]initWithFrame:distanceTipRect];
        distanceTipLabel.text = @"距离:";
        distanceTipLabel.font = [UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:distanceTipLabel];
        
        CGRect distanceRect = CGRectMake(188, 60, 200, 20);
        UILabel *distanceLabel = [[UILabel alloc]initWithFrame:distanceRect];
        distanceLabel.tag = distanceTag;
        distanceLabel.font = [UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:distanceLabel];
        
        //chexkBox
        CGRect imageRect = CGRectMake(30, 30, 30, 30);
        UIImageView *imageView= [[UIImageView alloc]initWithFrame:imageRect];
        imageView.tag = imageTag;
        //为图片添加边框
        CALayer *layer = [imageView layer];
        layer.cornerRadius = 8;//角弧度
        //layer.borderColor = [[UIColor whiteColor]CGColor];
        layer.masksToBounds=YES;//图片填充
        [cell.contentView addSubview:imageView];
    }
    
    //获得行数
    NSUInteger row = [indexPath row];
    
    //获取字典
    NSString *a = [[NSNumber numberWithInteger:row+10000]stringValue];
    
    NSDictionary *dic =[_data objectForKey:a];
    NSDictionary *img = [_data objectForKey:@"selected"];
    //NSLog(@"dic = %@",dic);
    //NSLog(@"img = %@",img);
    
    //设置number
    UILabel *number = (UILabel *)[cell.contentView viewWithTag:numberTag];
    number.text = [dic objectForKey:@"number"];
    
    //设置task
    UILabel *task = (UILabel *)[cell.contentView viewWithTag:taskTag];
    task.text = [dic objectForKey:@"task"];
    
    //设置distance
    UILabel *distance = (UILabel *)[cell.contentView viewWithTag:distanceTag];
    distance.text = [dic objectForKey:@"distance"];
    
    //设置图片
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:imageTag];
    NSString *check = [[NSString alloc]init];
    check = [dic objectForKey:@"boolean"];
    if ([check isEqualToString:@"YES"]) {
        imageView.image = [UIImage imageNamed:[img objectForKey:@"image1"]];
    }else{
        imageView.image = [UIImage imageNamed:[img objectForKey:@"image0"]];
    }
    
    
    //设置右侧箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
