//  Copyright (c) 2020 650 Industries, Inc. All rights reserved.

#import <XCTest/XCTest.h>

#import <EXUpdates/EXUpdatesConfig.h>
#import <EXUpdates/EXUpdatesDatabase.h>
#import <EXUpdates/EXUpdatesLegacyUpdate.h>
#import <EXUpdates/EXUpdatesUpdate.h>

@interface EXUpdatesLegacyUpdateTests : XCTestCase

@property (nonatomic, strong) EXUpdatesConfig *config;
@property (nonatomic, strong) EXUpdatesDatabase *database;

@end

@implementation EXUpdatesLegacyUpdateTests

- (void)setUp
{
  _config = [EXUpdatesConfig configWithDictionary:@{
    @"EXUpdatesURL": @"https://exp.host/@test/test",
    @"EXUpdatesUsesLegacyManifest": @(YES)
  }];

  _database = [EXUpdatesDatabase new];
}

- (void)tearDown
{
  [super tearDown];
}

- (void)testBundledAssetBaseUrl_ExpoDomain
{
  NSURL *expected = [NSURL URLWithString:@"https://d1wp6m56sqw74a.cloudfront.net/~assets/"];
  XCTAssert([expected isEqual:[EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{} config:[EXUpdatesConfig configWithDictionary:@{@"EXUpdatesURL": @"https://exp.host/@test/test"}]]]);
  XCTAssert([expected isEqual:[EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{} config:[EXUpdatesConfig configWithDictionary:@{@"EXUpdatesURL": @"https://expo.io/@test/test"}]]]);
  XCTAssert([expected isEqual:[EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{} config:[EXUpdatesConfig configWithDictionary:@{@"EXUpdatesURL": @"https://expo.test/@test/test"}]]]);
}

- (void)testBundledAssetBaseUrl_ExpoSubdomain
{
  NSURL *expected = [NSURL URLWithString:@"https://d1wp6m56sqw74a.cloudfront.net/~assets/"];
  XCTAssert([expected isEqual:[EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{} config:[EXUpdatesConfig configWithDictionary:@{@"EXUpdatesURL": @"https://staging.exp.host/@test/test"}]]]);
  XCTAssert([expected isEqual:[EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{} config:[EXUpdatesConfig configWithDictionary:@{@"EXUpdatesURL": @"https://staging.expo.io/@test/test"}]]]);
  XCTAssert([expected isEqual:[EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{} config:[EXUpdatesConfig configWithDictionary:@{@"EXUpdatesURL": @"https://staging.expo.test/@test/test"}]]]);
}

- (void)testBundledAssetBaseUrl_AssetUrlOverride
{
  EXUpdatesConfig *config = [[EXUpdatesConfig alloc] init];
  [config loadConfigFromDictionary:@{ @"EXUpdatesURL": @"https://esamelson.github.io/self-hosting-test/ios-index.json", @"EXUpdatesSDKVersion": @"38.0.0" }];

  NSString *absoluteUrlString = @"https://xxx.dev/~assets";
  NSURL *absoluteExpected = [NSURL URLWithString:absoluteUrlString];
  NSURL *absoluteActual = [EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{ @"assetUrlOverride": absoluteUrlString } config:config];
  XCTAssert([absoluteActual isEqual:absoluteExpected], @"should return the value of assetUrlOverride if it's an absolute URL");

  NSURL *relativeExpected = [NSURL URLWithString:@"https://esamelson.github.io/self-hosting-test/my_assets"];
  NSURL *relativeActual = [EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{ @"assetUrlOverride": @"my_assets" } config:config];
  XCTAssert([relativeActual isEqual:relativeExpected], @"should return a URL relative to manifest URL base if it's a relative URL");

  NSURL *relativeDotSlashExpected = [NSURL URLWithString:@"https://esamelson.github.io/self-hosting-test/my_assets"];
  NSURL *relativeDotSlashActual = [EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{ @"assetUrlOverride": @"./my_assets" } config:config];
  XCTAssert([relativeDotSlashActual isEqual:relativeDotSlashExpected], @"should return a URL relative to manifest URL base with `./` resolved correctly if it's a relative URL");

  NSURL *defaultExpected = [NSURL URLWithString:@"https://esamelson.github.io/self-hosting-test/assets"];
  NSURL *defaultActual = [EXUpdatesLegacyUpdate bundledAssetBaseUrlWithManifest:@{} config:config];
  XCTAssert([defaultActual isEqual:defaultExpected], @"should return a URL with `assets` relative to manifest URL base if unspecified");
}

- (void)testUpdateWithLegacyManifest_Development
{
  // manifests served from a developer tool should not need the releaseId and commitTime fields
  NSDictionary *manifest = @{
    @"sdkVersion": @"39.0.0",
    @"bundleUrl": @"https://url.to/bundle.js",
    @"developer": @{@"tool": @"expo-cli"}
  };
  XCTAssert([EXUpdatesLegacyUpdate updateWithLegacyManifest:manifest config:_config database:_database] != nil);
}

- (void)testUpdateWithLegacyManifest_Production_AllFields
{
  // production manifests should require the releaseId, commitTime, sdkVersion, and bundleUrl fields
  NSDictionary *manifest = @{
    @"sdkVersion": @"39.0.0",
    @"releaseId": @"0eef8214-4833-4089-9dff-b4138a14f196",
    @"commitTime": @"2020-11-11T00:17:54.797Z",
    @"bundleUrl": @"https://url.to/bundle.js"
  };
  XCTAssert([EXUpdatesLegacyUpdate updateWithLegacyManifest:manifest config:_config database:_database] != nil);
}

- (void)testUpdateWithLegacyManifest_Production_NoSdkVersion
{
  NSDictionary *manifest = @{
    @"releaseId": @"0eef8214-4833-4089-9dff-b4138a14f196",
    @"commitTime": @"2020-11-11T00:17:54.797Z",
    @"bundleUrl": @"https://url.to/bundle.js"
  };
  XCTAssertThrows([EXUpdatesLegacyUpdate updateWithLegacyManifest:manifest config:_config database:_database]);
}

- (void)testUpdateWithLegacyManifest_Production_NoReleaseId
{
  NSDictionary *manifest = @{
    @"sdkVersion": @"39.0.0",
    @"commitTime": @"2020-11-11T00:17:54.797Z",
    @"bundleUrl": @"https://url.to/bundle.js"
  };
  XCTAssertThrows([EXUpdatesLegacyUpdate updateWithLegacyManifest:manifest config:_config database:_database]);
}

- (void)testUpdateWithLegacyManifest_Production_NoCommitTime
{
  NSDictionary *manifest = @{
    @"sdkVersion": @"39.0.0",
    @"releaseId": @"0eef8214-4833-4089-9dff-b4138a14f196",
    @"bundleUrl": @"https://url.to/bundle.js"
  };
  XCTAssertThrows([EXUpdatesLegacyUpdate updateWithLegacyManifest:manifest config:_config database:_database]);
}

- (void)testUpdateWithLegacyManifest_Production_NoBundleUrl
{
  NSDictionary *manifest = @{
    @"sdkVersion": @"39.0.0",
    @"releaseId": @"0eef8214-4833-4089-9dff-b4138a14f196",
    @"commitTime": @"2020-11-11T00:17:54.797Z"
  };
  XCTAssertThrows([EXUpdatesLegacyUpdate updateWithLegacyManifest:manifest config:_config database:_database]);
}

@end
