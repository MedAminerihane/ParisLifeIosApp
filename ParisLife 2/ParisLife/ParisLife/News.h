//
//  news.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 3/15/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject{
    NSString *titre,*img,*desc;
}

@property (strong, nonatomic) NSString *titre;
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *desc;


@end
