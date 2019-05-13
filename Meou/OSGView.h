//
//  OSGView.h
//  TestOSGIOS
//
//  Created by 杨国龙 on 15/5/28.
//  Copyright (c) 2015年 dragonstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <osgDB/ReadFile>
#include <osg/MatrixTransform>
#include <osgText/Text>
#include <osgViewer/Viewer>

@interface OSGView : UIView
{
    osg::ref_ptr<osgViewer::Viewer> _viewer;
    osg::ref_ptr<osg::MatrixTransform> _root;
}

-(void)initOsg;
-(void)updateScene;
@end
