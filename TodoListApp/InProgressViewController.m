//
//  InProgressViewController.m
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

// InProgressViewController.m

#import "InProgressViewController.h"
#import "TodoDetailsViewController.h"
#import "TodoDetailsViewControllerDelegate.h"
#import "TodoData.h"
#import "ViewController.h"

typedef NS_ENUM(NSInteger, TodoPrioritySection) {
    TodoPrioritySectionLow,
    TodoPrioritySectionMedium,
    TodoPrioritySectionHigh,
    TodoPrioritySectionCount 
};

@implementation InProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.inprogressTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellp"];
    self.inprogressTableView.delegate = self;
    self.inprogressTableView.dataSource = self;
    self.todoItems = [NSMutableArray array];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
           NSData *retrievedData = [defaults objectForKey:@"Progress"];
    [self.inprogressTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
           NSData *retrievedData = [defaults objectForKey:@"Progress"];
           
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
    
   NSArray *todo = [self.todoItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.status == %@", @"InProgress"]];
        
    
    
    
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
    [self.inprogressTableView reloadData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredTodoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellp" forIndexPath:indexPath];
    
    if (self.filteredTodoItems.count > 0) {
           TodoData *todoItem = self.filteredTodoItems[indexPath.row];
           cell.textLabel.text =todoItem.title;
        NSLog(@"%@",todoItem.title);
          
       } else {
           cell.textLabel.text = @"No items";
         
       }
       
       return cell;
     
}

- (IBAction)plus:(UIBarButtonItem *)sender {
    TodoDetailsViewController *detailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
  //  detailsVC.delegate = self;
    [self.navigationController pushViewController:detailsVC animated:YES];
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
        [[NSUserDefaults standardUserDefaults] setObject:todoItemsData forKey:@"Progress"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)fillter:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Filter by Priority" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *lowAction = [UIAlertAction actionWithTitle:@"Low" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self filterByPriority:@"Low"];
    }];
    UIAlertAction *mediumAction = [UIAlertAction actionWithTitle:@"Medium" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self filterByPriority:@"Medium"];
    }];
    UIAlertAction *highAction = [UIAlertAction actionWithTitle:@"High" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self filterByPriority:@"High"];
    }];
    
    [alertController addAction:lowAction];
    [alertController addAction:mediumAction];
    [alertController addAction:highAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)filterByPriority:(NSString *)priority {
    NSArray *filteredItems = [self.todoItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"priority == %@", priority]];
    self.filteredTodoItems = [NSMutableArray arrayWithArray:filteredItems];
    [self.inprogressTableView reloadData];
}
@end
