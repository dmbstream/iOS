//
//  BaseViewController.m
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "ExpandedPlayerViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize managedObjectContext,
            scrollView,
            activeField,
            inputAccessoryView,
            inputAccessoryViewPrevious,
            inputAccessoryViewNext,
            inputAccessoryViewDone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigateToRootView) name:@"RootViewRequested" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigateToSearchView) name:@"SearchViewRequested" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showExpandedPlayerView) name:@"ShowExpandedPlayer" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(togglePlay) name:@"TogglePlay" object:nil];
    
    if (true) {
        LoginViewController *loginController = [[LoginViewController alloc] init];
        [self presentModalViewController:loginController animated:NO];
    }
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardDidShow:) 
                                                 name:UIKeyboardDidShowNotification 
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillHide:) 
                                                 name:UIKeyboardWillHideNotification 
                                               object:self.view.window];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSLog(@"keyboardDidShow");
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect rect = scrollView.frame;
    rect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(rect, activeField.frame.origin) ) {
        NSLog(@"Scrolling keyboard to field");
        CGPoint scrollPoint = CGPointMake(0.0, MAX(activeField.frame.origin.y-keyboardSize.height-15, 0));
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"keyboardWillHide");
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing");
    activeField = nil;
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    [[NSNotificationCenter defaultCenter] removeObserver:self];

    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIKeyboardWillShowNotification 
                                                  object:nil]; 
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIKeyboardWillHideNotification 
                                                  object:nil];  

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIKeyboardWillShowNotification 
                                                  object:nil]; 
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIKeyboardWillHideNotification 
                                                  object:nil];  
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)createInputAccessoryView:(BOOL)enablePrevious enableNext:(BOOL)enableNext {
    // Create the view that will play the part of the input accessory view.
    inputAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;

    // Let’s create our buttons now. First the previous button.
    inputAccessoryViewPrevious = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(focusPreviousInput:)];
    
    if (!enablePrevious) {
        [inputAccessoryViewPrevious setEnabled:NO];
    }
    inputAccessoryViewNext = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(focusNextInput:)];
    
    if (!enableNext) {
        [inputAccessoryViewNext setEnabled:NO];
    }
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    inputAccessoryViewDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    [inputAccessoryViewDone setTitle:@"Done"];
    
    
    
    NSArray *array = [NSArray arrayWithObjects:inputAccessoryViewPrevious, inputAccessoryViewNext, flexibleSpace, inputAccessoryViewDone, nil];
    [inputAccessoryView setItems:array];
}

- (IBAction)dismissKeyboard:(id)sender {
    inputAccessoryView = nil;
    [activeField resignFirstResponder];
}

#pragma mark Methods

- (void)navigateToRootView {
    NSLog(@"navigateToRootView");
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)navigateToSearchView {
    NSLog(@"navigateToSearchView");
    
    SearchViewController *searchController = [[SearchViewController alloc] init];
    searchController.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:searchController animated:YES];
}
- (void)showExpandedPlayerView {
    NSLog(@"showExpandedPlayerView");
    
    ExpandedPlayerViewController *expandedPlayerController = [[ExpandedPlayerViewController alloc] init];
    
    [self presentModalViewController:expandedPlayerController animated:YES];
}
- (void)togglePlay {
    NSLog(@"togglePlay");
}

@end
