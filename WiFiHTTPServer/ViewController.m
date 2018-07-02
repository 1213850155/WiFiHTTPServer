//
//  ViewController.m
//  WiFiHTTPServer
//
//  Created by 赵海明 on 2018/7/2.
//  Copyright © 2018年 ulaiber. All rights reserved.
//

#import "ViewController.h"
#import "HmSupportiTunesController.h"

// 屏幕的width
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕的height
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"测试";
    [self supoortiTunes];
//    [self demo1];
}

/// 支持iTunes文件共享
- (void)supoortiTunes {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(44, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height + 20, kScreenWidth - 88, 40);
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"支持iTunes文件共享" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(clickSupportAction:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.tag = 10;
    [self.view addSubview:btn];
}

// 点击
- (void)clickSupportAction:(UIButton *)btn {
    if (btn.tag == 10) {
        HmSupportiTunesController *supportVC = [[HmSupportiTunesController alloc] init];
        [self.navigationController pushViewController:supportVC animated:YES];
    }
}

-(void)demo1{
    //访问百度首页
    
    //1. 创建一个网络请求
    NSURL *url = [NSURL URLWithString:@"http://m.baidu.com"];
    
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //response ： 响应：服务器的响应
        //data：二进制数据：服务器返回的数据。（就是我们想要的内容）
        //error：链接错误的信息
        NSLog(@"网络响应：response：%@",response);
        
        //根据返回的二进制数据，生成字符串！NSUTF8StringEncoding：编码方式
        NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        //在客户端直接打开一个网页！
        //客户端服务器：UIWebView
        
        //将浏览器加载到view上
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //实例化一个客户端浏览器
            UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
            
            //加载html字符串：baseURL：基准的地址：相对路径/绝对路径
            [web loadHTMLString:html baseURL:nil];
            [self.view addSubview:web];
            [self.view sendSubviewToBack:web];
        });
        
        //        //在本地保存百度首页
        //        [data writeToFile:@"/Users/Liu/Desktop/baidu.html" atomically:YES];
        
    }
                                    ];
    
    //5.执行任务
    [dataTask resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
