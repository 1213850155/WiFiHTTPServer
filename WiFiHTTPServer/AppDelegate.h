//
//  AppDelegate.h
//  WiFiHTTPServer
//
//  Created by 赵海明 on 2018/7/2.
//  Copyright © 2018年 ulaiber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

