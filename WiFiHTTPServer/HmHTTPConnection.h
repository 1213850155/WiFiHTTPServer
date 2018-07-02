//
//  HmHTTPConnection.h
//  Reading
//
//  Created by 赵海明 on 2018/6/28.
//  Copyright © 2018年 ulaiber. All rights reserved.
//

#import <HTTPConnection.h>
@class MultipartFormDataParser;

@interface HmHTTPConnection : HTTPConnection {
    MultipartFormDataParser *parser;
    NSFileHandle *storeFile;
    NSMutableArray *uploadedFiles;
    
}

@end
