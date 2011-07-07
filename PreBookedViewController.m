//
//  PreBookedViewController.m
//  EntrySign
//
//  Created by mathew booth on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PreBookedViewController.h"
#import "EntrySignViewController.h"
#import "VisitorInfoViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation PreBookedViewController
@synthesize preBookedTableView,prebookedList;

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


-(IBAction) showVisitorInfo{
    
    VisitorInfoViewController *visitorInfoController = [[VisitorInfoViewController alloc] initWithNibName:@"VisitorInfoViewController" bundle:[NSBundle mainBundle]];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = visitorInfoController;
    [visitorInfoController release];
    
    //animation
    CATransition *animationVisitorInfo = [CATransition animation];
    [animationVisitorInfo setDuration:0.5];
    [animationVisitorInfo setType:kCATransitionPush];
    [animationVisitorInfo setSubtype:kCATransitionFromBottom];
    [animationVisitorInfo setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[window layer] addAnimation:animationVisitorInfo forKey:@"VisitorInfoAnimation"];
    
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

- (void) refreshData
{
    NSArray *pathsW = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryW = [pathsW objectAtIndex:0];
    NSString *plistPath;
    plistPath = [documentsDirectoryW stringByAppendingPathComponent:@"PreBookedList.plist"];
    
    NSArray *tmpList = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *tmpItems = [[NSMutableArray alloc] init];
    
    for (NSDictionary *tmpItem in tmpList) {
        NSDate * today = [NSDate date];
        NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"] autorelease];
        
        NSString *prebookedDate = [[[tmpItem objectForKey:@"prebookedDate"] descriptionWithLocale:usLocale] substringToIndex:10];
        NSString *todayString = [[today descriptionWithLocale:usLocale] substringToIndex:10];

        
        if([prebookedDate isEqualToString:todayString])
        {
            [tmpItems addObject:tmpItem]; 
        }
    }
    
    self.prebookedList = tmpItems;
 
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
    
    [self refreshData];
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
	//return UIInterfaceOrientationIsLandscape(interfaceOrientation);
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
    
    return [self.prebookedList count];
    
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
    
    NSDictionary *rowData = [self.prebookedList objectAtIndex:rowNum];
    
        cell.textLabel.text = [rowData objectForKey:@"Name"];
        cell.detailTextLabel.text = [rowData objectForKey:@"Visiting"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger rowNum = indexPath.row;
    
    NSDictionary *rowData = [self.prebookedList objectAtIndex:rowNum];
    

    //move to visitor info screen
    VisitorInfoViewController *visitorInfoController = [[VisitorInfoViewController alloc] initWithNibName:@"VisitorInfoViewController" bundle:[NSBundle mainBundle]];
    
    // pass variables across to next screen
    visitorInfoController.pName = [rowData objectForKey:@"Name"];
    visitorInfoController.pCompany = [rowData objectForKey:@"Company"];
    visitorInfoController.pReg = [rowData objectForKey:@"Reg"];
    visitorInfoController.pVisiting = [rowData objectForKey:@"Visiting"];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = visitorInfoController;
    [visitorInfoController release];
    
    //animation
    CATransition *animationVisitorInfo = [CATransition animation];
    [animationVisitorInfo setDuration:0.5];
    [animationVisitorInfo setType:kCATransitionPush];
    [animationVisitorInfo setSubtype:kCATransitionFromBottom];
    [animationVisitorInfo setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[window layer] addAnimation:animationVisitorInfo forKey:@"VisitorInfoAnimation"];
    
    [self removeRecord:rowNum];
    
}


- (void) removeRecord:(int)removeIndex {
    NSArray *pathsW = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryW = [pathsW objectAtIndex:0];
    NSString *plistPath;
    plistPath = [documentsDirectoryW stringByAppendingPathComponent:@"PreBookedList.plist"];
    
    NSLog(@"%@",plistPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray * appendArray;
    NSMutableArray *currentList;
    
    if ( [fileManager fileExistsAtPath:plistPath] == NO)
    {
        
    }
    else
    {
      currentList = [NSMutableArray arrayWithContentsOfFile:plistPath];
      [currentList removeObjectAtIndex:removeIndex];
      appendArray = currentList;
    }

    id plist = appendArray;
    NSData *xmlData;
    NSString * error;
    xmlData = [NSPropertyListSerialization dataFromPropertyList:plist format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    if(xmlData){
        if([xmlData writeToFile:plistPath atomically:YES]){
            NSLog(@"SUCCESS");
        }else{
            NSLog(@"FAIL");
        }
    }
}
@end
