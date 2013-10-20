//
//  TrackRow.h
//  Museica
//
//  Created by Andre on 10/16/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Track.h"
#import "MuseicaModel.h"
@class ProjectViewController;

@interface TrackRow : UIView

@property (strong, nonatomic) Track *track;
@property (weak, nonatomic) ProjectViewController   *viewController;
@property (strong, nonatomic) UIButton  *recordButton;
@property (strong, nonatomic) UIButton  *deleteButton;
@property (strong, nonatomic) UILabel   *timeLabel;


//--------------------------------------------------
//- (id)initWithFrame:(CGRect)frame andController:(ProjectViewController*)vc;
- (id)initWithFrame:(CGRect)frame andController:(ProjectViewController*)vc andTrack:(Track *)track;
-(IBAction) tappedRecordForTrack:(UIButton *)sender;

@end
