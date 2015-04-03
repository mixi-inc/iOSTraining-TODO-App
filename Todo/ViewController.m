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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *todo;
@property (strong, nonatomic) TodoTableViewCell *offscreenCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.todo = @[@"牛乳を買ってくる",
                  @"ビールを飲む",
                  @"家賃の振り込み",
                  @"洗剤を買い足す",
                  @"Macのアップデート",
                  @"ルンバの充電",
                  @"結婚式の招待状に返信する",
                  @"犬の散歩",
                  @"雨ニモマケズ 風ニモマケズ 雪ニモ夏ノ暑サニモマケヌ 丈夫ナカラダヲモチ 慾ハナク 決シテ瞋ラズ イツモシヅカニワラッテヰル 一日ニ玄米四合ト 味噌ト少シノ野菜ヲタベ アラユルコトヲ ジブンヲカンジョウニ入レズニ ヨクミキキシワカリ ソシテワスレズ",
                  @"ビールを飲む"
                  ];

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


- (IBAction)addButtonTapped:(id)sender {

    // Main.storyboardの Storyboard ID "AddTodoViewController" で登録されているViewControllerの初期化
    AddTodoViewController *addTodoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTodoViewController"];

    // AddTodoViewController ではNavigationBarにキャンセル、完了ボタンがあるのでUINavigationControllerで管理する
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addTodoViewController];

    // 表示
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
