//
//  ClassifyTableViewController.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-6.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "ClassifyTableViewController.h"
#import "ContentViewController1.h"
#import "ClassifyData1.h"
#import "ClassifyData2.h"
#import "ClassifyData3.h"
#import "ClassifyDataHandle1.h"
#import "ClassifyDataHandle2.h"
#import "ClassifyDataHandle3.h"

@interface ClassifyTableViewController ()
{
    NSString *string1;
    NSString *string2;
    NSString *string3;
}
@end

@implementation ClassifyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pui_sharingbtn@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButton)];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    self.tableView.rowHeight = 60;
    self.arrayTitle = @[@"电影", @"电视剧", @"综艺", @"动漫"];
    
    self.classifyData1 = [[ClassifyData1 alloc] init];
    self.classifyData2 = [[ClassifyData2 alloc] init];
    self.classifyData3 = [[ClassifyData3 alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.textLabel.text = _arrayTitle[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyDataHandle1 *classifyDataHandle1 = [ClassifyDataHandle1 shareClassifyDataHandle1];
    classifyDataHandle1.picArray1 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle1.nameArray1 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle1.IDArray1 = [NSMutableArray arrayWithCapacity:0];
    ClassifyDataHandle2 *classifyDataHandle2 = [ClassifyDataHandle2 shareClassifyDataHandle2];
    classifyDataHandle2.picArray2 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle2.nameArray2 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle2.IDArray2 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle2.titleArray2 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle2.cellNumber2 = [NSMutableArray arrayWithCapacity:0];
//    classifyDataHandle2.titleNumber2 = [NSMutableArray arrayWithCapacity:0];
    ClassifyDataHandle3 *classifyDataHandle3 = [ClassifyDataHandle3 shareClassifyDataHandle3];
    classifyDataHandle3.picArray3 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle3.nameArray3 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle3.IDArray3 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle3.areaArray3 = [NSMutableArray arrayWithCapacity:0];
    classifyDataHandle3.typeArray3 = [NSMutableArray arrayWithCapacity:0];
    
    if (indexPath.row == 0) {
        string1 = @"http://pm.funshion.com/v5/media/recommend?channel=1&pg=1&fudid=d73364da0ed90fd960d10cd964deb6da0706efd9e0ce181dc8cb04a340716675&cl=aphone&ve=2.2.5.4&mac=087a4ca86a0a&uc=6";
        string2 = @"http://pm.funshion.com/v5/media/album?channel=1&pg=1&fudid=d73364da0ed90fd960d10cd964deb6da0706efd9e0ce181dc8cb04a340716675&cl=aphone&ve=2.2.5.4&mac=087a4ca86a0a&uc=6";
        string3 = @"http://pm.funshion.com/v5/media/top?channel=1&rank=daily&cl=aphone&ve=2.2.5.4&mac=087a4ca86a0a&uc=6";
    } else if (indexPath.row == 1) {
        string1 = @"http://pm.funshion.com/v5/media/recommend?channel=2&cl=iphone&fudid=D4BAAE380E500E500F500F50740CF20469603E316A326A646E313C3636683967&pg=1&si=0&uc=6&ve=2.0.9.9";
        string2 = @"http://pm.funshion.com/v5/media/album?channel=2&cl=iphone&pg=1&si=0&uc=6&ve=2.0.9.9";
        string3 = @"http://pm.funshion.com/v5/media/top?channel=2&cl=iphone&rank=daily&si=0&uc=6&ve=2.0.9.9";
    } else if (indexPath.row == 2) {
        string1 = @"http://pm.funshion.com/v5/media/recommend?channel=4&cl=iphone&fudid=D4BAAE380E500E500F500F50740CF20469603E316A326A646E313C3636683967&pg=1&si=0&uc=6&ve=2.0.9.9";
        string2 = @"http://pm.funshion.com/v5/media/album?channel=4&cl=iphone&pg=1&si=0&uc=6&ve=2.0.9.9";
        string3 = @"http://pm.funshion.com/v5/media/top?channel=4&cl=iphone&rank=daily&si=0&uc=6&ve=2.0.9.9";
    } else if (indexPath.row == 3) {
        string1 = @"http://pm.funshion.com/v5/media/recommend?channel=3&cl=iphone&fudid=D4BAAE380E500E500F500F50740CF20469603E316A326A646E313C3636683967&pg=1&si=0&uc=6&ve=2.0.9.9";
        string2 = @"http://pm.funshion.com/v5/media/album?channel=3&cl=iphone&pg=1&si=0&uc=6&ve=2.0.9.9";
        string3 = @"http://pm.funshion.com/v5/media/top?channel=3&cl=iphone&rank=daily&si=0&uc=6&ve=2.0.9.9";
    }
      __weak ClassifyTableViewController *blockSelf = self;
    [blockSelf.classifyData1 getData1:string1 block:^(NSDictionary *dicData1) {
        for (NSDictionary *dic1 in [dicData1 objectForKey:@"medias"]) {
            [classifyDataHandle1.nameArray1 addObject:  [dic1 objectForKey:@"name"]];
            [classifyDataHandle1.picArray1 addObject: [dic1 objectForKey:@"focus"]];
            [classifyDataHandle1.IDArray1 addObject: [dic1 objectForKey:@"id"]];
        }
        [blockSelf.classifyData2 getData2:string2 block:^(NSDictionary *dicData2) {
            for (NSDictionary *dic2 in [dicData2 objectForKey:@"blocks"]) {
                [classifyDataHandle2.titleArray2 addObject: [dic2 objectForKey:@"name"]];
               [classifyDataHandle2.cellNumber2 addObject:[dic2 objectForKey:@"contents"]];
                for (NSDictionary *Dic in [dic2 objectForKey:@"contents"]) {
                    [classifyDataHandle2.IDArray2 addObject:[Dic objectForKey:@"id"]];
                    [classifyDataHandle2.nameArray2 addObject:[Dic objectForKey:@"name"]];
                    [classifyDataHandle2.picArray2 addObject:[Dic objectForKey:@"poster"]];
                }
            }
            
        [blockSelf.classifyData3 getData3:string3 block:^(NSDictionary *dicData3) {
            for (NSDictionary *dic3 in [dicData3 objectForKey:@"medias"]) {
                [classifyDataHandle3.IDArray3 addObject:[dic3 objectForKey:@"id"]];
                [classifyDataHandle3.nameArray3 addObject:[dic3 objectForKey:@"name"]];
                [classifyDataHandle3.picArray3 addObject:[dic3 objectForKey:@"poster"]];
                [classifyDataHandle3.areaArray3 addObject:[dic3 objectForKey:@"area"]];
                [classifyDataHandle3.typeArray3 addObject:[dic3 objectForKey:@"category"]];
            }
            ContentViewController1 *contentViewController = [[ContentViewController1 alloc] init];
            [self.navigationController pushViewController:contentViewController animated:YES];
        }];
      }];
    }];
    
    
    
}


- (void)shareButton
{
    NSLog(@"分享未完成");
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
