//
//  PolicyViewController.m
//  EntrySign
//
//  Created by mathew booth on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PolicyViewController.h"
#import "PreBookedViewController.h"
#import "EntrySignViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation PolicyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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


-(IBAction) showPrebooked{
    PreBookedViewController *prebookedController = [[PreBookedViewController alloc] initWithNibName:@"PreBookedViewController" bundle:[NSBundle mainBundle]];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = prebookedController;
    [prebookedController release];
    
    
    //animation
    CATransition *animationPrebooked = [CATransition animation];
    [animationPrebooked setDuration:0.5];
    [animationPrebooked setType:kCATransitionPush];
    [animationPrebooked setSubtype:kCATransitionFromBottom];
    [animationPrebooked setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[window layer] addAnimation:animationPrebooked forKey:@"prebookedAnimation"];
    
}

-(IBAction) showMainpage{
    EntrySignViewController *homeController = [[EntrySignViewController alloc] initWithNibName:@"EntrySignViewController" bundle:[NSBundle mainBundle]];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = homeController;
    [homeController release];
    
    
    //animation
    CATransition *animationHome = [CATransition animation];
    [animationHome setDuration:0.5];
    [animationHome setType:kCATransitionPush];
    [animationHome setSubtype:kCATransitionFromLeft];
    [animationHome setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[window layer] addAnimation:animationHome forKey:@"homeAnimation"];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set bg colour
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"backgroundColor"] isEqualToString:@"red"]){
        self.view.backgroundColor = [UIColor redColor];
    } 
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"backgroundColor"] isEqualToString:@"green"]){
        self.view.backgroundColor = [UIColor greenColor];
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"backgroundColor"] isEqualToString:@"blue"]){
        self.view.backgroundColor = [UIColor blueColor];
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
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
