#import <UIKit/UIKit.h>           // For UIView and related classes
#import <QuartzCore/QuartzCore.h>  // For CABasicAnimation
#import <Foundation/Foundation.h>   // For NSNumber
#import <math.h>                   // For HUGE_VALF

@protocol SBIconAccessoryView
@end

@interface SBIconBadgeView : UIView <SBIconAccessoryView>
 -(void)layoutSubviews;
@end

%hook SBIconBadgeView
-(void)layoutSubviews {
    %orig;
    
// Ngăn chặn các hoạt ảnh trùng lặp bằng cách kiểm tra xem hiệu ứng đã được áp dụng
    if (![self.layer animationForKey:@"badgeBreathingAnimation"]) {
        CABasicAnimation *breathAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        breathAnimation.duration = 0.7;
        breathAnimation.repeatCount = HUGE_VALF;
        breathAnimation.autoreverses = YES;
        breathAnimation.fromValue = [NSNumber numberWithFloat:1.2];
        breathAnimation.toValue = [NSNumber numberWithFloat:0.6];
        breathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        // Thêm hiệu ứng vào layer
        [self.layer addAnimation:breathAnimation forKey:@"badgeBreathingAnimation"];
    }
}
%end
