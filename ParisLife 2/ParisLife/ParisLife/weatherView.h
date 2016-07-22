//
//  weatherView.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 3/16/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML+HTTP.h"


@interface weatherView : UIViewController

@property (strong,nonatomic) NSMutableArray* tabweekweather;

-(void)loadweather:(TBXMLElement *)element;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnbaritem;
@property (strong, nonatomic) IBOutlet UIImageView *bigimageweather;

@property (strong, nonatomic) IBOutlet UILabel *todaydegree;

@property (strong, nonatomic) IBOutlet UILabel *day1name;

@property (strong, nonatomic) IBOutlet UIImageView *day1img;

@property (strong, nonatomic) IBOutlet UILabel *day1degree;

@property (strong, nonatomic) IBOutlet UILabel *day2name;
@property (strong, nonatomic) IBOutlet UIImageView *day2img;
@property (strong, nonatomic) IBOutlet UILabel *day2degree;

@property (strong, nonatomic) IBOutlet UILabel *day3name;
@property (strong, nonatomic) IBOutlet UIImageView *day3img;

@property (strong, nonatomic) IBOutlet UILabel *day3degree;


@property (strong, nonatomic) IBOutlet UILabel *day4name;

@property (strong, nonatomic) IBOutlet UIImageView *day4img;

@property (strong, nonatomic) IBOutlet UILabel *day4degree;


@property (strong, nonatomic) IBOutlet UILabel *day5name;

@property (strong, nonatomic) IBOutlet UIImageView *day5img;

@property (strong, nonatomic) IBOutlet UILabel *day5degree;

@property (strong, nonatomic) IBOutlet UILabel *day6name;

@property (strong, nonatomic) IBOutlet UIImageView *day6img;


@property (strong, nonatomic) IBOutlet UILabel *day6degree;



@end
