//
//  ProjectViewController.m
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import "ProjectViewController.h"

@interface ProjectViewController ()
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation ProjectViewController

@synthesize museModel       = _museModel;
@synthesize recordButton    = _recordButton;
@synthesize label           = _label;
@synthesize currentProject  = _currentProject;


int TRACK_ROW_HEIGHT    = 40;
int TRACK_ROW_WIDTH     = -1;

/**************************************************************************
 * Setting up the View Controller
 **************************************************************************/
#pragma mark VC Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//----------------------------------------------------
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;
{
    return UIInterfaceOrientationLandscapeLeft;
}
// TODO
- (NSUInteger)supportedInterfaceOrientations;
{
    return UIInterfaceOrientationMaskLandscape;
}
//----------------------------------------------------
- (BOOL)shouldAutorotate
{
    return YES;
}
//----------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    TRACK_ROW_WIDTH     = [[UIScreen mainScreen] bounds].size.height;
    NSLog(@"Project view controller view loaded WITH WIDTH %d.", TRACK_ROW_WIDTH);
    // Load the app model
    self.museModel = [MuseicaModel sharedInstance];
    // HACK
    self.currentProject = [self.museModel createProject];
    [self addNextTrackRow];
}
//----------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"!> DID RECEIVE MEMORY WARNING!!!");
}

#pragma mark UI Creation
//----------------------------------------------------
- (void)addNextTrackRow {
    // Check if we haven't passed max rows
    // Ask project for a new track.
    Track *track = [self.currentProject createTrack];
    // Create next row with that track.
    if (track) {
        NSLog(@">>> Adding row for track: %d", track.number);
        TrackRow *row = [[TrackRow alloc] initWithFrame:[self getRectForRow:track.number]
                                      andController:self
                                           andTrack:track];
        // Add to array of views?
        [self.view addSubview:row];
    }
}
//----------------------------------------------------
- (CGRect)getRectForRow:(int)num {
    return CGRectMake(0, TRACK_ROW_HEIGHT + TRACK_ROW_HEIGHT*num, TRACK_ROW_WIDTH, TRACK_ROW_HEIGHT);
}
//----------------------------------------------------
- (void)updateLabel;
{
    if(self.museModel.recording) {
        [self.label setText:@"Recording"];
    } else if(self.museModel.playing){
        [self.label setText:@"Playing"];
    } else {
        [self.label setText:@"Doing nothing"];
    }
}

#pragma mark UI Interaction
//----------------------------------------------------
- (IBAction)tappedAddTrack:(UIButton*)sender {
    [self addNextTrackRow];
}
//----------------------------------------------------
- (void)tappedRecordForTrack:(Track *)track {
    NSLog(@">> Tapped Record For Track: %d", track.number);
    // highlight current track view
    // show countin view
    // show scrubber line
    // tell model to record for project, track
    [self.museModel prepRecord];
    [self.museModel recordTrack:track
                      inProject:self.currentProject];
    // Should do this properly by calling view method.
    [self updateLabel];
}
//----------------------------------------------------
- (void)tappedStopForTrack:(Track *)track
{
    [self.museModel stopRecording];
    [self updateLabel];
}
//----------------------------------------------------
- (void)tappedDeleteForTrack:(Track*)track;
{
    [self.museModel deleteTrack:track
                     forProject:self.currentProject];
    // Update GUI.
}
//----------------------------------------------------
- (IBAction)tappedPlay:(UIButton*)sender {
    [self.museModel playTracksForProject:self.currentProject];
    [self updateLabel];
}



#pragma mark NEXT STUFF



@end
