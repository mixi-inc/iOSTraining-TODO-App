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
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

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
    // キャンセルボタンがタップされた時にdelegateに通知する. 新しいToDoはnil
    [self.delegate addTodoViewController:self addTodoCompleted:nil];
}

- (void)doneButtonTapped:(id)sender
{

    NSDictionary *newTodo = @{@"title": self.textView.text,
                              @"date": self.datePicker.date};

    // 入力されたTODOが要件を満たしているかをチェック
    if ([self isValidToDo:newTodo]) {

        // 満たしている場合はdelegeteに通知する.
        [self.delegate addTodoViewController:self addTodoCompleted:newTodo];

    } else {

        // 満たしていない場合はアラートを表示する.
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"TODOの追加に失敗しました"
                                                                       message:@"本文が空白, あるいは指定日時が過去の可能性があります."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];

    }
}

- (BOOL)isValidToDo:(NSDictionary *)dict
{
    NSString *title = dict[@"title"];
    NSDate *date = dict[@"date"];

    if (title.length == 0) return NO;
    if ([date timeIntervalSinceNow] < 0.0) return NO;
    return YES;
}

@end
