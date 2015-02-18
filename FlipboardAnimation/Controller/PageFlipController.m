//
//  PageFlipController.m
//  MBO
//
//  Created by Waheeda on 2/10/15.
//  Copyright (c) 2015 mohsin. All rights reserved.
//

#import "PageFlipController.h"


@interface PageFlipController ()

@end

@implementation PageFlipController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    _controllers = @[[[LoginController alloc] init], [[RegistrationController alloc] init], [[LoginController alloc] init]];
    _selectedControllerIndex = 0;

    [self addFlipViewController];
    
    
}


-(void) addFlipViewController
{
    self.flipViewController = [[MPFlipViewController alloc] initWithOrientation:MPFlipViewControllerOrientationVertical];
    self.flipViewController.delegate = self;
    self.flipViewController.dataSource = self;


self.flipViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.flipViewController.view.frame = self.view.bounds;
    [self addChildViewController:self.flipViewController];
    [self.view addSubview:self.flipViewController.view];
    [self.flipViewController didMoveToParentViewController:self];



    [self.flipViewController setViewController:[self getContentView] direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
}

#pragma MP_FLIP_VIEW_CONTROLLER_DATA_SOURCE_METHODS

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerBeforeViewController:(UIViewController *)viewController // get previous page, or nil for none
{
int index = (int)[_controllers indexOfObject:viewController];

    if(index == 0)
        return nil;

    _selectedControllerIndex  = index -1 ;
    return [self getContentView];
}

    
- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerAfterViewController:(UIViewController *)viewController // get next page, or nil for none
{


    int index = (int)[_controllers indexOfObject:viewController];


    if(index == self.getLastControllerIndex)
        return nil;

    _selectedControllerIndex = index + 1;

     return [self getContentView];
}


-(int) getLastControllerIndex
{
    return (int)(_controllers.count - 1);
}


-(UIViewController *) getContentView
{
//if(_loginController == nil)
  //  _loginController = [[LoginController alloc] init];
    return _controllers[_selectedControllerIndex];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    if (parent)
        NSLog(@"willMoveToParentViewController");
    else
        NSLog(@"willRemoveFromParentViewController");
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    if (parent)
        NSLog(@"didMoveToParentViewController");
    else
        NSLog(@"didRemoveFromParentViewController");
}



@end
