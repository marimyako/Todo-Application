//
//  DoneViewController.h
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "TodoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *doneTableView;


@property (nonatomic, strong) NSMutableArray<TodoData *> *todoItems;
@property (nonatomic, strong) NSMutableArray<TodoData *> *filteredTodoItems; 

@end


NS_ASSUME_NONNULL_END
