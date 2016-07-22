//
//  AlertManager.h
//  GiftApp
//
//  Created by Firas on 07/04/16.
//  Copyright © 2016 Firas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertManager : NSObject
{
    
}
+(void)show_alert:(NSString *)title message:(NSString *)msg viewcontroller:(UIViewController *)controller;
@end
