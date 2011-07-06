//
//  PreBookedViewController.h
//  EntrySign
//
//  Created by mathew booth on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PreBookedViewController : UIViewController {
    IBOutlet UITableView *preBookedTableView;
    NSMutableArray *prebookedList;
    bool isEditing;
    int editIndex;
    
}

@property (nonatomic, retain) IBOutlet UITableView *preBookedTableView;
@property (nonatomic, retain) NSMutableArray *prebookedList;

-(IBAction) showVisitorInfo;
-(IBAction) showMainpage;
- (void) removeRecord:(int)removeIndex;
@end
