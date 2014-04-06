//
//  MGIndexViewController.m
//  ImagesC
//
//  Created by snow on 7/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGIndexViewController.h"
#import "MGImagesManager.h"

@interface MGIndexViewController ()

@end

@implementation MGIndexViewController
@synthesize tag_id,c_id,rn,pn,photos,thumbs;
static bool isLoading = false;
-(void)imagesDataRecieve:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:kKeyListImagesSucc] == YES)
    {
        MGImagesModel * o = (MGImagesModel *)notification.object;
        [self generatePhotos:o];
        isLoading = false;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kKeyListImagesSucc object:nil];
    }
}

- (void)reloadSourceWithTag_id:(NSInteger)tag_id catalog_id:(NSInteger)c_id rn:(NSInteger)rn pn:(NSInteger)pn{
    self.tag_id = tag_id;
    self.c_id = c_id;
    self.rn = rn;
    self.pn = pn;
}

- (void)generatePhotos:(MGImagesModel *)m{
    self.tag_id = m.tag_id;
    self.c_id = m.c_id;
    self.rn = m.rn;
    self.pn = m.pn;
    

//    MWPhoto *photo;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = YES;
    BOOL enableGrid = YES;
    BOOL startOnGrid = YES;
    for (MGImagesObject *iter in m.images) {
        MWPhoto *m = [MWPhoto photoWithURL:[NSURL URLWithString:iter.origin_url]];
        m.caption = [iter.description  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.photos addObject:m];
        [self.thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:iter.origin_url]]];
    }
//    // Photos
    // Options
    startOnGrid = YES;
    displayNavArrows = YES;
    
    MWPhotoBrowser *browser = self;
    
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.wantsFullScreenLayout = YES;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    //default zero, go to MWPhotoBrowser.m line:1369
    [browser setCurrentPhotoIndex:pn];
    [self reloadData];
}


- (id)init{
    if (self = [super init]) {
        self.delegate = self;
        self.gvDelegate = self;
        self.photos = [[NSMutableArray alloc] init];
        self.thumbs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kKeyListImagesSucc object:nil];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < self.thumbs.count)
        return [self.thumbs objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

#pragma mark - scroll

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [super scrollViewDidScroll:scrollView];
//    NSLog(@"scolling");
//}
-(void)loadMore{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imagesDataRecieve:) name:kKeyListImagesSucc object:nil];
    [[MGImagesManager shareImagesManager] listImages:self.tag_id catalog_id:self.c_id start_index:self.pn + 100 rn:100];
    NSLog(@"try to fetch more data");
}

-(void)mg_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!isLoading) {
        if (scrollView.contentOffset.y + 700 > scrollView.contentSize.height) {
            //load more data;
            isLoading = true;
            [self loadMore];
        }
    }
}

@end
