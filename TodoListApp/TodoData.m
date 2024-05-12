//
//  TodoData.m
//  TodoListApp
//
//  Created by Marim Mohamed Mohamed Yacout on 21/04/2024.
//

#import "TodoData.h"

@implementation TodoData

- (void)encodeWithCoder:(nonnull NSCoder *)acoder {
    [acoder encodeObject:self.title forKey:@"Title"];
    [acoder encodeObject:self.desc forKey:@"Description"];
    [acoder encodeObject:self.piroity forKey:@"Priority"];
    [acoder encodeObject:self.status forKey:@"Status"];
    [acoder encodeObject:self.dt forKey:@"Date"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)acoder {
    if (self = [super init]) {
        self.title = [acoder decodeObjectForKey:@"Title"];
        self.desc = [acoder decodeObjectForKey:@"Description"];
        self.piroity = [acoder decodeObjectForKey:@"Priority"];
        self.status = [acoder decodeObjectForKey:@"Status"];
        self.dt = [acoder decodeObjectForKey:@"Date"];
    }
    return self;
}

@end
