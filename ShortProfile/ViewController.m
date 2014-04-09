//
//  ViewController.m
//  ShortProfile
//
//  Created by Vidya on 04/04/14.
//  Copyright (c) 2014 Vidya Murthy. All rights reserved.
//

//Main View Controller

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

#define kBottomButtonViewHeight 50
#define kImageSize CGSizeMake(56,56)
#define kScrollPageWidth 76
#define kScrollPageHeight 100

@implementation ViewController

@synthesize m_cBackgroundIV, m_cGradientView;
@synthesize m_cProfileDetailsView,m_cNameAgeLabel, m_cDetailsLabel, m_cBodyArtsLabel;
@synthesize m_cButtonsView, m_cSegmentControl;
@synthesize m_cScrollableDetailView, m_cScrollView;
@synthesize m_cInterestsButton, m_cSpotsButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view sendSubviewToBack:self.m_cBackgroundIV];
    
    isScrollViewVisible = NO;
    currentSelectedIndex = -1;
    
    self.m_cGradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 358, 320, 160)];
    self.m_cGradientView.backgroundColor = [UIColor clearColor];
    self.m_cGradientView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.m_cGradientView.bounds;
    
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[[UIColor clearColor] CGColor],
                       (id)[[UIColor clearColor] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.1f] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.2f] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.3f] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.4f] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.5f] CGColor],
                       nil];
    
    gradient.colors = colors;
    [self.m_cGradientView.layer insertSublayer:gradient atIndex:0];
    [self.view addSubview:self.m_cGradientView];
    
    self.m_cProfileDetailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 438, 320, 80)];
    self.m_cProfileDetailsView.backgroundColor = [UIColor clearColor];
    self.m_cProfileDetailsView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.m_cProfileDetailsView];
    
    self.m_cNameAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    self.m_cNameAgeLabel.textAlignment = NSTextAlignmentCenter;
    self.m_cNameAgeLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    self.m_cNameAgeLabel.textColor = [UIColor whiteColor];
    self.m_cNameAgeLabel.text = @"Candice, 24";
    self.m_cNameAgeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    self.m_cNameAgeLabel.backgroundColor = [UIColor clearColor];//colorWithWhite:0.9 alpha:0.6];
    [self.m_cProfileDetailsView addSubview:self.m_cNameAgeLabel];
    
    self.m_cDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 240, 25)];
    self.m_cDetailsLabel.textAlignment = NSTextAlignmentCenter;
    self.m_cDetailsLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    self.m_cDetailsLabel.backgroundColor = [UIColor clearColor];
    [self.m_cProfileDetailsView addSubview:self.m_cDetailsLabel];
    
    //Attributed text for the details - mixed with image and icons
    NSMutableAttributedString *mainString = [[NSMutableAttributedString alloc] init];
    
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:16], NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSDictionary *iconAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"fontellofull" size:16], NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"\uead5 " attributes:iconAttributes];
    [mainString appendAttributedString:string1];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"175cm, "attributes:textAttributes];
    [mainString appendAttributedString:string2];
    
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"\ue92f " attributes:iconAttributes];
    [mainString appendAttributedString:string3];
    
    NSMutableAttributedString *string4 = [[NSMutableAttributedString alloc] initWithString:@"Gray, "attributes:textAttributes];
    [mainString appendAttributedString:string4];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"female_hair_icon_light.png"];
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    [mainString appendAttributedString:attachmentString];

    NSMutableAttributedString *string5 = [[NSMutableAttributedString alloc] initWithString:@" Blond"attributes:textAttributes];
    [mainString appendAttributedString:string5];
    
    self.m_cDetailsLabel.attributedText = mainString;
    
    self.m_cBodyArtsLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 55, 240, 25)];
    self.m_cBodyArtsLabel.textAlignment = NSTextAlignmentCenter;
    self.m_cBodyArtsLabel.textColor = [UIColor whiteColor];
    self.m_cBodyArtsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    self.m_cBodyArtsLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    self.m_cBodyArtsLabel.text = @"Tattoo, Piercing, Brille";
    self.m_cBodyArtsLabel.backgroundColor = [UIColor clearColor];
    [self.m_cProfileDetailsView addSubview:self.m_cBodyArtsLabel];
    
    //Bottom View Buttons
    self.m_cButtonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 518, 320, kBottomButtonViewHeight)];
    self.m_cButtonsView.backgroundColor = [UIColor clearColor];
    self.m_cButtonsView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.m_cButtonsView];
    
    UIView *lSeparaterView = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 1, kBottomButtonViewHeight)];
    lSeparaterView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.8];
    lSeparaterView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.m_cButtonsView addSubview:lSeparaterView];
    
    
//    self.m_cSegmentControl = [[SPSegmentControl alloc] initWithItems:[NSArray arrayWithObjects:@"Shared Spots (10)", @"Shared Interests (10)", nil]];
//    self.m_cSegmentControl.frame = CGRectMake(0, 0, 320, kBottomButtonViewHeight);
//    self.m_cSegmentControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
//    [[UISegmentedControl appearance] setTitleTextAttributes:@{
//                                                              NSForegroundColorAttributeName: [UIColor colorWithRed:0.84 green:0.23 blue:0.52 alpha:1],
//                                                              NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:14],
//                                                              } forState:UIControlStateNormal];
//    [[UISegmentedControl appearance] setTitleTextAttributes:@{
//                                                              NSForegroundColorAttributeName: [UIColor colorWithRed:0.40 green:0.40 blue:0.56 alpha:1],
//                                                              NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:14],
//                                                              } forState:UIControlStateSelected];
//
//    self.m_cSegmentControl.tintColor = [UIColor colorWithWhite:1 alpha:0.1];
//    self.m_cSegmentControl.backgroundColor = [UIColor colorWithWhite:1 alpha:0.77];
//    [self.m_cSegmentControl addTarget:self action:@selector(segmentControlButtonClicked) forControlEvents:UIControlEventValueChanged];
//    [self.m_cButtonsView addSubview:self.m_cSegmentControl];

    
    self.m_cSpotsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.m_cSpotsButton.frame = CGRectMake(0, 0, 160, kBottomButtonViewHeight);
    [self.m_cSpotsButton setTitleColor:[UIColor colorWithRed:0.84 green:0.23 blue:0.52 alpha:1] forState:UIControlStateNormal];
    [self.m_cSpotsButton setTitle:@"Shared Spots (10)" forState:UIControlStateNormal];
    self.m_cSpotsButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    self.m_cSpotsButton.tag = 10;
    [self.m_cSpotsButton addTarget:self action:@selector(segmentControlButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.m_cSpotsButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.95];
    [self.m_cButtonsView addSubview:self.m_cSpotsButton];
    
    self.m_cInterestsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.m_cInterestsButton.frame = CGRectMake(160, 0, 160, kBottomButtonViewHeight);
    [self.m_cInterestsButton setTitleColor:[UIColor colorWithRed:0.31 green:0.36 blue:0.60 alpha:1] forState:UIControlStateNormal];
    [self.m_cInterestsButton setTitle:@"Shared Interests (10)" forState:UIControlStateNormal];
    self.m_cInterestsButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    self.m_cInterestsButton.tag = 11;
    [self.m_cInterestsButton addTarget:self action:@selector(segmentControlButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.m_cInterestsButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.95];
    [self.m_cButtonsView addSubview:self.m_cInterestsButton];
    
    
    [self.m_cButtonsView bringSubviewToFront:lSeparaterView];
    
    self.m_cScrollableDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, 568, 320, kScrollPageHeight)];
    self.m_cScrollableDetailView.backgroundColor = [UIColor colorWithRed:0.98 green:0.96 blue:0.95 alpha:0.95];
    self.m_cScrollableDetailView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.m_cScrollableDetailView];
    
    currentPages = 10;
    self.m_cScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kScrollPageHeight)];
    [self createScrollPages];
    self.m_cScrollView.contentSize = CGSizeMake(currentPages*kScrollPageWidth, kScrollPageHeight);
    self.m_cScrollView.delegate = self;
    self.m_cScrollView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.m_cScrollableDetailView addSubview:self.m_cScrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark User Defined Methods

-(void)createScrollPages{
    
    for (int i = 0; i < currentPages; i++) {
        CGFloat xOrigin = i * kScrollPageWidth;
        UIView *lView = [[UIView alloc] initWithFrame:CGRectMake(xOrigin, 0, kScrollPageWidth, self.m_cScrollView.frame.size.height)];
        lView.backgroundColor = [UIColor clearColor];//colorWithRed:1.0/i green:1.0/i blue:1.0/i alpha:1];
        
        UIImageView *lImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kImageSize.width, kImageSize.width)];
        lImageView.image = [UIImage imageNamed:@"image"];
        lImageView.layer.cornerRadius = kImageSize.width/2.0;
        lImageView.layer.masksToBounds = YES;
        [lView addSubview:lImageView];
        
        UILabel *lLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 68, 70, 30)];
        lLabel.text = @"Location name";
        lLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
        lLabel.textColor = [UIColor colorWithRed:0.52 green:0.72 blue:0.27 alpha:1];
        lLabel.numberOfLines = 2;
        lLabel.textAlignment = NSTextAlignmentCenter;
        lLabel.backgroundColor = [UIColor clearColor];
        [lView addSubview:lLabel];
        
        [self.m_cScrollView addSubview:lView];
    }
}

-(void)segmentControlButtonClicked:(UIButton*)pButton{
    
    int selectedIndex = pButton.tag;
    
    //there is no scroll visible
    if (isScrollViewVisible == NO && currentSelectedIndex != selectedIndex) {
        pButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.85];
        CGRect frame1 = self.m_cProfileDetailsView.frame;
        CGRect frame2 = self.m_cButtonsView.frame;
        CGRect frame3 = self.m_cScrollableDetailView.frame;
        CGRect frame4 = self.m_cGradientView.frame;
        
        frame1.origin.y -= kScrollPageHeight;
        frame2.origin.y -= kScrollPageHeight;
        frame3.origin.y -= kScrollPageHeight;
        frame4.origin.y -= kScrollPageHeight;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.m_cProfileDetailsView.frame = frame1;
                             self.m_cButtonsView.frame = frame2;
                             self.m_cScrollableDetailView.frame = frame3;
                             self.m_cGradientView.frame = frame4;
                         } completion:^(BOOL finished){
                             if(finished){
                                 isScrollViewVisible = YES;
                                 currentSelectedIndex = selectedIndex;
                             }
                         }];

    }
    //scrollview is visible, different segment selected
    else if (isScrollViewVisible == YES && currentSelectedIndex != selectedIndex){
        //change the background color of current selection
        pButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.85];
        //change the background color of previous selection
        if (self.m_cInterestsButton.tag == currentSelectedIndex) {
            self.m_cInterestsButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.95];
        }
        else {
            self.m_cSpotsButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.95];
        }
        currentSelectedIndex = selectedIndex;
        //reload the scrollview data
    }
    //same index is clicked again, scrollview has to be dismissed
    else if (currentSelectedIndex == selectedIndex && isScrollViewVisible == YES){
        pButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.95];
        CGRect frame1 = self.m_cProfileDetailsView.frame;
        CGRect frame2 = self.m_cButtonsView.frame;
        CGRect frame3 = self.m_cScrollableDetailView.frame;
        CGRect frame4 = self.m_cGradientView.frame;
        
        frame1.origin.y += kScrollPageHeight;
        frame2.origin.y += kScrollPageHeight;
        frame3.origin.y += kScrollPageHeight;
        frame4.origin.y += kScrollPageHeight;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.m_cProfileDetailsView.frame = frame1;
                             self.m_cButtonsView.frame = frame2;
                             self.m_cScrollableDetailView.frame = frame3;
                             self.m_cGradientView.frame = frame4;
                         } completion:^(BOOL finished){
                             if(finished){
                                 isScrollViewVisible = NO;
                                 currentSelectedIndex = -1;
                                 self.m_cSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment;
                             }
                         }];
        
    }
}


#pragma mark UIScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)myScrollView {
//    /**
//     * calculate the current page that is shown
//     * you can also use myScrollview.frame.size.height if your image is the exact size of your scrollview
//     */
//    int currentPage = (myScrollView.contentOffset.x / kImageSize.width);
//    
//    // display the image and maybe +/-1 for a smoother scrolling
//    // but be sure to check if the image already exists, you can do this very easily using tags
//    if ( [myScrollView viewWithTag:(currentPage +1)] ) {
//        return;
//    }
//    else {
//        // view is missing, create it and set its tag to currentPage+1
//        [self createScrollPages];
//    }
//    
//    /**
//     * using your paging numbers as tag, you can also clean the UIScrollView
//     * from no longer needed views to get your memory back
//     * remove all image views except -1 and +1 of the currently drawn page
//     */
//    for ( int i = 0; i < currentPages; i++ ) {
//        if ( (i < (currentPage-1) || i > (currentPage+1)) && [myScrollView viewWithTag:(i+1)] ) {
//            [[myScrollView viewWithTag:(i+1)] removeFromSuperview];
//        }
//    }
}

@end
