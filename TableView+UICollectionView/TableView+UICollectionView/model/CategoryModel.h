//
//  CategoryModel.h
//  Seller
//
//  Created by 崔忠海 on 2016/10/18.
//  Copyright © 2016年 bfme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdCateforyModel : NSObject
@property (nonatomic, copy) NSString *catId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@end

@interface SecCategoryModel : NSObject
@property (nonatomic, copy) NSString *catId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray <ThirdCateforyModel *>*array;

@end

@interface CategoryModel : NSObject

@property (nonatomic, copy) NSString *catId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray <SecCategoryModel *> *array;

@end
