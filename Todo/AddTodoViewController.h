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

/**
 *  Todoのバリデーションを行います
 *
 *  @param dict Todoのエンティティ
 *
 *  @return Todoの仕様を満たす場合はYESを, そうでない場合はNOを返します.
 */

- (BOOL)isValidToDo:(NSDictionary *)dict;
@end

/**
 *  ToDoの追加が完了したタイミングで呼ばれるdelgateプロトコル
 */
@protocol AddTodoViewControllerDelegate <NSObject>

/**
 *  新しいToDoの入力が完了した時に呼ばれるメソッドです.
 *
 *  @param sender  ToDoを入力したViewController
 *  @param newTodo 入力されたToDoです. キャンセルの場合はnilになります. 辞書のフォーマットは @{@"title": <タイトル, NSString型>, @"date": <締切, NSDate型>}; のようになります
 */
- (void)addTodoViewController:(AddTodoViewController *)sender addTodoCompleted:(NSDictionary *)newTodo;
@end