//
//  VisitorsListController.m
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitorsListController.h"


@implementation VisitorsListController
@synthesize  visitorsList, visitorsNotSignedOut, visitorTableView;
@synthesize  staffList, staffTableView, staffNotSignedOut, authTableView, authNotSignedOut;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //change bg image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundTile.png"]];
    
    // vis clear bg and black lines
    self.visitorTableView.backgroundColor = [UIColor clearColor];
    self.visitorTableView.separatorColor = [UIColor blackColor];
    
    // staff clear bg & black lines
    self.staffTableView.backgroundColor = [UIColor clearColor];
    self.staffTableView.separatorColor = [UIColor blackColor];
    
    // staff clear bg & black lines
    self.authTableView.backgroundColor = [UIColor clearColor];
    self.authTableView.separatorColor = [UIColor blackColor];
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"visitorsList" ofType:@"plist"];
    
    self.visitorsList = [NSArray arrayWithContentsOfFile:plistPath];
    self.visitorsNotSignedOut = [[NSMutableArray alloc] init];
    
    // create tmp files for visitors in
    for (NSDictionary *tmpVisitor in self.visitorsList){
        if ([[tmpVisitor objectForKey:@"SignedIn"] boolValue] == YES) {
            if ([[tmpVisitor objectForKey:@"Departed"] boolValue] == NO) {
                //Current visitor is signed in and not yet departed
                NSString *tmpName = [tmpVisitor objectForKey:@"Name"];
                NSString *tmpCompamy = [tmpVisitor objectForKey:@"Company"];
                NSDictionary *tmpDict = [[NSDictionary alloc] initWithObjectsAndKeys:tmpName, @"Name",tmpCompamy, @"Company",nil];
                [self.visitorsNotSignedOut addObject:tmpDict];
                [tmpDict release];
            }
        }
    }
        
    NSLog([NSString stringWithFormat:@"Not yet departed: %i", [self.visitorsNotSignedOut count]]);
    
    NSString* staffplistPath = [[NSBundle mainBundle] pathForResource:@"staffList" ofType:@"plist"];
    
    self.staffList = [NSArray arrayWithContentsOfFile:staffplistPath];
    self.staffNotSignedOut = [[NSMutableArray alloc] init];
    self.authNotSignedOut = [[NSMutableArray alloc] init ];
                              
    //create staff tmp
    for(NSDictionary *tmpStaff in self.staffList){
        if ([[tmpStaff objectForKey:@"Status"] isEqualToString:@"In"]){
            if ([[tmpStaff objectForKey:@"Staff"] boolValue] == YES) {
                //current staff signed in 
                NSString *tmpStaffName = [NSString stringWithFormat:@"%@ %@", [tmpStaff objectForKey:@"FirstName"], [tmpStaff objectForKey:@"Surname"]];
                
                NSString *tmpJob = [tmpStaff objectForKey:@"JobDescription"];
                
                NSDictionary *tmpStaffdict = [[NSDictionary alloc] initWithObjectsAndKeys:tmpStaffName,@"staffName", tmpJob, @"job", nil];
                [self.staffNotSignedOut addObject:tmpStaffdict];
                [tmpStaffdict release];
            }
            else
            {
                //current auth vis signed in 
                NSString *tmpAuthName = [NSString stringWithFormat:@"%@ %@", [tmpStaff objectForKey:@"FirstName"], [tmpStaff objectForKey:@"Surname"]];
                
                NSString *tmpAuthJob = [tmpStaff objectForKey:@"JobDescription"];
                
                NSDictionary *tmpAuthdict = [[NSDictionary alloc] initWithObjectsAndKeys:tmpAuthName,@"authName", tmpAuthJob, @"authJob", nil];
                [self.authNotSignedOut addObject:tmpAuthdict];
                [tmpAuthdict release];
            }
        }
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (tableView == self.visitorTableView) {
        return [self.visitorsNotSignedOut count];
    }
    else if (tableView == self.authTableView)
    {
        return [self.authNotSignedOut count];  
    }
    else {
        return [self.staffNotSignedOut count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    NSInteger rowNum = indexPath.row;
    
    if(tableView == self.visitorTableView)
    {
      NSDictionary *rowData = [ self.visitorsNotSignedOut objectAtIndex:rowNum];
    
      cell.textLabel.text = [rowData objectForKey:@"Name"];
      cell.detailTextLabel.text = [rowData objectForKey:@"Company"];
    }
    else if (tableView == self.authTableView)
    {
        NSDictionary *rowData = [ self.authNotSignedOut objectAtIndex:rowNum];
        
        cell.textLabel.text = [rowData objectForKey:@"authName"];
        cell.detailTextLabel.text = [rowData objectForKey:@"authJob"];
    }
    else
    {
        NSDictionary *rowData = [ self.staffNotSignedOut objectAtIndex:rowNum];
        
        cell.textLabel.text = [rowData objectForKey:@"staffName"];
        cell.detailTextLabel.text = [rowData objectForKey:@"job"];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated: NO];
    
    // add checkboxes
    if(tableView == visitorTableView)
    {
        UITableViewCell *tmpCell = [visitorTableView cellForRowAtIndexPath:indexPath];
        if(tmpCell.accessoryType == UITableViewCellAccessoryNone){
          tmpCell.accessoryType = UITableViewCellAccessoryCheckmark;  
            
        }
        else
        {
            tmpCell.accessoryType = UITableViewCellAccessoryNone;
        }
    
    }
}

@end
