//
//  TrackRow.m
//  Museica
//
//  Created by Andre on 10/16/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import "TrackRow.h"
#import "ProjectViewController.h"

@implementation TrackRow

@synthesize track           = _track;
@synthesize viewController  = _viewController;
@synthesize recordButton    = _recordButton;
@synthesize deleteButton    = _deleteButton;
@synthesize timeLabel       = _timeLabel;

MuseicaModel *museModel;

const NSString *RECORD_BUTTON_TITLE = @"Record";
const NSString *DELETE_BUTTON_TITLE = @"Clear";


//----------------------------------------------------
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}
//----------------------------------------------------
//- (id)initWithFrame:(CGRect)frame andController:(ProjectViewController*)vc
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        NSLog(@">> Init TrackRow frame + vc");
//        self.viewController = vc;
//    }
//    return self;
//}
//----------------------------------------------------
- (id)initWithFrame:(CGRect)frame
      andController:(ProjectViewController *)vc
           andTrack:(Track *)track
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewController = vc;
        self.track          = track;
        [self setUp];
    }
    return self;
}
//----------------------------------------------------
-(void) setUp {
    museModel = [MuseicaModel sharedInstance];
    [self setBackgroundColor:[UIColor colorWithRed:.0
                                             green:.8
                                              blue:.9
                                             alpha:1]];
    // Add record button
    [self addRecordButton];
    // Add delete button
    [self addDeleteButton];
    // Add soundwave
    // Add time view
}
//----------------------------------------------------
-(void) addRecordButton {
//    NSLog(@">> Adding Rec buttor for track: %d", self.track.number);
    self.recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.recordButton setFrame:CGRectMake(10, 10, 50, 20)];
    [self.recordButton setTitle:RECORD_BUTTON_TITLE forState:UIControlStateNormal];
    [self.recordButton addTarget:self
                          action:@selector(tappedRecordForTrack:)
                forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.recordButton];
}
//----------------------------------------------------
-(void) addDeleteButton {
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.deleteButton setFrame:CGRectMake(300, 10, 50, 20)];
    [self.deleteButton setTitle:DELETE_BUTTON_TITLE forState:UIControlStateNormal];
    [self.deleteButton addTarget:self
                          action:@selector(tappedDeleteForTrack:)
                forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteButton];
}
//----------------------------------------------------
- (void)updateUI;
{
    if(museModel.recording) {
        [self.recordButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else if(museModel.playing) {
        
    } else {
        [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
    }
}
// -- UI Callbacks --------------------------------
-(void) tappedRecordForTrack:(UIButton *)sender;
{
    if(museModel.recording) {
        NSLog(@">> Tapped Stop in track view");
        [self.viewController tappedStopForTrack:self.track];
    } else {
        NSLog(@">> Tapped Record in track view");
        [self.viewController tappedRecordForTrack:self.track];
    }
    [self updateUI];
}
//----------------------------------------------------
- (void)tappedDeleteForTrack:(UIButton *)sender
{
    NSLog(@">> Tapped delete in track view: %d", self.track.number);
    [self.viewController tappedDeleteForTrack:self.track];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
