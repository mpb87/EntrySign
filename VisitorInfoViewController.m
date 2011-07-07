//
//  VisitorInfoViewController.m
//  EntrySign
//
//  Created by mathew booth on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitorInfoViewController.h"
#import "EntrySignViewController.h"
#import "SignatureViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation VisitorInfoViewController

@synthesize visitorCompany, visitorName, visitorReg, visitorVisiting;
@synthesize pName,pReg,pCompany,pVisiting;


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

-(IBAction) showThankyou{

        NSArray *pathsW = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryW = [pathsW objectAtIndex:0];
        NSString *plistPath;
        plistPath = [documentsDirectoryW stringByAppendingPathComponent:@"VisitorsList.plist"];
        
        NSLog(@"%@",plistPath);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSArray * appendArray;
        NSMutableArray *currentList;
        
        if ( [fileManager fileExistsAtPath:plistPath] == NO)
        {
            //Add files to dict
            NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:visitorName.text,@"Name", visitorCompany.text,@"Company",visitorVisiting.text,@"Visiting",visitorReg.text,@"Reg",[NSDate date],@"SignedIn", nil];
            currentList = [NSMutableArray arrayWithObject:tmpDict];
            appendArray = currentList;
            [tmpDict release];
            
        }else
        {
            if ( isEditing){
                currentList = [NSMutableArray arrayWithContentsOfFile:plistPath];
               NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:visitorName.text,@"Name", visitorCompany.text,@"Company",visitorVisiting.text,@"Visiting",visitorReg.text,@"Reg",[NSDate date],@"SignedIn", nil];
                [currentList replaceObjectAtIndex:editIndex withObject:tmpDict];
                appendArray = currentList;
                [tmpDict release];
                isEditing = NO;
            }else
            {
                currentList = [NSMutableArray arrayWithContentsOfFile:plistPath];
                 NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:visitorName.text,@"Name", visitorCompany.text,@"Company",visitorVisiting.text,@"Visiting",visitorReg.text,@"Reg",[NSDate date],@"SignedIn", nil];
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
                
                SignatureViewController *signatureController = [[SignatureViewController alloc] initWithNibName:@"SignatureViewController" bundle:[NSBundle mainBundle]];
                
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = signatureController;
                [signatureController release];
                
                
                //animation
                CATransition *animationSignature = [CATransition animation];
                [animationSignature setDuration:0.5];
                [animationSignature setType:kCATransitionPush];
                [animationSignature setSubtype:kCATransitionFromBottom];
                [animationSignature setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                
                [[window layer] addAnimation:animationSignature forKey:@"SignatureAnimation"];
            }else{
                NSLog(@"FAIL");
            }
        }
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
    
    
    if (![pName isEqualToString:@""]) {
        visitorName.text = pName;
    }
    if (![pCompany isEqualToString:@""])
    {
        visitorCompany.text = pCompany;
    }
    if (![pReg isEqualToString:@""]){
        visitorReg.text = pReg;
    }
    if(![pVisiting isEqualToString:@""]){
        visitorVisiting.text = pVisiting;
    }
     
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
    //return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
