//
//  Project.h
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Track.h"

@interface Project : NSObject

// -- Properties -------------------------------------
@property (weak, nonatomic) NSString    *name;
@property (nonatomic) int               number;
@property (nonatomic) int               numTracks;
@property (strong, nonatomic) NSMutableArray *tracks;
@property (weak, nonatomic) Track       *currentTrack;

// -- Methods ----------------------------------------
-(id) initWithNumber:(int)number;
-(Track *) createTrack;

@end
