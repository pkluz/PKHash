//
//  PKHashTests.m
//  PKHashTests
//
//  Created by Philip Kluz on 10/27/15.
//  Copyright © 2015 nsexceptional.com. All rights reserved.
//

@import XCTest;
@import PKHash;

@interface PKHashTests : XCTestCase

@property (nonatomic, strong, readwrite) NSData *keyData;

@end

@implementation PKHashTests

- (void)setUp
{
    NSString *keyString = @"b45FD/fsdds3871uGBAJsyGYbv/I3df6Z8==";
    self.keyData = [[NSData alloc] initWithBase64EncodedString:keyString options:0];
}

- (void)testSHA256Hash
{
    NSString *input = @"hello world this is an amazing string";
    NSData *inputData = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *digest = [PKHash hash:inputData algorithm:PKHashAlgorithmSHA256];
    
    NSString *expectationAsBase64 = @"YaLeN5zCHlyFPrFvs8nxIRqg9VUFozD1IF9S6vu5l3U=";
    NSData *expectation = [[NSData alloc] initWithBase64EncodedString:expectationAsBase64 options:0];
    
    XCTAssert([digest isEqualToData:expectation], @"");
}

@end
