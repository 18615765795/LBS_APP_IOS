//
//  AppDelegate.h
//  LBS_APP
//
//  Created by msi on 16/3/28.
//  Copyright © 2016年 msi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UIWindow *window;
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
    
}

@property (strong, nonatomic) UIWindow *window;


@end

