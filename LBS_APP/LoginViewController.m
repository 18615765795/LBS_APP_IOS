//
//  LoginViewController.m
//  LBS_APP
//
//  Created by msi on 16/4/26.
//  Copyright © 2016年 msi. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+NJ.h"
#import "MainViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *pswField;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIImageView *personAvatar;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pswField];
    [self personAvatars];//设置用户头像
}

-(void)personAvatars{//用户头像
    //CALayer *layer = [self.personAvatar layer];
    self.personAvatar.layer.masksToBounds = YES;//将位于layer之下的部分覆盖
    self.personAvatar.layer.cornerRadius = self.personAvatar.bounds.size.width*0.5;//设置圆角为图片一般，就刚好是圆形
    
    self.personAvatar.layer.borderWidth = 3.0;
    self.personAvatar.layer.borderColor = [[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:240.0/255.0]CGColor];
    
}
-(void)textChange{//输入框文字改变
    if (self.nameField.text.length && self.pswField.text.length) {
        self.loginBtn.enabled = YES;
        self.loginBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:45.0/255.0 blue:70.0/255.0 alpha:1];//red
    }else{
        self.loginBtn.enabled = NO;
        self.loginBtn.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1];//blue
    }
}
- (IBAction)checkLogin {//检查登录
    if(![self.nameField.text isEqualToString:@"123"]){
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    if(![self.pswField.text isEqualToString:@"123"]){
        [MBProgressHUD showError:@"密码不正确"];
        return;
    }
    //设置代理
    MainViewController *view = [[MainViewController alloc]init];
    _PVdelegate = view;
    
    //传值
    if ([_PVdelegate respondsToSelector:@selector(passValue:)]) {//如果协议响应了passValue方法
        [_PVdelegate passValue:self.nameField.text];//通知执行协议方法
    }
    
    //显示过度动画
    [MBProgressHUD showMessage:@"加载ing"];
    //延时2秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];//隐藏过度动画
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MainViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
        [self presentModalViewController:view animated:YES];
        //[self performSegueWithIdentifier:@"loginToMain" sender:nil];//根据identifier跳转
    });
    
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
