//
//  ProjectViewController.h
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MuseicaModel.h"
#import "Project.h"

@interface ProjectViewController : UIViewController

@property (strong, nonatomic) MuseicaModel  *museModel;
@property (strong, nonatomic) Project       *currentProject;


@end