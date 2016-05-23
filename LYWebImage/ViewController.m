//
//  ViewController.m
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+ly_WebCache.h"

static NSString *const tableviewIndentity = @"tableviewIndentity";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonnull,nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [imageview ly_setImageWithUrl:[NSURL URLWithString:@"http://img.sccnn.com/bimg/330/157.jpg"]];
    [self.view addSubview:imageview];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableviewIndentity];
    [self.view addSubview:self.tableView];
}


- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray= [NSMutableArray array];
        
        [_imageArray addObject:@"http://www.eprice.cn/image/upload/articles/20150227/130694745104094402.png"];
        [_imageArray addObject:@"http://img.sccnn.com/bimg/330/157.jpg"];
        [_imageArray addObject:@"http://d6.yihaodianimg.com/N06/M0A/F4/80/CgQIzlRHZ8KAERx4AAZ4RFROD_c61501.jpg"];
        [_imageArray addObject:@"http://img.pconline.com.cn/images/product/5286/528658/mini.jpg"];
        [_imageArray addObject:@"http://c.cnfolimg.com/20140722/18/9978973136555790166.jpg"];
        [_imageArray addObject:@"http://s9.knowsky.com/bizhi/l/35001-45000/200952942011314821004.jpg"];
        [_imageArray addObject:@"http://img0.imgtn.bdimg.com/it/u=1694435551,2310929519&fm=21&gp=0.jpg"];
        [_imageArray addObject:@"http://s9.knowsky.com/bizhi/l/35001-45000/200952941233694906830.jpg"];
        [_imageArray addObject:@"http://imga1.pic21.com/bizhi/130901/00590/s13.jpg"];
        [_imageArray addObject:@"http://img3.imgtn.bdimg.com/it/u=2717064270,84960519&fm=21&gp=0.jpg"];
    }
    
    return _imageArray;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.imageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableviewIndentity];
    
    [cell.imageView ly_setImageWithUrl:[NSURL URLWithString:self.imageArray[indexPath.row]]];
    return cell;
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
