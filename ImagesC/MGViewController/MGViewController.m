//
//  MGViewController.m
//  ImagesC
//
//  Created by snow on 7/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGViewController.h"
#import "SDImageCache.h"
#import "MMDrawerController.h"
#import "MGCatalogManager.h"
#import "MGImagesManager.h"
#import "MGIndexViewController.h"
#import "MGTagViewController.h"

@interface MGViewController ()

@end

@implementation MGViewController

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
		self.title = @"dont know why still here";
//        self.navigationController.view.backgroundColor = [UIColor blackColor];
//        self.parentViewController.view.backgroundColor = [UIColor blackColor];
        // Clear cache for testing
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        
        self.tableView.tableHeaderView = nil;
//        self.navigationItem.rightBarButtonItem = item;
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
//        
        self.view.backgroundColor = [UIColor blackColor];

    }
    return self;
}

#pragma mark - datarecive

-(void)catalogDataRecieve:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:kKeyListCatalogsSucc] == YES)
    {
        catalogsModel * o = (catalogsModel *)notification.object;
        self.catalogs =  o.catalogs;
        [self.tableView reloadData];
    }
}
-(void)imagesDataRecieve:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:kKeyListImagesSucc] == YES)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kKeyListImagesSucc object:nil];
        MGImagesModel * o = (MGImagesModel *)notification.object;
        MGIndexViewController * center = [[MGIndexViewController alloc] init];
        [center generatePhotos:o];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:center];
        MMDrawerController *d = [self mm_drawerController];
        [d setCenterViewController:nc withCloseAnimation:YES completion:nil];
    }
}
//
//- (void)generatePhotos:(MGImagesModel *)m{
//    
//    NSMutableArray *photos = [[NSMutableArray alloc] init];
//    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
//    
//    for (MGImagesObject *iter in m.images) {
//        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:iter.origin_url]]];
//        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:iter.origin_url]]];
//    }
//    
//    self.photos = photos;
//    self.thumbs = thumbs;
//}

#pragma mark View

- (void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(catalogDataRecieve:) name:kKeyListCatalogsSucc object:nil];
    [[MGCatalogManager shareCatalogManager]listCatalogs:0 rn:100];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    //    self.navigationController.navigationBar.translucent = NO;
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if (self.catalogs != nil) {
        rows = self.catalogs.count;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Create
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor blackColor];
    }
    catalogsObject *co = [self.catalogs objectAtIndex:indexPath.row];
    cell.textLabel.text = co.title;
    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.detailTextLabel.text = @"selection enabled, start at grid";
//    cell.detailTextLabel.textColor = [UIColor whiteColor];
    return cell;
	
}


#pragma mark - btn touch event
-(void)btnTouch:(id)e{
    MGTagViewController *center = [[MGTagViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:center];
    MMDrawerController *d = [self mm_drawerController];
    [d setCenterViewController:nc withCloseAnimation:YES completion:nil];
}

#pragma mark -
#pragma mark Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 32.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 32)];
    v.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.text = @"current is xxx, changed?";
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.backgroundColor = [UIColor blueColor];
    [v addSubview:btn];
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    catalogsObject *co = [self.catalogs objectAtIndex:indexPath.row];
    [self pushBrowserWitht_id:co.tag_id Catalog_id:co.c_id rn:20 pn:0];
}

- (void)pushBrowserWitht_id:(NSInteger)t_id Catalog_id:(NSInteger)catalog_id rn:(NSInteger)rn pn:(NSInteger)pn{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imagesDataRecieve:) name:kKeyListImagesSucc object:nil];
    [[MGImagesManager shareImagesManager] listImages:t_id catalog_id:catalog_id start_index:pn rn:rn];
}

//#pragma mark - MWPhotoBrowserDelegate
//
//- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
//    return _photos.count;
//}
//
//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
//    if (index < _photos.count)
//        return [_photos objectAtIndex:index];
//    return nil;
//}
//
//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _thumbs.count)
//        return [_thumbs objectAtIndex:index];
//    return nil;
//}
//
//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
//}
#pragma mark - mm

-(MMDrawerController*)mm_drawerController{
    if([self.parentViewController isKindOfClass:[MMDrawerController class]]){
        return (MMDrawerController*)self.parentViewController;
    }
    else if([self.parentViewController isKindOfClass:[UINavigationController class]] &&
            [self.parentViewController.parentViewController isKindOfClass:[MMDrawerController class]]){
        return (MMDrawerController*)[self.parentViewController parentViewController];
    }
    else{
        return nil;
    }
}
@end
