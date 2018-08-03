//
//  YMTextView.m
//  输入框
//
//  Created by cym_bj on 2018/8/3.
//  Copyright © 2018年 cym_bj. All rights reserved.
//

#import "YMTextView.h"

#define knumaberSpace 10

@interface YMTextView ()<UITextViewDelegate>

@property (nonatomic,strong)UITextView *textView;

@property (nonatomic,strong)UILabel *placeholderLB;

@property (nonatomic,strong)UILabel *numberLb;

//适应的高度
@property (nonatomic,assign)CGFloat adaptHeight;

@end
@implementation YMTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.topAndBottomSpace=5;
        self.leftAndRightSpace=5;
        self.borderLineColor=[UIColor redColor];
        self.borderLineWidth=1;
        self.isSetBorder=YES;
        [self addSubview:self.textView];
        [self addSubview:self.placeholderLB];
        [self addSubview:self.numberLb];
        //实时监听textView值得改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}
-(UILabel *)numberLb
{
    if (!_numberLb) {
        
        _numberLb=[[UILabel alloc]init];
        _numberLb.textAlignment=NSTextAlignmentRight;
        _numberLb.hidden=YES;
    
    }
    return _numberLb;
}
-(UILabel *)placeholderLB
{
    if (!_placeholderLB) {
        _placeholderLB=[[UILabel alloc]init];
        _placeholderLB.text=@"请输入文字";
        _placeholderLB.textColor=[UIColor darkGrayColor];
        _placeholderLB.font=[UIFont systemFontOfSize:17];
        _placeholderLB.numberOfLines=0;
    }
    return _placeholderLB;
}
-(UITextView *)textView
{
    if (!_textView) {
        _textView=[[UITextView alloc]init];
        _textView.backgroundColor=[UIColor clearColor];
        _textView.font=[UIFont systemFontOfSize:17];
        _textView.delegate=self;
        _textView.contentInset=UIEdgeInsetsMake(-8, -5, -5, -5);
    }
    return _textView;
}

#pragma mark - 占位文字
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=placeholder;
    self.placeholderLB.text=placeholder;
    [self.placeholderLB sizeToFit];
}

#pragma mark - 占位颜色
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor=placeholderColor;
    self.placeholderLB.textColor=placeholderColor;
}
#pragma mark - 文字颜色
-(void)setTextColor:(UIColor *)textColor
{
    _textColor=textColor;
    self.textView.textColor=textColor;
    
}

#pragma mark - 边距
-(void)setTopAndBottomSpace:(CGFloat)topAndBottomSpace
{
    _topAndBottomSpace=topAndBottomSpace;
    [self setNeedsLayout];
    
}
-(void)setLeftAndRightSpace:(CGFloat)leftAndRightSpace
{
    _leftAndRightSpace=leftAndRightSpace;
    [self setNeedsLayout];
    
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont=textFont;
    self.placeholderLB.font=textFont;
    self.textView.font=textFont;
    [self setNeedsLayout];
}

- (void)setIsSetBorder:(BOOL)isSetBorder
{
    _isSetBorder=isSetBorder;
    
    if (isSetBorder) {
        
        self.layer.borderWidth=self.borderLineWidth;
        self.layer.borderColor=self.borderLineColor.CGColor;
    }
    else{
        self.layer.borderWidth=0;
        self.layer.borderColor=[UIColor clearColor].CGColor;
    }
    
}

-(void)setRowSpace:(NSInteger)rowSpace
{
    _rowSpace=rowSpace;
    if (rowSpace) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing =rowSpace;
        // 字体的行间距
        NSDictionary *attributes = @{ NSFontAttributeName:self.textView.font, NSParagraphStyleAttributeName:paragraphStyle };
        self.textView.typingAttributes = attributes;
    }
}

-(NSString *)getContentStr
{
    return self.textView.text;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W=CGRectGetWidth(self.frame);
    CGFloat H=CGRectGetHeight(self.frame);
    self.placeholderLB.frame=CGRectMake(self.leftAndRightSpace, self.topAndBottomSpace, W-self.leftAndRightSpace*2, 30);
    [self.placeholderLB sizeToFit];
    
    if (self.isTextNum) {
        CGFloat numW=100;
        CGFloat numH=25;
        self.numberLb.frame=CGRectMake(W-numW-knumaberSpace, H-numH-knumaberSpace, numW, numH);
         self.textView.frame=CGRectMake(self.leftAndRightSpace, self.topAndBottomSpace, W-self.leftAndRightSpace*2, H-self.topAndBottomSpace-numH-knumaberSpace*2);
    }
    else{
        self.textView.frame=CGRectMake(self.leftAndRightSpace, self.topAndBottomSpace, W-self.leftAndRightSpace*2, H-self.topAndBottomSpace*2);
    }

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ((comcatstr.length>self.maxNumb)&&self.maxNumb) {
        
        return NO;
    }
    
    return YES;
}

-(void)setIsTextNum:(BOOL)isTextNum
{
    _isTextNum=isTextNum;
    
    self.numberLb.hidden=!isTextNum;
    [self setNeedsLayout];
    if (isTextNum) {
        
        [self showNumber];
    }
    
}
#pragma mark- 监听文字改变
-(void)textDidChange
{
    self.placeholderLB.hidden=self.textView.text.length;
    
    if (self.textValue) {
        self.textValue(self.textView.text);
    }
    
    
    //显示文字的数量
    [self showNumber];
    
    if (self.isAutoHeigth) {
        [self autoCalculateHeight];
    }
}

#pragma mark- 自动计算高度
-(void)autoCalculateHeight
{
    //动态计算文字的高度
    CGFloat height=[self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, MAXFLOAT)].height;
    
    //计算间距
    if (self.rowSpace) {
        
        //如果设置了间距
        UIFont*temp=self.textView.font;
        //行数
         NSInteger row= height/temp.lineHeight;
         height=height+(row-1)*self.rowSpace;
    }
   

   
    if (self.isTextNum) {
        
       height= height+self.topAndBottomSpace*2+CGRectGetHeight(self.numberLb.frame)+knumaberSpace*2;
    }
    else{
         height= height+self.topAndBottomSpace*2;
    }

    height=height>self.frameHeight?height:self.frameHeight;
    
   
    
    
    self.bounds=CGRectMake(0, 0, self.bounds.size.width, height);
    
    if (self.textHeigth) {
        
         self.textHeigth(height>self.frameHeight?height:self.frameHeight);
    }
   
    

}
-(void)showNumber
{
    if(self.isTextNum)
    {
        NSString *str=nil;
        if (self.maxNumb) {
            str=[NSString stringWithFormat:@"%lu/%d",(unsigned long)self.textView.text.length,self.maxNumb];
        }else{
            str=[NSString stringWithFormat:@"%lu",(unsigned long)self.textView.text.length];
        }
        self.numberLb.text =str;
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
