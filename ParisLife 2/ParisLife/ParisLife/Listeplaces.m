//
//  Listeplaces.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 4/7/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "Listeplaces.h"
#import "AFNetworking.h"
#import "Place.h"
#import "BFPaperTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "Guidedetail.h"
@interface Listeplaces ()

@end

@implementation Listeplaces

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myplacetab = [[NSMutableArray alloc] init];
    
    //NSLog(@"its cat %@",self.categorie);
    
    
    
    [self loadplaces];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) loadplaces{
    
    

    NSString *ch=@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=48.830931,2.364063&rankby=distance&types=";
    NSString *dataservices=[[ch stringByAppendingString:self.categorie] stringByAppendingString:@"&key=AIzaSyCFAS49gjZXdCIDKbCXu1VzTDk_CSTgE_4"];


    
      NSString *escapedPath = [dataservices stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager GET:escapedPath parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSDictionary *value = [responseObject objectForKey:@"results"];
        
        for (NSDictionary * dataDict in value) {
            
           // NSDictionary *value = [responseObject[@"results"] objectAtIndex:i];
            Place *myplace=[[Place alloc] init];
            myplace.name=[dataDict objectForKey:@"name"];
            myplace.rating=[dataDict objectForKey:@"rating"];
            myplace.type=[[dataDict objectForKey:@"types"] objectAtIndex:0];
            myplace.vicinity=[dataDict objectForKey:@"vicinity"];
            myplace.lat=[[[dataDict objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"];
              myplace.lon=[[[dataDict objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"];
            
            
            
            
            NSArray *data = [dataDict objectForKey:@"photos"];
            NSDictionary *dict = [data objectAtIndex:0];
            NSLog(@"ndict = %@", dict);
            NSString *name = [dict objectForKey:@"photo_reference"];
            //NSString *ch = [[[responseObject objectForKey:@"photos"] objectAtIndex:0] objectForKey:@"photo_reference"] ;

           
            
            
            
            myplace.imgref=name;
                              

            
            [self.myplacetab addObject:myplace];
            
            
        }	
        
        /*for (int i = 0; i < 20; i++)
        {

        
        NSDictionary *value = [responseObject[@"results"] objectAtIndex:i];
        // NSLog(@"value===: %@", [value objectForKey:@"nom"]);
        
        }*/
      
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mytableviewlist reloadData];
        });

        
       // NSLog(@"FROM ---> %lu ", (unsigned long)[self.myplacetab count]);

       
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.myplacetab count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
   
    
    
    
    BFPaperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placecell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BFPaperTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"placecell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.tapCircleDiameter = bfPaperTableViewCell_tapCircleDiameterSmall;
    cell.tapCircleColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    cell.backgroundFadeColor = [UIColor whiteColor];
    cell.letBackgroundLinger = NO;
    cell.tapDelay=0;
    //cell.textLabel.text = [self.myArray objectAtIndex:indexPath.row];
    
    Place *x = [[Place alloc]init];
    x = [self.myplacetab objectAtIndex:indexPath.row];
    
    
    UIImageView *myimage = (UIImageView *)[tableView viewWithTag:501];
    
    UILabel *lblTitle = (UILabel *)[tableView viewWithTag:500];
    lblTitle.text = x.name;
    
    if (x.imgref == nil)

    {
        
        myimage.image=[UIImage imageNamed:@"noimg"];

    }
    else {
    
    NSString *str = @"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=";
    
    
        NSString   *imgfinal = [str stringByAppendingString:x.imgref] ;
    
    NSString *imgfinal2= [imgfinal stringByAppendingString:@"&key=AIzaSyBF0ZDR7QPOhG0GD2vuQOdmt9akEk7lhMM"];
    
    
    [myimage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgfinal2]] placeholderImage:nil  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        myimage.image = image;
    }
                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                NSLog(@"Unable to retrieve image");
                            }];
    }
    
   UILabel *place=(UILabel*)[tableView viewWithTag:502];
    
    
    place.text=x.vicinity;
    
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




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    
        if([segue.identifier isEqualToString:@"detailguide"]){
            
            NSIndexPath *selectedIndexPath = [self.mytableviewlist indexPathForSelectedRow];
            
            Place *selectedevent=[self.myplacetab objectAtIndex:selectedIndexPath.row];
            
            Guidedetail *vc=[segue destinationViewController];
            
            vc.data=selectedevent;
            
        
        
        
    }
}


@end
