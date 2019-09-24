# iOS jira test tool

## Usage

Copy `jira_test_tool` and `config.plist` into the iOS project folder

Open **Terminal** and run this command:

`./jira-test-tool test -test-cases=${test_cases} -issue-key=${issue_key}`

With `${test_cases}` is test objects for testing, separated by commas and `${issue_key}` is name of the Issue (Task) which needs to be tested.

Example:

`./jira-test-tool test -test-cases=VNShopTests/ProductDetailViewControllerTests.swift,VNShopTests/ProductImageTableViewCellTests/testNumberOfItemsIfNoImage -issue-key=VNSI-XXX`

## Configurations

All configurations can be set up in `config.plist`.  Before running tests, please update values for cycleName, jira username and password.

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>cycleName</key>
    <string>VNSI-253 cycle 1</string>
    <key>cycleFolder</key>
    <string>Sprint1</string>
    <key>folder</key>
    <string>/APP</string>
    <key>jiraPassword</key>
    <string>${jira_pass_word}</string>
    <key>jiraUsername</key>
    <string>${jira_user_name}</string>
    <key>device</key>
    <string>iPhone 8</string>
    <key>projectKey</key>
    <string>VNSI</string>
    <key>scheme</key>
    <string>VNShop</string>
    <key>workspace</key>
    <string>VNShop.xcworkspace</string>
</dict>
</plist>

```

## Demo

```
Failing tests:
    VNShopTests:
        ProductDetailViewControllerTests.testCellsForAttributeSection()

** TEST FAILED **

Test case ProductDetailOptionalPromotionsCellTests/testPromotionCellForVoucher() existed on jira
Test case ProductDetailViewControllerTests/testCellsForAttributeSection() existed on jira
Test case ProductDetailViewControllerTests/testVarHasOptionDefinitions() existed on jira
Test case ProductDetailOptionalPromotionsCellTests/testPromotionCellForItem() existed on jira
Test case ProductDetailViewControllerTests/testEnumProductDetailSectionType() existed on jira
Test case ProductDetailOptionalPromotionsCellTests/testPromotionCellForCoupon() existed on jira
Test case ProductDetailViewControllerTests/testViewForHeaderFooterInSections() existed on jira
Test case ProductDetailViewControllerTests/testHeightForFooterInSection0() existed on jira
Test case ProductDetailViewControllerTests/testFuncBackAction() existed on jira
Test case ProductDetailViewControllerTests/testSetupNavigationBar() existed on jira
Test case VNSI-T457 is created successfully
Test case VNSI-T456 is created successfully
Test case VNSI-T458 is created successfully
Test case ProductDetailViewControllerTests/testNumberOfRowsInSection() existed on jira
Test case ProductDetailViewControllerTests/testCellsForDescriptionSection() existed on jira
Test case VNSI-T459 is created successfully
Test case ProductDetailViewControllerTests/testNumberOfRowInSection() existed on jira
[✓] Total 17 test cases
[✓] Cycle with key = VNSI-C72 is created successfully

```



