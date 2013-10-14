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

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;
{
    return UIInterfaceOrientationLandscapeLeft;
}

// TODO
//- (NSUInteger)supportedInterfaceOrientations;
//{
//    return UIInterfaceOrientationMaskLandscape;
//}
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
    NSLog(@"Project view controller view loaded.");
    // Load the app model
    self.museModel = [MuseicaModel sharedInstance];
    // HACK
    self.currentProject = [self.museModel createProject];
}
//----------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"!> DID RECEIVE MEMORY WARNING!!!");
}


#pragma mark UI Interaction

- (IBAction)tappedRecord:(UIButton*)sender {
    if ([sender.titleLabel.text isEqualToString:@"Record"]) {
        NSLog(@">> Tapped Record.");
        [self.recordButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.label setText:@"Recording"];
    } else {
        NSLog(@">> Tapped Stop.");
        [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
        [self.label setText:@"Doing Nothing"];
    }
}
//----------------------------------------------------
- (IBAction)tappedPlay:(UIButton*)sender {
    [self.label setText:@"Playing"];
}

#pragma mark NEXT STUFF



@end
