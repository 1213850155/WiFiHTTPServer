//
//  HmSupportiTunesController.m
//  Reading
//
//  Created by 赵海明 on 2018/6/20.
//  Copyright © 2018年 ulaiber. All rights reserved.
//

#import "HmSupportiTunesController.h"
#import "HmHTTPConnection.h"
#import "HmTool.h"
#import <HTTPServer.h>

@interface HmSupportiTunesController ()<UITableViewDelegate, UITableViewDataSource> {
    HTTPServer *httpServer;
}

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *dirArray; // 存储沙盒里面的所有文件
@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;    // 一个文件交互控制器，提供应用程序管理与本地系统中的文件的用户交互的支持

@end

@implementation HmSupportiTunesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支持iTunes文件共享";
    [self setupView];
    
    // WiFi传文件
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"同网传送" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonItemAction:)];
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)bar {
    [self initServer];
}

// 初始化本地服务器
- (void)initServer {
    httpServer = [[HTTPServer alloc] init];
    [httpServer setType:@"_http._tcp."];
    // webPath是server搜寻HTML等文件的路径
    NSString *webPath = [[NSBundle mainBundle] resourcePath];
    [httpServer setDocumentRoot:webPath];
    [httpServer setConnectionClass:[HmHTTPConnection class]];
    NSError *error;
    if ([httpServer start:&error]) {
        NSLog(@"IP: %@:%hu", [HmTool getIPAddress:YES], [httpServer listeningPort]);
    }else {
        NSLog(@"%@", error);
    }
}

- (void)setupView {
    [self setupTableView];
    
    // 获取沙盒中所有文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 在这里获取应用程序Documents文件夹里的文件及文件夹列表
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    // fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];
    
    self.dirArray = [[NSMutableArray alloc] init];
    for (NSString *fileName in fileList) {
        [self.dirArray addObject:fileName];
    }
    [self.tableV reloadData];
}

- (void)setupTableView {
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.navigationController.navigationBar.bounds.size.height) style:(UITableViewStylePlain)];
    self.tableV.backgroundColor = [UIColor lightGrayColor];
    self.tableV.tableFooterView = [UIView new];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.rowHeight = UITableViewAutomaticDimension;
    self.tableV.estimatedRowHeight = 100;
    [self.view addSubview:_tableV];
}

#pragma mark -- UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dirArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dirArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
