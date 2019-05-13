//
//  TryOnViewController.m
//  Meou
//
//  Created by 杨国龙 on 15/10/8.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import "TryOnViewController.h"

@interface TryOnViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightMenuViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMenuViewRightConstraint;

@end

@implementation TryOnViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UILongPressGestureRecognizer * longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longpress.numberOfTouchesRequired = 2;
    longpress.minimumPressDuration = 2;
    [self.view addGestureRecognizer:longpress];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pinch:(UIPinchGestureRecognizer *)sender {
    
    DLog(@"pinch scale %f",sender.scale);
    if (sender.scale > 1) {
        _rightMenuViewLeftConstraint.constant = -60;
        _leftMenuViewRightConstraint.constant = -45;
    }else{
        _rightMenuViewLeftConstraint.constant = 0;
        _leftMenuViewRightConstraint.constant = 0;
    }
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}

- (IBAction)swipe:(id)sender {

    DLog(@"双指并拢享有刷屏");
}
- (IBAction)pan:(id)sender {
    DLog(@"单指拖动");
}
- (void)longPress:(UILongPressGestureRecognizer *)sender {
    DLog(@"两秒长摁");
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
