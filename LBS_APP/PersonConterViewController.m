//
//  PersonConterViewController.m
//  LBS_Safe
//
//  Created by msi on 16/3/28.
//  Copyright © 2016年 msi. All rights reserved.
//

#import "PersonConterViewController.h"
@interface PersonConterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *PhoneNumber;
@property (nonatomic,strong)NSArray *arrayData;
@property (nonatomic,strong)NSArray *arrayDataImage;

@end

@implementation PersonConterViewController
@synthesize arrayData;
@synthesize arrayDataImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    //UITableView *tableView =[[UITableView alloc]init];
    //[self.view addSubview:_tableView];
    
    arrayData = [NSArray arrayWithObjects:@"我的过往",@"消息中心",@"客服中心",@"关于我们",nil];
    arrayDataImage = [NSArray arrayWithObjects:@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/我的过往.png",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/消息中心.png",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/客服中心.png",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/关于我们.png",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;//几个section
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//每个section行数
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 50;//section高度
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];//重用
 
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    [tableView setSeparatorColor:[UIColor grayColor]];//设置分割线颜色
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;//右箭头
    cell.textColor = [UIColor grayColor];//灰色字体
    cell.selectedTextColor=[UIColor redColor];//点击变红
    cell.textLabel.text =[arrayData objectAtIndex:indexPath.section];//加载文字，按section编号
    cell.imageView.image = [UIImage imageNamed:[arrayDataImage objectAtIndex:indexPath.section]];//加载图片
    cell.font=[UIFont boldSystemFontOfSize:18];//字体大小
    return cell;
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
