//
//  eventsliste.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/20/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "Dataevents.h"

#import "AFNetworking.h"
#import "SWRevealViewController.h"
#import "BFPaperTableViewCell.h"
#import "Event.h"
#import <UIImageView+AFNetworking.h>
#import "Backendless.h"
#import "DetailEventView.h"
#import "NSString+HTML.h"

@interface Dataevents ()

@end

@implementation Dataevents

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.mytab = [[NSMutableArray alloc] init];
    
    
    
    
   [self loadevents];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        
        revealViewController.rearViewRevealWidth = [UIScreen mainScreen].bounds.size.width-70;
        [self.btnx setTarget: self.revealViewController];
        [self.btnx setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *)flattenHtml: (NSString *) html {
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString: html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString: @"<" intoString: NULL];
        // find end of tag
        [theScanner scanUpToString: @">" intoString: &text];
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat: @"%@>", text]
                                               withString: @" "];
    } // while //
    return html;
}


-(void) loadevents{
    
    NSString *path = @"https://api.paris.fr/api/data/1.4/QueFaire/get_activities/?token=46f0825ba104099b7df908b9838bf946e19ceb6c0681ad6a05cfd1d8194a9ece&cid=0&tag=0&created=0&start=0&end=0&offset=0&limit=20";
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager GET:escapedPath parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        //NSError *error;
        //NSDictionary *json = [NSJSONSerialization JS:responseObject options:kNilOptions error:&error];
        //NSMutableArray *fetchedArr = [json objectForKey:@"data"];
        //self.myarray=fetchedArr;
        
        
        @try {
                for (int i = 0; i < 20; i++)
        {
            Event *ev = [[Event alloc]init];
            NSDictionary *value = [responseObject[@"data"] objectAtIndex:i];
            
            NSString *nome=[[[value objectForKey:@"nom"] stringByConvertingHTMLToPlainText] stringByDecodingHTMLEntities];
            
            ev.nom=[self flattenHtml:nome];
           // NSLog(@"value===: %@", [value objectForKey:@"nom"]);
            
           NSString *addr=[[[value objectForKey:@"adresse"] stringByConvertingHTMLToPlainText] stringByDecodingHTMLEntities];
            ev.adresse=[self flattenHtml:addr];
            NSString *descc=[[[value objectForKey:@"description"] stringByConvertingHTMLToPlainText] stringByDecodingHTMLEntities];
            ev.desc=[self flattenHtml:descc];
           
            ev.idEvent=[value objectForKey:@"idactivites"];
            
           ev.image=[[[value objectForKey:@"files"]objectAtIndex:0]objectForKey:@"file"];
            NSString *lieux=[[[value objectForKey:@"lieu"] stringByConvertingHTMLToPlainText] stringByDecodingHTMLEntities];
            
            ev.lieu=[self flattenHtml:lieux];
            
            ev.lat=[value objectForKey:@"lat"];
            
            ev.lon=[value objectForKey:@"lon"];
            //ev.accees=[value objectForKey:@"accessType"];

            
            if([[value objectForKey:@"occurrences"] count]==0){
              //ev.dateevent=nil;
            }
            else{
                NSDateFormatter *labelFormatter = [[NSDateFormatter alloc] init];
                [labelFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDateFormatter *labelFormatter2 = [[NSDateFormatter alloc] init];
                [labelFormatter2 setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];

                [labelFormatter setDateStyle:NSDateFormatterMediumStyle];
                [labelFormatter setTimeStyle:NSDateFormatterNoStyle];
                NSString *ch=[[[value objectForKey:@"occurrences"]objectAtIndex:0]objectForKey:@"jour"];
                NSDate *ch2=[labelFormatter2 dateFromString:ch];
           // ev.dateevent=[[[value objectForKey:@"occurrences"]objectAtIndex:0]objectForKey:@"jour"];
                
                ev.dateevent=[labelFormatter stringFromDate:ch2];
            
            }
            ev.categorie=[[[value objectForKey:@"rubriques"]objectAtIndex:0]objectForKey:@"rubrique"];
            
            ev.accees=@"Free";

            if([value objectForKey:@"accessType"]!=[NSNull null]){
                //ev.dateevent=nil;
                

                ev.accees=[value objectForKey:@"accessType"];

            }
                           // ev.accees=[value objectForKey:@"accessType"];
            
            //ev.accees=[value objectForKey:@"accessType"];
            //NSLog(@"valuetest===: %@", ev.desc);
            [self.mytab addObject:ev];
            
        }
        }
        @catch (NSException *exception) {
            
            UIAlertController * alert2=   [UIAlertController
                                           alertControllerWithTitle:@"Info"
                                           message:@"Impossible de trouver les données relative aux événements Verifier votre connexion"
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
        @finally {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mytable reloadData];
                if([self.mytab count]<= 0){
                    UIAlertController * alert2=   [UIAlertController
                                                   alertControllerWithTitle:@"Info"
                                                   message:@"Impossible de trouver les données relative aux événements Verifier votre connexion"
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
                
                
            });        }

        
       
        NSLog(@"valuetaab: %lu",(unsigned long)[self.mytab count] );
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        UIAlertController * alert2=   [UIAlertController
                                       alertControllerWithTitle:@"Info"
                                       message:@"Impossible de trouver les données relative aux événements Verifier votre connexion"
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
        NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@" its my test %@",ErrorResponse);
        NSLog(@"Error: %@", error);
    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"heeey %lu",(unsigned long)self.mytab.count);
    return [self.mytab count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%lu",(unsigned long)[self.mytab count]);
    
    
   //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celldata" forIndexPath:indexPath];
    
    BFPaperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celldata" forIndexPath:indexPath];
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
    x = [self.mytab objectAtIndex:indexPath.row];
    
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
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"detailevent"]){
        
        NSIndexPath *selectedIndexPath = [self.mytable indexPathForSelectedRow];

        Event *selectedevent=[self.mytab objectAtIndex:selectedIndexPath.row];
        
        DetailEventView *vc=[segue destinationViewController];
        
        vc.v=selectedevent;
        
        
        
    }
    
    
}





@end
