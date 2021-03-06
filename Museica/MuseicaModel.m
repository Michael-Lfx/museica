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
@property (strong, nonatomic)   NSFileManager *fileManager;
@property (strong, nonatomic)   AEAudioFilePlayer   *player;

@end


@implementation MuseicaModel

// Synthesis
@synthesize projects        = _projects;
@synthesize projectCounter  = _projectCounter;
@synthesize audioController = _audioController;
@synthesize fileManager     = _fileManager;
@synthesize player          = _player;
@synthesize recording       = _recording;
@synthesize playing         = _playing;


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
    self.recording      = self.playing = NO;
    self.fileManager    = [NSFileManager defaultManager];
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
- (NSString *)docFolder;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
//----------------------------------------------------
- (NSString *)getFilePathForTrack:(Track *)track inProject:(Project *)project {
        NSString *subPath = [NSString stringWithFormat:@"%@.wave", [self getFileNameForTrack:track inProject:project]];
    NSString *filePath = [[self docFolder] stringByAppendingPathComponent:subPath];
//    NSLog(@">> Made filePath: %@", filePath);
    return filePath;
}
//----------------------------------------------------
- (NSString *)getFileNameWithExtensionForTrack:(Track *)track inProject:(Project *)project;
{
    return [NSString stringWithFormat:@"%d-%d.wave", project.number, track.number];
}
//----------------------------------------------------
- (NSString *)getFileNameForTrack:(Track *)track inProject:(Project *)project;
{
    return [NSString stringWithFormat:@"%d-%d", project.number, track.number];
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
    NSLog(@"*> Recording file at: %@", filePath);
    if (![self.recorder beginRecordingToFileAtPath:filePath
                                          fileType:kAudioFileWAVEType
                                             error:&error])
    {
        NSLog(@"!> ERROR recording! :( %@", error);
        return;
    }
    [self.audioController addInputReceiver:self.recorder];
    self.recording = YES;
}
//----------------------------------------------------
- (void)stopRecording;
{
    [self.audioController removeInputReceiver:self.recorder];
    [self.recorder finishRecording];
    self.recording = NO;
    self.recorder = nil;
}

// Tear Down Recording

# pragma mark Playback
//----------------------------------------------------
- (void)playTracksForProject:(Project *)project;
{
    NSArray *chanArr = [self getChannelsForProject:project];
    [self.audioController addChannels:chanArr];
}
//----------------------------------------------------
- (void)playTrack:(Track *)track inProject:(Project *)project;
{
    
    NSArray *chanArr = [[NSArray alloc] initWithObjects:
                        [self getChannelForURL:[self getUrlForTrack:track inProject:project]],
                        nil];
    NSLog(@">> Adding channels for project: %@", chanArr);
    [self.audioController addChannels:chanArr];
}
//----------------------------------------------------
- (NSURL *)getUrlForTrack:(Track *)track inProject:(Project *)project;
{
    NSURL *fileUrl = [NSURL fileURLWithPath:[self getFilePathForTrack:track inProject:project]];

    //    NSLog(@">> Made URL to: %@ from: %@", fileUrl, [self getFilePathForTrack:track inProject:project]);
    return fileUrl;
}
//----------------------------------------------------
- (NSArray *)getChannelsForProject:(Project *)project;
{
    NSMutableArray *chanArr = [[NSMutableArray alloc] initWithCapacity:project.tracks.count];
    
    AEAudioFilePlayer *filePlayer = nil;
    for(Track *track in project.tracks) {
        filePlayer = [self getChannelForURL:[self getUrlForTrack:track inProject:project]];
        if (filePlayer) {
            [chanArr addObject:filePlayer];
            filePlayer = nil;
        }
    }
    return [NSArray arrayWithArray:chanArr];
}
//----------------------------------------------------
- (AEAudioFilePlayer *)getChannelForURL:(NSURL *)fileUrl;
{
    NSError *error = nil;
    self.player = [AEAudioFilePlayer audioFilePlayerWithURL:fileUrl
                                            audioController:self.audioController
                                                      error:&error];
    __weak MuseicaModel *weakSelf = self;
    [self.player setCompletionBlock:^{
        [weakSelf playingCompleted];
    }];
    
     return self.player;
}
//----------------------------------------------------
- (void)playingCompleted;
{
    NSArray *chanArr = [[NSArray alloc] initWithObjects:self.player, nil];
    [self.audioController removeChannels:chanArr];
    self.playing = NO;
    self.player = nil;
}


# pragma mark File Management
//----------------------------------------------------
- (BOOL)deleteTrack:(Track *)track forProject:(Project *)project;
{
    NSString *filePath = [self getFilePathForTrack:track
                                         inProject:project];
    NSLog(@"X> Deleting file at: %@", filePath);
    
    NSError *error;
    if(![self.fileManager removeItemAtPath:filePath error:&error]) {
        NSLog(@"!>> ERROR deleting! :( %@", [error localizedDescription]);
        return NO;
    }
    return YES;
}


# pragma mark NEXT STUFF

@end
