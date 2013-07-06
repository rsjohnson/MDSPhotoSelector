//
//  MDSAlbumCell.h
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/5/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsGroup;

/*! Protocol for all cells which are used in the MDSAlbumsViewController */
@protocol MDSAlbumCell <NSObject>
@required
- (void) setGroup:(ALAssetsGroup*)group;
@end
