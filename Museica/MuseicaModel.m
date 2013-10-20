//
//  MuseicaModel.m
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import "MuseicaModel.h"
#import "Project.h"
#import "AERecorder.h"

@interface MuseicaModel()

@property (nonatomic) int   projectCounter;

@end


@implementation MuseicaModel

// Synthesis
@synthesize projects        = _projects;
@synthesize projectCounter  = _projectCounter;
@synthesize audioController = _audioController;
// ---------------------------------------------------
//- (id)init{
//    if ((self = [super init])) {
//        // Read projectCounter from storage. If first run, init to 0.
//        self.projectCounter = 0;
//        self.projects = [[NSMutableArray alloc] init];
//    }
//    return self;
//}

// ---------------------------------------------------
+ (MuseicaModel *) sharedInstance {
    static MuseicaModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MuseicaModel alloc] init];
        [sharedInstance setup];
            });
    return sharedInstance;
}
// ---------------------------------------------------
- (void) setup {
    self.audioController = [[AEAudioController alloc]
                            initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription]
                            inputEnabled:YES];
    NSError *error = NULL;
    BOOL result = [_audioController start:&error];
    if( !result){
        NSLog(@"Error in setup");
    }
    [self testThings];
}
// ---------------------------------------------------
- (void) testThings {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docFolder = [paths objectAtIndex:0];
    NSString *subPath = [NSString stringWithFormat:@"%d/%d.wav", 0, 0];
    NSString *filePath = [docFolder stringByAppendingPathComponent:subPath];
    NSLog(@">> Made filePath: %@", filePath);
}

# pragma mark Project Methods
//----------------------------------------------------
- (Project *) createProject {
    Project *project = self.currentProject = [[Project alloc]  initWithNumber:self.projectCounter++];
    [self.projects addObject:project];
    return project;
}

# pragma mark File Things
//----------------------------------------------------
- (NSString *)getFilePathForTrack:(Track *)track inProject:(Project *)project {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docFolder = [paths objectAtIndex:0];
    NSString *subPath = [NSString stringWithFormat:@"%d/%d.wav", project.number, track.number];
    NSString *filePath = [docFolder stringByAppendingPathComponent:subPath];
    NSLog(@">> Made filePath: %@", filePath);
    return filePath;
}

# pragma mark Recording
//----------------------------------------------------
- (void)prepRecord;
{
    self.recorder = [[AERecorder alloc] initWithAudioController:self.audioController];
}
//----------------------------------------------------
- (void)recordTrack:(Track *)track inProject:(Project *)project;
{
    NSString *filePath = [self getFilePathForTrack:track inProject:project];
    NSError *error = NULL;
    if (![self.recorder beginRecordingToFileAtPath:filePath
                                          fileType:kAudioFileWAVEType
                                             error:&error])
    {
        NSLog(@"!> ERROR recording! :(");
        return;
    }
    [self.audioController addInputReceiver:self.recorder];
}
//----------------------------------------------------
- (void)endRecording;
{
    [self.audioController removeInputReceiver:self.recorder];
    [self.recorder finishRecording];
    self.recorder = nil;
}

// Tear Down Recording

# pragma mark Playback
- (void)playTracksForProject:(Project *)project;
{
    
}


# pragma mark File Management
- (void)deleteTrack:(Track *)track forProject:(Project *)project;
{
    NSString *filePath = [self getFilePathForTrack:track
                                         inProject:project];
    
}


# pragma mark NEXT STUFF

@end
