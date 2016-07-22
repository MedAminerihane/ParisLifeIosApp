//
//  EventFavoris.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 5/8/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventFavoris : NSObject{
NSString *objectId,*idEvent, *lieu, *adresse, *nom, *desc, *lat, *lon, *accees, *image ,*categorie , *iduser ;


NSDate *dateevent;
}
@property (nonatomic, strong) NSString *objectId;
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
@property (strong, nonatomic) NSString *iduser;
@property (strong, nonatomic) NSDate *dateevent;

@end