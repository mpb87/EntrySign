//
//  EntrySignViewController.h
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntrySignViewController : UIViewController {
    IBOutlet UILabel *schoolName;
    IBOutlet UILabel *schoolAddress;
    IBOutlet UITextField *adminPwd;
    IBOutlet UIButton *visitorButton;
    IBOutlet UIButton *adminBtn;
    
}

@property (nonatomic, retain) IBOutlet UILabel *schoolName;
@property ( nonatomic, retain) IBOutlet UILabel *schoolAddress;
@property (nonatomic, retain) IBOutlet UITextField *adminPwd;
@property (nonatomic, retain) IBOutlet UIButton *visitorButton;
@property (nonatomic, retain) IBOutlet UIButton *adminBtn;

-(IBAction) showAdmin;
-(IBAction) showPolicy;
- (void)startAdmin;

@end
