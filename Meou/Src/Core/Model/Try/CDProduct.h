//
//  CDProduct.h
//  Meou
//
//  Created by 杨国龙 on 15/10/14.
//  Copyright © 2015年 cloudream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDProduct : NSObject
/** id */
@property (nonatomic ,copy)NSString *ID;
/** 商品名称 */
@property (nonatomic ,copy)NSString *name;
/** 商品描述 */
@property (nonatomic ,copy)NSString *desc;
/** 所属商品类别 */
@property (nonatomic ,copy)NSString *product_type_id;
/** 传在身体的哪个部位 */
@property (nonatomic ,copy)NSString *tryon_type;
/** 品牌名称 */
@property (nonatomic ,copy)NSString *brand_name;
/** 价格 */
@property (nonatomic ,copy)NSString *price;
/** 商品缩略图 */
@property (nonatomic ,copy)NSString *thumb_url;
/** 商品官网或者购买链接 */
@property (nonatomic ,copy)NSString *link_url;
/** 3D模型资源的id */
@property (nonatomic ,copy)NSString *td_res_id;
/** 颜色 */
@property (nonatomic ,copy)NSString *color;
/** 尺寸 */
@property (nonatomic ,copy)NSString *size;
/** 码数 */
@property (nonatomic ,copy)NSString *yardage;
/** 面料 */
@property (nonatomic ,copy)NSString *fabric;
/** 是否定制 */
@property (nonatomic ,copy)NSString *customize;
/** 所属企业 */
@property (nonatomic ,copy)NSString *company;
/** 所属设计师 */
@property (nonatomic ,copy)NSString *designer;
/** 版型 */
@property (nonatomic ,copy)NSString *edition;
/** 风格 */
@property (nonatomic ,copy)NSString *style;
/** 流行元素 */
@property (nonatomic ,copy)NSString *popular_elements;
/** 图案 */
@property (nonatomic ,copy)NSString *design;
/** 选购热点 */
@property (nonatomic ,copy)NSString *buy_hot;
/**  是否有3D模型 */
@property (nonatomic ,copy)NSString *td_model;
/**  是否已上传3D文件 */
@property (nonatomic ,copy)NSString *uploaded_td_file;
/**  是否是服装类 */
@property (nonatomic ,copy)NSString *clothing;
/**  货存数量 */
@property (nonatomic ,copy)NSString *stock;
/** 定制周期  */
@property (nonatomic ,copy)NSString *custom_cycle;
/** 毛重  */
@property (nonatomic ,copy)NSString *gw;
/** 净重  */
@property (nonatomic ,copy)NSString *nw;
/**  皮重 */
@property (nonatomic ,copy)NSString *tw;
/**  是否冻结 */
@property (nonatomic ,copy)NSString *status;
/**  添加时间 */
@property (nonatomic ,copy)NSString *create_time;

@end
