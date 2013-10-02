/*
 * Copyright (c) 2013, Sean Heber. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of Sean Heber nor the names of any contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL SEAN HEBER BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>

@interface IndexedTable : NSObject
+ (instancetype)indexedTableWithCapacity:(NSUInteger)cap;
- (id)initWithCapacity:(NSUInteger)cap;

- (void)setObject:(id)obj forIndex:(NSInteger)index;
- (id)objectForIndex:(NSInteger)index;

- (void)removeObjectForIndex:(NSInteger)index;
- (void)removeAllObjects;

- (void)enumerateIndexesAndObjectsUsingBlock:(void (^)(NSInteger idx, id obj, BOOL *stop))block;

- (NSUInteger)count;
- (NSArray *)allObjects;
- (NSArray *)allIndexes;    // converts the indexes to NSNumbers

// for subscript access
- (id)objectAtIndexedSubscript:(NSInteger)index;
- (void)setObject:(id)obj atIndexedSubscript:(NSInteger)index;
@end
