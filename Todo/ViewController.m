//
//  ViewController.m
//  Todo
//
//  Created by appdojo on 2015/03/16.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import "ViewController.h"
#import "TodoTableViewCell.h"
#import "AddTodoViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, AddTodoViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *todo;
@property (strong, nonatomic) TodoTableViewCell *offscreenCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.todo = [NSMutableArray array];
    self.title = @"TODO";

    UINib *nib = [UINib nibWithNibName:@"TodoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    self.offscreenCell = [nib instantiateWithOwner:nil options:nil][0];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewDidLayoutSubviews
{
    self.offscreenCell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.tableView.bounds));
    [self.offscreenCell setNeedsLayout];
    [self.offscreenCell layoutIfNeeded];
    self.offscreenCell.todoLabel.text = nil;
    self.offscreenCell.todoLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.offscreenCell.todoLabel.bounds);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoTableViewCell *cell = self.offscreenCell;

    cell.todoLabel.text = self.todo[indexPath.row];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

    return ceil(size.height) + 1.0; // 1.0はUITableViewCellのcontentViewとcellの間にあるマージン
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.todo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.todoLabel.text = self.todo[indexPath.row];
    return cell;
}


// UITableViewの編集モードに各rowが移行できるかどうかを返すメソッド. 今回はすべてのセルにTODOが表示されており、削除できるのでYESを返す
// このメソッドを実装することでセルをスワイプした時に赤い "Delete" ボタンが出現する
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// セルをスワイプした時の赤い "Delete" ボタンをタップしたときのハンドラ
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 他の編集モードもあるが、UITableViewCellEditingStyleDeleteの場合のみ扱う
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // UITableViewをアニメーション付きで削除する場合以下の二点を実行します
        // 1. データ構造(今回だとself.todo)から該当するデータを削除する
        // 2. beginUpdates - endUpdatesの間で tableView#deleteRowsAtIndexPaths でセルを削除する

        [self.todo removeObjectAtIndex:indexPath.row];

        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];

    }
}

- (IBAction)addButtonTapped:(id)sender {

    // Main.storyboardの Storyboard ID "AddTodoViewController" で登録されているViewControllerの初期化
    AddTodoViewController *addTodoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTodoViewController"];
    addTodoViewController.delegate = self; // addTodoViewControllerが完了した時に呼ばれるクラスをこのクラスにする


    // AddTodoViewController ではNavigationBarにキャンセル、完了ボタンがあるのでUINavigationControllerで管理する
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addTodoViewController];

    // 表示
    [self presentViewController:navigationController animated:YES completion:nil];
}

// 新しいToDoが追加された時に呼ばれる
- (void)addTodoViewController:(AddTodoViewController *)sender addTodoCompleted:(NSString *)newTodo
{
    // 表示していた AddTodoViewController を閉じる
    [self dismissViewControllerAnimated:YES completion:nil];

    if (newTodo != nil) {

        // 新しいToDoを追加
        [self.todo insertObject:newTodo atIndex:0];

        // tableveiwの再読み込み
        [self.tableView reloadData];

    }
}

@end
