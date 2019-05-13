//
//  OSGViewController.h
//  TestOSGIOS
//
//  Created by 林涛赵 on 15/5/28.
//  Copyright (c) 2015年 dragonstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <osgDB/ReadFile>
#include <osg/MatrixTransform>
#include <osgViewer/Viewer>

@interface OSGViewController : UIViewController
{
    osg::ref_ptr<osgViewer::Viewer> _viewer;
    osg::ref_ptr<osg::MatrixTransform> _root;
    
}

@property(nonatomic, strong) UIView *osgView;
-(void)initOSG;
@end
