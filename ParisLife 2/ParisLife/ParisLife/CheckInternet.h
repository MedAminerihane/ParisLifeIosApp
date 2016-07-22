//
//  CheckInternet.h
//  German-Teacher
//
//  Created by marwa zribi on 26/02/2016.
//  Copyright © 2016 esprit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CheckInternet : NSObject
+ (BOOL) isInternetConnectionAvailable :(UIViewController *)controller;
@end
