//
//  ICNetworkStatus.m
//  IntelligentChild
//
//  Created by L on 14/11/3.
//  Copyright (c) 2014年 Fish. All rights reserved.
//

#import "CDNetworkStatus.h"
#import "AppMacro.h"


static CDNetworkStatus *_instance = nil;
@implementation CDNetworkStatus
@synthesize reachDetector = _reachDetector;
@synthesize isHaveNetwork = _isHaveNetwork;
#pragma mark - System methods
- (void)dealloc
{
    self.reachDetector = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        [self initCurrentNewwork];
    }
    
    return self;
}

#pragma mark - Custom methods
- (BOOL)haveNetWork
{
    [self currentInternetStatus];
    return self.isHaveNetwork;
}

+ (CDNetworkStatus*)shareInstance
{
    if (nil == _instance)
    {
        _instance = [[CDNetworkStatus alloc] init];
    }
    
    return _instance;
}

- (void)refrushCurrentNetworkStatus:(Reachability*)currentReach
{
    if ([currentReach isKindOfClass:[Reachability class]])
    {
        NetworkStatus netStatus = [currentReach currentReachabilityStatus];
        
        switch (netStatus)
        {
            case NotReachable:
            {
                self.isHaveNetwork = NO;
                DLog(@"WatchDog: no network......");
                if (!_isTellMe)
                {
                    _isTellMe = YES;
                    _isPushNotification = NO;
                    //                    [currentReach stopNotifier];
                }
            }
                break;
            case ReachableViaWiFi:
                self.isHaveNetwork = YES;
                DLog(@"WatchDog: the network is WiFi...");
                if (!_isPushNotification)
                {
                    _isPushNotification = YES;
                    _isTellMe = NO;
                }
                
                break;
            case ReachableViaWWAN:
                self.isHaveNetwork = YES;
                DLog(@"WatchDog: the network is 3G...");
                if (!_isPushNotification)
                {
                    _isPushNotification = YES;
                    _isTellMe = NO;
                }
                
                break;
            default:
                break;
        }
    }
}

- (void)currentInternetStatus
{
    [self refrushCurrentNetworkStatus:self.reachDetector];
}

- (void)rechabilityChanged:(NSNotification*)notification
{
    Reachability *currentReach = [notification object];
    [self refrushCurrentNetworkStatus:currentReach];
}

- (void)initCurrentNewwork
{
    self.reachDetector = [Reachability reachabilityForInternetConnection];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(rechabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self.reachDetector startNotifier];
    [self currentInternetStatus];
}


@end
