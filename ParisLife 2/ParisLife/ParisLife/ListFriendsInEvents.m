//
//  ListFriendsInEvents.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 5/6/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "ListFriendsInEvents.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <UIImageView+AFNetworking.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FBUser.h"

@interface ListFriendsInEvents ()

@end

@implementation ListFriendsInEvents
@synthesize friendsinf;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"image %lu",(unsigned long)[self.friendsinf count]);
    if([self.friendsinf count]==0){
        UIAlertController * alert2=   [UIAlertController
                                       alertControllerWithTitle:@"Alerte"
                                       message:@"aucun ami(e)s participées"
                                       preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //Handel your yes please button action here
                                        
                                        
                                    }];
        
        [alert2 addAction:yesButton];
        
        [self presentViewController:alert2 animated:YES completion:nil];
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendsinf count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellfriends" forIndexPath:indexPath];
    
    
            FBUser *fbuser = [FBUser new];
    fbuser=[self.friendsinf objectAtIndex:indexPath.row];
            UIImageView *myimage = (UIImageView *)[tableView viewWithTag:2];
            
            UILabel *nom=(UILabel*)[tableView viewWithTag:1];
    nom.text=fbuser.name;
NSString *ch=@"http://graph.facebook.com/";
    ch=[ch stringByAppendingString:fbuser.idd];
    ch=[ch stringByAppendingString:@"/picture?type=square"];

    
            //[self.imageView setImageWithURL:url placeholderImage: nil];
           // NSLog(@"Logged in %@",imageStringOfLoginUser);
            [myimage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ch]] placeholderImage:nil  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                myimage.image = image;
            }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                        NSLog(@"Unable to retrieve image");
                                    }];
            
            
    
    
    
    

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
