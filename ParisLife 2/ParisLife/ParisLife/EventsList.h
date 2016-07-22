//
//  EventsList.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/18/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsList : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *myarray;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;

@end
