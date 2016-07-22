//
//  ViewController.h
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/15/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML+HTTP.h"

@interface Acceuil : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *myb;

@property (strong , nonatomic) NSMutableArray *mytabnews;


@property (weak, nonatomic) IBOutlet UITableView *tablenews;


-(void)loadnews:(TBXMLElement *)element;
@end

