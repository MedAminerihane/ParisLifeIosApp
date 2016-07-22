//
//  DetailEventView.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 3/17/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "DetailEventView.h"
#import <UIImageView+AFNetworking.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "NSString+HTML.h"
#import "Participants.h"
#import "ListFriendsInEvents.h"
#import <Backendless.h>
#import "FBUser.h"
#import "EventFavoris.h"
@interface DetailEventView ()

@end

@implementation DetailEventView

@synthesize mymapview;


-(void) getfriends{
  
        
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:@"/me/friends"
                                      parameters:nil
                                      HTTPMethod:@"GET"];
        
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            // Handle the result
            
            NSDictionary * friends = result;
            //Save that in NSUserDefaults to be retrieved in BaeTable and ShareTable
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:friends[@"data"] forKey:@"friends"];
            
            NSArray *data = [result objectForKey:@"data"];
            
            self.friendslist = [NSMutableArray array];
            for (int i = 0; i < data.count; i++){
                id object = [data objectAtIndex:i];
                
                FBUser *fbuser = [FBUser new];
                fbuser.idd = [object objectForKey:@"id"];
                fbuser.name = [object objectForKey:@"name"];
                fbuser.email = [object objectForKey:@"email"];
                
                NSLog(@"fbuser = %@", fbuser.name);
                /*
                 [backendless.persistenceService save:fbuser response:^(id response) {
                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                 NSLog(@"%@", [response valueForKey:@"objectId"]);
                 
                 } error:^(Fault *fault) {
                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                 NSLog(@"StartViewController -> removeObjectWithIndex: FAULT = %@ <%@>", fault.message, fault.detail);
                 [self showAlert:fault.message];
                 }];
                 */
                
                
                
                /*******get backendless account for friends ***********/
                /*
                 BackendlessDataQuery *query = [BackendlessDataQuery query];
                 
                 query.whereClause = [NSString stringWithFormat:@"facebookId = \'%@\'", fbuser.id];
                 [[backendless.persistenceService of:[Users class]] find:[BackendlessDataQuery query]
                 response:^(BackendlessCollection *gifts) {
                 UserArray =[gifts getCurrentPage];
                 }
                 error:^(Fault *fault) {
                 NSLog(@"Server reported an error: %@", fault);
                 }];
                 */
                
                
                [self.friendslist addObject:fbuser];
                
            }
            
        }];
    }




- (NSString *)decodeHTMLEntities:(NSString *)string {
    // Reserved Characters in HTML
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    // ISO 8859-1 Symbols
    string = [string stringByReplacingOccurrencesOfString:@"&iexcl;" withString:@"¡"];
    string = [string stringByReplacingOccurrencesOfString:@"&cent;" withString:@"¢"];
    string = [string stringByReplacingOccurrencesOfString:@"&pound;" withString:@"£"];
    string = [string stringByReplacingOccurrencesOfString:@"&curren;" withString:@"¤"];
    string = [string stringByReplacingOccurrencesOfString:@"&yen;" withString:@"¥"];
    string = [string stringByReplacingOccurrencesOfString:@"&brvbar;" withString:@"¦"];
    string = [string stringByReplacingOccurrencesOfString:@"&sect;" withString:@"§"];
    string = [string stringByReplacingOccurrencesOfString:@"&uml;" withString:@"¨"];
    string = [string stringByReplacingOccurrencesOfString:@"&copy;" withString:@"©"];
    string = [string stringByReplacingOccurrencesOfString:@"&ordf;" withString:@"ª"];
    string = [string stringByReplacingOccurrencesOfString:@"&laquo;" withString:@"«"];
    string = [string stringByReplacingOccurrencesOfString:@"&not;" withString:@"¬"];
    string = [string stringByReplacingOccurrencesOfString:@"&shy;" withString:@"    "];
    string = [string stringByReplacingOccurrencesOfString:@"&reg;" withString:@"®"];
    string = [string stringByReplacingOccurrencesOfString:@"&macr;" withString:@"¯"];
    string = [string stringByReplacingOccurrencesOfString:@"&deg;" withString:@"°"];
    string = [string stringByReplacingOccurrencesOfString:@"&plusmn;" withString:@"±       "];
    string = [string stringByReplacingOccurrencesOfString:@"&sup2;" withString:@"²"];
    string = [string stringByReplacingOccurrencesOfString:@"&sup3;" withString:@"³"];
    string = [string stringByReplacingOccurrencesOfString:@"&acute;" withString:@"´"];
    string = [string stringByReplacingOccurrencesOfString:@"&micro;" withString:@"µ"];
    string = [string stringByReplacingOccurrencesOfString:@"&para;" withString:@"¶"];
    string = [string stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    string = [string stringByReplacingOccurrencesOfString:@"&cedil;" withString:@"¸"];
    string = [string stringByReplacingOccurrencesOfString:@"&sup1;" withString:@"¹"];
    string = [string stringByReplacingOccurrencesOfString:@"&ordm;" withString:@"º"];
    string = [string stringByReplacingOccurrencesOfString:@"&raquo;" withString:@"»"];
    string = [string stringByReplacingOccurrencesOfString:@"&frac14;" withString:@"¼"];
    string = [string stringByReplacingOccurrencesOfString:@"&frac12;" withString:@"½"];
    string = [string stringByReplacingOccurrencesOfString:@"&frac34;" withString:@"¾"];
    string = [string stringByReplacingOccurrencesOfString:@"&iquest;" withString:@"¿"];
    string = [string stringByReplacingOccurrencesOfString:@"&times;" withString:@"×"];
    string = [string stringByReplacingOccurrencesOfString:@"&divide;" withString:@"÷"];
    
    // ISO 8859-1 Characters
    string = [string stringByReplacingOccurrencesOfString:@"&Agrave;" withString:@"À"];
    string = [string stringByReplacingOccurrencesOfString:@"&Aacute;" withString:@"Á"];
    string = [string stringByReplacingOccurrencesOfString:@"&Acirc;" withString:@"Â"];
    string = [string stringByReplacingOccurrencesOfString:@"&Atilde;" withString:@"Ã"];
    string = [string stringByReplacingOccurrencesOfString:@"&Auml;" withString:@"Ä"];
    string = [string stringByReplacingOccurrencesOfString:@"&Aring;" withString:@"Å"];
    string = [string stringByReplacingOccurrencesOfString:@"&AElig;" withString:@"Æ"];
    string = [string stringByReplacingOccurrencesOfString:@"&Ccedil;" withString:@"Ç"];
    string = [string stringByReplacingOccurrencesOfString:@"&Egrave;" withString:@"È"];
    string = [string stringByReplacingOccurrencesOfString:@"&Eacute;" withString:@"É"];
    string = [string stringByReplacingOccurrencesOfString:@"&Ecirc;" withString:@"Ê"];
    string = [string stringByReplacingOccurrencesOfString:@"&Euml;" withString:@"Ë"];
    string = [string stringByReplacingOccurrencesOfString:@"&Igrave;" withString:@"Ì"];
    string = [string stringByReplacingOccurrencesOfString:@"&Iacute;" withString:@"Í"];
    string = [string stringByReplacingOccurrencesOfString:@"&Icirc;" withString:@"Î"];
    string = [string stringByReplacingOccurrencesOfString:@"&Iuml;" withString:@"Ï"];
    string = [string stringByReplacingOccurrencesOfString:@"&ETH;" withString:@"Ð"];
    string = [string stringByReplacingOccurrencesOfString:@"&Ntilde;" withString:@"Ñ"];
    string = [string stringByReplacingOccurrencesOfString:@"&Ograve;" withString:@"Ò"];
    string = [string stringByReplacingOccurrencesOfString:@"&Oacute;" withString:@"Ó"];
    string = [string stringByReplacingOccurrencesOfString:@"&Ocirc;" withString:@"Ô"];
    string = [string stringByReplacingOccurrencesOfString:@"&Otilde;" withString:@"Õ"];
    string = [string stringByReplacingOccurrencesOfString:@"&Ouml;" withString:@"Ö"];
    string = [string stringByReplacingOccurrencesOfString:@"&Oslash;" withString:@"Ø"];
    string = [string stringByReplacingOccurrencesOfString:@"&Ugrave;" withString:@"Ù"];
    string = [string stringByReplacingOccurrencesOfString:@"&Uacute;" withString:@"Ú"];
    string = [string stringByReplacingOccurrencesOfString:@"&Ucirc;" withString:@"Û"];
    string = [string stringByReplacingOccurrencesOfString:@"&Uuml;" withString:@"Ü"];
    string = [string stringByReplacingOccurrencesOfString:@"&Yacute;" withString:@"Ý"];
    string = [string stringByReplacingOccurrencesOfString:@"&THORN;" withString:@"Þ"];
    string = [string stringByReplacingOccurrencesOfString:@"&szlig;" withString:@"ß"];
    string = [string stringByReplacingOccurrencesOfString:@"&agrave;" withString:@"à"];
    string = [string stringByReplacingOccurrencesOfString:@"&aacute;" withString:@"á"];
    string = [string stringByReplacingOccurrencesOfString:@"&acirc;" withString:@"â"];
    string = [string stringByReplacingOccurrencesOfString:@"&atilde;" withString:@"ã"];
    string = [string stringByReplacingOccurrencesOfString:@"&auml;" withString:@"ä"];
    string = [string stringByReplacingOccurrencesOfString:@"&aring;" withString:@"å"];
    string = [string stringByReplacingOccurrencesOfString:@"&aelig;" withString:@"æ"];
    string = [string stringByReplacingOccurrencesOfString:@"&ccedil;" withString:@"ç"];
    string = [string stringByReplacingOccurrencesOfString:@"&egrave;" withString:@"è"];
    string = [string stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"é"];
    string = [string stringByReplacingOccurrencesOfString:@"&ecirc;" withString:@"ê"];
    string = [string stringByReplacingOccurrencesOfString:@"&euml;" withString:@"ë"];
    string = [string stringByReplacingOccurrencesOfString:@"&igrave;" withString:@"ì"];
    string = [string stringByReplacingOccurrencesOfString:@"&iacute;" withString:@"í"];
    string = [string stringByReplacingOccurrencesOfString:@"&icirc;" withString:@"î"];
    string = [string stringByReplacingOccurrencesOfString:@"&iuml;" withString:@"ï"];
    string = [string stringByReplacingOccurrencesOfString:@"&eth;" withString:@"ð"];
    string = [string stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"ñ"];
    string = [string stringByReplacingOccurrencesOfString:@"&ograve;" withString:@"ò"];
    string = [string stringByReplacingOccurrencesOfString:@"&oacute;" withString:@"ó"];
    string = [string stringByReplacingOccurrencesOfString:@"&ocirc;" withString:@"ô"];
    string = [string stringByReplacingOccurrencesOfString:@"&otilde;" withString:@"õ"];
    string = [string stringByReplacingOccurrencesOfString:@"&ouml;" withString:@"ö"];
    string = [string stringByReplacingOccurrencesOfString:@"&oslash;" withString:@"ø"];
    string = [string stringByReplacingOccurrencesOfString:@"&ugrave;" withString:@"ù"];
    string = [string stringByReplacingOccurrencesOfString:@"&uacute;" withString:@"ú"];
    string = [string stringByReplacingOccurrencesOfString:@"&ucirc;" withString:@"û"];
    string = [string stringByReplacingOccurrencesOfString:@"&uuml;" withString:@"ü"];
    string = [string stringByReplacingOccurrencesOfString:@"&yacute;" withString:@"ý"];
    string = [string stringByReplacingOccurrencesOfString:@"&thorn;" withString:@"þ"];
    string = [string stringByReplacingOccurrencesOfString:@"&yuml;" withString:@"ÿ"];
    
    return string;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.scroller setScrollEnabled:YES];
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    switch (screenHeight) {
            // iPhone 4s
        case 480:
            [self.scroller setContentSize:CGSizeMake(300, 1250)];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            // iPhone 5s
        case 568:
            [self.scroller setContentSize:CGSizeMake(300, 1250)];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            // iPhone 6
        case 667:
            [self.scroller setContentSize:CGSizeMake(375, 1700)];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            // iPhone 6 Plus
        default:
            [self.scroller setContentSize:CGSizeMake(414, 1500)];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            
    }
    
    NSLog(@"%@",self.v.nom);
    
    double lat = [self.v.lat doubleValue];
    double lon = [self.v.lon doubleValue];

    
    // Create a coordinate structure for the location.
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(lat, lon);
    
    // Create a coordinate structure for the point on the ground from which to view the location.
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(lat, lon);
    
    // Ask Map Kit for a camera that looks at the location from an altitude of 100 meters above the eye coordinates.
    MKMapCamera *myCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground fromEyeCoordinate:eye eyeAltitude:100];
    
    
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lon);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = {coord, span};
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coord];
    
    [self.mymapview setRegion:region];
    [self.mymapview addAnnotation:annotation];
    // Assign the camera to your map view.
    mymapview.camera = myCamera;
    
    NSRange myrange={0,4};
   
    NSString *str = @"http://filer.paris.fr/";
    
    if([[self.v.image substringWithRange:myrange] isEqual:@"http"]){
        str=self.v.image;
    }
    else{
        str = [str stringByAppendingString:self.v.image];
    }
    
    [self.imageevent setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]] placeholderImage:nil  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
       self.imageevent.image = image;
    }
                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                NSLog(@"Unable to retrieve image");
                            }];
    
    
    //self.imageevent=self.v.image;
    
    self.eventname.text=self.v.nom;
    self.eventadresse.text=self.v.adresse;
    self.eventdate.text=self.v.dateevent;
    //self.eventdate.text=self.v.dateevent;
    self.eventcategorie.text=self.v.categorie;
    self.eventtypaeaccess.text=self.v.accees;
    //NSLog(@"text true 1 %@",[self decodeHTMLEntities:self.v.desc]);
    //self.eventdescription.text=[self decodeHTMLEntities:self.v.desc];
   // NSLog(@"text true 4 %@",[self.v.desc stringByDecodingHTMLEntities]);

    NSString *string1 =[[self.v.desc stringByConvertingHTMLToPlainText] stringByDecodingHTMLEntities];
    //NSString *stringDate = [string1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.eventdescription.text=[self flattenHtml:string1];
    self.friendslist = [[NSMutableArray alloc] init];
    self.friendslistparticiper = [[NSMutableArray alloc] init];

    [self getfriends];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*)fetchingparticipants :(NSString*)fbid{
    
    @try {
        
        BackendlessDataQuery *query = [BackendlessDataQuery query];
        query.whereClause = [NSString stringWithFormat:@"fbid = \'%@\'", fbid];
        BackendlessCollection *data = [backendless.persistenceService find:[Participants class] dataQuery:query];
        return [data getCurrentPage];
        NSLog(@"Total participnts in the Backendless storage - %@", [data getTotalObjects]);
    }
    @catch (Fault *fault) {
        NSLog(@"Server reported an error: %@", fault);
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [self.friendslistparticiper removeAllObjects];
    
    if([segue.identifier isEqualToString:@"seefr"]){
        
        

    for (int i = 0; i < [self.friendslist count]; i++)
    {
        FBUser *fbuser = [[FBUser alloc] init];
        fbuser =[self.friendslist objectAtIndex:i];
        NSArray *array=[self fetchingparticipants:fbuser.idd];
        
        
        if([array count]!=0){
            for(int j=0;j <[array count];j++ ){
                Participants *x=[[Participants alloc]init];
                x=[array objectAtIndex:j];
                
                if([x.eventid isEqual:self.v.idEvent]){
            [self.friendslistparticiper addObject:fbuser];
        
                }}
        }
    }
   
   
        ListFriendsInEvents *vc=[segue destinationViewController];
        vc.friendsinf=[[NSMutableArray alloc]init];
        
        vc.friendsinf=[NSMutableArray arrayWithArray:self.friendslistparticiper];

   }
}




#pragma mark - responder
-(id)responseHandler:(id)response
{
    NSLog(@"%@", response);
    return response;
}
-(id)errorHandler:(Fault *)fault
{
    NSLog(@"%@", fault.detail);
    return fault;
}

-(NSArray *)is_post_exist:(Participants*)p{
    
    @try {
        
        BackendlessDataQuery *query = [BackendlessDataQuery query];
        query.whereClause = [NSString stringWithFormat:@"fbid = \'%@\' AND eventid = \'%@\'", p.fbid,p.eventid];
        
        BackendlessCollection *pi = [backendless.persistenceService find:[Participants class] dataQuery:query];
        
        
        NSArray *array= [pi getCurrentPage];
        
        //[Println printch:@"array count:" :[gifts getTotalObjects]];
        
        return array;
    }
    
    @catch (Fault *fault) {
        NSLog(@"Server reported an error: %@", fault);
    }
    
}

- (IBAction)clickadd:(id)sender {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSString *iduser = [result valueForKey:@"id"];

                
                Responder *responder = [Responder responder:self
                                         selResponseHandler:@selector(responseHandler:)
                                            selErrorHandler:@selector(errorHandler:)];
                Participants *p = [Participants new];
                p.eventid = self.v.idEvent;
                p.fbid = iduser;
                
                NSArray *array= [self is_post_exist:p];
                
                if([array count]==0){
                id<IDataStore> dataStore = [backendless.persistenceService of:[p class]];
                [dataStore save:p responder:responder];
                
                }
               // NSLog(@"Logged in 222222 %@",iduser);
               // NSLog(@"Logged in 222222 %@",self.v.idEvent);

                
            }
        }];
        
        
        
        
        
    }


    

}
- (IBAction)Ajoutfavoris:(id)sender {
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSString *iduser = [result valueForKey:@"id"];
                EventFavoris *thisevent = [EventFavoris new];
                
                BackendlessDataQuery *query = [BackendlessDataQuery query];
                query.whereClause = [NSString stringWithFormat:@"idEvent = \'%@\' AND iduser = \'%@\'", self.v.idEvent,iduser];
                
                BackendlessCollection *pi = [backendless.persistenceService find:[EventFavoris class] dataQuery:query];
                
                
                NSArray *numrows= [pi getCurrentPage];

                
                if([numrows count] <= 0){
               
                
                thisevent.nom=self.v.nom;
                thisevent.lat=self.v.lat;
                thisevent.lon=self.v.lon;
                thisevent.lieu=self.v.lieu;
                thisevent.categorie=self.v.categorie;
                thisevent.adresse=self.v.adresse;
                thisevent.accees=self.v.accees;
                thisevent.desc=self.v.desc;
                thisevent.image=self.v.image;
                thisevent.dateevent=self.v.dateevent;
                thisevent.idEvent=self.v.idEvent;
                thisevent.iduser=iduser;
                
                Responder *responder = [Responder responder:self
                                         selResponseHandler:@selector(responseHandler:)
                                            selErrorHandler:@selector(errorHandler:)];
    

                id<IDataStore> dataStore = [backendless.persistenceService of:[thisevent class]];
                [dataStore save:thisevent responder:responder];
                    
                    
                    UIAlertController * alert2=   [UIAlertController
                                                   alertControllerWithTitle:@"Info"
                                                   message:@"Ajout Favoris avec succées"
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
                else{
                    UIAlertController * alert2=   [UIAlertController
                                                   alertControllerWithTitle:@"Info"
                                                   message:@"Event existe dejà dans votre repertoire favoris "
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
        }];
        
        
        
    }
    else{
        UIAlertController * alert2=   [UIAlertController
                                       alertControllerWithTitle:@"Alerte"
                                       message:@"verifier votre connexion "
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
@end
