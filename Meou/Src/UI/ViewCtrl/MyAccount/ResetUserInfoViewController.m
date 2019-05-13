//
//  ResetUserInfoViewController.m
//  Meou
//
//  Created by 杨国龙 on 15/10/13.
//  Copyright © 2015年 cloudream. All rights reserved.
//

#import "ResetUserInfoViewController.h"
#import "CDService.h"
#import <UIView+MJExtension.h>
#import "AreaPickerView.h"
#import "CDService.h"
#import "UIImage+Addition.h"
@interface ResetUserInfoViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UIButton *boyButton;
@property (weak, nonatomic) IBOutlet UIButton *girlButton;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIButton *choseAgeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UIButton *provinceButton;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;
@property (weak, nonatomic) IBOutlet UITextField *detailAreaTextField;
@property (weak, nonatomic) IBOutlet UIButton *headImageButton;


@property (nonatomic,copy)NSString * headimagPath;


@property (nonatomic,strong)UITableView * tabelView;

@property (nonatomic,strong)NSArray * arealist;

@property(nonatomic,strong)UIView * pickerview;

@property (nonatomic,strong)UIDatePicker * datePicker;

@property (nonatomic,strong)AreaPickerView * areaPickerView;

@end

@implementation ResetUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置个人信息";
    
    [self initAreaPickerView];
    [self configurationButtons];
    // Do any additional setup after loading the view.
}

-(void)configurationButtons{
    _provinceButton.layer.cornerRadius = 3;
    _provinceButton.layer.borderWidth = 1;
    _provinceButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _cityButton.layer.cornerRadius = 3;
    _cityButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _cityButton.layer.borderWidth = 1;
    
    _areaButton.layer.cornerRadius = 3;
    _areaButton.layer.borderWidth = 1;
    _areaButton.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)initAreaPickerView{
    _pickerview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.mj_h - 330 +64, self.view.mj_w, 330)];
    _pickerview.backgroundColor = [UIColor whiteColor];
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.mj_w - 60 , 0, 60, 30)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(comfirechooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_pickerview addSubview:button];
     _areaPickerView = [[AreaPickerView alloc]initWithFrame:CGRectMake(0, 30, self.view.mj_w, 300)];
    
    [_pickerview addSubview:_areaPickerView];
    _pickerview.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_pickerview];


}
-(void)comfirechooseButtonClick:(UIButton *)bt{
    _pickerview.hidden = YES;
    [_provinceButton setTitle:_areaPickerView.provinceName forState:UIControlStateNormal];
    [_cityButton setTitle:_areaPickerView.cityName forState:UIControlStateNormal];
    [_areaButton setTitle:_areaPickerView.areaName forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)provinceButtonClick:(UIButton *)sender {
    
    
    _pickerview.hidden = NO;
}

- (IBAction)cityButtonClick:(UIButton *)sender {
    _pickerview.hidden = NO;

}

- (IBAction)areaButtonClick:(UIButton *)sender {
    _pickerview.hidden = NO;

}

- (IBAction)comfireButtonClick:(UIButton *)sender {
    Sex sex = _boyButton.selected ? Man: Woman;
    NSString * address = [NSString stringWithFormat:@"%@%@%@%@",[_provinceButton titleForState:UIControlStateNormal],[_cityButton titleForState:UIControlStateNormal],[_areaButton titleForState:UIControlStateNormal],_detailAreaTextField.text];

    [[CDService shareInstance] setPersonInfoWithName:_nameTextField.text sex:sex addr:address headerImagePath:_headimagPath age:_ageTextField.text email:_mailTextField.text cardno:nil success:^(id result) {
        
    } failure:^(NSString *reason) {
        
    }];

}
- (IBAction)headImageButtonClick:(UIButton *)sender {
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.navigationController.view];

}
- (IBAction)sexChooseButtonClick:(UIButton *)sender {
    _girlButton.selected = [sender isEqual:_girlButton];
    _boyButton.selected = [sender isEqual:_boyButton];
    
}

- (IBAction)ageChooseButtonClick:(UIButton *)sender {
//    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.window.mj_h - 300, self.view.mj_w, 300)];
//    _datePicker.datePickerMode = UIDatePickerModeDate;
//    
//    [self.view.window addSubview:_datePicker];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.allowsEditing = YES;
    imagePickerController.delegate = self;
    
    if (buttonIndex == 0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            return;
        }
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }else if (buttonIndex == 1){
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            return;
        }
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //取出用户选择的图片
    UIImage *image = [self scaleImage:[info objectForKey:UIImagePickerControllerEditedImage]];
 
    [_headImageButton setImage:image forState:UIControlStateNormal];
    
    [[CDService shareInstance] uploadfile:image success:^(id result) {
        _headimagPath = result;
    } failure:^(NSString *reason) {
        
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(UIImage *)scaleImage:(UIImage *)image{
    NSData * imagedata = UIImageJPEGRepresentation(image, 0.3);
    
    UIImage * aImage = [UIImage imageWithImage:[UIImage imageWithData:imagedata] scaledToSize:CGSizeMake(120, 120)];
    
    return aImage;
}

@end
