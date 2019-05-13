//
//  AreaPickerView.m
//  Meou
//
//  Created by 杨国龙 on 15/10/16.
//  Copyright © 2015年 cloudream. All rights reserved.
//

#import "AreaPickerView.h"

@interface AreaPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

//@property (nonatomic,strong)NSArray * areaList;

@property (nonatomic,strong)NSMutableArray * provinces;

@property (nonatomic,strong)NSArray * citys;

@property (nonatomic,strong)NSArray * areas;

@property (nonatomic,strong)NSArray * provinceDics;


@end

@implementation AreaPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSome];
 
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSome];
    }
    return self;
}
-(void)initSome{
    _provinces = [NSMutableArray array];
    NSString * plistPath = [[NSBundle mainBundle]pathForResource:@"area.plist" ofType:nil];
    _provinceDics = [[NSArray alloc]initWithContentsOfFile:plistPath];
//    NSDictionary * p =  _provinceDics[0];
    for (NSDictionary * p in _provinceDics) {
        [_provinces addObject:[[p allKeys] firstObject]];
        
    }
    
    _provinceName = _provinces[0];
    
    _citys = [_provinceDics[0] objectForKey:_provinces[0]];
    
    
    /*
     (root
       item0 {
           key(省) = (
                        {
                            key(市) = (
                                        区，
                                        区，
                                        )
                                }
                    )
            },
    )
     
     */
//    _citys =   [p allValues][0];
    
    if (_citys) {
        NSDictionary * c = _citys[0];
        _cityName = [[c allKeys]firstObject];
        _areas = [[c allValues] firstObject];
        _areaName = _areas[0];
    }
    self.delegate = self;
    self.dataSource = self;
    
    

}
#pragma mark - UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return _provinces.count;
            break;
        case 1:
            return _citys.count;
            case 2:
        return _areas.count;
        default:
            break;
    }
    return 0;
}
#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:{
            _provinceName = _provinces[row];
            _citys = [_provinceDics[row] objectForKey:_provinces[row]];

            
            if (_citys) {
                NSDictionary * c = _citys[0];
                _cityName = [[c allKeys] objectAtIndex:0];

                _areas = [[c allValues] firstObject];
                _areaName = _areas[0];

            }
            [pickerView selectRow:0 inComponent:2 animated:YES];

            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
            break;
        case 1:
            if (_citys) {

                NSDictionary * c = _citys[row];
                _cityName = [[c allKeys] firstObject];
                _areas = [[c allValues] firstObject];
                [pickerView selectRow:0 inComponent:2 animated:YES];
                _areaName = _areas[0];

            }
            
            break;
        case 2:
            _areaName = _areas[row];
            break;
        default:
            break;
    }
    
    [pickerView reloadAllComponents];

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
        {
            return [_provinces objectAtIndex:row];
            
        }
        case 1:{
            
            NSDictionary * c = [_citys objectAtIndex:row];
            return [c allKeys][0];
        }
        case 2:{
            
            return _areas[row];
        }

        default:
            break;
    }
    return nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
