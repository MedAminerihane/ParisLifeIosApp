//
//  CheckInternet.m
//  German-Teacher
//
//  Created by marwa zribi on 26/02/2016.
//  Copyright © 2016 esprit. All rights reserved.
//

#import "CheckInternet.h"
#import "Reachability.h"
#import "AlertManager.h"
@implementation CheckInternet



+ (BOOL) isInternetConnectionAvailable :(UIViewController *)controller
{
    Reachability *internet = [Reachability reachabilityWithHostName: @"www.google.com"];
    NetworkStatus netStatus = [internet currentReachabilityStatus];
    bool netConnection = false;
    switch (netStatus)
    {
        case NotReachable:
        {
            NSLog(@"NotReachable");
            netConnection = false;
            [AlertManager show_alert:@"Check internet" message:@"Please connection to the internet and try again" viewcontroller:controller];
            break;
        }
        case ReachableViaWWAN:
        {   NSLog(@"ReachableViaWWAN");
            netConnection = true;
            break;
        }
        case ReachableViaWiFi:
        {   NSLog(@"ReachableViaWiFi");
            netConnection = true;
            break;
        }
    }
    return netConnection;
}

@end
