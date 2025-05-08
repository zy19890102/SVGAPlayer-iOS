//
//  SVGAImageView.m
//  SVGAPlayer
//
//  Created by 崔明辉 on 2017/10/17.
//  Copyright © 2017年 UED Center. All rights reserved.
//

#import "SVGAImageView.h"
#import "SVGAParser.h"

//static SVGAParser *sharedParser;

//@interface SVGAImageView ()
//@property (nonatomic, strong) SVGAParser *sharedParser;
//@end

@implementation SVGAImageView {
    SVGAParser *sharedParser;
}

//+ (void)load {
//    sharedParser = [SVGAParser new];
//}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _autoPlay = YES;
        sharedParser = [SVGAParser new];
        sharedParser.checkURLChange = YES;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _autoPlay = YES;
        sharedParser = [SVGAParser new];
        sharedParser.checkURLChange = YES;
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    if ([imageName hasPrefix:@"http://"] || [imageName hasPrefix:@"https://"]) {
        __weak SVGAImageView *weakSelf = self;
        [self loadSvgWithURL:[NSURL URLWithString:imageName] completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
            [weakSelf setVideoItem:videoItem];
            if (weakSelf.autoPlay) {
                [weakSelf startAnimation];
            }
        } failureBlock:nil];
    }
    else {
        __weak SVGAImageView *weakSelf = self;

        [sharedParser parseWithNamed:imageName inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
            [weakSelf setVideoItem:videoItem];
            if (weakSelf.autoPlay) {
                [weakSelf startAnimation];
            }
        } failureBlock:nil];
    }
}

- (void)loadSvgWithURL:(NSURL *)url
        completionBlock:(void (^)(SVGAVideoEntity * _Nullable))completionBlock
          failureBlock:(void (^)(NSError * _Nullable))failureBlock {
    if (!url) {
        if (failureBlock) {
            failureBlock(nil);
        }
        return;
    }
    [sharedParser parseWithURL:url completionBlock:completionBlock failureBlock:failureBlock];
}

@end
