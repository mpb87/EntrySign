//
//  EntrySignViewController.m
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EntrySignViewController.h"
#import "MasterViewController.h"
#import "DetailsViewController.h"
#import "AdminController.h"
#import <QuartzCore/QuartzCore.h>
#import "PolicyViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

@implementation EntrySignViewController
@synthesize  schoolAddress, schoolName, adminPwd,visitorButton, adminBtn;

- (void)dealloc
{
    [super dealloc];
}


- ( IBAction) showAdmin{
    if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"adminPassword" ] isEqualToString:adminPwd.text]){
        
        [self startAdmin];
    
    }

}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    schoolName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"schoolName"];
    schoolAddress.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"schoolAddress"];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"backgroundColor"] isEqualToString:@"red"]){
        self.view.backgroundColor = [UIColor redColor];
    } 
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"backgroundColor"] isEqualToString:@"green"]){
        self.view.backgroundColor = [UIColor greenColor];
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"backgroundColor"] isEqualToString:@"blue"]){
        self.view.backgroundColor = [UIColor blueColor];
    }
    
    
    self.view.backgroundColor = UIColorFromRGB(0xEE9A49);
    
    UIImage *whiteButtonimage = [UIImage imageNamed:@"WhiteButton.png"];
    UIImage * stretchableWhiteButton = [whiteButtonimage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [visitorButton setBackgroundImage:stretchableWhiteButton forState:UIControlStateNormal];
    
}


- (void)startAdmin {
    MasterViewController *masterView = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:[NSBundle mainBundle]];
    DetailsViewController *detailsView = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:[NSBundle mainBundle]];
    
    AdminController *splitController = [[AdminController alloc] init];
    splitController.delegate = splitController;
    
    splitController.viewControllers = [NSArray arrayWithObjects:masterView, detailsView, nil];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = splitController;
    [splitController release];
    
    //animation
    CATransition *animation2 = [CATransition animation];
    [animation2 setDuration:0.5];
    [animation2 setType:kCATransitionPush];
    [animation2 setSubtype:kCATransitionFromRight];
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[window layer] addAnimation:animation2 forKey:@"adminAnimation"];

    
}

-(IBAction) showPolicy{
    
    
    
    PolicyViewController *policyController = [[PolicyViewController alloc] initWithNibName:@"PolicyViewController" bundle:[NSBundle mainBundle]];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = policyController;
    [policyController release];

    
    //animation
    CATransition *animationPolicy = [CATransition animation];
    [animationPolicy setDuration:0.5];
    [animationPolicy setType:kCATransitionPush];
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft) {
        [animationPolicy setSubtype:kCATransitionFromRight];
    } else if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight) {
        [animationPolicy setSubtype:kCATransitionFromLeft];
    }
    else if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait){
        [animationPolicy setSubtype:kCATransitionFromLeft];
    }
    else
    {
        [animationPolicy setSubtype:kCATransitionFromBottom];
    }
    
    [animationPolicy setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[window layer] addAnimation:animationPolicy forKey:@"policyAnimation"];
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
    //return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
