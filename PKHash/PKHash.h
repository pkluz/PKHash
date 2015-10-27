//
//  PKHash.h
//  PKHash
//
//  Created by Philip Kluz on 10/27/15.
//  Copyright © 2015 nsexceptional.com. All rights reserved.
//

@import UIKit;
@import Security;

/**
 @constant  PKHMACSHA1     HMAC with SHA1 digest.
 @constant  PKHMACMD5      HMAC with MD5 digest.
 @constant  PKHMACSHA224   HMAC with SHA224 digest.
 @constant  PKHMACSHA256   HMAC with SHA256 digest.
 @constant  PKHMACSHA384   HMAC with SHA384 digest.
 @constant  PKHMACSHA512   HMAC with SHA512 digest.
 */
typedef NS_ENUM(NSUInteger, PKHashHMACAlgorithm)
{
    PKHashHMACAlgorithmSHA1,
    PKHashHMACAlgorithmMD5,
    PKHashHMACAlgorithmSHA224,
    PKHashHMACAlgorithmSHA256,
    PKHashHMACAlgorithmSHA384,
    PKHashHMACAlgorithmSHA512
};

/**
 @constant  PKHashAlgorithmSHA224   HMAC with SHA256 digest.
 @constant  PKHashAlgorithmSHA256   HMAC with SHA384 digest.
 @constant  PKHashAlgorithmSHA384   HMAC with SHA512 digest.
 @constant  PKHashAlgorithmSHA512   HMAC with SHA224 digest.
 */
typedef NS_ENUM(NSUInteger, PKHashAlgorithm)
{
    PKHashAlgorithmSHA224,
    PKHashAlgorithmSHA256,
    PKHashAlgorithmSHA384,
    PKHashAlgorithmSHA512
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^PKHashCompletion)(NSData *result);

@interface PKHash : NSObject

/// Hash with `algorithm` type digest.
+ (NSData *)hash:(NSData *)input algorithm:(PKHashAlgorithm)algorithm;

/// Asynchronously computed hash with `algorithm` type digest.
+ (void)hash:(NSData *)input algorithm:(PKHashAlgorithm)algorithm completion:(PKHashCompletion)completion;

/// HMAC with `algorithm` type digest.
+ (NSData *)hash:(NSData *)input key:(NSData *)key algorithm:(PKHashHMACAlgorithm)algorithm;

/// Asynchronously computed HMAC with `algorithm` type digest.
+ (void)hash:(NSData *)input key:(NSData *)key algorithm:(PKHashHMACAlgorithm)algorithm completion:(PKHashCompletion)completion;

@end

NS_ASSUME_NONNULL_END
