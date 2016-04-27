//
//  TaskDetailsViewController.m
//  LBS_APP
//
//  Created by msi on 16/4/15.
//  Copyright © 2016年 msi. All rights reserved.
//

#import "TaskDetailsViewController.h"
#import "TaskViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SingleRowValue.h"
//获取屏幕 宽度、高度
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface TaskDetailsViewController ()
{
    //UIScrollView *scrollView;
    NSString *_plistPath;
    NSDictionary *_dataDictionary;
    NSString *_rowValue;
}
@property (strong, nonatomic) IBOutlet UITextView *taskDetails;//任务详情
@property (strong, nonatomic) IBOutlet UITextView *taskReport;//任务报告
@property (strong, nonatomic) IBOutlet UIScrollView *scrollPhoto;//滚动照片
@property (nonatomic,strong) NSArray *photoData;
@property (strong, nonatomic) IBOutlet UILabel *taskRpPlaceholder;//任务报告提示文字
@property (strong, nonatomic) IBOutlet UIButton *taskRpBtn;//任务报告提交按钮
@property (strong, nonatomic) IBOutlet UIImageView *Camera;//相机图片




@end

@implementation TaskDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoData = [NSArray arrayWithObjects:@"/Volumes/VMware Shared Folders/IOS Share/图片/scroll/1.jpg",@"/Volumes/VMware Shared Folders/IOS Share/图片/scroll/2.jpg",@"/Volumes/VMware Shared Folders/IOS Share/图片/scroll/3.jpg",@"/Volumes/VMware Shared Folders/IOS Share/图片/scroll/4.jpg",@"/Volumes/VMware Shared Folders/IOS Share/图片/scroll/5.jpg",nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"ThinkChange" style:UIBarButtonItemStylePlain target:self action:@selector(navigationButton)];
    
    //通知 －－ 提交报告
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.taskReport];
    
    //单例传值－－cell编号
    _rowValue =[SingleRowValue shareData].rowValue;
    
    //读取taskDetails.plist
    _plistPath = [[NSBundle mainBundle]pathForResource:@"taskDetails" ofType:@"plist"];
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:_plistPath];
    _dataDictionary = [data objectForKey:_rowValue];
    NSLog(@"_dataArray data = %@",_dataDictionary);
    
    [self camera];
    [self textField];
    [self scrollView];
    [self navigationButton];
}
#pragma  mark -- textChange
-(void)textChange{
    //文字改变
    if (self.taskReport.text.length) {
        self.taskRpPlaceholder.hidden = YES;
        self.taskRpBtn.enabled = YES;
        self.taskRpBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:45.0/255.0 blue:70.0/255.0 alpha:1];//红色
        [self.taskRpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.taskRpPlaceholder.hidden = NO;
        self.taskRpBtn.enabled = NO;
        self.taskRpBtn.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1];//蓝色
        [self.taskRpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
}
#pragma mark -- camera
-(void)camera{
    //给camera图片添加点击手势
    self.Camera.userInteractionEnabled = YES;//响应用户触发事件
    UITapGestureRecognizer *singeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCamera)];
    [self.Camera addGestureRecognizer:singeTap];
}
-(void)onClickCamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }else{
        NSLog(@"模拟器中无法打开照相机,需要在真机中使用");
    }
    
}
#pragma mark -- 二维码
-(void)navigationButton{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [rightButton setImage:[UIImage imageNamed:@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/二维码.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightBarButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}
//点击二维码
-(void)clickRightBarButton{
    
}

#pragma mark -- textfield
-(void)textField{
    
    
    //背景阴影设置
    self.taskRpBG.layer.shadowOpacity = 0.4;
    self.taskDetailsBG.layer.shadowOpacity = 0.4;
    self.scrollBG.layer.shadowOpacity = 0.4;
    self.taskRpBtn.layer.shadowOpacity = 0.4;
    
    //任务详情
    self.taskDetails.layer.cornerRadius = 5.0;
    //self.taskDetails.layer.borderColor = [[UIColor grayColor]CGColor];
    //self.taskDetails.layer.borderWidth = 1.0;
    [self.taskDetails setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]];
    
    //任务详情对应标签
    self.numberLabel.text= _rowValue;
    self.distanceLabel.text = [_dataDictionary objectForKey:@"distance"];
    self.taskNameLabel.text = [_dataDictionary objectForKey:@"task"];
    self.taskDetailsLabel.text = [_dataDictionary objectForKey:@"detail"];
    NSString *check = [_dataDictionary objectForKey:@"boolean"];
    if ([check isEqualToString:@"YES"]) {
        self.taskStatusLabel.text = @"已完成";
    }else{
        self.taskStatusLabel.text = @"未完成";
    }
    
    //任务报告
    //self.taskReport.text = @"请输入任务报告";
    self.taskReport.textColor = [UIColor grayColor];
    self.taskReport.layer.cornerRadius = 5.0;
    //self.taskReport.layer.borderWidth = 1.0;
    //self.taskReport.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.taskReport setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]];
}
-(void)scrollView{
//    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 360, 374,94)];
//    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH-40, 94)];
//    [scrollView setPagingEnabled:YES];
//    [scrollView setBounces:NO];
//    [scrollView setBackgroundColor:[UIColor colorWithWhite:0.5f alpha:0.5f]];
//    
//    //手势识别
//    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
//    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//
//    [scrollView addGestureRecognizer:swipeGestureLeft];
//    [self.view addSubview:scrollView];
    
    //self.scrollPhoto.layer.borderWidth = 1.0;
    //self.scrollPhoto.layer.borderColor = [[UIColor grayColor]CGColor];
    self.scrollPhoto.contentSize = CGSizeMake(360, 86);//内容宽度
    [self.scrollPhoto setBackgroundColor:[UIColor whiteColor]];
    
    UISwipeGestureRecognizer *swipeGestureLeft =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    swipeGestureLeft.direction =UISwipeGestureRecognizerDirectionLeft;//向左
    [self.scrollPhoto addGestureRecognizer:swipeGestureLeft];//添加手势识别
    
    
    
}
#pragma mark -- 轻扫手势
-(void)swipeGesture:(id)sender{
    
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
