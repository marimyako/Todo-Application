//
//  TodoDetailsViewController.m
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

#import "TodoDetailsViewController.h"
#import "TodoData.h"

@interface TodoDetailsViewController ()

@end

@implementation TodoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)add:(UIButton *)sender {
   
    TodoData *todoItem = [[TodoData alloc] init];
    todoItem.title = self.titleTF.text;
    todoItem.desc = self.DESC.text;
    todoItem.status=self.status;
    todoItem.piroity = self.priorityyyy;
    todoItem.dt=self.dt.date;
    //printf("%s\n",todoItem.piroity.UTF8String);
   // printf("%s\n",todoItem.status.UTF8String);
 /* NSString *oo = [todoItem setPiroity:[self.priorityyyy titleForSegmentAtIndex:self.priorityyyy.selectedSegmentIndex]];*/
    
    NSLog(@"Title: %@", self.titleTF.text);
                NSLog(@"Description: %@", self.DESC.text);
                NSLog(@"Priority: %@", [self.priorityyyy titleForSegmentAtIndex:self.priorityyyy.selectedSegmentIndex]);
                NSLog(@"Status: %@", [self.status titleForSegmentAtIndex:self.status.selectedSegmentIndex]);
    
    NSLog(@"d: %@", self.dt.date);
               // NSLog(@"Date: %@", formattedDate);
    ///NSLog(@"%@",oo);
  //  NSLog(@"%@",todoItem.title);
   
        NSData *todoItemsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"TodoItems"];
        NSMutableArray *todoItems = [NSMutableArray array];
        if (todoItemsData) {
            [todoItems addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:todoItemsData]];
        }
        
       
        [todoItems addObject:todoItem];
        
        NSData *updatedTodoItemsData = [NSKeyedArchiver archivedDataWithRootObject:todoItems];
        [[NSUserDefaults standardUserDefaults] setObject:updatedTodoItemsData forKey:@"TodoItems"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"Todo item saved successfully." preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
       [alert addAction:okAction];
       [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)dt:(UIDatePicker *)sender {
}


@end
