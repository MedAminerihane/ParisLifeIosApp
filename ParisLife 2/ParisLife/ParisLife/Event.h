//
//  Event.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/18/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject{

    NSString *idEvent, *lieu, *adresse, *nom, *desc, *lat, *lon, *accees, *image ,*categorie ;
    
    
    NSDate *dateevent;
    
}

@property (strong, nonatomic) NSString *idEvent;
@property (strong, nonatomic) NSString *lieu;
@property (strong, nonatomic) NSString *adresse;
@property (strong, nonatomic) NSString *nom;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property (strong, nonatomic) NSString *accees;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *categorie;
@property (strong, nonatomic) NSDate *dateevent;


@end
