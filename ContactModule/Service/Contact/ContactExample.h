//
//  ContactExample.h
//  ContactListSorter
//
//  Created by fallen.ink on 24/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#pragma mark - CNContactPickerViewController 创建
/**
 CNContactPickerViewController * contactPickerVc = [CNContactPickerViewController new];
 
 contactPickerVc.delegate = self;
 
 [self presentViewController:contactPickerVc animated:YES completion:nil];
 #pragma mark - 选中一个联系人
 - (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
 
 NSLog(@"contact:%@",contact);
 //phoneNumbers 包含手机号和家庭电话等
 for (CNLabeledValue * labeledValue in contact.phoneNumbers) {
 
 CNPhoneNumber * phoneNumber = labeledValue.value;
 
 NSLog(@"phoneNum:%@", phoneNumber.stringValue);
 
 }
 }
 */
 
 #pragma mark - 选中一个联系人属性
/**
 - (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
 
 NSLog(@"contactProperty:%@",contactProperty);
 }
 */
 
 #pragma mark - 选中一个联系人的多个属性
/**
 - (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties{
 
 NSLog(@"contactPropertiescontactProperties:%@",contactProperties);
 }
 */
 
 #pragma mark - 选中多个联系人
/**
 - (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts{
 
 NSLog(@"contactscontacts:%@",contacts);
 }
 */
