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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(catalogDataRecieve:) name:kKeyListCatalogsSucc object:nil];
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



#pragma mark View

- (void)viewDidLoad{
    [super viewDidLoad];
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

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Browser
	NSMutableArray *photos = [[NSMutableArray alloc] init];
	NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    MWPhoto *photo;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    // Photos
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo5" ofType:@"jpg"]]];
    photo.caption = @"White Tower";
    [photos addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"]]];
    photo.caption = @"The London Eye is a giant Ferris wheel situated on the banks of the River Thames, in London, England.";
    [photos addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
    photo.caption = @"York Floods";
    [photos addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo4" ofType:@"jpg"]]];
    photo.caption = @"Campervan";
    [photos addObject:photo];
    // Thumbs
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo5t" ofType:@"jpg"]]];
    [thumbs addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo2t" ofType:@"jpg"]]];
    [thumbs addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3t" ofType:@"jpg"]]];
    [thumbs addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo4t" ofType:@"jpg"]]];
    [thumbs addObject:photo];
    // Options
    startOnGrid = YES;
    displayNavArrows = YES;
    
    self.photos = photos;
    self.thumbs = thumbs;
	
	// Create browser
	MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.wantsFullScreenLayout = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    [browser setCurrentPhotoIndex:0];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    MMDrawerController *d = [self mm_drawerController];
    [d setCenterViewController:nc withCloseAnimation:YES completion:nil];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}
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
