//
//  ViewController.h
//  ShortProfile
//
//  Created by Vidya on 04/04/14.
//  Copyright (c) 2014 Vidya Murthy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSegmentControl.h"

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    
    int currentPages;
    BOOL isScrollViewVisible;
    int currentSelectedIndex;
}


@property (nonatomic, strong) IBOutlet UIImageView *m_cBackgroundIV;

@property (nonatomic, strong) UIView *m_cGradientView;

@property (nonatomic, strong) UIView *m_cButtonsView;
@property (nonatomic, strong) SPSegmentControl *m_cSegmentControl;

@property (nonatomic, strong) UIView *m_cProfileDetailsView;
@property (nonatomic, strong) UILabel *m_cNameAgeLabel;
@property (nonatomic, strong) UILabel *m_cDetailsLabel;
@property (nonatomic, strong) UILabel *m_cBodyArtsLabel;

@property (nonatomic, strong) UIView *m_cScrollableDetailView;
@property (nonatomic, strong) UIScrollView *m_cScrollView;

@property (nonatomic, strong) UIButton *m_cSpotsButton;
@property (nonatomic, strong) UIButton *m_cInterestsButton;

@end
