//
//  Categoriegrid.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 4/6/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "Categoriegrid.h"
#import "Listeplaces.h"
#import "SWRevealViewController.h"

@interface Categoriegrid ()

@end

@implementation Categoriegrid

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        
        revealViewController.rearViewRevealWidth = [UIScreen mainScreen].bounds.size.width-70;
        [self.myb setTarget: self.revealViewController];
        [self.myb setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }

    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gridcat" forIndexPath:indexPath];
    
    
    UIImageView *gridImageView = (UIImageView *)[cell viewWithTag:232];
    
    
    
    
    
    // Configure the cell
    
    switch (indexPath.row) {
        case 0:
            gridImageView.image=[UIImage imageNamed:@"imgg1"] ;
            break;
            
        case 1:
            gridImageView.image=[UIImage imageNamed:@"imgg2"] ;
            break;
            
        case 2:
            gridImageView.image=[UIImage imageNamed:@"imgg3"] ;
            break;
            
        case 3:
            gridImageView.image=[UIImage imageNamed:@"imgg4"] ;
            break;
        case 4:
            gridImageView.image=[UIImage imageNamed:@"imgg5"] ;
            break;
        case 5:
            gridImageView.image=[UIImage imageNamed:@"imgg6"] ;
            break;
            
            
    }

    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"ggggg %ld",(long)indexPath.row);


}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"listplaces"]){
       
        
        
        
        NSIndexPath *index = [self.collectionView indexPathForCell:sender];
       
        
        long cat=index.row;
        
        Listeplaces *vc=[segue destinationViewController];
        NSString *catt;
        switch (cat) {
            case 0:
                catt=@"restaurant";
                break;
                
            case 1:
                catt=@"bar";
                break;
                
            case 2:
                catt=@"night_club";
                break;
                
            case 3:
                catt=@"museum";
                break;
            case 4:
                catt=@"lodging";
                break;
            case 5:
                catt=@"hospital";
                break;
                
            
        }
        
        
        vc.categorie=catt;
        
    }
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
