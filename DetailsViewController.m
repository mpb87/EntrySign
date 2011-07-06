//
//  DetailsViewController.m
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailsViewController.h"
#import "EntrySignViewController.h"

@implementation DetailsViewController
@synthesize schoolName, schoolAddress, adminPassword, visitorPolicy,red, green, blue;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) Red{
    
    [[NSUserDefaults standardUserDefaults] setValue:@"red" forKey:@"backgroundColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self setButtonHighlights];
    
}

- (IBAction) Green{
    [[NSUserDefaults standardUserDefaults] setValue:@"green" forKey:@"backgroundColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self setButtonHighlights];
}


- (IBAction) Blue {
    [[NSUserDefaults standardUserDefaults] setValue:@"blue" forKey:@"backgroundColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self setButtonHighlights];
}

- (IBAction) Save{
    [[NSUserDefaults standardUserDefaults] setValue:schoolName.text forKey:@"schoolName"];
    [[NSUserDefaults standardUserDefaults] setValue:schoolAddress.text forKey:@"schoolAddress"];
    [[NSUserDefaults standardUserDefaults] setValue:adminPassword.text forKey:@"adminPassword"];
    [[NSUserDefaults standardUserDefaults] setValue:visitorPolicy.text forKey:@"visitorPolicy"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    EntrySignViewController *entrySign = [[EntrySignViewController alloc] initWithNibName:@"EntrySignViewController" bundle:[NSBundle mainBundle]];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = entrySign;
    [entrySign release];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    schoolName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"schoolName"];
    schoolAddress.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"schoolAddress"];
    adminPassword.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"adminPassword"];
    visitorPolicy.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"visitorPolicy"];
    
    [self setButtonHighlights];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundTile.png"]];
}

- (void)setButtonHighlights {
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"backgroundColor"] isEqualToString:@"red"]){
        red.highlighted  = YES;
        green.highlighted = NO;
    } 
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"backgroundColor"] isEqualToString:@"green"]){
        green.highlighted = YES;
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"backgroundColor"] isEqualToString:@"blue"]){
        blue.highlighted = YES;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
