//
//  BusViewController.m
//  GeEuro
//
//  Created by Ahmad Farrag on 10/9/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import "BusViewController.h"
#import "BusTableViewCell.h"
#import "GoEuroNetworking.h"
#import "DiskPersistance.h"
#import "GoEuro-Swift.h"

static const CGFloat kBusCellHeight = 99;

static const NSString *kBusesEndpoint = @"37yzm";
static const NSString *kBusIDKey = @"id";
static const NSString *kBusArrivalTimeKey = @"arrival_time";
static const NSString *kBusDepartureTimeKey = @"departure_time";
static const NSString *kBusNumberOfStopsKey = @"number_of_stops";
static const NSString *kBusPriceInEurosKey = @"price_in_euros";
static const NSString *kBusProviderLogoKey = @"provider_logo";

@interface BusViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *busTableView;
@property (nonatomic, strong) NSMutableArray *busesTicketsArray;

@end

@implementation BusViewController

- (instancetype)init {
    self = [super initWithNibName:@"BusViewController" bundle:[NSBundle mainBundle]];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self registerCell];
    self.busTableView.userInteractionEnabled = YES;
    self.busTableView.delegate = self;
    self.busTableView.dataSource = self;
    
    self.busesTicketsArray = [[NSMutableArray alloc] init];
    
    NSData *jsonData = [[DiskPersistance sharedInstance] loadDataWithName:kBusesEndpoint];
    if (jsonData != nil) {
        [self populateBusTableViewWith:jsonData];
        return;
    }
    
    [[GoEuroNetworking sharedInstance] getJSONResponseForEndpoint:kBusesEndpoint withCompletionHandler:^(id response, NSError *error) {
        if (error == nil) {
            [[DiskPersistance sharedInstance] cacheResponse:response withName:kBusesEndpoint];
            [self populateBusTableViewWith:response];
            
        } else {
            [self presentAlertWithTitle:@"Error" description:@"No Internet Connection!" andActionString:@"OK"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Deleagte and Datasource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.busesTicketsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusCellIdentifier"];
    return [self configureCell:cell forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self presentAlertWithTitle:@"Alert!" description:@"Offer details are not yet implemented!" andActionString:@"OK"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kBusCellHeight;
}

#pragma mark - Helpers

- (void)registerCell {
    [self.busTableView registerNib:[UINib nibWithNibName:@"BusTableViewCell"
                                                  bundle:nil]
            forCellReuseIdentifier:@"BusCellIdentifier"];
}

- (BusTableViewCell *)configureCell:(BusTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    cell.providerImageView.image = nil;
    
    TicketInfo *ticket = self.busesTicketsArray[indexPath.row];
    cell.tag = indexPath.row;
    cell.intervalTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", ticket.departureTime, ticket.arrivalTime];
    cell.priceLabel.text = [NSString stringWithFormat:@"%.2f €", ticket.price];
    if (ticket.numberOfStops > 1) {
        cell.stopsLabel.text = [NSString stringWithFormat:@"%ld stops", (long)ticket.numberOfStops];
    }
    
    UIImage *providerImage = [self loadCachedImageWithName:[ticket.providerLogo lastPathComponent]];
    if (providerImage != nil) {
        cell.providerImageView.image = providerImage;
        return cell;
    }
    [[GoEuroNetworking sharedInstance] getImageFromPath:ticket.providerLogo
                                  withCompletionHandler:^(id response, NSError *error) {
                                      if (error == nil) {
                                          if (cell.tag == indexPath.row) {
                                              
                                              UIImage *image = [UIImage imageWithData:response];
                                              [[DiskPersistance sharedInstance] cacheImage:image
                                                                                  withName:[ticket.providerLogo lastPathComponent]];
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  cell.providerImageView.image = image;
                                              });
                                          }
                                      } else {
                                          
                                      }
                                  }];
    return cell;
}

- (void)presentAlertWithTitle:(NSString *)title description:(NSString *)description andActionString:(NSString *)actionString {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
//                                                                             message:description
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:actionString
//                                                     style:UIAlertActionStyleDefault
//                                                   handler:nil];
//    [alertController addAction:action];
//    [self presentViewController:alertController animated:YES completion:nil];
    
    [[[NSArray alloc] init] objectAtIndex:100];
}

- (void)parseBusesArray:(NSArray *)array {
    for (NSDictionary *ticketDic in array) {
        TicketInfo *ticket = [[TicketInfo alloc] initUsingDicationary:ticketDic];
        [self.busesTicketsArray addObject:ticket];
    }
}

- (UIImage *)loadCachedImageWithName:(NSString *)name {
    NSData *imageData = [[DiskPersistance sharedInstance] loadDataWithName:name];
    return (imageData == nil) ? nil : [UIImage imageWithData:imageData];
}

- (void)populateBusTableViewWith:(NSData *)data {
    NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self parseBusesArray:responseArray];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.busTableView reloadData];
    });
}
@end
