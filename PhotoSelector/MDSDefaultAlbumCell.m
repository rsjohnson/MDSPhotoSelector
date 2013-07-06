//
//  MDSDefaultAlbumCell.m
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/5/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import "MDSDefaultAlbumCell.h"

@implementation MDSDefaultAlbumCell
- (void) setGroup:(ALAssetsGroup *)group {
  self.imageView.image = [UIImage imageWithCGImage:group.posterImage];
  self.textLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
}
@end
