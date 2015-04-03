//
//  AddTodoViewController.m
//  Todo
//
//  Created by yuichi.takeda on 4/3/15.
//  Copyright (c) 2015 appdojo. All rights reserved.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomConstraint;

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelButtonTapped:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(doneButtonTapped:)];

    // キーボード表示時の通知を受け取るようにオブザーバーとして登録する
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)dealloc
{
    // インスタンスが破棄されても通知は呼ばれるので通知されないようにする
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)keyboardWillShow:(NSNotification *)notification
{
    // キーボードのサイズを取得
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    // キーボードのサイズに合わせてTextViewの下マージンの値を変える
    self.textViewBottomConstraint.constant = CGRectGetHeight(keyboardFrame);
}

- (void)cancelButtonTapped:(id)sender
{

}

- (void)doneButtonTapped:(id)sender
{

}

@end
