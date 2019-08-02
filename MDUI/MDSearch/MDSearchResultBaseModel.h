//
//  MDSearchResultBaseModel.h
//  MDUI
//
//  Created by 李永杰 on 2019/7/30.
//

#import <Foundation/Foundation.h>
@class MDResultUIModel;
@interface MDSearchResultBaseModel : NSObject

@property (nonatomic, copy) NSString            *resultName;

@property (nonatomic, copy) MDResultUIModel     *uiModel;

@end

@interface MDResultUIModel : NSObject

@property (nonatomic, assign) CGFloat    rowHeight;

@property (nonatomic, strong) UIColor    *textColor;

@end

