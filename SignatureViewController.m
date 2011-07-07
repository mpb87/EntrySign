//
//  SignatureViewController.m
//  EntrySign
//
//  Created by mathew booth on 07/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SignatureViewController.h"


@implementation SignatureViewController
@synthesize  drawImage;


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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    
    if([touch tapCount] == 3)
    {
        drawImage.image = nil;
        return;
    }
    
    lastPoint = [touch locationInView:drawImage];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    mouseSwiped = YES;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:drawImage];
    currentPoint.y -= 5; // only if goes off screen
    
    UIGraphicsBeginImageContext(drawImage.frame.size);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    [drawImage.image drawInRect:CGRectMake(0, 0,drawImage.frame.size.width, drawImage.frame.size.height)];
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineWidth(currentContext, 2.0);
    CGContextSetRGBStrokeColor(currentContext, 0.0,0.0,0.0,1.0);
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(currentContext, currentPoint.x, currentPoint.y);
    CGContextStrokePath(currentContext);
    drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    if ([touch tapCount] == 3)
        {
            drawImage.image = nil;
            return;
        }
    if(!mouseSwiped){
        UIGraphicsBeginImageContext(drawImage.frame.size);
        
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        [drawImage.image drawInRect:CGRectMake(0, 0,drawImage.frame.size.width, drawImage.frame.size.height)];
        CGContextSetLineCap(currentContext, kCGLineCapRound);
        CGContextSetLineWidth(currentContext, 3.0);
        CGContextSetRGBStrokeColor(currentContext, 1.0,1.0,2.0,2.0);
        CGContextBeginPath(currentContext);
        CGContextMoveToPoint(currentContext, lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(currentContext, lastPoint.x, lastPoint.y);
        CGContextStrokePath(currentContext);
        drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    drawImage = [[UIImageView alloc] initWithFrame:CGRectMake(220,20,480,350)];
    
    drawImage .backgroundColor = [UIColor blueColor];
    [self.view addSubview:drawImage];
}

// check orientation and change size accordingly
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // checls orientations
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        drawImage.frame = CGRectMake(400, 20, 80, 600);
    } else {
        drawImage.frame = CGRectMake(220,20,480,380);
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
}

@end
