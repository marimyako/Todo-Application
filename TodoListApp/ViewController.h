//
//  ViewController.h
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "TodoData.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
- (IBAction)plus:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (weak, nonatomic) IBOutlet UITableView *todoTableView;

@property (nonatomic, strong) NSMutableArray<TodoData *> *todoItems;
@property (nonatomic, strong) NSMutableArray<TodoData *> *filteredTodoItems; 


@property (nonatomic, strong) NSMutableArray<TodoData *> *lowPriorityItems;
@property (nonatomic, strong) NSMutableArray<TodoData *> *mediumPriorityItems;
@property (nonatomic, strong) NSMutableArray<TodoData *> *highPriorityItems;

@end

