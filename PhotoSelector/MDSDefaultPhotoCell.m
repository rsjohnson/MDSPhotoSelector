//
//  MDSDefaultPhotoCell.m
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/6/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import "MDSDefaultPhotoCell.h"

@implementation MDSDefaultPhotoCell
{
  UIImageView * _imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
      [self addSubview:_imageView];
    }
    return self;
}

- (void) applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  self.frame = layoutAttributes.frame;
  _imageView.frame = self.bounds;
}

- (void) setAsset:(ALAsset *)asset {
  _imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
}

@end
