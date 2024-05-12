//
//  ViewController.m
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

#import "ViewController.h"
#import "TodoDetailsViewController.h"
#import "TodoData.h"
#import "TodoDetailsViewControllerDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.todoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.todoTableView.delegate = self;
    self.todoTableView.dataSource = self;
    self.todoItems = [NSMutableArray array];
    self.search.delegate = self;
    self.search.autocapitalizationType = UITextAutocapitalizationTypeNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
           NSData *retrievedData = [defaults objectForKey:@"TodoItems"];
           
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
    
 /*  NSArray *todo = [self.todoItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.status == %@", @"TODO"]];*/
        
  
    
    
    
    
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
      self.filteredTodoItems = [NSMutableArray arrayWithArray:self.todoItems ];
           [self.todoTableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredTodoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    TodoData *todoItem = self.filteredTodoItems[indexPath.row];
    cell.textLabel.text = todoItem.title;
   /* if ([todoItem.priority isEqualToString:@"Medium"]) {
            cell.imageView.image = [UIImage imageNamed:@"medium.png"];
        } else if ([todoItem.priority isEqualToString:@"Low"]) {
            cell.imageView.image = [UIImage imageNamed:@"low.png"];
        }else if ([todoItem.priority isEqualToString:@"High"]){
            cell.imageView.image = [UIImage imageNamed:@"high.png"];
        }*/
        
        return cell;
     
}

-(void) viewWillDisappear:(BOOL)animated{
    [self progress];
    [self done];
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
        [[NSUserDefaults standardUserDefaults] setObject:todoItemsData forKey:@"TodoItems"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
    
        self.filteredTodoItems = [self.todoItems mutableCopy];
    } else {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText];
        self.filteredTodoItems = [[self.todoItems filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    [self.todoTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    self.filteredTodoItems = [self.todoItems mutableCopy];
    [self.todoTableView reloadData];
}
-(void) progress {
    NSArray *progressItems = [self.todoItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.status == %@", @"InProgress"]];
    NSData *progressData = [NSKeyedArchiver archivedDataWithRootObject:progressItems];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:progressData forKey:@"Progress"];
    [userDefaults synchronize];
}

-(void) done {
    NSArray *progressItems = [self.todoItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.status == %@", @"Done"]];
    NSData *progressData = [NSKeyedArchiver archivedDataWithRootObject:progressItems];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:progressData forKey:@"DoneToDo"];
    [userDefaults synchronize];
}
@end
