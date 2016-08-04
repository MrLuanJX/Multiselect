//
//  LabelViewController.m
//  申请标签列表多选
//
//  Created by Mr.Luan on 16/1/6.
//  Copyright © 2016年 中邦游. All rights reserved.
//

#import "LabelViewController.h"

#import "LabelCollectionViewCell.h"
#import "HeaderCollectionView.h"

#import "MLabel.h"
#import "MItem.h"

@interface LabelViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, HeaderCollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView; //集合视图
@property (nonatomic, strong) NSMutableArray *arrayM; // 区头数组
@end

@implementation LabelViewController

static NSString *const ID = @"cell";
static NSString *const HeaderID = @"header";
static NSString *const FooterID = @"footer";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationController];
    [self getData];
    [self.view addSubview:self.collectionView];
}

#pragma mark - 导航条
-(void)setNavigationController {
    self.navigationItem.title = @"标签选择";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:210.0/255.0f green:210.0/255.0f blue:210.0/255.0f alpha:1]];
}

#pragma mark - 获得数据
- (void)getData {
    NSArray * secTitles = @[@"北京市",@"天津市",@"上海市",@"广州市",@"深圳市",@"重庆市",@"沈阳市"];
    NSArray * itemTitles = @[@"朝阳区",@"海淀区",@"东城区",@"西城区",@"丰台区",@"通州区",@"昌平区"];
    NSArray * itemTitles1 = @[@"和平区",@"河北区",@"河西区",@"河东区",@"南开区",@"红桥区",@"滨海新区"];
    NSArray * itemTitle2 = @[@"黄浦区",@"徐汇区",@"长宁区",@"静安区",@"嘉定区",@"宝山区",@"浦东新区",@"闵行区"];
    NSArray * itemTitle3 = @[@"越秀区",@"海珠区",@"荔湾区",@"白云区",@"黄浦区",@"花都区",@"天河区",@"番禺区"];
    NSArray * itemTitle4 = @[@"福田区",@"罗湖区",@"南山区",@"宝安区",@"龙岗区",@"盐田区"];
    NSArray * itemTitle5 = @[@"渝中区",@"江北区",@"南岸区",@"沙坪坝区",@"九龙坡区",@"大渡口区",@"北碚区",@"渝北区",@"巴南区",@"双桥区",@"永川区",@"合川市",@"南川市"];
    NSArray * itemTitle6 = @[@"沈河区",@"和平区",@"大东区",@"皇姑区",@"铁西区",@"苏家屯区",@"东陵区",@"沈北新区",@"于洪区",@"新民市",@"辽中县",@"康平县",@"法库县"];
    NSArray * titles = @[itemTitles,itemTitles1,itemTitle2,itemTitle3,itemTitle4,itemTitle5,itemTitle6];
    for (int i = 1; i < secTitles.count + 1; i++) {
        MLabel *model = [self getDataWithSectionTitle:[NSString stringWithFormat:@"%@",secTitles[i-1]] andWithItemTitles:titles[i-1]] ;
        [self.arrayM addObject:model];
    }
    [self.collectionView reloadData];
}

- (MLabel *)getDataWithSectionTitle:(NSString *)SecTitle andWithItemTitles:(NSArray *)ItemTitles{
    MLabel *model = [MLabel new];
    model.sectionStr = SecTitle;
    
    MItem * item = [[MItem alloc]init];
    NSMutableArray * itemArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < ItemTitles.count; i++) {
        item = [MItem new];
        item.itemTitle = ItemTitles[i];
        [itemArr addObject:item];
    }
    model.items = itemArr;
    return model;
}

#pragma mark - UICollectionViewDataSource 
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.arrayM.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    MLabel *model = self.arrayM[section];
    return model.open ? model.items.count : 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    MLabel *model = self.arrayM[indexPath.section];
    cell.model = model.items[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) { // 如果是头部就返回头部
        HeaderCollectionView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderID forIndexPath:indexPath];
        sectionView.indexPath = indexPath;
        sectionView.delegate = self;
        sectionView.model = self.arrayM[indexPath.section];
        return sectionView;
    } else if (kind == UICollectionElementKindSectionFooter) {// 如果是尾部就返回尾部
        // 这里的的UICollectionReusableView是苹果封装的一个有标识可以复用的View
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterID forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor blackColor];
        return footerView;
    } else {
        return nil;
    }
}

// UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LabelCollectionViewCell *cell = (LabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    MLabel *model = self.arrayM[indexPath.section];
    MItem *item = model.items[indexPath.item];
    item.clicked = !item.clicked;
    cell.model = item;
}

#pragma mark - HeaderCollectionViewDelegate
- (void)headerDidClick:(HeaderCollectionView *)header indexPath:(NSIndexPath *)indexPath {
    
    MLabel *model = self.arrayM[indexPath.section];
    model.allSelected = !model.allSelected;
    for (MItem *item in model.items) {
        item.clicked = model.allSelected;
    }
    // 刷新表格
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.collectionView reloadSections:indexSet];
}

- (void)headerDidClickZhankaiBtn:(HeaderCollectionView *)header indexPath:(NSIndexPath *)indexPath {
    MLabel *model = self.arrayM[indexPath.section];
    model.open = !model.open;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.collectionView reloadSections:indexSet];
}

#pragma mark - UICollectionViewDelegateFlowLayout
// header 高度 如果不实现这个方法 header 显示不出来因为没有高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 50);
}

// footer 高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 1);
}

#pragma mark - getter method
- (NSMutableArray *)arrayM {
    if (!_arrayM) {
        _arrayM = [NSMutableArray array];
    }
    return _arrayM;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.view.frame.size.width/ 5, 30);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 5;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [self.collectionView registerClass:[LabelCollectionViewCell class] forCellWithReuseIdentifier:ID];
        //注册区头
        [self.collectionView registerClass:[HeaderCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
        
        //注册区尾
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID];
    }
    return _collectionView;
}

@end
