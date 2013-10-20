//
//  Project.m
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import "Project.h"
#import "MuseicaModel.h"

@implementation Project

@synthesize museModel       = _museModel;
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
    self.museModel = [MuseicaModel sharedInstance];
    self.tracks = [[NSMutableArray alloc] init];
    // HACK: This should be done lazily. Not automatically
//    [self createTrack];
}

#pragma mark Project Stuff
// ---------------------------------------------------
- (Track *) createTrack {
    Track *track = nil;
    if(self.tracks.count <= MAX_TRACKS) {
        track = self.currentTrack = [[Track alloc] initWithNumber:self.numTracks++];
        [self.tracks addObject:track];
    }
    return track;
}
// ---------------------------------------------------
/*
- (void)playTrack:(Track*) track {
    NSURL *file = [[NSBundle mainBundle] URLForResource:[self.museModel getTrackName:track inProject:self] withExtention:@"m4a"];
    self.trackPlayer = [AEAudioFilePlayer audioFilePlayerWithURL:file audioController:_audioController error:NULL];
    
}
 */

@end
