//
//  DoneViewController.m
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

#import "DoneViewController.h"
#import "TodoDetailsViewController.h"
#import "TodoDetailsViewControllerDelegate.h"
#import "TodoData.h"
#import "ViewController.h"

@interface DoneViewController ()

@end
typedef NS_ENUM(NSInteger, TodoPrioritySection) {
    TodoPrioritySectionLow,
    TodoPrioritySectionMedium,
    TodoPrioritySectionHigh,
    TodoPrioritySectionCount
};
@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.doneTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"celld"];
    self.doneTableView.delegate = self;
    self.doneTableView.dataSource = self;
    self.todoItems = [NSMutableArray array];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
           NSData *retrievedData = [defaults objectForKey:@"DoneToDo"];
           
           if (retrievedData) {
               NSArray *tempArray = [NSKeyedUnarchiver unarchiveObjectWithData:retrievedData];
               if ([tempArray isKindOfClass:[NSArray class]]) {
                   self.todoItems = [NSMutableArray arrayWithArray:tempArray];
               } else {
                   self.todoItems = [NSMutableArray array];
               }
           } else {
               self.todoItems = [NSMutableArray array];
           }
    
   NSArray *todo = [self.todoItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.status == %@", @"Done"]];
        
    
    
    
   /* NSData *todoItemsData = [NSKeyedUnarchiver unarchiveObjectWithData:self.todoItems];
    [[NSUserDefaults standardUserDefaults] setObject:todoItemsData forKey:@"TodoItems"];
    [[NSUserDefaults standardUserDefaults] synchronize];
      // Reload table view data to reflect the changes
      [self.todoTableView reloadData];
      for (TodoData *todoItem in self.todoItems) {
          if ([todoItem.status isEqual:@"todo"]) {
              [filteredItems addObject:todoItem];
          }
      }*/
      self.filteredTodoItems = [NSMutableArray arrayWithArray:todo ];
    [self.doneTableView reloadData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredTodoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celld" forIndexPath:indexPath];
    
    if (self.filteredTodoItems.count > 0) {
           TodoData *todoItem = self.filteredTodoItems[indexPath.row];
           cell.textLabel.text =todoItem.title;
        NSLog(@"%@",todoItem.title);
       
       } else {
           cell.textLabel.text = @"No items";
           
       }
       
       return cell;
     
}


#pragma mark - TodoDetailsViewControllerDelegate

/*- (void)todoDetailsViewControllerDidSaveTodoItem:(TodoData *)todoItem {
    [self.todoItems addObject:todoItem];
       
       // Update filteredTodoItems with a mutable copy of todoItems
       self.filteredTodoItems = [self.todoItems mutableCopy];
       
       // Reload table view data to reflect the changes
       [self.todoTableView reloadData];

       // Save todoItems to user defaults
       NSData *todoItemsData = [NSKeyedArchiver archivedDataWithRootObject:self.todoItems];
       [[NSUserDefaults standardUserDefaults] setObject:todoItemsData forKey:@"TodoItems"];
       [[NSUserDefaults standardUserDefaults] synchronize];
}*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      
        [self.todoItems removeObjectAtIndex:indexPath.row];
        
       
        self.filteredTodoItems = [self.todoItems mutableCopy];
        
       
        NSData *todoItemsData = [NSKeyedArchiver archivedDataWithRootObject:self.todoItems];
        [[NSUserDefaults standardUserDefaults] setObject:todoItemsData forKey:@"DoneToDo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
