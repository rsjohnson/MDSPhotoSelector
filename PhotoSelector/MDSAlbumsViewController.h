//
//  MDSAlbumsViewController.h
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/5/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDSAlbumsViewControllerDelegate;
@class ALAssetsGroup;

/*! View Controller for displaying a table view containing a list
 *  of the available ALAssetsGroup 
 */
@interface MDSAlbumsViewController : UITableViewController

@property (nonatomic, weak) id<MDSAlbumsViewControllerDelegate> delegate;
/*! The Class must conform to the MDSAlbumCell Protocol */
@property (nonatomic, assign) Class cellClass;

@end


@protocol MDSAlbumsViewControllerDelegate <NSObject>

@required

- (void) albumViewController:(MDSAlbumsViewController*)viewController
              didSelectGroup:(ALAssetsGroup*)group;

@end