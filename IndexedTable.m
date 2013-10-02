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

#import "IndexedTable.h"

@implementation IndexedTable {
    CFMutableDictionaryRef _dict;
}

+ (instancetype)indexedTableWithCapacity:(NSUInteger)cap
{
    return [[self alloc] initWithCapacity:cap];
}

- (id)init
{
    return [self initWithCapacity:0];
}

- (id)initWithCapacity:(NSUInteger)cap
{
    if ((self=[super init])) {
        _dict = CFDictionaryCreateMutable(NULL, cap, NULL, &kCFTypeDictionaryValueCallBacks);
    }
    return self;
}

- (void)dealloc
{
    CFRelease(_dict);
}

- (void)setObject:(id)obj forIndex:(NSInteger)index
{
    self[index] = obj;
}

- (id)objectForIndex:(NSInteger)index
{
    return self[index];
}

- (void)removeObjectForIndex:(NSInteger)index
{
    CFDictionaryRemoveValue(_dict, (void *)index);
}

- (void)removeAllObjects
{
    CFDictionaryRemoveAllValues(_dict);
}

- (id)objectAtIndexedSubscript:(NSInteger)index
{
    return (__bridge id)CFDictionaryGetValue(_dict, (void *)index);
}

- (void)setObject:(id)obj atIndexedSubscript:(NSInteger)index
{
    CFDictionarySetValue(_dict, (void *)index, (__bridge void *)obj);
}

- (NSUInteger)count
{
    return CFDictionaryGetCount(_dict);
}

- (void)enumerateIndexesAndObjectsUsingBlock:(void (^)(NSInteger idx, id obj, BOOL *stop))block
{
    const NSUInteger count = CFDictionaryGetCount(_dict);
    
    if (count > 0) {
        NSInteger *keys = (NSInteger *)malloc(sizeof(void *) * count);
        __unsafe_unretained id *objects = (__unsafe_unretained id *)malloc(sizeof(void *) * count);
        BOOL stop = NO;
        
        CFDictionaryGetKeysAndValues(_dict, (void *)keys, (void *)objects);
        
        for (NSInteger i=0; !stop && i<count; ++i) {
            block(keys[i], objects[i], &stop);
        }
        
        free(keys);
        free(objects);
    }
}

- (NSArray *)allObjects
{
    const NSUInteger count = CFDictionaryGetCount(_dict);
    NSArray *result = nil;
    
    if (count > 0) {
        __unsafe_unretained id *objects = (__unsafe_unretained id *)malloc(sizeof(void *) * count);
        CFDictionaryGetKeysAndValues(_dict, NULL, (void *)objects);
        result = [NSArray arrayWithObjects:objects count:count];
        free(objects);
    }

    return result;
}

- (NSArray *)allIndexes
{
    const NSUInteger count = CFDictionaryGetCount(_dict);
    NSMutableArray *results = nil;
    
    if (count > 0) {
        NSInteger *keys = (NSInteger *)malloc(sizeof(void *) * count);
        CFDictionaryGetKeysAndValues(_dict, (void *)keys, NULL);
        results = [NSMutableArray arrayWithCapacity:count];
        
        for (NSInteger i=0; i<count; ++i) {
            [results addObject:@(keys[i])];
        }

        free(keys);
    }

    return results;
}

@end
