//
//  FBUser.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 5/5/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBUser : NSObject{
    NSString *name,*idd,*email;
}
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *idd;
@property(nonatomic,strong) NSString *email;
@end
