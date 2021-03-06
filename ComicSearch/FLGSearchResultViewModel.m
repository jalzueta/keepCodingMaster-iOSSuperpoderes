//
//  FLGSearchResultViewModel.m
//  ComicSearch
//
//  Created by Javi Alzueta on 17/5/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGSearchResultViewModel.h"

@implementation FLGSearchResultViewModel

- (instancetype) initWithIdentifier: (NSNumber *) identifier
                           imageURL: (NSURL *) imageURL
                              title: (NSString *) title
                          publisher: (NSString *) publisher{
    if (self = [super init]) {
        _identifier = identifier;
        _imageURL = [imageURL copy];
        _title = [title copy];
        _publisher = [publisher copy];
    }
    return self;
}

@end
