//
//  MDSPhotoCell.h
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/6/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAsset;

@protocol MDSPhotoCell <NSObject>
@required
- (void) setAsset:(ALAsset*)asset;
@end
