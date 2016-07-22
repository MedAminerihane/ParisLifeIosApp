//
//  ViewController.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/15/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "Acceuil.h"

#import "SWRevealViewController.h"
#import "TBXML+HTTP.h"
#import "TBXML.h"
#import "news.h"
#import <UIImageView+AFNetworking.h>

@interface Acceuil ()

@end

@implementation Acceuil

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mytabnews = [[NSMutableArray alloc] init];
    
    
    
    
    [self loadnews2];
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        
        revealViewController.rearViewRevealWidth = [UIScreen mainScreen].bounds.size.width-70;
        [self.myb setTarget: self.revealViewController];
        [self.myb setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)loadnews:(TBXMLElement *)element{
    
    TBXMLElement *item = [TBXML childElementNamed:@"item" parentElement:element];
    
    do {
        TBXMLElement *titre = [TBXML childElementNamed:@"title" parentElement:item];
        TBXMLElement *desc = [TBXML childElementNamed:@"description" parentElement:item];
        
        
        
        
        
        TBXMLElement *imgitem = [TBXML childElementNamed:@"enclosure" parentElement:item];
        
        
        News *myitem=[[News alloc] init];
        myitem.titre=[TBXML textForElement:titre];
        myitem.desc=[TBXML textForElement:desc];
        
        
        if(imgitem){
            myitem.img=[TBXML valueOfAttributeNamed:@"url" forElement:imgitem];
            
        }
        else {
            myitem.img=@"noimg";
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        [self.mytabnews addObject:myitem];
        
        
        
    } while ((item = item->nextSibling));
    
    //[self.tablenews performSelectorOnMainThread:@selector(reloadData)
    //      withObject:nil
    //  waitUntilDone:NO];}
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tablenews reloadData];
    });
}

-(void)loadnews2{
    
    // Create a success block to be called when the async request completes
    TBXMLSuccessBlock successBlock = ^(TBXML *tbxmlDocument) {
        // If TBXML found a root node, process element and iterate all children
        
        if (tbxmlDocument.rootXMLElement){
            
            @try {
                TBXMLElement *myel=[TBXML childElementNamed:@"channel" parentElement:tbxmlDocument.rootXMLElement];
                [self loadnews:myel];
            }
            @catch (NSException *exception) {
                UIAlertController * alert2=   [UIAlertController
                                               alertControllerWithTitle:@"Info"
                                               message:@"Problem de chargemnt de données verifier votre connexion"
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
            
            
            
            
        }
        
    };
    
    // Create a failure block that gets called if something goes wrong
    TBXMLFailureBlock failureBlock = ^(TBXML *tbxmlDocument, NSError * error) {
        NSLog(@"Error! %@ %@", [error localizedDescription], [error userInfo]);
        
        UIAlertController * alert2=   [UIAlertController
                                       alertControllerWithTitle:@"Info"
                                       message:@"Problem de chargemnt de données verifier votre connexion"
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
        
        
    };
    
    // Initialize TBXML with the URL of an XML doc. TBXML asynchronously loads and parses the file.
    TBXML *tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:@"http://www.francetvinfo.fr/france.rss"]
                                      success:successBlock
                                      failure:failureBlock];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mytabnews count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycellnews" forIndexPath:indexPath];
    
    
    UILabel *lblTitle = (UILabel *)[tableView viewWithTag:1];
    UIImageView *myimage = (UIImageView *)[tableView viewWithTag:2];
    UILabel *lbldesc = (UILabel *)[tableView viewWithTag:3];
    
    News *datanews=[[News alloc]init];
    datanews=[self.mytabnews objectAtIndex:indexPath.row];
    
    if([datanews.img isEqualToString:@"noimg"]){
        myimage.image=[UIImage imageNamed:@"noimg"];
    }
    else{
        [myimage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:datanews.img]] placeholderImage:nil  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
            myimage.image = image;
        }
                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                    NSLog(@"Unable to retrieve image");
                                }];
        
        
    }
    lblTitle.text=datanews.titre;
    lbldesc.text=datanews.desc;
    
    return cell;
    
}

@end
