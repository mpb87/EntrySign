//
//  DetailsViewController.h
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailsViewController : UIViewController {
   IBOutlet UITextField *schoolName;
   IBOutlet UITextField *schoolAddress;
   IBOutlet UITextField *adminPassword;
   IBOutlet UITextField *visitorPolicy;
   
   IBOutlet UIButton *red;
   IBOutlet UIButton *green;
   IBOutlet UIButton *blue;
}

@property (nonatomic, retain) IBOutlet UITextField *schoolName;
@property (nonatomic,retain) IBOutlet UITextField *schoolAddress;
@property (nonatomic, retain) IBOutlet UITextField *adminPassword;
@property (nonatomic, retain) IBOutlet UITextField *visitorPolicy;

@property ( nonatomic, retain) IBOutlet UIButton *red;
@property ( nonatomic, retain) IBOutlet UIButton *green;
@property ( nonatomic, retain) IBOutlet UIButton *blue;

- (IBAction) Red;
- (IBAction) Green;
- (IBAction) Blue;

- (IBAction) Save;

- (void)setButtonHighlights;

@end
