//
//  EditTableViewCell.h
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 22/04/2024.
//

#import <UIKit/UIKit.h>
#import "TodoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *editTitle;
@property (weak, nonatomic) IBOutlet UITextView *editDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editProity;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editStatus;
@property (weak, nonatomic) IBOutlet UIDatePicker *editDT;
- (IBAction)edit:(UIButton *)sender;
@property (nonatomic, strong) TodoData *edittodoItem;

@end

NS_ASSUME_NONNULL_END
