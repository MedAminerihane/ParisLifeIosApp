//
//  Listeplaces.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 4/7/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Listeplaces : UITableViewController
@property (weak,nonatomic) NSString* categorie;
@property (strong, nonatomic) IBOutlet UITableView *mytableviewlist;
@property (strong , nonatomic) NSMutableArray *myplacetab;
@end
