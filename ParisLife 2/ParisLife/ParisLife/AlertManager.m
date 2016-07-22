//
//  AlertManager.m
//  GiftApp
//
//  Created by Firas on 07/04/16.
//  Copyright © 2016 Firas. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(void)show_alert:(NSString *)title :(NSString *)msg :(UIViewController *)controller
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:msg
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    /*
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
     */
    
    [alert addAction:ok];
    //[alert addAction:cancel];
    [controller presentViewController:alert animated:YES completion:nil];
}

@end
