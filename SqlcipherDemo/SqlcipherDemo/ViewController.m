//
//  ViewController.m
//  SqlcipherDemo
//
//  Created by ZhengXiankai on 16/4/17.
//  Copyright © 2016年 bomo. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "DbTest.h"
#import "DbService.h"
#import "FMEncryptHelper.h"

@interface ViewController ()
{
    NSString *_dbPath;
}
@property (weak, nonatomic) IBOutlet UILabel *lbInfo;

@end

@implementation ViewController

static NSString *encryptKey = @"32r32rdewfds";

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _dbPath = [directory stringByAppendingPathComponent:@"db1.db"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Event
- (IBAction)init:(id)sender
{
    DbService *dbService = [[DbService alloc] initWithPath:_dbPath encryptKey:nil];
    [DbTest createTable:dbService];
    [DbTest insertPeople:dbService];
    [[[UIAlertView alloc] initWithTitle:nil message:@"create unencrypt database success" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
}
- (IBAction)query:(id)sender
{
    DbService *dbService = [[DbService alloc] initWithPath:_dbPath encryptKey:nil];
    NSInteger count = [DbTest peopleCount:dbService];
    
    NSString *msg = [NSString stringWithFormat:@"people count:%@", @(count)];
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
}

- (IBAction)encrypt:(id)sender
{
    BOOL res = [FMEncryptHelper encryptDatabase:_dbPath encryptKey:encryptKey];
    
    NSString *msg = res ? @"encrypt success" : @"encrypt fail";
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
}

- (IBAction)encryptQuery:(id)sender
{
    DbService *dbService = [[DbService alloc] initWithPath:_dbPath encryptKey:encryptKey];
    NSInteger count = [DbTest peopleCount:dbService];
    
    NSString *msg = [NSString stringWithFormat:@"people count:%@", @(count)];
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
}

- (IBAction)decrypt:(id)sender
{
    BOOL res = [FMEncryptHelper unEncryptDatabase:_dbPath encryptKey:encryptKey];
    
    NSString *msg = res ? @"decrypt success" : @"decrypt fail";
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
}


@end