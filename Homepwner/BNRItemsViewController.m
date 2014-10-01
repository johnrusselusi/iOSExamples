//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by John Russel Usi on 9/29/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  BNRDetailViewController *detailViewController =
        [[BNRDetailViewController alloc] initForNewItem:NO];
  
  NSArray *items = [[BNRItemStore sharedStore]allItems];
  BNRItem *selectedItem = items[indexPath.row];
  
  //  Give detail view controller a pointer to the item object in row
  detailViewController.item = selectedItem;
  
  //  Push it onto the top of the navigation controller's stack
  [self.navigationController pushViewController:detailViewController
                                      animated:YES];
}

#pragma mark - IBActions

- (IBAction)addNewItem:(id)sender{

  //  Create a new BNRItem and add it to the store
  BNRItem *newItem = [[BNRItemStore sharedStore]createItem];
  
  BNRDetailViewController *detailViewController =
  [[BNRDetailViewController alloc]initForNewItem:YES];
  
  detailViewController.item = newItem;
  
  UINavigationController *navController = [[UINavigationController alloc]
                                           initWithRootViewController:detailViewController];
  
  detailViewController.dismissBlock = ^{
    [self.tableView reloadData];
  };
  
  navController.modalPresentationStyle = UIModalPresentationFormSheet;
  
  [self presentViewController:navController animated:YES completion:NULL];
}

#pragma mark - Lifecycle

- (instancetype)init{
  
  // Call the superclass'designated initializer
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"Homepwner";
    
    // Create a new bar button item that will send
    // addNewItem: to BNRItemsViewController
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(addNewItem:)];
    // Set this bar button item as the right item in the navigationItem
    navItem.rightBarButtonItem = bbi;
    
    navItem.leftBarButtonItem = self.editButtonItem;
  }
  
  return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{

  return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
  
  return [[[BNRItemStore sharedStore]allItems]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  //  Get a new or recycled
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                      forIndexPath:indexPath];
  
  //  Set the text on the cell with the description of the item
  //  that is at the nth index of items, where n = row this cell
  //  will appear in on the table
  NSArray *items = [[BNRItemStore sharedStore]allItems];
  BNRItem *item = items[indexPath.row];
  
  cell.textLabel.text = [item description];
  
  return cell;
}

- (void)viewDidLoad{

  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
      forRowAtIndexPath:(NSIndexPath *)indexPath{

  //  If the table view is asking to commit a delegate command...
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    BNRItem *item = items[indexPath.row];
    [[BNRItemStore sharedStore]removeItem:item];
    
    //  Also remove that row from the table view with animation
    [tableView deleteRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (void)tableView:(UITableView *)tableView
      moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath{

  [[BNRItemStore sharedStore]moveItemAtIndex:sourceIndexPath.row
                                     toIndex:destinationIndexPath.row];
}

- (void)viewWillAppear:(BOOL)animated{

  [super viewWillAppear:animated];
  
  [self.tableView reloadData];
}

@end
