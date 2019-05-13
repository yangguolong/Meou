//
//  VCButton.m
//  Meou
//
//  Created by 杨国龙 on 15/10/16.
//  Copyright © 2015年 cloudream. All rights reserved.
//

#import "VCButton.h"


static NSInteger totalCount;
@implementation VCButton


-(void)startCountDown{
    
    self.enabled = NO;
    
   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    
    totalCount = 60;
}

-(void)countDown:(NSTimer *)timer{
    totalCount --;
    [self setTitle:[NSString stringWithFormat:@"%zds",totalCount] forState:UIControlStateDisabled];
    if (totalCount == 0) {
        self.enabled = YES;
    }
}
/*

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
