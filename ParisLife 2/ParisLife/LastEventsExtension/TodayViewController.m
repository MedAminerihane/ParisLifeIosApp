//
//  TodayViewController.m
//  LastEventsExtension
//
//  Created by Mohamed Amine Rihane on 5/12/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "EventWidget.h"




@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loaddataintab];
    
    
    
}
-(void)loaddataintab{
    NSUserDefaults *userdefault=[[NSUserDefaults alloc]initWithSuiteName:@"group.esprit.ParisForWin"];
    
    NSString *geteddata=[userdefault valueForKey:@"weathertoday"];
    //NSString *geteddata2=[userdefault valueForKey:@"weatheretat"];
    NSString *chi=@"La Temperature à Paris est ";
    self.values.text=[chi stringByAppendingString:geteddata];
        
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
