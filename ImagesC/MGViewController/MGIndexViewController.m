//
//  MGIndexViewController.m
//  ImagesC
//
//  Created by snow on 7/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGIndexViewController.h"


@interface MGIndexViewController ()

@end

@implementation MGIndexViewController


-(void)imagesDataRecieve:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:kKeyListCatalogsSucc] == YES)
    {

    }
}


- (id)init{
    if (self = [super init]) {

        self.delegate = self;
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

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
