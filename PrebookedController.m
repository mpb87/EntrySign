//
//  PrebookedController.m
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrebookedController.h"
#import "EntrySignViewController.h"


@implementation PrebookedController
@synthesize  pReg, pName, pCompany, pVisiting, pDate, preBookedTableView, prebookedList;
@synthesize parentViewController,datePicker;
@synthesize currentPopover, selectedDate;

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

- (IBAction) savePreBooked{
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
        //Add files to dict    
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:pName.text,@"Name", pCompany.text,@"Company",pVisiting.text,@"Visiting",pReg.text,@"Reg", selectedDate, @"prebookedDate", nil];
        currentList = [NSMutableArray arrayWithObject:tmpDict];
        appendArray = currentList;
        [tmpDict release];
        
    }else
    {
        if ( isEditing){
            currentList = [NSMutableArray arrayWithContentsOfFile:plistPath];
            NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:pName.text,@"Name", pCompany.text,@"Company",pVisiting.text,@"Visiting",pReg.text,@"Reg", selectedDate, @"prebookedDate", nil];
            [currentList replaceObjectAtIndex:editIndex withObject:tmpDict];
            appendArray = currentList;
            [tmpDict release];
            isEditing = NO;
        }else
        {
            currentList = [NSMutableArray arrayWithContentsOfFile:plistPath];
            NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:pName.text,@"Name", pCompany.text,@"Company",pVisiting.text,@"Visiting",pReg.text,@"Reg", selectedDate, @"prebookedDate", nil];
            [currentList addObject:tmpDict];
            appendArray = currentList;
            [tmpDict release];
        }
        
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
    pName.text = @"";
    pCompany.text = @"";
    pVisiting.text = @"";
    pReg.text = @"";
    
    [ self refreshData];
    [preBookedTableView reloadData];
    
}



- (void)getDateSelection{
    
    NSDate *pickDate = [datePicker date];
    selectedDate = pickDate;
    
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"DD-MM-YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:pickDate];
    
    pDate.text = dateString;

}


- (IBAction)selectDate{
    CGRect pickerFrame = CGRectMake(0,0,300,216);
    
    UIViewController *tempDateViewController = [[UIViewController alloc] init ];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    [datePicker addTarget:self action:@selector(getDateSelection) forControlEvents:UIControlEventValueChanged];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"] autorelease];
    datePicker.locale = usLocale;
    
    [tempDateViewController.view addSubview:datePicker];
    if(!currentPopover)
    {
        currentPopover = [[UIPopoverController alloc] initWithContentViewController:tempDateViewController];
    }
    else
    {
        [currentPopover setContentViewController:tempDateViewController animated:YES];
    }
    
    currentPopover.popoverContentSize = CGSizeMake(300, 300);
    [datePicker release];
    [tempDateViewController release];
    [currentPopover presentPopoverFromRect:pDate.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //change bg image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundTile.png"]];
    
    // vis clear bg and black lines
    self.preBookedTableView.backgroundColor = [UIColor clearColor];
    self.preBookedTableView.separatorColor = [UIColor blackColor];
    
    
    isEditing = NO;
    [self refreshData];
    
}

- (void) refreshData
{
    NSArray *pathsW = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryW = [pathsW objectAtIndex:0];
    NSString *plistPath;
    plistPath = [documentsDirectoryW stringByAppendingPathComponent:@"PreBookedList.plist"];
    
    self.prebookedList = [NSArray arrayWithContentsOfFile:plistPath];
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
    
        NSDictionary *rowData = [ self.prebookedList objectAtIndex:rowNum];
        
        cell.textLabel.text = [rowData objectForKey:@"Name"];
        cell.detailTextLabel.text = [rowData objectForKey:@"Visiting"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger rowNum = indexPath.row;
    
    // populate text fields with existing data for editing
    NSDictionary *rowData = [self.prebookedList objectAtIndex:rowNum];
    pName.text = [rowData objectForKey:@"Name"];
    pCompany.text = [rowData objectForKey:@"Company"];
    pVisiting.text = [rowData objectForKey:@"Visiting"];
    pReg.text = [rowData objectForKey:@"Reg"];
    isEditing = TRUE;
    editIndex = rowNum;
}


@end
