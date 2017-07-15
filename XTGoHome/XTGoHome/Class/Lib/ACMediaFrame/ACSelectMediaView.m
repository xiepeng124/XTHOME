//
//  ACSelectMediaView.m
//
//  Created by caoyq on 17/04/12.
//  Copyright © 2016年 ArthurCao. All rights reserved.
//

#import "ACSelectMediaView.h"
#import "ACMediaImageCell.h"
#import "ACMediaFrameConst.h"
#import "ACMediaManager.h"
//#import "ACAlertController.h"
#import "TZImagePickerController.h"
#import "MWPhotoBrowser.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "XTPostMoodCollectionReusableView.h"
#import "XTPostMoodCollectionViewCell.h"
#import "XTBaseNavViewController.h"
@interface ACSelectMediaView ()<UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MWPhotoBrowserDelegate,UICollectionViewDelegateFlowLayout>



@property (nonatomic, copy) ACMediaHeightBlock block;

@property (nonatomic, copy) ACSelectMediaBackBlock backBlock;




/** 记录从相册中已选的Image Asset */
@property (nonatomic, strong) NSMutableArray *selectedImageAssets;

/** 记录从相册中已选的Image model */
@property (nonatomic, strong) NSMutableArray *selectedImageModels;

/** 记录从相册中已选的Video model*/
@property (nonatomic, strong) NSMutableArray *selectedVideoModels;

/** MWPhoto对象数组 */
@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, copy) NSString *writetoken;       // 用户的writeToken


@end

@implementation ACSelectMediaView

#pragma mark - Init
-(NSMutableArray*)upModelarr{
    if (!_upModelarr) {
        _upModelarr = [NSMutableArray array];
    }
    return _upModelarr;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(self.x, self.y, self.width, ACMedia_ScreenWidth/4);
        [self _setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    _mediaArray = [NSMutableArray array];
    _preShowMedias = [NSMutableArray array];
    _selectedImageAssets = [NSMutableArray array];
    _selectedVideoModels = [NSMutableArray array];
    _selectedImageModels = [NSMutableArray array];
    _type = ACMediaTypePhotoAndCamera;
    _showDelete = YES;
    _showAddButton = YES;
    _allowMultipleSelection = YES;
    _maxImageSelected = 9;
    _videoMaximumDuration = 60;
    _backgroundColor = [UIColor whiteColor];
    
//    self.hud = [[MBProgressHUD alloc]init];
//    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
//    self.hud.label.text = @"正在上传";
//    self.hud.mode =MBProgressHUDModeAnnularDeterminate;
    self.CoverImageUrl =@"";
    [self configureCollectionView];
  
    //[self addSubview:self.hud];
}

- (void)configureCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)*0.33, (SCREEN_WIDTH-30)*0.33);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.alwaysBounceVertical = YES;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,(SCREEN_WIDTH-40)*0.33+15+65) collectionViewLayout:layout];
    [_collectionView registerClass:[ACMediaImageCell class] forCellWithReuseIdentifier:NSStringFromClass([ACMediaImageCell class])];
      [_collectionView registerNib:[UINib nibWithNibName:@"XTPostMoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    [_collectionView registerNib:[UINib nibWithNibName:@"XTPostMoodCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [XTColor colorWithHexString:LIGHT_COLOR];
    [self addSubview:_collectionView];
}

#pragma mark - getter

- (UIViewController *)rootViewController {
    if (!_rootViewController) {
        _rootViewController = [self getCurrentVC];
    }
    return _rootViewController;
}

#pragma mark - setter

- (void)setShowDelete:(BOOL)showDelete {
    _showDelete = showDelete;
}

- (void)setShowAddButton:(BOOL)showAddButton {
    _showAddButton = showAddButton;
    if (_mediaArray.count > 3 || _mediaArray.count == 0) {
        [self layoutCollection];
    }
}

- (void)setPreShowMedias:(NSArray *)preShowMedias {
    
    _preShowMedias = preShowMedias;
    NSMutableArray *temp = [NSMutableArray array];
    for (id object in preShowMedias) {
        ACMediaModel *model = [ACMediaModel new];
        if ([object isKindOfClass:[UIImage class]]) {
            model.image = object;
        }else if ([object isKindOfClass:[NSString class]]) {
            NSString *obj = (NSString *)object;
            if ([obj isValidUrl]) {
                model.imageUrlString = object;
            }else if ([obj isGifImage]) {
                //名字中有.gif是识别不了的（和自己的拓展名重复了，所以先去掉）
                NSString *name_ = obj.lowercaseString;
                if ([name_ containsString:@"gif"]) {
                    name_ = [name_ stringByReplacingOccurrencesOfString:@".gif" withString:@""];
                }
                model.image = [UIImage ac_setGifWithName:name_];
            }else {
                model.image = [UIImage imageNamed:object];
            }
        }else if ([object isKindOfClass:[ACMediaModel class]]) {
            model = object;
        }
        [temp addObject:model];
    }
    if (temp.count > 0) {
        _mediaArray = temp;
        [self layoutCollection];
    }
}

- (void)setAllowPickingVideo:(BOOL)allowPickingVideo {
    _allowPickingVideo = allowPickingVideo;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    [_collectionView setBackgroundColor:backgroundColor];
}

#pragma mark - public method

- (void)observeViewHeight:(ACMediaHeightBlock)value {
    _block = value;
    //预防先加载数据源的情况
    if (_mediaArray.count > 3) {
        _block(_collectionView.height);
    }
}

- (void)observeSelectedMediaArray: (ACSelectMediaBackBlock)backBlock {
    _backBlock = backBlock;
}

+ (CGFloat)defaultViewHeight {
    return ACMedia_ScreenWidth/4;
}

- (void)reload {
    [self.collectionView reloadData];
}

#pragma mark -  Collection View DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _showAddButton ? _mediaArray.count + 1 : _mediaArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACMediaImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ACMediaImageCell class]) forIndexPath:indexPath];
  
    if (indexPath.row == _mediaArray.count) {
        XTPostMoodCollectionViewCell *cell = (XTPostMoodCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//        cell.icon.image = [UIImage imageNamed:@"ACMediaFrame.bundle/AddMedia"];
//        cell.videoImageView.hidden = YES;
//        cell.deleteButton.hidden = YES;
        return cell;
    }else{
        ACMediaModel *model = [[ACMediaModel alloc] init];
        model = _mediaArray[indexPath.row];

//        if (indexPath.row == 0&&self.isMerge ==1) {
//              WKUpVideoCollectionViewCell*cell2 =(WKUpVideoCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//            [ cell2.editCover addTarget:self action:@selector(editCoverAction) forControlEvents:UIControlEventTouchUpInside];
//            if (!model.isVideo && model.imageUrlString) {
//                [cell2.videoCover ac_setImageWithUrlString:model.imageUrlString placeholderImage:nil];
//            }else {
//                cell2.videoCover.image = model.image;
//            }
//            [cell2 setACMediaClickDelete2Button:^{
//                
//                ACMediaModel *model = _mediaArray[indexPath.row];
//                if (!_allowMultipleSelection) {
//                    if ([_selectedImageModels containsObject:model]) {
//                        for (NSInteger idx =0; idx < _selectedImageModels.count; idx++) {
//                            if (_selectedImageModels[idx] == model) {
//                                [_selectedImageAssets removeObjectAtIndex:idx];
//                                [_selectedImageModels removeObject:model];
//                                break;
//                            }
//                        }
//                    }else if ([_selectedVideoModels containsObject:model]) {
//                        [_selectedVideoModels removeObject:model];
//                    }
//                }
//                
//                //总数据源中删除对应项
//                [_mediaArray removeObjectAtIndex:indexPath.row];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self layoutCollection];
//                });
//            }];
//            return cell2;
//
//        }
        if (!model.isVideo && model.imageUrlString) {
        [cell.icon ac_setImageWithUrlString:model.imageUrlString placeholderImage:nil];
        }else {
            cell.icon.image = model.image;
        }
        
        cell.icon.image = model.image;
        cell.videoImageView.hidden = !model.isVideo;
        cell.deleteButton.hidden = !_showDelete;
        [cell setACMediaClickDeleteButton:^{
            
            ACMediaModel *model = _mediaArray[indexPath.row];
            if (!_allowMultipleSelection) {
                if ([_selectedImageModels containsObject:model]) {
                    for (NSInteger idx =0; idx < _selectedImageModels.count; idx++) {
                        if (_selectedImageModels[idx] == model) {
                            [_selectedImageAssets removeObjectAtIndex:idx];
                            [_selectedImageModels removeObject:model];
                      
                            break;
                        }
                    }
                }else if ([_selectedVideoModels containsObject:model]) {
                    [_selectedVideoModels removeObject:model];
                }
            }
            
            //总数据源中删除对应项
            [_upModelarr removeObjectAtIndex:indexPath.row];
            [_mediaArray removeObjectAtIndex:indexPath.row];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self layoutCollection];
            });
        }];
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionFooter) {
        XTPostMoodCollectionReusableView *foot = (XTPostMoodCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        return foot;
    }
    return nil;
}

#pragma mark - collection view delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     return CGSizeMake((SCREEN_WIDTH-30)*0.33, (SCREEN_WIDTH-30)*0.33);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 65);

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了");
    if (indexPath.row == _mediaArray.count && _mediaArray.count >= _maxImageSelected) {
        //[self.viewController.view addSubview:self.hud];

        [UIAlertController showAlertWithTitle:[NSString stringWithFormat:@"最多只能选择%ld张",(long)_maxImageSelected] message:nil actionTitles:@[@"确定"] cancelTitle:nil style:UIAlertControllerStyleAlert completion:nil];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    //点击的是添加媒体的按钮
    NSLog(@"——me =%lu",_mediaArray.count);
    
    if (indexPath.row == _mediaArray.count) {
        NSLog(@"222");
        switch (_type) {
            case ACMediaTypePhoto:
                [self openAlbum];
                break;
            case ACMediaTypeCamera:
                [self openCamera];
                break;
            case ACMediaTypePhotoAndCamera:
            {
                NSLog(@"3333");
                UIAlertController *alertCol = [UIAlertController alertControllerWithTitle:@"请选择照片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [ weakSelf openAlbum];
                }];
                [alertCol addAction:action];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [ weakSelf openCamera];
                }];
                [alertCol addAction:action2];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertCol addAction:cancelAction];
                NSLog(@"4444");
                NSLog(@"self.view =%@",self.viewController);
//                [self.viewController .navigationController pushViewController:alertCol animated:YES];
              [self.viewController presentViewController:alertCol animated:YES completion:^{
                     NSLog(@"4455");
              }];
            }
                break;
            case ACMediaTypeVideotape:
                [self openVideotape];
                break;
            case ACMediaTypeVideo:
                [self openVideo];
                break;
            case ACMediaTypeVideoAndCamera:{
               UIAlertController *alertCol = [UIAlertController alertControllerWithTitle:@"请选择视频来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"本地视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [ weakSelf openVideo];
                }];
                  [alertCol addAction:action];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [ weakSelf openVideotape];
                }];
                [alertCol addAction:action2];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

                }];
                [alertCol addAction:cancelAction];
         
                [weakSelf.viewController presentViewController:alertCol animated:YES completion:^{
                  
                }];


            }
                break;
            default:         {
                UIAlertController *alertCol = [UIAlertController alertControllerWithTitle:@"请选择照片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [ weakSelf openAlbum];
                }];
                [alertCol addAction:action];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [ weakSelf openCamera];
                }];
                [alertCol addAction:action2];
                UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"本地视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [ weakSelf openVideo];
                }];
                 [alertCol addAction:action3];
                UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [ weakSelf openVideotape];
                }];

                [alertCol addAction:action4];

                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertCol addAction:cancelAction];
                NSLog(@"4444");
                NSLog(@"self.view =%@",self.viewController);
                //                [self.viewController .navigationController pushViewController:alertCol animated:YES];
                [weakSelf.viewController presentViewController:alertCol animated:YES completion:^{
                    NSLog(@"4455");
                }];

           }
                break;
        }
    }
    //展示媒体
    else {
        NSLog(@"one");
        _photos = [NSMutableArray array];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.navigationItem.rightBarButtonItem.style= UIBarButtonSystemItemCancel;
        browser.displayActionButton = NO;
        browser.alwaysShowControls = NO;
        browser.displaySelectionButtons = NO;
        browser.zoomPhotosToFill = YES;
        browser.displayNavArrows = NO;
        browser.startOnGrid = NO;
        browser.enableGrid = YES;
   
               for (ACMediaModel *model in _mediaArray) {
            MWPhoto *photo = [MWPhoto photoWithImage:model.image];
            photo.caption = model.name;
            if (model.isVideo) {
                if (model.mediaURL) {
           
                    photo.photoURL = model.mediaURL;
                }else {
     
                    //photo = [photo initWithAsset:model.asset targetSize:CGSizeZero];
                }
            }
            else if (model.imageUrlString) {
                
                photo = [MWPhoto photoWithURL:[NSURL URLWithString:model.imageUrlString]];
            }
            [_photos addObject:photo];
        }
        [browser setCurrentPhotoIndex:indexPath.row];
             //navi.viewControllers = @[browser];
        XTBaseNavViewController *navi = [[XTBaseNavViewController alloc]init];
        ;
        navi.viewControllers = @[browser];

  [self.viewController presentViewController:navi animated:YES completion:nil];
 //[self.viewController.navigationController pushViewController:browser animated:YES];
    }
}

#pragma mark - <MWPhotoBrowserDelegate>

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

#pragma mark - 布局

///重新布局collectionview
- (void)layoutCollection {
    
    NSInteger allImageCount = _showAddButton ? _mediaArray.count + 1 : _mediaArray.count;
    NSInteger maxRow = (allImageCount - 1) / 3 + 1;
    _collectionView.height = allImageCount == 0 ? 0 : maxRow * ACMedia_ScreenWidth/3+80;
    self.height = _collectionView.height;
    //block回调
    !_block ?  : _block(_collectionView.height);
    !_backBlock ?  : _backBlock(_mediaArray);
    
    [_collectionView reloadData];
}

#pragma mark - actions

/** 相册 */
- (void)openAlbum {
    NSInteger count = 0;
    if (!_allowMultipleSelection) {
        count = _maxImageSelected - (_mediaArray.count - _selectedImageModels.count);
    }else {
        count = _maxImageSelected - _mediaArray.count;
    }
    TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
    //是否 在相册中显示拍照按钮
    imagePickController.allowTakePicture = self.allowTakePicture;
    //是否可以选择显示原图
    imagePickController.allowPickingOriginalPhoto = self.allowPickingOriginalPhoto;
    //是否 在相册中可以选择视频
    imagePickController.allowPickingVideo = _allowPickingVideo;
    imagePickController.allowPickingImage = !_allowPickingVideo ;
    if (!_allowMultipleSelection) {
        imagePickController.selectedAssets = _selectedImageAssets;
    }
      [self.viewController presentViewController:imagePickController animated:YES completion:nil];
}

/** 相机 */
- (void)openCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;

    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self.viewController presentViewController:picker animated:YES completion:nil];
    }else{
        [UIAlertController showAlertWithTitle:@"该设备不支持拍照" message:nil actionTitles:@[@"确定"] cancelTitle:nil style:UIAlertControllerStyleAlert completion:nil];
    }
}

/** 录像 */
- (void)openVideotape {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray * mediaTypes =[UIImagePickerController  availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = mediaTypes;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        picker.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
        picker.videoMaximumDuration = 3600;        //录像最长时间
    } else {
        [UIAlertController showAlertWithTitle:@"当前设备不支持录像" message:nil actionTitles:@[@"确定"] cancelTitle:nil style:UIAlertControllerStyleAlert completion:nil];
    }
       self.viewController.modalTransitionStyle = UIModalPresentationOverCurrentContext;
    [self.viewController presentViewController:picker animated:YES completion:nil];

}

/** 视频 */
- (void)openVideo {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
   //  picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
      NSString *requiredMediaType2 = ( NSString *)kUTTypeVideo;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: requiredMediaType1, requiredMediaType2, nil];
    picker. videoMaximumDuration = 300;

    picker.allowsEditing = YES;
    self.viewController.modalTransitionStyle = UIModalPresentationOverCurrentContext;
//    UIViewController *vc = [[UIApplication sharedApplication] keyWindow].rootViewController;
    [self.viewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - TZImagePickerController Delegate

//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    if ([_selectedImageAssets isEqualToArray: assets]) {
        return;
    }
    //每次回传的都是所有的asset 所以要初始化赋值
    if (!_allowMultipleSelection) {
        _selectedImageAssets = [NSMutableArray arrayWithArray:assets];
    }
    
    NSMutableArray *models = [NSMutableArray array];
    //2次选取照片公共存在的图片
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableArray *temp2 = [NSMutableArray array];
    for (NSInteger index = 0; index < assets.count; index++) {
        PHAsset *asset = assets[index];
        [[ACMediaManager manager] getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
            ACMediaModel *model = [[ACMediaModel alloc] init];
            model.name = name;
            model.uploadType = pathData;
            model.image = photos[index];
                        [self.hud showAnimated:YES];
            self.hud.label.text = [NSString stringWithFormat:@"正在上传图片" ];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//                [WKHttpTool uploadWithURLString:self.uploadUrl parameters:self.dic images:model.image success:^(id responseObject) {
//                    NSLog(@" ...%@",responseObject);
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if ([[responseObject objectForKey:@"flag" ]intValue]) {
//                            WKMyUploadTaskmodel *myUpload = [WKMyUploadTaskmodel mj_objectWithKeyValues:responseObject];
//                            myUpload.sourceName = model.name;
//                            [weakself.upModelarr addObject:myUpload];
//                            [self.hud hideAnimated:YES];
//                        }
//                    });
//                } failure:^(NSError *error) {
//                    
//                } upload:^(NSProgress *progress) {
//                       [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
//               }];
//            });
//            

            //区分gif
            if ([NSString isGifWithImageData:pathData]) {
                model.image = [UIImage ac_setGifWithData:pathData];
            }
            
            if (!_allowMultipleSelection) {
                //用数组是否包含来判断是不成功的。。。
                for (ACMediaModel *md in _selectedImageModels) {
                    if ([md.name isEqualToString:model.name]) {
                        [temp addObject:md];
                        [temp2 addObject:model];
                        break;
                    }
                }
            }
            [models addObject:model];
            if (index == assets.count - 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                    if (!_allowMultipleSelection) {
                        
                        //删除公共存在的，剩下的就是已经不存在的
                        [_selectedImageModels removeObjectsInArray:temp];
                        //总媒体数组删先除掉不存在，这样不会影响排列的先后顺序
                        [_mediaArray removeObjectsInArray:_selectedImageModels];
                        //将这次选择的进行赋值，深复制
                        _selectedImageModels = [models mutableCopy];
                        //这次选择的删除公共存在的，剩下的就是新添加的
                        [models removeObjectsInArray:temp2];
                        //总媒体数组中在后面添加新数据
                        [_mediaArray addObjectsFromArray:models];
                        NSLog(@"%lu....",_mediaArray.count);
                        [self.delegate selectedImages:_mediaArray.count];
                        
                    }
                    else {
                        [_selectedImageModels addObjectsFromArray:models];
                        [_mediaArray addObjectsFromArray:models];
                    }
                    
                    [self layoutCollection];
          });
            }
        }];
    }
   // NSLog(@"33");

//    NSLog(@"----%lu",_mediaArray.count);
//    for (int i =0; i<_mediaArray.count; i++) {
//        ACMediaModel *Imagemodel = [[ACMediaModel alloc] init];
//            NSLog(@"34");
//        Imagemodel = _mediaArray[i];
//        
//    }
//
    
}

///选取视频后的回调
//- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
//    
//    [[ACMediaManager manager] getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
//        ACMediaModel *model = [[ACMediaModel alloc] init];
//        model.name = name;
//        model.uploadType = pathData;
//        model.image = coverImage;
//        model.isVideo = YES;
//        model.asset = asset;
//        NSLog(@"here");
//             dispatch_async(dispatch_get_main_queue(), ^{
//             NSLog(@"here2");
//            if (!_allowMultipleSelection) {
//                //用数组是否包含来判断是不成功的。。。
//                for (ACMediaModel *tmp in _selectedVideoModels) {
//                    if ([tmp.name isEqualToString:model.name]) {
//                        return ;
//                    }
//                }
//            }
//            [_selectedVideoModels addObject:model];
//            [_mediaArray addObject:model];
//            [self layoutCollection];
//        });
//    }];
//}

#pragma mark - UIImagePickerController Delegate
///拍照、选视频图片、录像 后的回调（这种方式选择视频时，会自动压缩，但是很耗时间）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    //媒体类型
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //原图URL
    NSURL *imageAssetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ///视频 和 录像
    if ([mediaType isEqualToString:@"public.movie"]) {
        
        NSURL *videoAssetURL = [info objectForKey:UIImagePickerControllerMediaURL];
        PHAsset *asset;
        //录像没有原图 所以 imageAssetURL 为nil
        if (imageAssetURL) {
            PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetURL] options:nil];
            asset = [result firstObject];
        }
        [[ACMediaManager manager] getVideoPathFromURL:videoAssetURL PHAsset:asset enableSave:YES completion:^(NSString *name, UIImage *screenshot, id pathData) {
            ACMediaModel *model = [[ACMediaModel alloc] init];
            model.image = screenshot;
            model.name = name;
            model.uploadType = pathData;
            NSLog(@"pathData = %@",pathData);
            model.isVideo = YES;
            model.mediaURL = videoAssetURL;
            [self.hud showAnimated:YES];
            self.hud.progress =0;
            self.hud.label.text = @"正在上传";

            
//
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//                [WKHttpTool uploadTwoVideoWithURLString:nil parameters:nil images:screenshot date:pathData success:^(id responseObject) {
//                    NSLog(@"res = %@",responseObject);
//                    weakself.hud.label.text = @"上传成功";
//                    
//                    [weakself.hud hideAnimated:YES];
//
//                    
//                    } failure:^(NSError *error) {
//                        NSLog(@"error = %@",error);
//                        weakself.hud.label.text = @"上传失败";
//
//                        [weakself.hud hideAnimated:YES];
//
//                } upload:^(NSProgress *progress) {
//                    [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
//
//                }];
//            });
               }];
    }
    
    else if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        //如果 picker 没有设置可编辑，那么image 为 nil
        if (image == nil) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        PHAsset *asset;
        //拍照没有原图 所以 imageAssetURL 为nil
        if (imageAssetURL) {
            PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetURL] options:nil];
            asset = [result firstObject];
        }
        [[ACMediaManager manager] getImageInfoFromImage:image PHAsset:asset completion:^(NSString *name, NSData *data) {
            ACMediaModel *model = [[ACMediaModel alloc] init];
            model.image = image;
            model.name = name;
            model.uploadType = data;
            dispatch_async(dispatch_get_main_queue(), ^{
              
                [_mediaArray addObject:model];
                [self layoutCollection];
            });
        }];
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"fractionCompleted"]&&[object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress*)object;
        self.hud.progress = progress.fractionCompleted;
    }
}

#pragma mark - private

//有时候获取不到
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    NSAssert(result, @"\n*******\n rootViewController must not be nil. \n******");
    
    return result;
}

@end
