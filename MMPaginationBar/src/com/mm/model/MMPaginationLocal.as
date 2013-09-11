package com.mm.model
{
	/**
	 * @author manjun.han
	 * @date 2013.9.10
	 * @purpose 分页工具条button文本和分页信息文本国际化配置对象
	 * 			curPageInforLabel字段为模板字段，需要包含指定的配置项，
	 * 			如当前页模板必须为"{currentPageIndex}",总页数模板,必须为"{totalPageSize}"
	 */
	public class MMPaginationLocal
	{
		//----------------------------------
		// 构造器
		//----------------------------------
		
		public function MMPaginationLocal(options:Object = null)
		{
			options = options || {
				headerButtonLabel:"首页",
				preButtonLabel:"上一页",
				nextButtonLabel:"下一页",
				tailButtonLabel:"尾页",
				curPageInforLabel:"第 {currentPageIndex} 页,共 {totalPageSize} 页"
			}
				
			this.headerButtonLabel = options.headerButtonLabel ;
			
			this.preButtonLabel = options.preButtonLabel ;
			
			this.nextButtonLabel = options.nextButtonLabel ;
			
			this.tailButtonLabel = options.tailButtonLabel ;
			
			this.curPageInforLabel = options.curPageInforLabel ;
		}
		
		//----------------------------------
		// 属性
		//----------------------------------
		
		[Bindable]
		public var headerButtonLabel:String ; // 首页按钮文本
		
		[Bindable]
		public var preButtonLabel:String ; // 上一页按钮文本
		
		[Bindable]
		public var nextButtonLabel:String ; // 下一页按钮文本
		
		[Bindable]
		public var tailButtonLabel:String ; // 尾页按钮文本
		
		[Bindable]
		public var curPageInforLabel:String ; // 尾部当前页展示信息模板文本
		
		public static const currentPageIndexTmplString:String = "{currentPageIndex}" ; // 当前页索引模板
		
		public static const totalPageSizeTmplString:String = "{totalPageSize}" ; // 总页数模板
	}
}