//
//  VisitorInfoViewController.h
//  EntrySign
//
//  Created by mathew booth on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VisitorInfoViewController : UIViewController {
    IBOutlet UITextField *visitorName;
    IBOutlet UITextField *visitorCompany;
    IBOutlet UITextField *visitorVisiting;    
    IBOutlet UITextField *visitorReg;
    
    NSString *pName;
    NSString *pCompany;
    NSString *pVisiting;
    NSString *pReg;
    
    bool isEditing;
    int editIndex;
    
}

@property (nonatomic, retain) IBOutlet UITextField *visitorName;
@property (nonatomic, retain) IBOutlet UITextField *visitorCompany;
@property (nonatomic, retain) IBOutlet UITextField *visitorVisiting;
@property (nonatomic, retain) IBOutlet UITextField *visitorReg;

@property (nonatomic, retain) NSString *pName;
@property (nonatomic, retain) NSString *pCompany;
@property (nonatomic, retain) NSString *pVisiting;
@property (nonatomic, retain) NSString *pReg;

-(IBAction) showThankyou;
-(IBAction) showMainpage;

@end
