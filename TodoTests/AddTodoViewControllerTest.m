//
//  AddTodoViewControllerTest.m
//  Todo
//
//  Created by yuichi.takeda on 6/1/15.
//  Copyright (c) 2015 appdojo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "AddTodoViewController.h"

@interface AddTodoViewControllerTest : XCTestCase

@end

@implementation AddTodoViewControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testValidateTodo
{
    AddTodoViewController *vc = [[AddTodoViewController alloc] init];
    NSDictionary *todo;

    // タイトルを満たし, 1時間後に設定
    todo = @{@"title": @"hogehoge",
             @"date": [NSDate dateWithTimeIntervalSinceNow:60*60]};
    XCTAssertTrue([vc isValidToDo:todo]);

    // タイトルが空文字列の場合 NO
    todo = @{@"title": @"",
             @"date": [NSDate dateWithTimeIntervalSinceNow:60*60]};
    XCTAssertFalse([vc isValidToDo:todo]);

    // タイトルが空白のみの場合 NO
    todo = @{@"title": @"      ",
             @"date": [NSDate dateWithTimeIntervalSinceNow:60*60]};
    XCTAssertFalse([vc isValidToDo:todo]);

    // 締め切りが現在より昔の場合 NO
    todo = @{@"title": @"hogehoge",
             @"date": [NSDate dateWithTimeIntervalSinceNow:-60*60]};
    XCTAssertFalse([vc isValidToDo:todo]);

    // title, dateのどちらかが欠けていても NO が返る
    todo = @{@"title": @"hogehoge"};
    XCTAssertFalse([vc isValidToDo:todo]);

    todo = @{@"date": [NSDate dateWithTimeIntervalSinceNow:-60*60]};
    XCTAssertFalse([vc isValidToDo:todo]);

    // nil を渡してもnilが返る
    XCTAssertFalse([vc isValidToDo:nil]);

}

@end
