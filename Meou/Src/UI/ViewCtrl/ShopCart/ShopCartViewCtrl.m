//
//  ShopCartViewCtrl.m
//  Meou
//
//  Created by 杨国龙 on 15/9/28.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import "ShopCartViewCtrl.h"

@interface ShopCartViewCtrl ()
@property (weak, nonatomic) IBOutlet UIView *emptyAlertView;

@end

@implementation ShopCartViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shopCartCell" forIndexPath:indexPath];
    return cell;
    
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
