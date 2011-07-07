//
//  SignatureViewController.h
//  EntrySign
//
//  Created by mathew booth on 07/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SignatureViewController : UIViewController {
    bool mouseSwiped;
    CGPoint lastPoint;
    UIImageView *drawimage;
}

@property (nonatomic, retain) UIImageView *drawImage;

@end
