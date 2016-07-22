//
//  Place.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 4/7/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject{
    NSString *name,*rating,*vicinity,*type,*lat,*lon;
}

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *vicinity;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property (strong, nonatomic) NSString *imgref;





@end
