//
//  ICNetworkStatus.h
//  IntelligentChild
//
//  Created by L on 14/11/3.
//  Copyright (c) 2014年 Fish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface CDNetworkStatus : NSObject
{
    Reachability *_reachDetector;
    BOOL         _isHaveNetwork;
    BOOL         _isTellMe;
    BOOL         _isPushNotification;
}

@property (nonatomic, retain) Reachability *reachDetector;
@property BOOL         isHaveNetwork;


+ (CDNetworkStatus *)shareInstance;
- (BOOL)haveNetWork;

@end
