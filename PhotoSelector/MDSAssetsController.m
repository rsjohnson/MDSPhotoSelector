//
//  MDSAssetsController.m
//  PhotoSelector
//
//  Created by Ryan Johnson on 7/5/13.
//  Copyright (c) 2013 MDS. All rights reserved.
//

#import "MDSAssetsController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation MDSAssetsController
{
  ALAssetsLibrary * _assetsLibrary;
  NSMutableArray * _groups;
}

+ (MDSAssetsController*) sharedController {
  static MDSAssetsController * sharedController;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedController = [[self alloc] init];
  });
  
  return sharedController;
}

- (id) init {
  self = [super init];
  if (self) {
    _groups = [NSMutableArray array];
    [self loadGroups];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(assetsDidUpdate:)
                                                 name:ALAssetsLibraryChangedNotification
                                               object:nil];
  }
  return self;
}

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - ALAssetGroup Management

- (void) loadGroups {
  ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
  if (authStatus == ALAuthorizationStatusRestricted ||
      authStatus == ALAuthorizationStatusDenied) {
    _canAccessAssets = NO;
  }
  else {
    _canAccessAssets = YES;
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetTypePhoto
                                  usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                    if (group) {
                                      [self addGroup:group];
                                    }
                                  }
                                failureBlock:^(NSError *error) {
                                  _canAccessAssets = NO;
                                }];
  }
}

/*! wipes out the cached ALAssetGroups */
- (void) resetGroups {
  [self willChangeValueForKey:@"groups"];
  _groups = [NSMutableArray array];
  [self didChangeValueForKey:@"groups"];
  [self loadGroups];
}

/*! Convenience method for retrieving an index set of indexes in the _groups array for a group of urls */
- (NSIndexSet*) indexesOfGroupsWithURLs:(NSArray*)urls {
  return [_groups indexesOfObjectsPassingTest:^BOOL(ALAssetsGroup * group, NSUInteger idx, BOOL *stop) {
    NSURL * url = [group valueForProperty:ALAssetsGroupPropertyURL];
    return [urls containsObject:url];
  }];
}

/*! Processes the updated URLs given by the assets library updated notification */
- (void) processUpdatedGroupURLS:(NSArray*)urls {
  if (!urls) {
    return;
  }
  
  NSIndexSet * idxSet = [self indexesOfGroupsWithURLs:urls];
  [self willChange:NSKeyValueChangeReplacement
   valuesAtIndexes:idxSet
            forKey:@"groups"];
  [self didChange:NSKeyValueChangeReplacement
  valuesAtIndexes:idxSet
           forKey:@"groups"];
}
/*! Processes inserted group URLS sent over in an assets library update notification */
- (void) processInsertedGroupURLS:(NSArray*)urls {
  if (!urls) {
    return;
  }
  for (NSURL * url in urls) {
    [_assetsLibrary groupForURL:url
                    resultBlock:^(ALAssetsGroup *group) {
                      [self addGroup:group];
                    } failureBlock:^(NSError *error) {
                      
                    }];
  }
}

/*! Removes groups as reported byt the assets library update notification */
- (void) processRemovedGroupURLS:(NSArray*)urls {
  if (!urls) {
    return;
  }
  
  NSIndexSet * indexSet = [self indexesOfGroupsWithURLs:urls];
  [self willChange:NSKeyValueChangeRemoval
   valuesAtIndexes:indexSet
            forKey:@"groups"];
  [_groups removeObjectsAtIndexes:indexSet];
  [self didChange:NSKeyValueChangeRemoval
  valuesAtIndexes:indexSet
           forKey:@"groups"];
}

/*! 
 * ALAssetGroups should be added here instead of directly to the mutable array
 * in order to enable KVO 
 */
- (void) addGroup:(ALAssetsGroup*)group {
  [self willChange:NSKeyValueChangeInsertion
   valuesAtIndexes:[NSIndexSet indexSetWithIndex:_groups.count]
            forKey:@"groups"];
  [_groups addObject:group];
  [self didChange:NSKeyValueChangeInsertion
  valuesAtIndexes:[NSIndexSet indexSetWithIndex:_groups.count - 1]
           forKey:@"groups"];
}


#pragma mark -

- (void) assetsDidUpdate:(NSNotification*)notification {
  NSDictionary * userInfo = notification.userInfo;
  if (userInfo) {
    [self processUpdatedGroupURLS:userInfo[ALAssetLibraryUpdatedAssetsKey]];
    [self processInsertedGroupURLS:userInfo[ALAssetLibraryInsertedAssetGroupsKey]];
    [self processRemovedGroupURLS:userInfo[ALAssetLibraryDeletedAssetGroupsKey]];
    
  } else {
    // when the user info dictionary is nil we need to reload all assets
    [self resetGroups];
  }
}




@end
