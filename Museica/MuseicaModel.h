//
//  MuseicaModel.h
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Track.h"
#import "AEAudioController.h"
#import "AERecorder.h"

@class Project;

@interface MuseicaModel : NSObject

// -- Properties -------------------------------------
@property (strong, atomic)      NSMutableArray  *projects;
@property (strong, nonatomic)   Project         *currentProject;
@property (nonatomic, strong) AEAudioController *audioController;
@property (strong, nonatomic) AERecorder        *recorder;


// -- Methods ----------------------------------------
+ (MuseicaModel *)  sharedInstance;
- (Project *)       createProject;

- (void)prepRecord;
- (void)recordTrack:(Track *)track inProject:(Project *)project;
- (void)endRecording;

- (void)deleteTrack:(Track *)track forProject:(Project *)project;
- (void)playTracksForProject:(Project *)project;

@end
