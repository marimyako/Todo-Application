//
//  TodoData.h
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodoData : NSObject  <NSCoding>

@property NSString *title;
@property NSString *desc;
@property NSString *piroity;
@property NSString *status;
@property NSDate *dt;

@property (nonatomic, strong) NSMutableArray<TodoData *> *todoItems;
//@property (nonatomic, strong) NSString *selectedPriority;
@property (nonatomic, strong) NSString *priority;
@end

NS_ASSUME_NONNULL_END
