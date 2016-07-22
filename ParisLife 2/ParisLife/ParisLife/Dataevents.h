//
//  eventsliste.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/20/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dataevents : UIViewController <UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnx;
@property (strong , nonatomic) NSMutableArray *mytab;
@property (weak, nonatomic) IBOutlet UITableView *mytable;

@end
