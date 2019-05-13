//
//  OSGView.m
//  TestOSGIOS
//
//  Created by 杨国龙 on 15/5/28.
//  Copyright (c) 2015年 dragonstudio. All rights reserved.
//

#import "OSGView.h"

#include <osgGA/TrackballManipulator>
#include <osgGA/MultiTouchTrackballManipulator>
#include <osg/ShapeDrawable>
#include <osg/DisplaySettings>
#include <osgViewer/api/IOS/GraphicsWindowIOS>

@implementation OSGView

osg::Camera* createHUD(unsigned int w, unsigned int h)
{
    osg::Camera* camera = new osg::Camera;
    
    camera->setProjectionMatrix(osg::Matrix::ortho2D(0,w,0,h));
    
    camera->setReferenceFrame(osg::Transform::ABSOLUTE_RF);
    camera->setViewMatrix(osg::Matrix::identity());
    
    camera->setClearMask(GL_DEPTH_BUFFER_BIT);
    
    camera->setRenderOrder(osg::Camera::POST_RENDER);
    
    camera->setAllowEventFocus(false);
    
    return camera;
}

class TestMultiTouchEventHandler : public osgGA::GUIEventHandler {
public:
    TestMultiTouchEventHandler(osg::Group* parent_group)
    :   osgGA::GUIEventHandler(),
    _cleanupOnNextFrame(false)
    {
        createTouchRepresentations(parent_group, 10);
    }
    
private:
    void createTouchRepresentations(osg::Group* parent_group, unsigned int num_objects)
    {
        for(unsigned int i = 0; i != num_objects; ++i)
        {
            std::ostringstream ss;
            
            osg::Geode* geode = new osg::Geode();
            
            osg::ShapeDrawable* drawable = new osg::ShapeDrawable(new osg::Box(osg::Vec3(0,0,0), 100));
            drawable->setColor(osg::Vec4(0.5, 0.5, 0.5,1));
            geode->addDrawable(drawable);
            
            ss << "Touch " << i;
            
            osgText::Text* text = new  osgText::Text;
            geode->addDrawable( text );
            drawable->setDataVariance(osg::Object::DYNAMIC);
            _drawables.push_back(drawable);
            
            
            text->setFont("fonts/arial.ttf");
            text->setPosition(osg::Vec3(110,0,0));
            text->setText(ss.str());
            _texts.push_back(text);
            text->setDataVariance(osg::Object::DYNAMIC);
            
            
            
            osg::MatrixTransform* mat = new osg::MatrixTransform();
            mat->addChild(geode);
            mat->setNodeMask(0x0);
            
            _mats.push_back(mat);
            
            parent_group->addChild(mat);
        }
        
        parent_group->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF);
    }
    
    virtual bool handle (const osgGA::GUIEventAdapter &ea, osgGA::GUIActionAdapter &aa, osg::Object *, osg::NodeVisitor *)
    {
        switch(ea.getEventType())
        {
            case osgGA::GUIEventAdapter::FRAME:
                if (_cleanupOnNextFrame) {
                    cleanup(0);
                    _cleanupOnNextFrame = false;
                }
                break;
                
            case osgGA::GUIEventAdapter::PUSH:
            case osgGA::GUIEventAdapter::DRAG:
            case osgGA::GUIEventAdapter::RELEASE:
            {
                if (!ea.isMultiTouchEvent())
                    return false;
                
                unsigned int j(0);
                
                unsigned num_touch_ended(0);
                
                for(osgGA::GUIEventAdapter::TouchData::iterator i = ea.getTouchData()->begin(); i != ea.getTouchData()->end(); ++i, ++j)
                {
                    const osgGA::GUIEventAdapter::TouchData::TouchPoint& tp = (*i);
                    _mats[j]->setMatrix(osg::Matrix::translate(tp.x, ea.getWindowHeight() - tp.y, 0));
                    _mats[j]->setNodeMask(0xffff);
                    
                    std::ostringstream ss;
                    ss << "Touch " << tp.id;
                    _texts[j]->setText(ss.str());
                    
                    switch (tp.phase)
                    {
                        case osgGA::GUIEventAdapter::TOUCH_BEGAN:
                            _drawables[j]->setColor(osg::Vec4(0,1,0,1));
                            std::cout << "touch began: " << ss.str() << std::endl;
                            break;
                            
                        case osgGA::GUIEventAdapter::TOUCH_MOVED:
                            //std::cout << "touch moved: " << ss.str() << std::endl;
                            //_drawables[j]->setColor(osg::Vec4(1,1,1,1));
//                            return true;
                            break;
                            
                        case osgGA::GUIEventAdapter::TOUCH_ENDED:
                            _drawables[j]->setColor(osg::Vec4(1,0,0,1));
                            std::cout << "touch ended: " << ss.str() << std::endl;
                            ++num_touch_ended;
                            break;
                            
                        case osgGA::GUIEventAdapter::TOUCH_STATIONERY:
                            _drawables[j]->setColor(osg::Vec4(0.8,0.8,0.8,1));
                            break;
                            
                        default:
                            break;
                            
                    }
                }
                
                // hide unused geometry
                cleanup(j);
                
                //check if all touches ended
                if ((ea.getTouchData()->getNumTouchPoints() > 0) && (ea.getTouchData()->getNumTouchPoints() == num_touch_ended))
                {
                    _cleanupOnNextFrame = true;
                }
                
                // reposition mouse-pointer
                aa.requestWarpPointer((ea.getWindowX() + ea.getWindowWidth()) / 2.0, (ea.getWindowY() + ea.getWindowHeight()) / 2.0);
            }
                break;
                
            default:
                break;
        }
        
        return false;
    }
    
    void cleanup(unsigned int j)
    {
        for(unsigned k = j; k < _mats.size(); ++k) {
            _mats[k]->setNodeMask(0x0);
        }
    }
    
    std::vector<osg::ShapeDrawable*> _drawables;
    std::vector<osg::MatrixTransform*> _mats;
    std::vector<osgText::Text*> _texts;
    bool _cleanupOnNextFrame;
    
};

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initOsg];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initOsg];
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}
-(void)initOsg
{

    unsigned int h = self.bounds.size.height * [[UIScreen mainScreen] scale];
    unsigned int w = self.bounds.size.width * [[UIScreen mainScreen] scale];
  //  NSLog(@"");
    _viewer = new osgViewer::Viewer();
    _viewer->setUpViewerAsEmbeddedInWindow(0, 0, w, h);
    
    osg::ref_ptr<osg::GraphicsContext::Traits> traits = new osg::GraphicsContext::Traits;
    
    osg::ref_ptr<osg::Referenced> windata = new osgViewer::GraphicsWindowIOS::WindowData(self);

    traits->x = 0;
    traits->y = 0;
    traits->width = w;
    traits->height =  h;
    traits->depth = 16;
    traits->windowDecoration = false;
    traits->doubleBuffer = true;
    traits->sharedContext = 0;
    traits->setInheritedWindowPixelFormat = true;
    traits->samples = 4;
    traits->sampleBuffers = 1;
    
    traits->inheritedWindowData = windata;
    
    osg::ref_ptr<osg::GraphicsContext> graphicsContext = osg::GraphicsContext::createGraphicsContext(traits.get());
    
    if(graphicsContext)
    {
        _viewer->getCamera()->setGraphicsContext(graphicsContext);
        _viewer->getCamera()->setViewport(new osg::Viewport(0, 0, traits->width, traits->height));
//        _viewer->getCamera()->setViewport(new osg::Viewport(0, 0, 320*2, 6);

    }
//    _viewer->getCamera()->setProjectionMatrixAsPerspective(45.0,  traits->width / traits->height, 1, 1000);
    double fovy, aspect, zNear, zFar;
    _viewer->getCamera()->getProjectionMatrixAsPerspective(fovy, aspect, zNear, zFar);
    NSLog(@"%f,%f,%f，%f,%ud,%ud",fovy,aspect,zNear,zFar,w,h);
    _root = new osg::MatrixTransform();
    
   NSString *path = @"/Users/a/Desktop/dev_meou_iPhone/trunk/Meou/Meou/nanhai/nanhai.obj";//[[NSBundle mainBundle] pathForResource:@"nanhai.obj" ofType:@""];
    [self loadModel:path];
   

//        osg::Geode* geode = new osg::Geode();
//        osg::ShapeDrawable* drawable = new osg::ShapeDrawable(new osg::Box(osg::Vec3(1,1,1), 1));
//        geode->addDrawable(drawable);
//        _root->addChild(geode);
    
//    _root->setMatrix(osg::Matrix::rotate(osg::DegreesToRadians(90.0), 0,0,1));
    
    osg::Camera* hud_camera = createHUD(w,h);

    _root->addChild(hud_camera);
    
    _viewer->setSceneData(_root.get());
    
    _viewer->setCameraManipulator(new osgGA::MultiTouchTrackballManipulator());
    
    _viewer->addEventHandler(new TestMultiTouchEventHandler(hud_camera));
    
    _viewer->setThreadingModel(osgViewer::Viewer::SingleThreaded);
    
    _viewer->realize();
    
    _viewer->frame();
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(updateScene) userInfo:nil repeats:YES];
}

- (void)loadModel:(NSString *)path
{
    
    const char *cpath = [path fileSystemRepresentation];
    
    osg::ref_ptr<osg::Node> model = osgDB::readNodeFile(cpath);
    _root->addChild(model);
}


-(void)updateScene
{
    _viewer->frame();
    
}



@end
