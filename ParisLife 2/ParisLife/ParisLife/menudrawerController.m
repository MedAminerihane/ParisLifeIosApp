//
//  menudrawerController.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/17/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "menudrawerController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Backendless.h"
#import "AlertManager.h"
#import <UIImageView+AFNetworking.h>



@interface menudrawerController ()


@end


@implementation menudrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getdatauserconnected];
   
    self.userimg.layer.cornerRadius=self.userimg.frame.size.width/2;
    self.userimg.layer.borderWidth=5;
    self.userimg.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    self.userimg.clipsToBounds=YES;
    
    /*UIBlurEffect *effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.alpha=0.7;
    effectView.frame = self.view.frame;
    [self.bg addSubview:effectView];
    
    */
    
}

-(void)getdatauserconnected{
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(600).height(600)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSString *iduser = [result valueForKey:@"id"];
                NSString *nameuser = [result valueForKey:@"name"];
                
                self.nameofuser.text=nameuser;
                
                NSString *ch=@"http://graph.facebook.com/";
                ch=[ch stringByAppendingString:iduser];
                ch=[ch stringByAppendingString:@"/picture?type=large"];
                
                
                [self.userimg setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ch]] placeholderImage:nil  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                    self.userimg.image = image;
                }
                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                            NSLog(@"Unable to retrieve image");
                                        }];
                
                Responder *responder = [Responder responder:self
                                         selResponseHandler:@selector(responseHandler:)
                                            selErrorHandler:@selector(errorHandler:)];
                
                
                
            
            }
        }];
    }
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


- (UIStoryboard *)grabStoryboard {
    
    
    // determine screen size
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIStoryboard *storyboard;
    
    NSLog(@"screenHeight:-%d",screenHeight);
    
    
    switch (screenHeight) {
            // iPhone 4s
        case 480:
            storyboard = [UIStoryboard storyboardWithName:@"Main-4s" bundle:nil];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            // iPhone 5s
        case 568:
            storyboard = [UIStoryboard storyboardWithName:@"Main-5s" bundle:nil];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            // iPhone 6
        case 667:
            storyboard = [UIStoryboard storyboardWithName:@"Main-6s" bundle:nil];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            // iPhone 6 Plus
        default:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            
    }
    
    
    
    return storyboard;
}


- (IBAction)Signout:(id)sender {
    
    @try {
        id result = [backendless.userService logout];
        NSLog(@"Logout : %p",result);
        //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
        //return result;
        UIStoryboard *storyboard = [self grabStoryboard];
        
        UIViewController *controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier: @"555"];
        [self presentViewController:controller animated:YES completion:nil];

    }
    @catch (Fault *fault) {
        NSLog(@"FAULT = %@ <%@>", fault.message, fault.detail);
        [AlertManager show_alert:@"Error" message:fault.detail viewcontroller:self];
        //return nil;
    }
    
   
    
}
@end
