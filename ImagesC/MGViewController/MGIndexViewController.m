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


-(void)imagesDataRecieve:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:kKeyListImagesSucc] == YES)
    {
        MGImagesModel * o = (MGImagesModel *)notification.object;
        [self generatePhotos:o];
    }
}

- (void)generatePhotos:(MGImagesModel *)m{
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];

//    MWPhoto *photo;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    
    for (MGImagesObject *iter in m.images) {
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:iter.origin_url]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:iter.origin_url]]];
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
    [browser setCurrentPhotoIndex:0];
    
    
    self.photos = photos;
    self.thumbs = thumbs;
    [self reloadData];
}


- (id)init{
    if (self = [super init]) {
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imagesDataRecieve:) name:kKeyListImagesSucc object:nil];
    [[MGImagesManager shareImagesManager] listImages:1 catalog_id:1 start_index:1 rn:30];
}

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

@end
