//
//  FBAnnotationCluster.m
//  AnnotationClustering
//
//  Created by Filip Bec on 06/01/14.
//  Copyright (c) 2014 Infinum Ltd. All rights reserved.
//

#import "FBAnnotationCluster.h"

@implementation FBAnnotationCluster

- (BOOL) isEqual:(id)object {
    if (self == object) {
        return YES;
    } else if (![object isKindOfClass:[self class]]) {
        return NO;
    } else {
        return [self isEqualAnnotation:object];
    }
}

- (BOOL) isEqualAnnotation:(FBAnnotationCluster *)annotation {
    if (self.coordinate.latitude != annotation.coordinate.latitude) {
        return NO;
    }
    if (self.coordinate.longitude != annotation.coordinate.longitude) {
        return NO;
    }
    
    NSSet *set1 = [NSSet setWithArray:self.annotations];
    NSSet *set2 = [NSSet setWithArray:annotation.annotations];
    BOOL sameAnnotations = [set1 isEqualToSet:set2];
    
    return sameAnnotations;
}

#define NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define NSUINTROTATE(val, howmuch) ((((NSUInteger)val) << howmuch) | (((NSUInteger)val) >> (NSUINT_BIT - howmuch)))

- (NSUInteger) hash {
    return NSUINTROTATE(_coordinate.latitude, NSUINT_BIT / 3) ^ NSUINTROTATE(_coordinate.longitude, NSUINT_BIT * 2/ 3) ^ [_annotations hash];
}

@end
