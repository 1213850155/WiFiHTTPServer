//
//  HmTool.h
//  Reading
//
//  Created by 赵海明 on 2018/6/28.
//  Copyright © 2018年 ulaiber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HmTool : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (BOOL)isValidatIP:(NSString *)ipAddress;

+ (NSDictionary *)getIPAddresses;

@end
