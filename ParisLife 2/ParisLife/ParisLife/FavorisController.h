//
//  FavorisController.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 5/8/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavorisController : UITableViewController{
    NSMutableArray *favlist;
}
@property (strong, nonatomic) NSMutableArray *favlist;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *myb;

@end
