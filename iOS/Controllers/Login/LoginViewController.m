//
//  LoginViewController.m
//  iOS
//
//  Created by James Geurts on 5/6/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountService.h"
#import "AppDelegate.h"
#import "UITextField+Validation.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize username;
@synthesize password;

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

    username.delegate = self;
    password.delegate = self;
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField*)_textField
{
    if (_textField == username) {
        [password becomeFirstResponder];        
    } else if (_textField == password) {
        [password resignFirstResponder];
        [self login:password];
    }
    return YES;
}

- (IBAction)login:(id)sender {
    

    BOOL isValid = TRUE;
    NSString *userErrors = [[NSString alloc] initWithString:@""];
    
    if(![username requiredText])
    {
        isValid = FALSE;
        [username becomeFirstResponder];
        userErrors = [userErrors stringByAppendingString:@"Username is required. \r\n"];
    }
    if(![password requiredText])
    {
        if (isValid) 
        {
            [password becomeFirstResponder];
        }
        userErrors = [userErrors stringByAppendingString:@"Password is required. \r\n"];
        isValid = FALSE;
    }
    
    if (isValid) 
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
        [appDelegate requestNetworkActivityIndicator];
        AccountService *service = [AccountService new];
    
        [service getUser:[username text] password:[password text] completionHandler:^(User* user, NSError* error) {
            [appDelegate releaseNetworkActivityIndicator];
            if (error) {
                NSMutableString *message = [[NSMutableString alloc] initWithString: @"The specific username or password was incorrect.  "];
//                [message appendString:[error localizedDescription]];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
                [alertView show];

                NSLog(@"%@", error);
            } else {
                NSLog(@"%@", user);
                // TODO: Cache the user information in a plist
                [self dismissModalViewControllerAnimated:YES];
            }
        }];
    } 
    else
    {
        UIAlertView *errors = [[UIAlertView alloc] initWithTitle:nil message:userErrors delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [errors show];
    }
    
}

@end
