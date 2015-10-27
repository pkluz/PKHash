//
//  PKHash.h
//  PKHash
//
//  Created by Philip Kluz on 10/27/15.
//  Copyright © 2015 nsexceptional.com. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>

#import "PKHash.h"

@implementation PKHash

#pragma mark - PKHash (Public)

+ (NSData *)hash:(NSData *)input algorithm:(PKHashAlgorithm)algorithm
{
    NSParameterAssert(input);
    
    NSUInteger digestLength = [PKHash digestLengthForHashAlgorithm:algorithm];
    NSMutableData *digest = [[NSMutableData alloc] initWithLength:digestLength];
    
    switch (algorithm) {
        case PKHashAlgorithmSHA224:
            CC_SHA224([input bytes], (unsigned int)[input length], [digest mutableBytes]);
            break;
            
        case PKHashAlgorithmSHA256:
            CC_SHA256([input bytes], (unsigned int)[input length], [digest mutableBytes]);
            break;
            
        case PKHashAlgorithmSHA384:
            CC_SHA384([input bytes], (unsigned int)[input length], [digest mutableBytes]);
            break;
            
        case PKHashAlgorithmSHA512:
            CC_SHA512([input bytes], (unsigned int)[input length], [digest mutableBytes]);
            break;
    }
    
    return [digest copy];
}

+ (void)hash:(NSData *)input algorithm:(PKHashAlgorithm)algorithm completion:(PKHashCompletion)completion
{
    NSParameterAssert(input);
    NSParameterAssert(completion);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *digest = [PKHash hash:input algorithm:algorithm];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(digest);
        });
    });
}

+ (NSData *)hash:(NSData *)input key:(NSData *)key algorithm:(PKHashHMACAlgorithm)algorithm
{
    NSParameterAssert(input);
    NSParameterAssert(key);
    
    CCHmacAlgorithm alg = [PKHash commonCryptoHMACAlgorithmFromPKHashHMACAlgorithm:algorithm];
    NSUInteger digestLength = [PKHash digestLengthForHMACHashAlgorithm:algorithm];
    
    NSMutableData *digest = [[NSMutableData alloc] initWithLength:digestLength];
    
    CCHmac(alg,
           [key bytes],
           (unsigned int)[key length],
           [input bytes],
           (unsigned int)[input length],
           [digest mutableBytes]);
    
    return [digest copy];
    
}

+ (void)hash:(NSData *)input key:(NSData *)key algorithm:(PKHashHMACAlgorithm)algorithm completion:(PKHashCompletion)completion
{
    NSParameterAssert(input);
    NSParameterAssert(key);
    NSParameterAssert(completion);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *digest = [PKHash hash:input key:key algorithm:algorithm];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(digest);
        });
    });
}

#pragma mark - PKHash (Private)

+ (CCHmacAlgorithm)commonCryptoHMACAlgorithmFromPKHashHMACAlgorithm:(PKHashHMACAlgorithm)algorithm
{
    switch (algorithm) {
        case PKHashHMACAlgorithmMD5:
            return kCCHmacAlgMD5;
        case PKHashHMACAlgorithmSHA1:
            return kCCHmacAlgSHA1;
        case PKHashHMACAlgorithmSHA224:
            return kCCHmacAlgSHA224;
        case PKHashHMACAlgorithmSHA256:
            return kCCHmacAlgSHA256;
        case PKHashHMACAlgorithmSHA384:
            return kCCHmacAlgSHA384;
        case PKHashHMACAlgorithmSHA512:
            return kCCHmacAlgSHA512;
    }
}

+ (CCHmacAlgorithm)digestLengthForHMACHashAlgorithm:(PKHashHMACAlgorithm)algorithm
{
    switch (algorithm) {
        case PKHashHMACAlgorithmMD5:
            return CC_MD5_DIGEST_LENGTH;
        case PKHashHMACAlgorithmSHA1:
            return CC_SHA1_DIGEST_LENGTH;
        case PKHashHMACAlgorithmSHA224:
            return CC_SHA224_DIGEST_LENGTH;
        case PKHashHMACAlgorithmSHA256:
            return CC_SHA256_DIGEST_LENGTH;
        case PKHashHMACAlgorithmSHA384:
            return CC_SHA384_DIGEST_LENGTH;
        case PKHashHMACAlgorithmSHA512:
            return CC_SHA512_DIGEST_LENGTH;
    }
}

+ (CCHmacAlgorithm)digestLengthForHashAlgorithm:(PKHashAlgorithm)algorithm
{
    switch (algorithm) {
        case PKHashAlgorithmSHA224:
            return CC_SHA224_DIGEST_LENGTH;
        case PKHashAlgorithmSHA256:
            return CC_SHA256_DIGEST_LENGTH;
        case PKHashAlgorithmSHA384:
            return CC_SHA384_DIGEST_LENGTH;
        case PKHashAlgorithmSHA512:
            return CC_SHA512_DIGEST_LENGTH;
    }
}

@end
