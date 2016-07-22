//
//  Guidedetail.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 4/8/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "Guidedetail.h"
#import <UIImageView+AFNetworking.h>
@interface Guidedetail ()

@end

@implementation Guidedetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // NSLog(@"its cat %@",self.data.name);
    [self.myscroll setScrollEnabled:YES];
    
    
    [self.myscroll setScrollEnabled:YES];
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    switch (screenHeight) {
            // iPhone 4s
        case 480:
            [self.myscroll setContentSize:CGSizeMake(300, 811)];
            break;
            
            // iPhone 5s
        case 568:
            [self.myscroll setContentSize:CGSizeMake(300, 811)];
            break;
            
            // iPhone 6
        case 667:
            [self.myscroll setContentSize:CGSizeMake(375, 800)];
            break;
            
            // iPhone 6 Plus
        default:
            [self.myscroll setContentSize:CGSizeMake(414, 1250)];
            break;
            
            
    }

    //[self.myscroll setContentSize:CGSizeMake(414, 811)];
    
    
    
    double lat = [self.data.lat doubleValue];
    double lon = [self.data.lon doubleValue];
    
    
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
    
    [self.mapdata setRegion:region];
    [self.mapdata addAnnotation:annotation];
    // Assign the camera to your map view.
    self.mapdata.camera = myCamera;
    
    
    if (self.data.imgref == nil)
        
    {
        
        self.imgguide.image=[UIImage imageNamed:@"noimg"];
        
    }
    else {
        
        NSString *str = @"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=";
        
        
        NSString   *imgfinal = [str stringByAppendingString:self.data.imgref] ;
        
        NSString *imgfinal2= [imgfinal stringByAppendingString:@"&key=AIzaSyBF0ZDR7QPOhG0GD2vuQOdmt9akEk7lhMM"];
        
        
        [self.imgguide setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgfinal2]] placeholderImage:nil  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
            self.imgguide.image = image;
        }
                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                    NSLog(@"Unable to retrieve image");
                                }];
    }
    
    
    self.nameguide.text=self.data.name;
    self.vicinity.text=self.data.vicinity;
    self.numtel.text=@"003314578956";
    self.type.text=self.data.type;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
