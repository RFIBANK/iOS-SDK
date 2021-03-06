//
//  RFIInvoiceData.m
//  test
//
//  Created by Alexander Nazarov on 9/6/18.
//  Copyright © 2018 forkode. All rights reserved.
//

#import "RFIInvoiceData.h"

@implementation RFIInvoiceItem

@end

@implementation RFIInvoiceData

+ (instancetype)invoiceDataWithVatTotal:(NSNumber *)vatTotal
                          discountTotal:(NSNumber *)discountTotal
                           invoiceItems:(NSArray<RFIInvoiceItem *> *)items
{
    RFIInvoiceData *invoiceData = [RFIInvoiceData new];
    
    invoiceData.vatTotal = vatTotal;
    invoiceData.discountTotal = discountTotal;
    invoiceData.items = items;
    
    return invoiceData;
}

- (NSString *)parameters {
    
    NSMutableArray *invoiceItems = [NSMutableArray new];
    for (RFIInvoiceItem *invoiceItem in self.items) {
        
        NSMutableDictionary *invoiceItemParam = [NSMutableDictionary new];
        if (invoiceItem.code) {
            invoiceItemParam[@"code"] = invoiceItem.code;
        }
        
        if (invoiceItem.name) {
            invoiceItemParam[@"name"] = invoiceItem.name;
        }
        
        if (invoiceItem.unit) {
            invoiceItemParam[@"unit"] = invoiceItem.unit;
        }
        
        if (invoiceItem.vatMode) {
            invoiceItemParam[@"vat_mode"] = invoiceItem.vatMode;
        }
        
        if (invoiceItem.price) {
            invoiceItemParam[@"price"] = invoiceItem.price;
        }
        
        if (invoiceItem.quantity) {
            invoiceItemParam[@"quantity"] = invoiceItem.quantity;
        }
        
        if (invoiceItem.sum) {
            invoiceItemParam[@"sum"] = invoiceItem.sum;
        }
        
        if (invoiceItem.vatAmount) {
            invoiceItemParam[@"vat_amount"] = invoiceItem.vatAmount;
        }
        
        if (invoiceItem.discountRate) {
            invoiceItemParam[@"discount_rate"] = invoiceItem.discountRate;
        }
        
        if (invoiceItem.discountAmount) {
            invoiceItemParam[@"discount_amount"] = invoiceItem.discountAmount;
        }
        
        [invoiceItems addObject:[invoiceItemParam copy]];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (self.vatTotal) {
        params[@"vat_total"] = self.vatTotal;
    }
    
    if (self.discountTotal) {
        params[@"discount_total"] = self.discountTotal;
    }
    
    if (invoiceItems.count) {
        params[@"items"] = [invoiceItems copy];
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[params copy]
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (error) {
        return @"";
    }
        
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
