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

#import "LCCircleProgressView.h"

#define __DEGREES_TO_RADIANS(x) (M_PI*(x)/180.0)

@interface LCCircleProgressView ()

@property (nonatomic, assign) BOOL _inited;

@property (nonatomic, strong) CAShapeLayer * progressTrackLayer;
@property (nonatomic, strong) CAShapeLayer * backgroundTrackLayer;

@property (nonatomic, strong) CAGradientLayer * leftGradientLayer;
@property (nonatomic, strong) CAGradientLayer * rightGradientLayer;

@end

@implementation LCCircleProgressView

#pragma mark -

+(instancetype) view
{
   return self.class.init;
}

-(instancetype) initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame]) {
      
      [self buildUI:frame];
   }
   
   return self;
}

-(instancetype) init
{
   if (self = [super initWithFrame:CGRectMake(0, 0, 100, 100)]) {
      
      [self buildUI:self.frame];
   }
   
   return self;
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
   if (self = [super initWithCoder:aDecoder]) {
      
      [self buildUI:self.frame];
   }
   
   return self;
}

#pragma mark -

-(void) buildUI:(CGRect)frame
{
   
   if (self._inited) {
      // error.
      return;
   }
   
   
   self.lineWidth     = 13;
   self.openingDegree = 80;
   self.animationDuration = 1.5;
   
   self.progressBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
   self.startColor              = [UIColor colorWithRed:13. / 255. green:175. / 255. blue:251. / 255. alpha:1];
   self.middleColor             = [UIColor colorWithRed:77. / 255. green:245. / 255. blue:255. / 255. alpha:1];
   self.endColor                = [UIColor colorWithRed:15. / 255. green:255. / 255. blue:160. / 255. alpha:1];
   
   
   
   UIBezierPath * path = [self buildBezierPath];
   
   
   self.backgroundTrackLayer             = [CAShapeLayer layer];
   self.backgroundTrackLayer.frame       = self.bounds;
   self.backgroundTrackLayer.fillColor   = UIColor.clearColor.CGColor;
   self.backgroundTrackLayer.strokeColor = self.progressBackgroundColor.CGColor;
   self.backgroundTrackLayer.lineCap     = kCALineCapRound;
   self.backgroundTrackLayer.lineWidth   = self.lineWidth;
   self.backgroundTrackLayer.path        = path.CGPath;
   
   [self.layer addSublayer:self.backgroundTrackLayer];
   
   
   self.progressTrackLayer             = [CAShapeLayer layer];
   self.progressTrackLayer.frame       = self.bounds;
   self.progressTrackLayer.fillColor   = UIColor.clearColor.CGColor;
   self.progressTrackLayer.strokeColor = UIColor.blackColor.CGColor;
   self.progressTrackLayer.lineCap     = kCALineCapRound;
   self.progressTrackLayer.lineWidth   = self.lineWidth;
   self.progressTrackLayer.path        = path.CGPath;
   self.progressTrackLayer.strokeStart = 0;
   self.progressTrackLayer.strokeEnd   = 1;
   
   [self.layer addSublayer:self.progressTrackLayer];
   
   
   CALayer * gradientLayer = [CALayer layer];
   
   
   self.leftGradientLayer            = [CAGradientLayer layer];
   self.leftGradientLayer.frame      = CGRectMake(0, 0, self.frame.size.width / 2., self.frame.size.height);
   self.leftGradientLayer.colors     = @[(id)self.startColor.CGColor, (id)self.middleColor.CGColor];
   self.leftGradientLayer.locations  = @[@0.5, @0.9, @1];
   self.leftGradientLayer.startPoint = CGPointMake(0.5, 1);
   self.leftGradientLayer.endPoint   = CGPointMake(0.5, 0);
   
   [gradientLayer addSublayer:self.leftGradientLayer];
   
   
   self.rightGradientLayer            = [CAGradientLayer layer];
   self.rightGradientLayer.locations  = @[@0.1, @0.5, @1];
   self.rightGradientLayer.frame      = CGRectMake(self.frame.size.width / 2., 0, self.frame.size.width / 2, self.frame.size.height);
   self.rightGradientLayer.colors     = @[(id)self.middleColor.CGColor, (id)self.endColor.CGColor];
   self.rightGradientLayer.startPoint = CGPointMake(0.5, 0);
   self.rightGradientLayer.endPoint   = CGPointMake(0.5, 1);
   
   [gradientLayer addSublayer:self.rightGradientLayer];
   
   
   
   gradientLayer.mask = self.progressTrackLayer;
   
   [self.layer addSublayer:gradientLayer];
   
   
   self._inited = YES;
}

-(UIBezierPath *) buildBezierPath
{
   return [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2) radius:(self.frame.size.width - self.lineWidth) / 2 startAngle:__DEGREES_TO_RADIANS(-270 + self.openingDegree / 2) endAngle:__DEGREES_TO_RADIANS(90 - self.openingDegree / 2) clockwise:YES];
   
}

-(void) updateBezierPath
{
   UIBezierPath * path = [self buildBezierPath];
   
   self.backgroundTrackLayer.path = path.CGPath;
   self.progressTrackLayer.path   = path.CGPath;
}

-(void) updateGradientColor
{
   
}

#pragma mark -

-(void) setFrame:(CGRect)frame
{
   if (self.frame.size.width != frame.size.width || self.frame.size.height != frame.size.height) {
      
      [super setFrame:frame];
      
      self.backgroundTrackLayer.frame = self.bounds;
      self.progressTrackLayer.frame   = self.bounds;
      
      self.leftGradientLayer.frame    = CGRectMake(0, 0, self.frame.size.width / 2., self.frame.size.height);
      self.rightGradientLayer.frame   = CGRectMake(self.frame.size.width / 2., 0, self.frame.size.width / 2, self.frame.size.height);
   }
   else{
      
      [super setFrame:frame];
   }
}

-(void) setLineWidth:(CGFloat)lineWidth
{
   _lineWidth = lineWidth;
   
   self.backgroundTrackLayer.lineWidth = lineWidth;
   self.progressTrackLayer.lineWidth   = lineWidth;
   
   [self updateBezierPath];
   
}

-(void) setOpeningDegree:(CGFloat)openingDegree
{
   _openingDegree = openingDegree;
   
   [self updateBezierPath];
}

-(void) setStartColor:(UIColor *)startColor
{
   _startColor = startColor;
   
   if (!self._inited)
      return;
      
   self.leftGradientLayer.colors = @[(id)self.startColor.CGColor, (id)self.middleColor.CGColor];
}

-(void) setMiddleColor:(UIColor *)middleColor
{
   _middleColor = middleColor;
   
   if (!self._inited)
      return;
   
   self.leftGradientLayer.colors  = @[(id)self.startColor.CGColor, (id)self.middleColor.CGColor];
   self.rightGradientLayer.colors = @[(id)self.middleColor.CGColor, (id)self.endColor.CGColor];
}

-(void) setEndColor:(UIColor *)endColor
{
   _endColor = endColor;
   
   if (!self._inited)
      return;
   
   self.rightGradientLayer.colors = @[(id)self.middleColor.CGColor, (id)self.endColor.CGColor];
}

-(void) setProgress:(CGFloat)progress
{
   [self setProgress:progress animated:NO];
}

-(void) setProgress:(CGFloat)progress animated:(BOOL)animated
{
    _progress = progress;
    
    if (animated) {
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:self.animationDuration];
        self.progressTrackLayer.strokeEnd = progress;
        [CATransaction commit];
    }
    else{
        
        self.progressTrackLayer.strokeEnd = self.progress;
    }
}

@end
