//
//  MDSPhotoSelectViewController.h
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/5/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsGroup;
@class ALAsset;

@protocol MDSPhotoSelectViewControllerDelegate;

/**
 * Displays a collection view of photos for an ALAssetsGroup
 */
@interface MDSPhotoSelectViewController : UICollectionViewController

@property (nonatomic, readonly, strong) ALAssetsGroup * assetsGroup;

@property (nonatomic, weak) id<MDSPhotoSelectViewControllerDelegate> delegate;

/**
 * The class to use for cells in the collection view. Custom classes must
 * conform to the MDSPhotoCell protocol. If not provided defaults
 * to a cell with just an image view.
 */
@property (nonatomic, strong) Class cellClass;

/** 
 * Designated initializer.
 * @param group The ALAssetsGroup whose photos will be displayed.
 * @param layout The collection view layout. If nil, will default to a
 *               UICollectionViewLayout witha itemSize of {75,75}
 */
- (MDSPhotoSelectViewController*) initWithAssetsGroup:(ALAssetsGroup*)group
                                     collectionLayout:(UICollectionViewLayout*)layout;


@end

@protocol MDSPhotoSelectViewControllerDelegate <NSObject>

@required
- (void) photoSelectViewController:(MDSPhotoSelectViewController*)viewController
                    didSelectAsset:(ALAsset*)asset;

@end
