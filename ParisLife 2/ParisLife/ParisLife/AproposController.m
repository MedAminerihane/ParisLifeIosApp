//
//  AproposController.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 5/8/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "AproposController.h"
#import "SWRevealViewController.h"
@interface AproposController ()

@end

@implementation AproposController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        
        revealViewController.rearViewRevealWidth = 350;
        [self.myb setTarget: self.revealViewController];
        [self.myb setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    
    self.imgrihane.layer.cornerRadius=self.imgrihane.frame.size.width/2;
    self.imgrihane.layer.borderWidth=5;
    self.imgrihane.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    self.imgrihane.clipsToBounds=YES;
    
    self.imgseif.layer.cornerRadius=self.imgseif.frame.size.width/2;
    self.imgseif.layer.borderWidth=5;
    self.imgseif.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    self.imgseif.clipsToBounds=YES;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
