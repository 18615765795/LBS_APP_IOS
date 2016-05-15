//
//  MainViewController.m
//  LBS_Safe
//
//  Created by msi on 16/3/26.
//  Copyright © 2016年 msi. All rights reserved.
//
#import "TaskViewController.h"
#import "MainViewController.h"
#import "PersonConterViewController.h"
#import "TaskViewController.h"
#import "LoginViewController.h"
#import "PersonInformationViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

//获取屏幕 宽度、高度
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface MainViewController ()<LoginViewPassValueProtocal>
{
UIPageControl *pageControl;  //指示当前处于第几个引导页
UIScrollView *scrollView;     //用于存放并显示引导页
UIImageView *imageViewZero;
UIImageView *buttonView;
}
@property BMKMapView* mapView;
@property(strong,nonatomic)BMKLocationService *locService;
@property(strong,nonatomic)BMKUserLocation *userLocation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *personBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *TaskAction;
@property (nonatomic,strong)NSMutableArray *nameArray;
@property (nonatomic,strong)NSMutableArray *phoneArray;
@end

@implementation MainViewController
@synthesize listData =_listData;
@synthesize imageData =_imageData;
@synthesize tableView = _tableView;
@synthesize tableViewCell =_tableViewCell;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //百度地图
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = mapView;
    
    //定位
    //设置定位精确度，默认：kCLLocationAccuracyBest
    //[BMKLocationServicesetLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    //[BMKLocationServicesetLocationDistanceFilter:100.f];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    //普通态
    //以下_mapView为BMKMapView对象
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:_userLocation];
    
}
NSString *_passValue;
#pragma mark -- LoginViewPassValueProtocal
-(void)passValue:(NSString *)value
{
    _passValue = value;
    //NSLog(@"_passvalue = %@",_passValue);
}

#pragma mark -- scrollView视图
-(void)initScrollView
{
    //    存放显示在单元格上的数据
    self.imageData = [NSArray arrayWithObjects:@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/我的过往.png",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/消息中心.png",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/客服中心.png",@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/关于我们.png",nil];
    self.listData = [NSArray arrayWithObjects:@"我的过往",@"消息中心",@"客服中心",@"关于我们",nil];
    
    //初始化UI控件
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH*0.8, 10)];
    pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.0];
    pageControl.numberOfPages=1;
    [self.view addSubview:pageControl];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*(-1), 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT)];
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*0.8,SCREEN_HEIGHT)];//4张图片总共的宽度，图片高度
    [scrollView setPagingEnabled:YES];  //视图整页显示
    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    [scrollView setBackgroundColor:[UIColor colorWithWhite:0.5f alpha:0.5f]];//透明背景
    
    UISwipeGestureRecognizer *swipeGestureLeft =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    swipeGestureLeft.direction =UISwipeGestureRecognizerDirectionLeft;//向左
    [scrollView addGestureRecognizer:swipeGestureLeft];//添加手势识别
    
    [self hideNavigationBar];// 隐藏导航栏
    [self AnimationRight];//右移
    [self.view addSubview:scrollView];
    
    [self createViewZero];//背景图
    [self buttonView];
    [self initTableView];//cell表单
  
}
-(void)createViewZero  //背景图
{
    imageViewZero = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT)];
    imageViewZero.contentMode = UIViewContentModeScaleAspectFill;
    imageViewZero.image = [UIImage imageNamed:@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/0.jpg"];
    //[scrollView addSubview:imageViewZero];
    
//用户信息－头像
    UIImageView *photo = [[UIImageView alloc]initWithFrame:CGRectMake(20, 35, 80, 80)];
    photo.image = [UIImage imageNamed:@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/personCenter/头像.jpg"];
    CALayer *layer = [photo layer];
    photo.layer.masksToBounds = YES;//告诉layer将位于他之下的layer都遮盖住
    photo.layer.cornerRadius = photo.bounds.size.width*0.5;//设置layer的圆角，刚好是自身宽度的一半，这样就成了圆形
    photo.layer.borderWidth = 5.0;
    photo.layer.borderColor = [[UIColor whiteColor]CGColor];
    [scrollView addSubview:photo];

    //名字
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 40, 150, 30)];
    //_nameArray = [NSMutableArray arrayWithObjects:@"张三", nil];
    ///NSString *nameStr = [NSString stringWithFormat:@"%@",_nameArray];    
    nameLabel.text = _passValue;
    //NSLog(@"%@",_passValue);
    [scrollView addSubview:nameLabel];
    
//电话
    UILabel *phoneLable=[[UILabel alloc]initWithFrame:CGRectMake(120, 80, 150, 30)];
    //_phoneArray = [NSMutableArray arrayWithObjects:@"186****1234", nil];
    phoneLable.text = @"186****1234";
    [scrollView addSubview:phoneLable];
    
    
    UIButton *exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2, SCREEN_HEIGHT*0.7, SCREEN_WIDTH*0.4, 40)];
    exitBtn.backgroundColor = [UIColor colorWithRed:50 green:0 blue:0 alpha:0.5];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [scrollView addSubview:exitBtn];
    [exitBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
}
-(void)logout{//注销按钮点击事件
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"点击确认后将退出当前账户" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action){
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *view= [story instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:view animated:YES];
        
    }]];
    //显示当前前提
    [self presentViewController:alert animated:YES completion:NULL];
    
}
-(void)buttonView
{
    //初始化
    buttonView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.7-10, 40, 40, 40)];
    buttonView.contentMode = UIViewContentModeScaleAspectFill;
    buttonView.image =[UIImage imageNamed:@"/Users/msi/Documents/2016/LBS_APP/LBS_APP/首页.png"];
    
    //点击手势
    UITapGestureRecognizer *tapGestureRecognier =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pictureClick)];
    [buttonView addGestureRecognizer:tapGestureRecognier];
    buttonView.userInteractionEnabled=YES;
    
    [scrollView addSubview:buttonView];
}
-(void)initTableView
{
    //初始化表格
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, 200, SCREEN_WIDTH*0.6, 240) style:UITableViewStyleGrouped];
    // 设置协议，意思就是UITableView类的方法交给了tabView这个对象，让完去完成表格的一些设置操作
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    //背景透明
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.0f]];
    //关闭上下滑动
    [self.tableView setScrollEnabled:NO];
    //让你的tableView按照 上 ,左  ,下  ,右的方向 偏移
    self.tableView.contentInset=UIEdgeInsetsMake(-35, 0, 0, 0);
    
    
    [scrollView addSubview:self.tableView];
}

#pragma mark - delegate方法cell
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//几个section
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];//每个section行数
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 60;//section高度
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0;//这个方法返回指定的 section的header view 的高度。
}

-(NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置单元格缩进
//    NSInteger row = [indexPath row];
//    if (row % 2==0) {//轮流缩进
//        return 0;
//    }
    return 3;
}
//选中单元格所产生事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    首先是用indexPath获取当前行的内容
    NSInteger row = [indexPath row];
    //    从数组中取出当前行内容
    NSString *rowValue = [self.listData objectAtIndex:row];
    NSString *message = [[NSString alloc]initWithFormat:@"You selected%@",rowValue];
    //    弹出警告信息
    if(row == 0){
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        PersonInformationViewController *personInformation = [story instantiateViewControllerWithIdentifier:@"PersonInformationViewController"];
        [self.navigationController pushViewController:personInformation animated:YES];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles: nil];
        [alert show];
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    声明静态字符串型对象，用来标记重用单元格
    static NSString *cellIndentifier = @"cell";
    //    用cellIdentifier表示需要重用的单元
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    //    如果如果没有多余单元，则需要创建新的单元
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    else {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    //cell背景色
    [cell setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.0f]];
    //设置分割线颜色
    [tableView setSeparatorColor:[UIColor grayColor]];
    //cell上的右箭头
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    //白色字体
    cell.textColor = [UIColor whiteColor];
    //字体点击变红
    cell.selectedTextColor=[UIColor redColor];
    
    cell.textLabel.text =[self.listData objectAtIndex:indexPath.row];//加载文字，按row编号
    cell.imageView.image = [UIImage imageNamed:[self.imageData objectAtIndex:indexPath.row]];//加载图片
    
    //    表视图单元提供的UILabel属性，设置字体大小
    cell.textLabel.font=[UIFont boldSystemFontOfSize:18.0f];
    return cell;
}

#pragma mark -- 平移动画
-(void)AnimationLeft{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGPoint point = scrollView.center;
    point.x -=SCREEN_WIDTH;//平移
    [scrollView setCenter:point];
    [UIView commitAnimations];//提交动画
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGPoint point2 = buttonView.center;
    point.x -=SCREEN_WIDTH;//平移
    [buttonView setCenter:point2];
    [UIView commitAnimations];//提交动画
}
-(void)AnimationRight{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGPoint point = scrollView.center;
    point.x +=SCREEN_WIDTH;//平移
    [scrollView setCenter:point];
    [UIView commitAnimations];//提交动画
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGPoint point2 = buttonView.center;
    point.x +=SCREEN_WIDTH;//平移
    [buttonView setCenter:point2];
    [UIView commitAnimations];//提交动画
}
#pragma mark -- 轻扫手势
-(void)swipeGesture:(id)sender
{
    UISwipeGestureRecognizer *swipe = sender;
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        //MainViewController *mainViewController = [[MainViewController alloc]init];
        [self.navigationController popToRootViewControllerAnimated:YES];//返回首页
        
        //左移过度动画栏
        [self AnimationLeft];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showNavigationBar];
            [self hideScrollView];
        });
    }
}
#pragma mark -- 点击手势
-(void)pictureClick//点击首页图标
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    //左移过度动画栏
    [self AnimationLeft];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showNavigationBar];
        [self hideScrollView];
    });
    
//    //延迟隐藏
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showNavigationBar) userInfo:nil repeats:YES];
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideScrollView) userInfo:nil repeats:YES];
//    
}

#pragma mark -- 显示/隐藏
-(void)hideNavigationBar//隐藏导航
{
    self.navigationController.navigationBarHidden = YES;
}
-(void)showNavigationBar//显示导航
{
    self.navigationController.navigationBarHidden = NO;
}
-(void)hideScrollView
{
    [scrollView setHidden:YES];
}
-(void)showScrollView
{
    [scrollView setHidden:NO];
}



#pragma mark -- tap image
-(void)buttonpress0:(id)sender
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGPoint scrollpoint = CGPointMake(pageWidth, 0);
    [scrollView setContentOffset:scrollpoint animated:YES];
    pageControl.currentPage = 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 百度地图定位 BMKLocationServiceDelegate
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}



//点击个人中心
- (IBAction)personAction:(id)sender {
    [self initScrollView];//加载scrollView
    
}

//点击任务列表
-(IBAction)TaskAction:(id)sender {
    TaskViewController *taskViewController = [[TaskViewController alloc]init];
    [self.navigationController pushViewController:taskViewController animated:YES];
  
}


@end
