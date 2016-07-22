//
//  menudrawerController.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/17/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menudrawerController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userimg;

@property (weak, nonatomic) IBOutlet UIImageView *bg;

- (IBAction)Signout:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *nameofuser;

@end
