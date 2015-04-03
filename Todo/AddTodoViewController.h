//
//  AddTodoViewController.h
//  Todo
//
//  Created by yuichi.takeda on 4/3/15.
//  Copyright (c) 2015 appdojo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTodoViewControllerDelegate;

@interface AddTodoViewController : UIViewController

// ToDoの編集が完了したタイミングで呼ばれるdelgateのプロパティ
@property (nonatomic, weak) id<AddTodoViewControllerDelegate> delegate;
@end

/**
 *  ToDoの追加が完了したタイミングで呼ばれるdelgateプロトコル
 */
@protocol AddTodoViewControllerDelegate <NSObject>

/**
 *  新しいToDoの入力が完了した時に呼ばれるメソッドです.
 *
 *  @param sender  ToDoを入力したViewController
 *  @param newTodo 入力されたToDoです. キャンセルの場合はnilになります.
 */
- (void)addTodoViewController:(AddTodoViewController *)sender addTodoCompleted:(NSString *)newTodo;
@end