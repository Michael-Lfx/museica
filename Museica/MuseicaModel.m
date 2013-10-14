//
//  MuseicaModel.m
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import "MuseicaModel.h"

@interface MuseicaModel()

@property (nonatomic) int   projectCounter;

@end


@implementation MuseicaModel

// Synthesis
@synthesize projects        = _projects;
@synthesize projectCounter  = _projectCounter;

// ---------------------------------------------------
- (id)init{
    if ((self = [super init])) {
        // Read projectCounter from storage. If first run, init to 0.
        self.projectCounter = 0;
        self.projects = [[NSMutableArray alloc] init];
    }
    return self;
}

// ---------------------------------------------------
+ (MuseicaModel *) sharedInstance {
    static MuseicaModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MuseicaModel alloc] init];
    });
    return sharedInstance;
}

//----------------------------------------------------
- (Project *) createProject {
    Project *project = self.currentProject = [[Project alloc]  initWithNumber:self.projectCounter++];
    [self.projects addObject:project];
    return project;
}

@end
