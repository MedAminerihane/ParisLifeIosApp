//
//  Weather.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 3/16/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject{
    NSString *day,*temperature,*symbol;
    
}


@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *temperature;
@property (strong, nonatomic) NSString *symbol;

@end
