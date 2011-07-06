//
//  PrebookedController.h
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PrebookedController : UIViewController {
    IBOutlet UITextField *pName;
    IBOutlet UITextField *pCompany;
    IBOutlet UITextField *pVisiting;
    IBOutlet UITextField *pDate;
    IBOutlet UITextField *pReg;
    
    IBOutlet UITableView *preBookedTableView;
    NSMutableArray *prebookedList;
    bool isEditing;
    int editIndex;
    UIPopoverController *currentPopover;
    UIDatePicker *datePicker;
    NSDate *selectedDate;
    
}

@property (nonatomic, retain) IBOutlet UITextField *pName;
@property (nonatomic, retain) IBOutlet UITextField *pCompany;
@property (nonatomic, retain) IBOutlet UITextField *pVisiting;
@property (nonatomic, retain) IBOutlet UITextField *pDate;
@property (nonatomic, retain) IBOutlet UITextField *pReg;

@property (nonatomic, retain) IBOutlet UITableView *preBookedTableView;
@property (nonatomic, retain) NSMutableArray *prebookedList;
@property (nonatomic, retain) UIPopoverController *currentPopover;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDate *selectedDate;

- (void)getDateSelection;
- (IBAction)selectDate;
- (IBAction) savePreBooked;
- (void) refreshData;

@end
