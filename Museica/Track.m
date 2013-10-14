//
//  Track.m
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import "Track.h"

@implementation Track

@synthesize number = _number;

- (id)initWithNumber: (int) number {
    if ((self = [super init])) {
        self.number = number;
    }
    return self;
}

@end
