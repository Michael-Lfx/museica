//
//  MuseicaModel.h
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface MuseicaModel : NSObject

// -- Properties -------------------------------------
@property (strong, atomic)      NSMutableArray  *projects;
@property (strong, nonatomic)   Project         *currentProject;


// -- Methods ----------------------------------------
+ (MuseicaModel *)  sharedInstance;
- (Project *)       createProject;

@end
