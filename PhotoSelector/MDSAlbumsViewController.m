//
//  MDSAlbumsViewController.m
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/5/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import "MDSAlbumsViewController.h"
#import "MDSAssetsController.h"
#import "MDSAlbumCell.h"
#import "MDSDefaultAlbumCell.h"

@interface MDSAlbumsViewController ()

@end

@implementation MDSAlbumsViewController
{
  MDSAssetsController * _assetsController;
}

NSString * const MDSAlbumViewControllerCellIdentifier = @"AlbumCell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      _assetsController = [MDSAssetsController sharedController];
      [_assetsController addObserver:self
                          forKeyPath:@"groups"
                             options:NSKeyValueObservingOptionNew
                             context:NULL];
      self.cellClass = [MDSDefaultAlbumCell class];
    }
    return self;
}

- (void) dealloc {
  [_assetsController removeObserver:self
                         forKeyPath:@"groups"
                            context:NULL];
}

#pragma mark - KVO

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  [self.tableView reloadData]; // this should be way better
}

#pragma mark - Setters / Getters

- (void) setCellClass:(Class)cellClass {
  NSAssert([cellClass conformsToProtocol:@protocol(MDSAlbumCell)], @"Cell Classes Must Conform to the MDSAlbumCell Protocol");
  _cellClass = cellClass;
  [self.tableView registerClass:cellClass
         forCellReuseIdentifier:MDSAlbumViewControllerCellIdentifier];
}

#pragma mark - View Methods

- (void) viewDidLoad {
  [self.tableView registerClass:self.cellClass
         forCellReuseIdentifier:MDSAlbumViewControllerCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _assetsController.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<MDSAlbumCell> *cell = [tableView dequeueReusableCellWithIdentifier:MDSAlbumViewControllerCellIdentifier forIndexPath:indexPath];
    
  ALAssetsGroup * group = _assetsController.groups[indexPath.row];
  [cell setGroup:group];
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ALAssetsGroup * group = _assetsController.groups[indexPath.row];
  [self.delegate albumViewController:self
                      didSelectGroup:group];
}

@end
