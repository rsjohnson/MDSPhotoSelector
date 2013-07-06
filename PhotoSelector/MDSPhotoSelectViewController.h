//
//  MDSPhotoSelectViewController.h
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/5/13.
//  Copyright (c) 2013 Mobile Data Solutions, Inc.. 
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
