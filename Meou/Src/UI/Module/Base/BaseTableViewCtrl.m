//
//  BaseTableViewCtrl.m
//  Meou
//
//  Created by 杨国龙 on 15/9/28.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import "BaseTableViewCtrl.h"
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)

@interface BaseTableViewCtrl ()

@end

@implementation BaseTableViewCtrl

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController.viewControllers.count > 1) {
        
        [self setUpLeftBarItem];
    }
    //ios7
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    //ios8
    if (IS_IOS_8) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
}
- (void)setUpLeftBarItem{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 15, 20);
    [btn addTarget:self action:@selector(leftBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:[self leftBarItemIcon]] forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barItem;
    
}

- (void)setUpRightBarItem{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 18);
    [btn addTarget:self action:@selector(rightBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:[self rightBarItemIcon]] forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
    
}

- (void)setUpRightTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 70);
    [btn addTarget:self action:@selector(rightBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn setAttributedTitle:[self attributedStrWithText:[btn titleForState:UIControlStateNormal]
                                                  Color:[UIColor whiteColor]]
                   forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (NSMutableAttributedString *)attributedStrWithText:(NSString *)text Color:(UIColor *)color{
    
    NSMutableAttributedString *attriButedStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attriButedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15]
                          range:NSMakeRange(0, [attriButedStr length])];
    
    [attriButedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [attriButedStr length])];
    
    return attriButedStr;
}
- (void)leftBarItemPress:(id)sender{
    
    if (self.navigationController.viewControllers.count > 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
         [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (void)rightBarItemPress:(id)sender{
    
}

- (NSString *)leftBarItemIcon{
    return @"back";
}

- (NSString *)rightBarItemIcon{
    return @"ico_refresh";
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
