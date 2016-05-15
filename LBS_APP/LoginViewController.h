//
//  LoginViewController.h
//  LBS_APP
//
//  Created by msi on 16/4/26.
//  Copyright © 2016年 msi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MainViewController.h"
@protocol LoginViewPassValueProtocal <NSObject>
@required
-(void)passValue:(NSString *)value;
@end

@interface LoginViewController : UIViewController
{
    
}
@property (nonatomic,weak)id<LoginViewPassValueProtocal> PVdelegate;
@end
