//
//
//      _|          _|_|_|
//      _|        _|
//      _|        _|
//      _|        _|
//      _|_|_|_|    _|_|_|
//
//
//  Copyright (c) 2014-2015, Licheng Guo. ( http://nsobject.me )
//  http://github.com/titman
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#import "ViewController.h"
#import "LCCircleProgressView.h"

@interface ViewController ()

@property (nonatomic, strong) LCCircleProgressView * chart;
@property (nonatomic, strong) LCCircleProgressView * chart1;
@property (nonatomic, strong) LCCircleProgressView * chart2;

@end

@implementation ViewController

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    LCCircleProgressView * chart = [[LCCircleProgressView alloc] init];
    chart.frame                   = CGRectMake(0, 0, 300, 300);
    chart.center                  = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    chart.lineWidth               = 20;
    chart.openingDegree           = 80;
    chart.progressBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    chart.startColor              = [UIColor colorWithRed:13. / 255. green:175. / 255. blue:251. / 255. alpha:1];
    chart.middleColor             = [UIColor colorWithRed:77. / 255. green:245. / 255. blue:255. / 255. alpha:1];
    chart.endColor                = [UIColor colorWithRed:15. / 255. green:255. / 255. blue:160. / 255. alpha:1];
    chart.progress = 0;
    
    self.chart = chart;
    [self.view addSubview:chart];
    
    
    LCCircleProgressView * chart1 = [[LCCircleProgressView alloc] init];
    chart1.frame                   = CGRectMake(0, 0, 200, 200);
    chart1.center                  = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    chart1.lineWidth               = 10;
    chart1.openingDegree           = 140;
    chart1.progressBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    chart1.startColor              = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    chart1.middleColor             = [[UIColor yellowColor] colorWithAlphaComponent:0.7];
    chart1.endColor                = [[UIColor redColor] colorWithAlphaComponent:0.7];
    chart1.progress = 0;
    chart1.animationDuration = 1.25;
    
    self.chart1 = chart1;
    [self.view addSubview:chart1];
    
    
    LCCircleProgressView * chart2 = [[LCCircleProgressView alloc] init];
    chart2.frame                   = CGRectMake(0, 0, 100, 100);
    chart2.center                  = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    chart2.lineWidth               = 5;
    chart2.openingDegree           = 20;
    chart2.progressBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    chart2.startColor              = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    chart2.middleColor             = [[UIColor purpleColor] colorWithAlphaComponent:0.7];
    chart2.endColor                = [[UIColor cyanColor] colorWithAlphaComponent:0.7];
    chart2.progress = 0;
    chart2.animationDuration = 1;

    self.chart2 = chart2;
    [self.view addSubview:chart2];
    
    
    
    
    
    [self performSelector:@selector(test) withObject:nil afterDelay:2];
}

-(void) test
{
    [self.chart setProgress:1 animated:YES];
    [self.chart1 setProgress:0.9 animated:YES];
    [self.chart2 setProgress:0.8 animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
