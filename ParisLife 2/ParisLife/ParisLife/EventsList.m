//
//  EventsList.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/18/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "EventsList.h"
#import "AFNetworking.h"
#import "SWRevealViewController.h"

#import "Event.h"

@interface EventsList ()

@end

@implementation EventsList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadevents];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        
        revealViewController.rearViewRevealWidth = [UIScreen mainScreen].bounds.size.width-70;
        [self.barbutton setTarget: self.revealViewController];
        [self.barbutton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void) loadevents{
    
    NSString *path = @"https://api.paris.fr/api/data/1.4/QueFaire/get_activities/?token=46f0825ba104099b7df908b9838bf946e19ceb6c0681ad6a05cfd1d8194a9ece&cid=4&tag=4&created=0&start=0&end=0&offset=1&limit=2";
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:escapedPath parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        //NSError *error;
        //NSDictionary *json = [NSJSONSerialization JS:responseObject options:kNilOptions error:&error];
        //NSMutableArray *fetchedArr = [json objectForKey:@"data"];
        //self.myarray=fetchedArr;
        
        for (int i = 0; i < 2; i++)
        {
             Event *ev = [[Event alloc]init];
        NSDictionary *value = [responseObject[@"data"] objectAtIndex:i];
        NSLog(@"value===: %@", [value objectForKey:@"nom"]);
            ev.nom=[value objectForKey:@"nom"];
            
            [self.myarray addObject:ev];
        }
        
        [self.tableView reloadData];
        //NSMutableArray *mt=[NSMutableArray alloc];
        //[mt addObject:value];
        
        // NSMutableArray *list=[[[NSMutableArray alloc] initWithObjects:responseObject, nil] valueForKey:@"data"];
        //self.myarray=[[[NSMutableArray alloc] initWithObjects:responseObject, nil]
                   //   valueForKey:@"data"];
        
       
      //  NSLog(@"format %@", list);
        
        /*for (int i = 0; i < 2; i++)
        {*/
            
        
       // Event *ev = [[Event alloc]init];
        
        
        
       // ev.nom=[NSString stringWithFormat:@"%@",[[[list objectAtIndex:0] objectAtIndex:1] objectForKey:@"nom"] ];
        
        //NSLog(@"event %@",ev.nom);
            
       /* *ev.lieu=[NSString stringWithFormat:@"%@",[[[list objectAtIndex:0] objectAtIndex:i] objectForKey:@"lieu"] ];
            
        ev.lat=[NSString stringWithFormat:@"%@",[[[list objectAtIndex:0] objectAtIndex:i] objectForKey:@"lat"] ];
            
            
        ev.lon=[NSString stringWithFormat:@"%@",[[[list objectAtIndex:0] objectAtIndex:i] objectForKey:@"lon"] ];
            
        ev.desc=[NSString stringWithFormat:@"%@",[[[list objectAtIndex:0] objectAtIndex:i] objectForKey:@"small_description"] ];
            
         */
            //[self.myarray addObject:ev];
            
        //}
        
        //[self.tableView reloadData];// reload table data
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {  
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"nnnnn%lu", (unsigned long)[self.myarray count]);

    return [self.myarray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventcell" forIndexPath:indexPath];
    
    //cell.textLabel.text = [self.myArray objectAtIndex:indexPath.row];
    
    
    Event *v = [self.myarray objectAtIndex:indexPath.row];
    
    //UIImageView *myImage = (UIImageView *)[tableView viewWithTag:103];
    //myImage.image = v.nom;
    
    //NSLog(v.nom);
   // NSLog(v.lon);
    NSLog(@"value2222===: %@", v.nom);
    
    UILabel *lblTitle = (UILabel *)[tableView viewWithTag:104];
    lblTitle.text = v.nom;
    
   // UILabel *lblBody = (UILabel *)[tableView viewWithTag:105];
    //lblBody.text = v.lat;
    
    
    return cell;
}




@end
