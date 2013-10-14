//
//  Project.m
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import "Project.h"

@implementation Project

@synthesize name            = _name;
@synthesize number          = _number;
@synthesize numTracks       = _numTracks;
@synthesize tracks          = _tracks;
@synthesize currentTrack    = _currentTrack;

#pragma mark Set Up Stuff
-(id) initWithNumber:(int)number {
    if ((self = [super init])) {
        self.number = number;
        [self setUp];
    }
    return self;
}

// ---------------------------------------------------
-(void) setUp {
    self.tracks = [[NSMutableArray alloc] init];
    // HACK: This should be done lazily. Not automatically
    [self createTrack];
}



#pragma mark Project Stuff
// ---------------------------------------------------
- (Track *) createTrack {
    Track *track = [[Track alloc] initWithNumber:self.numTracks++];
    self.currentTrack = track;
    return track;
}

@end
