//
//  ViewController.m
//  Table Option
//
//  Created by MagicStudio on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize list;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:
                             @"Horse", @"Sheep", @"Pig", @"Dog",
                             @"Cat", @"Chicken", @"Duck", @"Goose",
                             @"Tree", @"Flower", @"Grass", @"Fence",
                             @"House", @"Table", @"Chair", @"Book",
                             @"Swing" ,nil];
    self.list = array;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //启动表格的编辑模式
    [self.myTableView setEditing:YES animated:YES];

}

//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.list removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }else {
        //我们实现的是在所选行的位置插入一行，因此直接使用了参数indexPath
        NSArray *insertIndexPaths = [NSArray arrayWithObjects:indexPath,nil];
        //同样，将数据加到list中，用的row
        [self.list insertObject:@"新添加的行" atIndex:row];
        [tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

//打开编辑模式后，默认情况下每行左边会出现红的删除按钮，这个方法就是关闭这些按钮的
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleInsert;
}

//这个方法用来告诉表格 这一行是否可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//这个方法就是执行移动操作的
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)
sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [list objectAtIndex:fromRow];
    [list removeObjectAtIndex:fromRow];
    [list insertObject:object atIndex:toRow];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - 
#pragma mark Table View Data Source Methods 
//返回行数
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section { 
    return [self.list count]; 
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
    if (oneCell.accessoryType == UITableViewCellAccessoryNone) {
        oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
        oneCell.accessoryType = UITableViewCellAccessoryNone;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//新建某一行并返回
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier"; 
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: 
                             TableSampleIdentifier]; 
    if (cell == nil) { 
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleDefault 
                reuseIdentifier:TableSampleIdentifier]; 
    } 
    
    NSUInteger row = [indexPath row]; 
    cell.textLabel.text = [list objectAtIndex:row]; 
	return cell; 
}

@end
