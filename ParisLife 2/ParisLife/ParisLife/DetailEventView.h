//
//  DetailEventView.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 3/17/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <MapKit/MapKit.h>
@interface DetailEventView : UIViewController{
    MKMapView *mymap;
}

- (IBAction)clickadd:(id)sender;
@property (strong,nonatomic) Event* v;

@property (strong, nonatomic) IBOutlet MKMapView *mymapview;
@property (strong, nonatomic) IBOutlet UIImageView *imageevent;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UILabel *eventname;

@property (strong, nonatomic) IBOutlet UILabel *eventdate;

@property (strong, nonatomic) IBOutlet UILabel *eventadresse;
@property (strong, nonatomic) IBOutlet UILabel *eventcategorie;
@property (strong, nonatomic) IBOutlet UILabel *eventtypaeaccess;
@property (strong, nonatomic) IBOutlet UILabel *eventdescription;
@property (strong, nonatomic) NSMutableArray *friendslist;
@property (strong, nonatomic) NSMutableArray *friendslistparticiper;

- (IBAction)Ajoutfavoris:(id)sender;


@end
