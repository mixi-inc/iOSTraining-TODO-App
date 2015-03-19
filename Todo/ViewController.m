//
//  ViewController.m
//  Todo
//
//  Created by appdojo on 2015/03/16.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *todo;
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

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.todo[indexPath.row];
    return cell;
}

@end
