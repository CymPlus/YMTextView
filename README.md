# YMTextView
功能强大的TextView输入功能
导入方法直接把文件夹<YMTextView>拖到项目中即中
支持的功能，可以根据的需要灵活添加功能。
//占位文字
@property (nonatomic, strong) NSString *placeholder;

//占位文字颜色 
@property (nonatomic, strong) UIColor *placeholderColor;

//文字颜色
@property (nonatomic,strong) UIColor *textColor;

//文字字体
@property (nonatomic,strong) UIFont *textFont;

//上下边框距离(默认5)
@property (nonatomic,assign)CGFloat topAndBottomSpace;

//左右边框距离(默认5)
@property (nonatomic,assign)CGFloat leftAndRightSpace;

//是否设置边框 (默认yes)
@property (nonatomic,assign) BOOL isSetBorder;

//边框线的颜色
@property (nonatomic,strong) UIColor *borderLineColor;

//边框线的宽度
@property (nonatomic,assign) CGFloat borderLineWidth;

//获取输入的内容
@property (nonatomic,copy,readonly)NSString *getContentStr;

//文字最多数量，限制
@property (nonatomic,assign) int maxNumb;

//是否显示输入的数量
@property (nonatomic,assign) BOOL isTextNum;

//输入数量的文字的颜色
@property (nonatomic,strong) UIColor *textNumColor;

//输入数量的文字的字体
@property (nonatomic,strong) UIFont *textNumFont;
//自动计算高度
@property (nonatomic,assign)BOOL isAutoHeigth;
//如果要自动计算高度，此参数必须设置 ，
@property (nonatomic,assign)CGFloat frameHeight;

//设置文字行间距
@property (nonatomic,assign)NSInteger rowSpace;

//监听高度的改变 (isAutoHeigth==yes 才有值)
@property (nonatomic,strong)YMTextHeightChangeBlock textHeigth;

//监听文字的改变
@property (nonatomic,strong)YMTextValueChangeBlock textValue;
