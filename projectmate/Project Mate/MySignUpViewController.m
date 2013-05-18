//
//  MySignUpViewController.m
//  Project Mate
//
//  Created by Zongheng Wang on 5/18/13.
//  Copyright (c) 2013 Cloud Computing. All rights reserved.
//

#import "MySignUpViewController.h"

@interface MySignUpViewController ()

@end

@implementation MySignUpViewController

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
    UIView *backView1 = [[UIView alloc] initWithFrame:CGRectZero];
	backView1.backgroundColor = [UIColor clearColor];
	UIView *backView2 = [[UIView alloc] initWithFrame:CGRectZero];
	backView2.backgroundColor = [UIColor clearColor];
	
	_nameField = [[UITableView alloc] initWithFrame:CGRectMake(10, 70, 300, 100) style:UITableViewStyleGrouped];
	_nameField.dataSource = self;
	_nameField.delegate = self;
	_nameField.scrollEnabled = NO;
	_nameField.backgroundView = backView1;
	[self.view addSubview:_nameField];
	
	_accountField = [[UITableView alloc] initWithFrame:CGRectMake(10, 258, 300, 150) style:UITableViewStyleGrouped];
	_accountField.dataSource = self;
	_accountField.delegate = self;
	_accountField.scrollEnabled = NO;
	_accountField.backgroundView = backView2;
	[self.view addSubview:_accountField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(tableView == _nameField)
    	return 2;
	else
		return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView == _nameField) {
		UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NameCell"];
		if(cell == nil)
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NameCell"];
	
			[cell setBackgroundColor:[UIColor whiteColor]];
	
		if (indexPath.row == 0) {
			_firstName = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 260, 21)];
			_firstName.placeholder = @"First Name";
			_firstName.autocorrectionType = UITextAutocorrectionTypeNo;
			_firstName.autocapitalizationType = NO;
			[_firstName setClearButtonMode:UITextFieldViewModeWhileEditing];
			_firstName.returnKeyType = UIReturnKeyNext;
			_firstName.delegate = self;
			_firstName.enablesReturnKeyAutomatically = YES;
			cell.accessoryView = _firstName ;
		} else {
			_lastName = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 260, 21)];
			_lastName.placeholder = @"Last Name";
			_lastName.autocorrectionType = UITextAutocorrectionTypeNo;
			[_lastName setClearButtonMode:UITextFieldViewModeWhileEditing];
			_lastName.returnKeyType = UIReturnKeyNext;
			_lastName.delegate = self;
			_lastName.enablesReturnKeyAutomatically = YES;
			cell.accessoryView = _lastName;
		}
	
		[self.view addSubview:_firstName];
		[self.view addSubview:_lastName];
	
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
	} else {
		UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
		if(cell == nil)
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
		
		[cell setBackgroundColor:[UIColor whiteColor]];
		
		if (indexPath.row == 0) {
			_email = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 260, 21)];
			_email.placeholder = @"Email";
			_email.autocorrectionType = UITextAutocorrectionTypeNo;
			_email.autocapitalizationType = NO;
			[_email setClearButtonMode:UITextFieldViewModeWhileEditing];
			_email.returnKeyType = UIReturnKeyNext;
			_email.delegate = self;
			_email.enablesReturnKeyAutomatically = YES;
			cell.accessoryView = _email ;
		} else if (indexPath.row == 1) {
			_password1 = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 260, 21)];
			_password1.placeholder = @"New Password";
			_password1.secureTextEntry = YES;
			_password1.autocorrectionType = UITextAutocorrectionTypeNo;
			[_password1 setClearButtonMode:UITextFieldViewModeWhileEditing];
			_password1.returnKeyType = UIReturnKeyNext;
			_password1.delegate = self;
			_password1.enablesReturnKeyAutomatically = YES;
			cell.accessoryView = _password1;
		} else {
			_password2 = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 260, 21)];
			_password2.placeholder = @"Confirm Password";
			_password2.secureTextEntry = YES;
			_password2.autocorrectionType = UITextAutocorrectionTypeNo;
			[_password2 setClearButtonMode:UITextFieldViewModeWhileEditing];
			_password2.returnKeyType = UIReturnKeyGo;
			_password2.delegate = self;
			_password2.enablesReturnKeyAutomatically = YES;
			cell.accessoryView = _password2;
		}
		
		[self.view addSubview:_email];
		[self.view addSubview:_password1];
		[self.view addSubview:_password2];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
	}
}
- (IBAction)backgroundTouched:(id)sender {
	
	[self.view endEditing:YES];

}

@end
