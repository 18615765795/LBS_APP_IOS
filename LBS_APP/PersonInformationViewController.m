//
//  PersonInformationViewController.m
//  LBS_APP
//
//  Created by msi on 16/5/4.
//  Copyright © 2016年 msi. All rights reserved.
//

#import "PersonInformationViewController.h"
#import "MainViewController.h"
@interface PersonInformationViewController ()
@property (nonatomic,strong)NSArray *arrayList;
@property (nonatomic,strong)NSArray *dataList;
@end

@implementation PersonInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayList = [NSArray arrayWithObjects:@"头像",@"性别",@"年龄",@"手机号", nil];
    _dataList = [NSArray arrayWithObjects:@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/头像1.jpg",@"男",@"25",@"186****1234", nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }else{
        while ([cell.contentView.subviews lastObject]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    
    NSInteger section=[indexPath section];
    NSInteger row = [indexPath row];
    //设置分割线颜色
    [tableView setSeparatorColor:[UIColor grayColor]];
    if (section == 0) {
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(250, 10, 60, 60)];
        view.image = [UIImage imageNamed:@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/头像1.jpg"];
        [cell addSubview:view];
    }
    if (section != 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(250, 30, 120, 25)];
        label.text = [_dataList objectAtIndex:indexPath.section];
        [cell addSubview:label];
    }
    cell.textLabel.text = [_arrayList objectAtIndex:indexPath.section];
    [tableView setSeparatorColor:[UIColor grayColor]];
    //cell.userInteractionEnabled = NO;
    tableView.userInteractionEnabled = NO;
    return cell;
}
- (IBAction)backAction:(id)sender {
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    MainViewController *main = [story instantiateViewControllerWithIdentifier:@"mainView"];
//    [self presentModalViewController:main animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MainViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    [self presentModalViewController:view animated:YES];
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
