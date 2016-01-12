//
//  SQLiteManager.h
//
//  Created by Anthony Ly on 11/03/12.
//  Copyright (c) 2012 AnthonyLy.com. All rights reserved.
//



/***** Define your database file here  *****/

#define kDatabaseName    @"swift.sqlite"

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLiteManager : NSObject{
    NSString *databasePath;
}

//------------------------------------------------------------------

+ (SQLiteManager *)singleton;

- (void)checkAndCreateDatabaseWithOverwrite:(BOOL)overwriteDB;

//------------------------------------------------------------------

#pragma mark - SQL : SQL METHOD

- (NSArray *)findAllFrom:(NSString *)table;
- (NSArray *)find:(NSString *)field from:(NSString *)table where:(NSString *)condition;
- (NSArray *)find:(NSString *)field from:(NSString *)table where:(NSString *)condition order:(NSString *)order limit:(NSString *)limit;
- (BOOL)save:(NSMutableDictionary *)data into:(NSString *)table;
- (BOOL)deleteRowWithId:(int)idRow from:(NSString *)table;
- (id)executeSql:(NSString *)sql;

@property(nonatomic, retain) NSString *databasePath;

@end
