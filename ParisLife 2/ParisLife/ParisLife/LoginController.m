//
//  LoginController.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/24/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginController.h"
#import "Acceuil.h"
#import "Backendless.h"
#import "CheckInternet.h"
@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @try {
        
        [backendless initAppFault];
        
#if _STAY_LOGGED_IN
        [self stayLoggedIn];
        
        id user = backendless.userService.currentUser;
        NSLog(@"viewDidLoad -> currentUser: %@", user);
        if(user == nil)
        {
            //_Login.hidden=NO;
        }
#endif
    }
    @catch (Fault *fault) {
        [self showAlert:fault.message];
    }
    
    
    
    [self.loginbtn addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginbtn];
    
    
    //_Login.hidden=true;
   /* if ([FBSDKAccessToken currentAccessToken]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        UIViewController *controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier: @"SWRevealViewController"];
        [self presentViewController:controller animated:YES completion:nil];
        
    }*/
    
    

    
   
   

   /* [loginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];*/

}

-(void)showAlert:(NSString *)message {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error:" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
}

- (UIStoryboard *)grabStoryboard {
    // determine screen size
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIStoryboard *storyboard;
    
    switch (screenHeight) {
            // iPhone 4s
        case 480:
            storyboard = [UIStoryboard storyboardWithName:@"Main-4s" bundle:nil];
            break;
            
            // iPhone 5s
        case 568:
            storyboard = [UIStoryboard storyboardWithName:@"Main-5s" bundle:nil];
            break;
            
            // iPhone 6
        case 667:
            storyboard = [UIStoryboard storyboardWithName:@"Main-6s" bundle:nil];
            break;
            
            // iPhone 6 Plus
        default:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            
    }
    return storyboard;
}



-(void)stayLoggedIn {
    
    if (backendless.userService.isStayLoggedIn)
    {
#if 1
        [self checkValidUserToken];
#else
        NSNumber *result = [backendless.userService isValidUserToken];
        NSLog(@"viewDidLoad -> isValidUserToken: %@", [result boolValue]?@"YES":@"NO");
        [result boolValue] ? [self switchToLogout] : [backendless.userService setStayLoggedIn:NO];
        //_Login.hidden=NO;
        
#endif
    }
    else
    {
        [backendless.userService setStayLoggedIn:YES];
    }
}


-(void)checkValidUserToken {
    
#if 1
    [backendless.userService
     isValidUserToken: ^(NSNumber *result) {
         NSLog(@"%@: Is UserToken Valid? %@", [NSDate date], result.boolValue?@"YES":@"NO");
         if(result.boolValue)
         {
             //[Println printbool:@"Is UserToken valid " :result.boolValue];
             //_Login.hidden=YES;
            // [self redirect_to_menu];
             UIStoryboard *storyboard = [self grabStoryboard];
             
             UIViewController *controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier: @"SWRevealViewController"];
             [self presentViewController:controller animated:YES completion:nil];
         }
     }
     error:^(Fault *fault) {
         NSLog(@"%@", fault);
         [backendless.userService setStayLoggedIn:NO];
         return;
     }];
#else
    NSNumber *result = [backendless.userService isValidUserToken];
    NSLog(@"viewDidLoad -> isValidUserToken: %@", [result boolValue]?@"YES":@"NO");
    [result boolValue] ? [self switchToLogout] : [backendless.userService setStayLoggedIn:NO];
    //_Login.hidden=NO;
    
#endif
    
    /*
     dispatch_time_t interval = dispatch_time(DISPATCH_TIME_NOW, 1ull*NSEC_PER_SEC*60);
     dispatch_after(interval, dispatch_get_main_queue(), ^{
     [self checkValidUserToken];
     });
     */
}


- (void)loginButtonClicked {
    
    if ([CheckInternet isInternetConnectionAvailable:self])
    {
        
        
        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
        NSArray *permissionsArray = @[@"public_profile", @"user_friends"];
        [login logInWithReadPermissions:permissionsArray handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                // Process error
                NSLog(@"error %@", error);
            } else if (result.isCancelled) {
                // Handle cancellations
                NSLog(@"Cancelled");
            } else {
                if ([result.grantedPermissions containsObject:@"email"]) {
                    
                    UIStoryboard *storyboard = [self grabStoryboard];
                    
                    UIViewController *controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier: @"SWRevealViewController"];
                    [self presentViewController:controller animated:YES completion:nil];
                    

                    
                   // [self fetchUserInfo];
                    //call friend_list
                    //[FacebookUser get_facebook_friend_list];
                    //_Login.hidden=YES;
                    //end call friend list
                    
                    // Do work
                    //[self performSegueWithIdentifier:@"logins" sender:nil];
                    
                }
            }
        }];
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(void)loginButtonClicked
{
        
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
     
             
             
             
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSString *nameOfLoginUser = [result valueForKey:@"name"];
                         NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                         NSURL *url = [[NSURL alloc] initWithString: imageStringOfLoginUser];
                         //[self.imageView setImageWithURL:url placeholderImage: nil];
                         NSLog(@"Logged in %@",imageStringOfLoginUser);
                         
                     }
                 }];
             }
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];

             UIViewController *controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier: @"SWRevealViewController"];
             [self presentViewController:controller animated:YES completion:nil];
             
             
         }
     }];
     
     }
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
