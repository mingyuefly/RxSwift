//
//  ViewController.m
//  OC_RxSwiftHelloWorld
//
//  Created by GMY on 2023/11/20.
//

#import "ViewController.h"
#import "OC_RxSwiftHelloWorld-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"next" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)nextAction{
    NSLog(@"nextAction");
    RxViewController *rvc = [[RxViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

@end
