//
//  FavorisController.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 5/8/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "FavorisController.h"
#import <Backendless.h>
#import "EventFavoris.h"
#import "AFNetworking.h"
#import "SWRevealViewController.h"
#import "BFPaperTableViewCell.h"
#import "Event.h"
#import <UIImageView+AFNetworking.h>

@interface FavorisController ()

@end

@implementation FavorisController

@synthesize favlist;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        
        revealViewController.rearViewRevealWidth = [UIScreen mainScreen].bounds.size.width-70;
        [self.myb setTarget: self.revealViewController];
        [self.myb setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }

    [self getlistfav];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getlistfav{
    @try {
        
        BackendlessUser *x=  backendless.userService.currentUser;
        
        BackendlessDataQuery *query = [BackendlessDataQuery query];
        query.whereClause = [NSString stringWithFormat:@"iduser = \'%@\'",[x getProperty:@"facebookId"] ];
        
        BackendlessCollection *pi = [backendless.persistenceService find:[EventFavoris class] dataQuery:query];
        
        
        NSArray *array= [pi getCurrentPage];
        
        //[Println printch:@"array count:" :[gifts getTotalObjects]];
        
        favlist=[NSMutableArray arrayWithArray:array];
    }
    
    @catch (Fault *fault) {
        NSLog(@"Server reported an error: %@", fault);
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [favlist count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BFPaperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellfav" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[BFPaperTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celldata"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.tapCircleDiameter = bfPaperTableViewCell_tapCircleDiameterSmall;
    cell.tapCircleColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    cell.backgroundFadeColor = [UIColor whiteColor];
    cell.letBackgroundLinger = NO;
    cell.tapDelay=0;
    //cell.textLabel.text = [self.myArray objectAtIndex:indexPath.row];
    
    Event *x = [[Event alloc]init];
    x = [self.favlist objectAtIndex:indexPath.row];
    
    //UIImageView *myImage = (UIImageView *)[tableView viewWithTag:103];
    //myImage.image = v.nom;
    
    NSLog(@"hhhh%@",x.nom);
    // NSLog(v.lon);
    //NSLog(@"value2222===: %@", v.nom);
    UIImageView *myimage = (UIImageView *)[tableView viewWithTag:501];
    
    UILabel *lblTitle = (UILabel *)[tableView viewWithTag:500];
    lblTitle.text = x.nom;
    NSRange myrange = {0, 4};
    NSString *str = @"http://filer.paris.fr/";
    
    if([[x.image substringWithRange:myrange] isEqual:@"http"]){
        str=x.image;
    }
    else{
        str = [str stringByAppendingString:x.image];
    }
    
    [myimage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]] placeholderImage:nil  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        myimage.image = image;
    }
                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                NSLog(@"Unable to retrieve image");
                            }];
    
    
    UILabel *place=(UILabel*)[tableView viewWithTag:502];
    
    UILabel *date=(UILabel*)[tableView viewWithTag:503];
    
    place.text=x.adresse;
    date.text=x.dateevent;
    
    return cell;
    // Configure the cell...
    
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
