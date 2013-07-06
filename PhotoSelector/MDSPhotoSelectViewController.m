//
//  MDSPhotoSelectViewController.m
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/5/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import "MDSPhotoSelectViewController.h"
#import "MDSPhotoCell.h"
#import "MDSDefaultPhotoCell.h"

@interface MDSPhotoSelectViewController ()

@end

@implementation MDSPhotoSelectViewController

- (MDSPhotoSelectViewController*) initWithAssetsGroup:(ALAssetsGroup *)group
                                     collectionLayout:(UICollectionViewLayout *)layout
{
  if (!layout) {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = (CGSize){75,75};
    layout = flowLayout;
  }
  
  self = [self initWithCollectionViewLayout:layout];
  if (self) {
    _assetsGroup = group;
    self.cellClass = [MDSDefaultPhotoCell class];
  }
  return self;
}

- (void) viewDidLoad {
  [super viewDidLoad];
  [self.collectionView registerClass:[UICollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];
  self.view.backgroundColor = [UIColor whiteColor];
  self.collectionView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Setters / Getters

- (void) setCellClass:(Class)cellClass {
  NSAssert([cellClass conformsToProtocol:@protocol(MDSPhotoCell)], @"Cell Classes Must Conform to MDSPhotoCell Protocol");
  _cellClass = cellClass;
  [self.collectionView registerClass:cellClass
          forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark - UICollectionView Delegate + Data Source

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return _assetsGroup.numberOfAssets;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell<MDSPhotoCell> * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
  [_assetsGroup enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:indexPath.row]
                                 options:0
                              usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                  if (result) {
                                    [cell setAsset:result];
                                  }
                                });
                              }];
  
  return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [_assetsGroup enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:indexPath.row]
                                 options:0
                              usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                if (result) {
                                  [self.delegate photoSelectViewController:self
                                                            didSelectAsset:result];
                                }
                              }];
}





@end
