//
//  VisitorsListController.h
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VisitorsListController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *visitorsList;
    NSMutableArray *visitorsNotSignedOut;
    IBOutlet UITableView *visitorTableView;
    
    NSArray *staffList;
    NSMutableArray *staffNotSignedOut;
    IBOutlet UITableView *staffTableView;
    
    NSMutableArray *authNotSignedOut;
    IBOutlet UITableView *authTableView;
}

@property ( nonatomic, retain) NSArray *visitorsList;
@property ( nonatomic, retain) NSMutableArray *visitorsNotSignedOut;
@property ( nonatomic, retain )IBOutlet UITableView *visitorTableView;

@property ( nonatomic, retain) NSArray *staffList;
@property ( nonatomic, retain) NSMutableArray *staffNotSignedOut;
@property ( nonatomic, retain )IBOutlet UITableView *staffTableView;

@property ( nonatomic, retain) NSMutableArray *authNotSignedOut;
@property ( nonatomic, retain )IBOutlet UITableView *authTableView;

@end
