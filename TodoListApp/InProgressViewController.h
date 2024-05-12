//
//  InProgressViewController.h
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "TodoData.h"


NS_ASSUME_NONNULL_BEGIN

@interface InProgressViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *inprogressTableView;
@property (nonatomic, strong) NSMutableArray<TodoData *> *todoItems;
@property (nonatomic, strong) NSMutableArray<TodoData *> *filteredTodoItems;

@property (nonatomic, strong) NSMutableArray<TodoData *> *lowPriorityItems;
@property (nonatomic, strong) NSMutableArray<TodoData *> *mediumPriorityItems;
@property (nonatomic, strong) NSMutableArray<TodoData *> *highPriorityItems;
- (IBAction)fillter:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
