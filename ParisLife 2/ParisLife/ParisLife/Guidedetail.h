//
//  Guidedetail.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 4/8/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import <MapKit/MapKit.h>

@interface Guidedetail : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *numtel;
@property (weak,nonatomic) Place* data;
@property (strong, nonatomic) IBOutlet UILabel *vicinity;
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UIScrollView *myscroll;
@property (strong, nonatomic) IBOutlet UILabel *nameguide;
@property (strong, nonatomic) IBOutlet UIImageView *imgguide;
@property (strong, nonatomic) IBOutlet MKMapView *mapdata;
@end
