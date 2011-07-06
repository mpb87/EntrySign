//
//  AdminController.m
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdminController.h"


@implementation AdminController
@synthesize toolBar, detailController;

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

// the Master view controller will be hidden
- (void) splitViewController:(UISplitViewController *)svc popoverController:(UIPopoverController *)pc willPresentViewController:(UIViewController *)aViewController {
    
    //empty for now
    
}

-(void) splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    
    if(toolBar == nil){
        //set title of master button
        barButtonItem.title = @"Sections";
    
        //create a toolbar
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [toolBar setItems:[NSArray arrayWithObject:barButtonItem] animated:YES];
    }
    
    //add the toolbar to the details view
    [detailController.view addSubview:toolBar];
    
}
//the master view will be shown again
- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    
    //remove the toolbar
    //[toolBar removeFromSuperview];
    
}


#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    detailController = [self.viewControllers objectAtIndex:1];
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
    detailController = [self.viewControllers objectAtIndex:1];
	return YES;
}

@end
