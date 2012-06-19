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
#import "Constants.h"
#import "LoginManager.h"

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

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [super textFieldDidBeginEditing:textField];

    // Call the createInputAccessoryView method we created earlier.
    // By doing that we will prepare the inputAccView.
    if (super.activeField == username) {
        [super createInputAccessoryView:NO enableNext:YES];
    } else if (super.activeField == password) {
        [super createInputAccessoryView:YES enableNext:NO];
    }
    
    // Now add the view as an input accessory view to the selected textfield.
    [textField setInputAccessoryView:super.inputAccessoryView];    
}
- (IBAction)focusNextInput:(id)sender {
    if (super.activeField == username) {
        [password becomeFirstResponder];
    }
}
- (IBAction)focusPreviousInput:(id)sender {
    if (super.activeField == password) {
        [username becomeFirstResponder];
    }
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

                LoginManager *manager = [[LoginManager alloc] init];
                manager.token = user.token;

                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGGED_IN];
                [[NSUserDefaults standardUserDefaults] setValue:user.name forKey:USER_NAME];
                [[NSUserDefaults standardUserDefaults] setInteger:user.id forKey:USER_ID];
                [[NSUserDefaults standardUserDefaults] setBool:user.isDonor forKey:USER_IS_DONOR];
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
