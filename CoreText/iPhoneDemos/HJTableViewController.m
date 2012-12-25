//
//  CSTableViewController.m
//  HuiYiTong
//
//  Created by Yu Hao on 12-7-18.
//  Copyright (c) 2012年 CSDN.net. All rights reserved.
//
#import <Social/Social.h>
#import "HJTableViewController.h"
#import "JSONKit.h"
#import "HJTableViewCell.h"

@interface HJTableViewController ()


@end


@implementation HJTableViewController

- (id)initWithJsonFile:(NSString *)jsonPath;
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonPath ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    return [self initWithJsonData:jsonData];    
    
}

- (id)initWithJsonData:(NSData *)jsonData
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        
        self.jsonRoot = (NSDictionary *)[jsonData objectFromJSONData];
//        for (NSString *row in [self.jsonRoot[@"sections"]allKeys]) {
//            NSLog(@"%@",row);
//        }
//        NSLog(@"%@",self.jsonRoot);
        /*
         NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
         jsonRoot = (NSDictionary *) [jsonString objectFromJSONString];
         
         NSError *jsonParsingError = nil;
         jsonRoot = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:&jsonParsingError];
         */
        
    }
    return  self;    
}

- (id)initWithJsonObject:(NSDictionary *)jsonObject
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.jsonRoot = jsonObject;
    }
    return  self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.jsonRoot!=nil)
    {
        self.title = (NSString *) [self.jsonRoot objectForKey:@"title"];
    }
    self.navigationController.navigationBarHidden = NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    int section_count = [self.jsonRoot[@"sections"] count];
    return section_count;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sections = (NSDictionary *)[self.jsonRoot objectForKey:@"sections"];
    return (NSString *)([sections allKeys][section]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sections = (NSDictionary *)[self.jsonRoot objectForKey:@"sections"];
    NSString *key = [sections allKeys][section];
    NSDictionary *section_obj = [sections objectForKey:key];
    return [section_obj count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    int section_count = [self.jsonRoot[@"sections"] count];
    if(section_count > 1)
    {
        return 35;
    }else{
        NSString *section_title = [self.jsonRoot[@"sections"] allKeys][0];
        if ([section_title isEqualToString:self.title]) {
            return 0;
        }else
             return  35;
    }
        
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     NSString *text = [items objectAtIndex:[indexPath row]];
     // Get a CGSize for the width and, effectively, unlimited height
     CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
     // Get the size of the text given the CGSize we just made as a constraint
     CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
     // Get the height of our measurement, with a minimum of 44 (standard cell size)
     CGFloat height = MAX(size.height, 44.0f);
     // return the height, with a bit of extra padding in
     return height + (CELL_CONTENT_MARGIN * 2);     
     */
    NSDictionary *cellData = [self cellDataAtIndex:indexPath];
    if(cellData[@"image"]!=nil)
    {
        return 67;
    }else if (cellData[@"subtitle"]!=nil)
    {
        return 50;
    }else
    {
        return 44;
    }

}

- (NSDictionary *) cellDataAtIndex:(NSIndexPath *)indexPath
{
    NSDictionary *sections = (NSDictionary *)[self.jsonRoot objectForKey:@"sections"];
    
    NSDictionary *cellData = [sections allValues][indexPath.section][indexPath.row];
    return cellData;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil)
    {
        cell = [[HJTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        //cell.userInteractionEnabled = NO;
    }
    
    
    NSDictionary *cellData = [self cellDataAtIndex:indexPath];
    
    cell.textLabel.text = (NSString *)[cellData objectForKey:@"title"];
    cell.detailTextLabel.text = (NSString *)[cellData objectForKey:@"subtitle"];
    cell.actionController = (NSString *)[cellData objectForKey:@"action"];

    if (cell.actionController==nil) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    // Configure the cell...
    NSString *base64String = (NSString *)[cellData objectForKey:@"image"];
    if(base64String!=nil){
        if([base64String length]<15)
        {
            NSString *path = [[NSBundle mainBundle]pathForResource:base64String ofType:nil];
            if (path) {
                cell.imageView.image = [UIImage imageWithContentsOfFile:path];
            }
        }else
        {
            NSURL *url = [NSURL URLWithString:base64String];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *ret = [UIImage imageWithData:imageData];
            cell.imageView.image = ret;
        }
    }

    cell.tag = [(NSNumber * )[cellData objectForKey:@"id"] intValue];
    
    //    cell.imageView.image = [[UIImage imageNamed:@"avatar"]scaleToSize:CGSizeMake(60, 60)];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
//    Class controllerClass = NSClassFromString(self.controllerName);
//    id view = [[controllerClass alloc]initWithStyle:UITableViewStylePlain];
    
    
    HJTableViewCell *cell = (HJTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    id controller =[[NSClassFromString(cell.actionController) alloc] init];

    
//    if([view respondsToSelector:@selector(setTrackId:)])
//    {
//        [view performSelector:@selector(setTrackId:) withObject:@(cell.tag)];
//    }
    //[view setTrackId:cell.tag];
    if(controller==nil)
        return ;
    [controller setTitle:cell.textLabel.text];
    
    [self.navigationController pushViewController:controller animated:YES];

}

@end
