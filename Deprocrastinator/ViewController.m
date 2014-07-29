//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Nicolas Semenas on 28/07/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic) BOOL edit;

@end

@implementation ViewController



- (IBAction)onSwipe:(UISwipeGestureRecognizer *)gestureRecognizer
{
    // find the cell that was
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [gestureRecognizer locationInView:self.myTableView];
        NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:location];
        UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
        
        // if the cell exists and it has text, change its text color
        if (cell && [cell.textLabel.text length] > 0) {
            [self setCellTextLabelPriorityColor:cell];
        }
    }
    
}

- (IBAction)onEditButtonPressed:(UIButton*)sender {
    
    
    if (self.edit == NO){
         [sender setTitle: @"Done" forState: UIControlStateNormal];
        self.edit = YES;
    } else {
        
        [sender setTitle: @"Edit" forState: UIControlStateNormal];
        self.edit = NO;

    }
    
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.edit == NO){

    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor greenColor];
        
    } else {
        
        [self.items removeObjectAtIndex:indexPath.row];
        [self.myTableView reloadData];
        
        

        
    }
}
    


- (IBAction)onAddButtonPressed:(id)sender {
    
    [self.items addObject:self.myTextField.text];
    [self.myTableView reloadData];
    self.myTextField.text = @"";
    [self.myTextField resignFirstResponder];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = [[NSMutableArray alloc] init];
    [self.items addObject:@"one"];
    [self.items addObject:@"two"];
    [self.items addObject:@"three"];
    [self.items addObject:@"four"];
    
    self.edit = NO;
    
    
}

#pragma mark - Helpher Methods

-(void)setCellTextLabelPriorityColor:(UITableViewCell*)cell{
    
    UIColor * actualColor = cell.textLabel.textColor;
    
    
    if ([actualColor isEqual:[UIColor greenColor]]){
        cell.textLabel.textColor = [UIColor yellowColor];
    } else if ([actualColor isEqual:[UIColor yellowColor]]){
        cell.textLabel.textColor = [UIColor redColor];
    } else if ([actualColor isEqual:[UIColor redColor]]){
        cell.textLabel.textColor = [UIColor greenColor];
    }
}


#pragma mark - Table View Delegate Methods


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
     return self.items.count;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES - we will be able to delete all rows
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Perform the real delete action here. Note: you may need to check editing style
    [self.items removeObjectAtIndex:indexPath.row];
    [self.myTableView reloadData];
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"%i",fromIndexPath.row);
    NSLog(@"%i",toIndexPath.row);


}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


@end
