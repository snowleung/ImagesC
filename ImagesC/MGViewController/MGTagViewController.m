//
//  MGTagViewController.m
//  ImagesC
//
//  Created by snow on 21/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGTagViewController.h"
#import "MGTagsManager.h"
#import "MGCatalogManager.h"

@interface MGTagViewController ()

@end

@implementation MGTagViewController
@synthesize tags;


- (id)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tagsDataRecieve:) name:kKeyListTagsSucc object:nil];
    TagsModel *m = [[MGTagsManager shareTagsManager]listTags:0 rn:10];
    self.tags = m.tags;
    [self.tableView reloadData];
}

-(void) viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kKeyListTagsSucc object:nil];
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TagsObject *o = [self.tags objectAtIndex:indexPath.row];
    [[MGCatalogManager shareCatalogManager] listCatalogsWithTag:o.tag_id pn:0 rn:100];
}

#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    if (self.tags != nil) {
        rows = self.tags.count;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Create
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor blackColor];
    }
    TagsObject *co = [self.tags objectAtIndex:indexPath.row];
    cell.textLabel.text = co.tag_name;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - source receive
-(void)tagsDataRecieve:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:kKeyListTagsSucc] == YES)
    {
        TagsModel * o = (TagsModel *)notification.object;
        self.tags =  o.tags;
        [self.tableView reloadData];

    }
}

@end
