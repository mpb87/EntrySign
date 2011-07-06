//
//  AdminController.h
//  EntrySign
//
//  Created by mathew booth on 05/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AdminController : UISplitViewController <UISplitViewControllerDelegate>{
    UIToolbar* toolBar;
    UIViewController* detailController;
}
@property (nonatomic, retain) UIToolbar* toolBar;
@property ( nonatomic, retain) UIViewController* detailController;

@end
