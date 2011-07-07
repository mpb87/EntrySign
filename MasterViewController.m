//
//  MasterViewController.m
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "VisitorsListController.h"
#import "DetailsViewController.h"
#import "PrebookedController.h"
#import "EntrySignViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation MasterViewController
@synthesize options;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSDictionary *dict1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Settings",@"mainBtns",@"157-wrench.png",@"Image", nil];
    NSDictionary *dict2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Visitors",@"mainBtns",@"111-user.png",@"Image", nil];
    NSDictionary *dict3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Staff & Auth visitors",@"mainBtns",@"112-group.png",@"Image", nil];
    NSDictionary *dict4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Pupils",@"mainBtns",@"1309868733_user6.png",@"Image", nil];
    NSDictionary *dict5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Evacuation List",@"mainBtns",@"63-runner.png",@"Image", nil];
    NSDictionary *dict6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Prebooked Visitors",@"mainBtns",@"111-user.png",@"Image", nil];
    NSDictionary *dict7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Main Menu",@"mainBtns",@"53-house.png",@"Image", nil];
    
    self.options = [[NSArray alloc] initWithObjects:dict1, dict2,dict6, dict3,dict4, dict5,dict7 ,nil];
    
    //change bg colour of list
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor lightGrayColor];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    NSInteger rowNum = indexPath.row;
    
    NSDictionary *rowData = [ self.options objectAtIndex:rowNum];
    
    
    cell.textLabel.text = [rowData objectForKey:@"mainBtns"];
    
   // cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Qty: %@", [rowData objectForKey:@"Type"], [[rowData objectForKey:@"Qty"] stringValue]];
    cell.imageView.image = [UIImage imageNamed:[rowData objectForKey: @"Image"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if ( indexPath.row == 5)
        {
            VisitorsListController *visitorsList = [[VisitorsListController alloc] initWithNibName:@"VisitorsListController" bundle:[NSBundle mainBundle]];
        
            NSArray *newControllers = [NSArray arrayWithObjects:self,visitorsList, nil];
           self.splitViewController.viewControllers = newControllers;
        
           [visitorsList release];
         }
        else if(indexPath.row == 0) {
            DetailsViewController *detailView = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:[NSBundle mainBundle]];
            
           NSArray *newControllers = [NSArray arrayWithObjects:self,detailView, nil];
            self.splitViewController.viewControllers = newControllers;
            
            [detailView release];
        }
        else if (indexPath.row == 2)
        {
            PrebookedController *preBooked = [[PrebookedController alloc] initWithNibName:@"PrebookedController" bundle:[NSBundle mainBundle]];
            
            NSArray *newControllers = [NSArray arrayWithObjects:self,preBooked, nil];
            self.splitViewController.viewControllers = newControllers;
            
            [preBooked release];
        }
    else if (indexPath.row == 6)
    {
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
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
