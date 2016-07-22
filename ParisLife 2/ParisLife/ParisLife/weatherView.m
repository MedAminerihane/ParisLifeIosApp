//
//  weatherView.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 3/16/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "weatherView.h"
#import "Weather.h"
#import "SWRevealViewController.h"

@interface weatherView ()

@end

@implementation weatherView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        
        revealViewController.rearViewRevealWidth = [UIScreen mainScreen].bounds.size.width-70;
        [self.btnbaritem setTarget: self.revealViewController];
        [self.btnbaritem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }

    self.tabweekweather = [[NSMutableArray alloc] init];

    [self loadnews2];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadweather:(TBXMLElement *)element{
    TBXMLElement *item = [TBXML childElementNamed:@"time" parentElement:element];
    do{
        
        TBXMLElement *symbol = [TBXML childElementNamed:@"symbol" parentElement:item];
        
        
        
        TBXMLElement *temp = [TBXML childElementNamed:@"temperature" parentElement:item];
        
        
        Weather *w=[[Weather alloc]init];
        
      
        
       w.day=[TBXML valueOfAttributeNamed:@"day" forElement:item];
        w.temperature=[TBXML valueOfAttributeNamed:@"day" forElement:temp];
        w.symbol=[TBXML valueOfAttributeNamed:@"name" forElement:symbol];
    
        
        [self.tabweekweather addObject:w];
        
    }
    while ((item=item->nextSibling));
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
    Weather *today=[self.tabweekweather objectAtIndex:0];
     
        NSString *str=[NSString stringWithFormat:@"%@",today.temperature];
        NSArray *arr=[str componentsSeparatedByString:@"."];
        NSInteger tempInt=[[arr firstObject] intValue];
        NSString *rssiString = [NSString stringWithFormat:@"%d", tempInt];

        
        self.todaydegree.text=[NSString stringWithFormat:rssiString];
        
        NSUserDefaults *userdefault=[[NSUserDefaults alloc]initWithSuiteName:@"group.esprit.ParisForWin"];
        
        NSString *myd=[NSString stringWithFormat:rssiString];
        [userdefault setObject:myd forKey:@"weathertoday"];
        [userdefault setObject:today.symbol forKey:@"weatheretat"];

        [userdefault synchronize];
        
     if([today.symbol isEqual:@"clear sky"]){
     
     
     self.bigimageweather.image=[UIImage imageNamed:@"iconsunny"];
     
     }
     else if([today.symbol isEqual:@"light rain"]){
     
     
     self.bigimageweather.image=[UIImage imageNamed:@"iconrainy"];
     
     }
     else{
     
     
     self.bigimageweather.image=[UIImage imageNamed:@"iconcloudy"];
     
     }
        
        for (int x=1; x<7; x++) {
            Weather *others=[self.tabweekweather objectAtIndex:x];
            NSDateFormatter *dateStringParser = [[NSDateFormatter alloc] init];
            [dateStringParser setDateFormat:@"yyyy-MM-dd"];
            
            NSDate *date = [dateStringParser dateFromString:others.day];
            
            NSDateFormatter *labelFormatter = [[NSDateFormatter alloc] init];
            [labelFormatter setDateFormat:@"EE"];
            
            
            NSString *str=[NSString stringWithFormat:@"%@",others.temperature];
            NSArray *arr=[str componentsSeparatedByString:@"."];
            NSInteger tempInt=[[arr firstObject] intValue];
            NSString *rssiString = [NSString stringWithFormat:@"%d", tempInt];
            rssiString=[rssiString stringByAppendingString:@"°"];
            
            

            switch (x) {
                case 1:
                    
                    self.day1degree.text=[NSString stringWithFormat:rssiString];
                    self.day1name.text=[labelFormatter stringFromDate:date];
                    if([others.symbol isEqual:@"clear sky"]){
                        
                        
                        self.day1img.image=[UIImage imageNamed:@"sunnydays"];
                        
                    }
                    else if([others.symbol isEqual:@"light rain"]){
                        
                        
                        self.day1img.image=[UIImage imageNamed:@"rainydays"];
                        
                    }
                    else{
                        
                        
                        self.day1img.image=[UIImage imageNamed:@"cloudydays"];
                        
                    }

                    break;
                case 2:
                    self.day2degree.text=[NSString stringWithFormat:rssiString];
                    self.day2name.text=[labelFormatter stringFromDate:date];
                    if([others.symbol isEqual:@"clear sky"]){
                        
                        
                        self.day2img.image=[UIImage imageNamed:@"sunnydays"];
                        
                    }
                    else if([others.symbol isEqual:@"light rain"]){
                        
                        
                        self.day2img.image=[UIImage imageNamed:@"rainydays"];
                        
                    }
                    else{
                        
                        
                        self.day2img.image=[UIImage imageNamed:@"cloudydays"];
                        
                    }

                    break;
                case 3:
                    self.day3degree.text=[NSString stringWithFormat:rssiString] ;
                    self.day3name.text=[labelFormatter stringFromDate:date];;
                    if([others.symbol isEqual:@"clear sky"]){
                        
                        
                        self.day1img.image=[UIImage imageNamed:@"sunnydays"];
                        
                    }
                    else if([others.symbol isEqual:@"light rain"]){
                        
                        
                        self.day3img.image=[UIImage imageNamed:@"rainydays"];
                        
                    }
                    else{
                        
                        
                        self.day3img.image=[UIImage imageNamed:@"cloudydays"];
                        
                    }

                    break;
                case 4:
                    self.day4degree.text=[NSString stringWithFormat:rssiString];
                    
                    self.day4name.text=[labelFormatter stringFromDate:date];
                    if([others.symbol isEqual:@"clear sky"]){
                        
                        
                        self.day4img.image=[UIImage imageNamed:@"sunnydays"];
                        
                    }
                    else if([others.symbol isEqual:@"light rain"]){
                        
                        
                        self.day4img.image=[UIImage imageNamed:@"rainydays"];
                        
                    }
                    else{
                        
                        
                        self.day4img.image=[UIImage imageNamed:@"cloudydays"];
                        
                    }

                    break;
                case 5:
                    self.day5degree.text=[NSString stringWithFormat:rssiString];
                    
                    self.day5name.text=[labelFormatter stringFromDate:date];
                    if([others.symbol isEqual:@"clear sky"]){
                        
                        
                        self.day5img.image=[UIImage imageNamed:@"sunnydays"];
                        
                    }
                    else if([others.symbol isEqual:@"light rain"]){
                        
                        
                        self.day5img.image=[UIImage imageNamed:@"rainydays"];
                        
                    }
                    else{
                        
                        
                        self.day5img.image=[UIImage imageNamed:@"cloudydays"];
                        
                    }

                    break;
                case 6:
                    self.day6degree.text=[NSString stringWithFormat:rssiString];
                    
                    self.day6name.text=[labelFormatter stringFromDate:date];
                    if([others.symbol isEqual:@"clear sky"]){
                        
                        
                        self.day6img.image=[UIImage imageNamed:@"sunnydays"];
                        
                    }
                    else if([others.symbol isEqual:@"light rain"]){
                        
                        
                        self.day6img.image=[UIImage imageNamed:@"rainydays"];
                        
                    }
                    else{
                        
                        
                        self.day6img.image=[UIImage imageNamed:@"cloudydays"];
                        
                    }

                    break;
                    }

        
        }
        
    });
    /*NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSDate *datex = [dateFormatter dateFromString:today.day];
     
     NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init] ;
     [dateFormatter2 setDateFormat:@"EEEE"];
     // NSLog(@"%@", [dateFormatter dateFromString:today.day]);
     */

    
    
}

-(void)loadnews2{
    
    // Create a success block to be called when the async request completes
    TBXMLSuccessBlock successBlock = ^(TBXML *tbxmlDocument) {
        // If TBXML found a root node, process element and iterate all children
        
        if (tbxmlDocument.rootXMLElement){
            @try {
                TBXMLElement *myel=[TBXML childElementNamed:@"forecast" parentElement:tbxmlDocument.rootXMLElement];
                [self loadweather:myel];
            }
            @catch (NSException *exception) {
                UIAlertController * alert2=   [UIAlertController
                                               alertControllerWithTitle:@"Alert"
                                               message:@"Problem de chargement de données"
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
                                       alertControllerWithTitle:@"Alert"
                                       message:@"Problem de chargement des données"
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
    TBXML *tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=Paris&mode=xml&units=metric&cnt=7&appid=011b52a4a37ac789f9e6381ed401abb3"]
                                      success:successBlock
                                      failure:failureBlock];
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
