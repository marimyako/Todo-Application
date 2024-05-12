//
//  TodoDetailsViewController.h
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "TodoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface TodoDetailsViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextView *DESC;
-  (IBAction)status:(UISegmentedControl *)sender;

- (IBAction)add:(UIButton *)sender;

@property (nonatomic, strong) TodoData *todoItem;

@property (nonatomic, strong) NSString *selectedStatus;
//@property (nonatomic, strong) NSString *selectedPriority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priorityyyy;

@property (weak, nonatomic) IBOutlet UISegmentedControl *status;
@property (weak, nonatomic) IBOutlet UIDatePicker *dt;


@end

NS_ASSUME_NONNULL_END
