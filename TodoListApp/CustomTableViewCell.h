//
//  CustomTableViewCell.h
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 22/04/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *customImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
