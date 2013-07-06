//
//  MDSAssetsController.h
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/5/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsLibrary;

/*! Manages the connection to the ALAssetsLibrary */
@interface MDSAssetsController : NSObject

+ (MDSAssetsController*) sharedController;

/*!  Access to the underlying ALAssetsLibrary. This value will be nil if the user has denied access to photos. */
@property (nonatomic, strong, readonly) ALAssetsLibrary * assetsLibrary;
/*! The ALAssetGroups in the library */
@property (nonatomic, strong, readonly) NSArray * groups;

@property (nonatomic, assign, readonly) BOOL canAccessAssets;

@end
