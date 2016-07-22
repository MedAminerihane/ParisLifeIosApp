//
//  newscell.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 3/10/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "newscell.h"

@implementation newscell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [self cardlayout];
}


-(void)cardlayout
{
    
    self.cardview.alpha = 1;
    self.cardview.layer.masksToBounds = false;
    self.cardview.layer.cornerRadius = 2;
    
    self.cardview.layer.shadowOffset = CGSizeMake(-0.2f, 0.2f);
    self.cardview.layer.shadowRadius = 1;
    self.cardview.layer.shadowOpacity = 0.2;
     UIBezierPath *path = [UIBezierPath bezierPathWithRect: self.cardview.bounds];
    self.cardview.layer.shadowPath = path.CGPath;
    self.backgroundColor = [UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1];
   /*
   [self.cardview setAlpha:1];
    self.cardview.layer.masksToBounds = NO;
    self.cardview.layer.cornerRadius = 2; // if you like rounded corners
    self.cardview.layer.shadowOffset = CGSizeMake(-.2f, .2f); //%%% this shadow will hang slightly down and to the right
    //self.cardview.layer.shadowOffset=CGSizeMake(1.0f, 3.0f);
    self.cardview.layer.shadowRadius = 1; //%%% I prefer thinner, subtler shadows, but you can play with this
    self.cardview.layer.shadowOpacity = 0.5; //%%% same thing with this, subtle is better for me
    
    //%%% This is a little hard to explain, but basically, it lowers the performance required to build shadows.  If you don't use this, it will lag
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cardview.bounds];
    self.cardview.layer.shadowPath = path.CGPath;
    
    //self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; //%%% I prefer choosing colors programmatically than on the storyboard
*/
}


@end
