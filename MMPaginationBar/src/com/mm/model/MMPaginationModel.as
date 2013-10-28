package com.mm.model
{
	/**
	 * @author manjun.han
	 * @date 2013.9.10
	 * @purpose 控制分页信息数据对象，配置和记录当前分页的数据项
	 * 	    如，数据项总个数，每页数据项个数，当前总页数，最大显示分页数，当前选中页等
	 */
	public class MMPaginationModel
	{
		
		//-----------------------------------
		// 构造器
		//-----------------------------------
		
		public function MMPaginationModel(options:Object=null)
		{
			options = options || {
				totalPageDataCount:0,
				perPageDataCount:10, // 每页默认显示项 10
				currentPageIndex:0,
				curPaginationButtonStartOffset:3, // 当前页的默认页偏移 3
				paginationButtonLength:10 // 默认分页button显示个数 10
			}
				
			this.initialize(options);
		}
		
		//-----------------------------------
		// 属性
		//-----------------------------------
				
		public var totalPageDataCount:Number = 0 ; //数据项个数
				
		public var perPageDataCount:Number = 0 ; //每页显示数据项
				
		public var currentPageIndex:Number = 0 ; //当前选中页码
		
		private var paginationButtonLength:Number = 0 ;//分页button显示个数
				
		public var curPaginationButtonStartOffset:Number = 0 ; //当前页button的显示偏移
				
		public var totalPageSize:Number = 0; //分页总页数
				
		public var startPageIndex:Number = 0; //起始页页码
				
		public var preButtonEnabled:Boolean = false ; //是否禁用前翻页
				
		public var nextButtonEnabled:Boolean = false ; //是否禁用后翻页
		
		//-----------------------------------
		// 方法
		//-----------------------------------
		
		/**
		 * @purpose model初始化
		 * @param options 配置对象
		 */
		public function initialize(options:Object):void
		{			
			this.initConfig(options);
			
			this.computeTotalPageSize();
			
			this.setCurrentPageIndex(options.currentPageIndex);
			
		}
				
		/**
		 * @purpose model默认选项初始化
		 * @param options 配置对象
		 */
		public function initConfig(options:Object):void
		{			
			// 数据项个数
			this.totalPageDataCount = Math.abs(options.totalPageDataCount) ;
			
			// 每页显示数据项
			this.perPageDataCount = Math.abs(options.perPageDataCount);
			
			// 添加校验
			this.perPageDataCount = this.perPageDataCount == 0 ? 10 : this.perPageDataCount ;
			
			// view层所显示的最大页数
			this.paginationButtonLength = Math.abs(options.paginationButtonLength) ;
			
			// 当前页的页偏移
			this.curPaginationButtonStartOffset = Math.abs(options.curPaginationButtonStartOffset) ;
			
			// 确保当前页button的页偏移的正确性			
			if(this.curPaginationButtonStartOffset == 0){
				
				this.curPaginationButtonStartOffset = 1 ;
				
			}else if( this.curPaginationButtonStartOffset >= this.paginationButtonLength){
				
				this.curPaginationButtonStartOffset =  this.paginationButtonLength - 2 ;
				
				this.curPaginationButtonStartOffset = this.curPaginationButtonStartOffset < 0 ? 0 : this.curPaginationButtonStartOffset ; 
			}		
		}
		
		
		/**
		 * @purpose 设置当期选中的页码 
		 * @param currentPageIndex ui视图上显示的当前页索引，在model中 this.currentPageIndex = pageIndexOfView - 1 ;
		 */
		public function setCurrentPageIndex(currentPageIndex:Number):void
		{
			// 首页边界溢出检测
			currentPageIndex = currentPageIndex < 0 ? 0 : currentPageIndex ;
			
			// 尾页边界溢出检测
			currentPageIndex = currentPageIndex >= this.totalPageSize ? this.totalPageSize -1 : currentPageIndex ;
			
			// 前后台索引从0开始,避免产生负值（totalPageSize=currentPageIndex=0）
			this.currentPageIndex = currentPageIndex < 0 ? 0 : currentPageIndex ;
			
			// 计算新的起始页码
			this.computeStartPageIndex();
			
			// 刷新前后翻页按钮状态
			this.refreshModelButtonState();			
		}		
		
		/**
		 * @purpose 执行上翻页后，刷新model及状态
		 */
		public function goToPrePage():void
		{
			var prePageIndexOfView:Number = this.currentPageIndex -1 ;
			this.setCurrentPageIndex(prePageIndexOfView);
		}
		
		/**
		 * @purpose 执行下翻页后，刷新model及状态
		 */
		public function goToNextPage():void
		{
			var currentPageIndex:Number = this.currentPageIndex+1 ;
			this.setCurrentPageIndex(currentPageIndex);
		}
		
		/**
		 * @purpose 计算当前总页数
		 */
		public function computeTotalPageSize():void
		{			
			this.totalPageSize = Math.ceil(this.totalPageDataCount / this.perPageDataCount );
		}
		
		/**
		 * @purpose 获得当前的分页显示长度
		 */
		public function getPaginationButtonLength():Number
		{
			return this.totalPageSize < this.paginationButtonLength ? this.totalPageSize : this.paginationButtonLength ;
		}
		
		/**
		 * @purpose 计算当前分页的起始页码
		 */
		public function computeStartPageIndex():void
		{			
			var startPageIndex:Number = 0;
			
			var pageEndOffset:Number = this.paginationButtonLength - this.curPaginationButtonStartOffset;
			
			// 实际页数小于最大显示页数
			if(this.totalPageSize <= this.paginationButtonLength){
				
				startPageIndex = 0 ;
				
			}else{
				
				startPageIndex = this.currentPageIndex - this.curPaginationButtonStartOffset ;
				
				// 到达首页部分
				if(startPageIndex < 0 ){
					
					startPageIndex = 0 ;
				// 到达尾页部分
				}else if(this.currentPageIndex + pageEndOffset > this.totalPageSize){
					
					startPageIndex = this.totalPageSize - this.paginationButtonLength ;
				// 中间页		
				}else{
					
					startPageIndex = this.currentPageIndex  - this.curPaginationButtonStartOffset  ;						
					
				}
			}
			
			this.startPageIndex = startPageIndex  ;			
		}
		
		/**
		 * @purpose 获取前翻页button的禁用状态
		 */
		public function isPreButtonEnabled():Boolean
		{
			return this.preButtonEnabled ;	
		}
		
		/**
		 * @purpose 获取后翻页button的禁用状态
		 */
		public function isNextButtonEnabled():Boolean
		{
			return this.nextButtonEnabled ;	
		}
		
		/**
		 *  @purpose 根据当前选中页，刷新前后翻页button的禁用状态控制
		 */
		public function refreshModelButtonState():void
		{
			//单页或无数据
			if(this.totalPageSize == 1 || this.totalPageSize == 0){
				this.preButtonEnabled = false ;
				this.nextButtonEnabled = false ;
			//多页
			}else{
				//首页
				if(this.currentPageIndex == 0 ){
					this.preButtonEnabled = false ;
					this.nextButtonEnabled = true ;
				//尾页
				}else if(this.currentPageIndex == this.totalPageSize - 1){
					this.preButtonEnabled = true ;
					this.nextButtonEnabled = false ;
				//中间页
				}else{
					this.preButtonEnabled = true ;
					this.nextButtonEnabled = true ;
				}
			}
		}
		
		/**
		 * @purpose 设置每页显示项数量
		 * @param perPageDataCount 每页分页项数量
		 */
		public function setPerPageDataCount(perPageDataCount:Number):void
		{		
			this.perPageDataCount = Math.abs(perPageDataCount);
			
			this.computeTotalPageSize();
			
			this.setCurrentPageIndex(this.currentPageIndex);
		}
		
		/**
		 * @purpose 设置分页button的显示长度
		 * @param paginationButtonLength button的显示长度
		 */
		public function setPaginationButtonLength(paginationButtonLength:Number):void
		{
			this.paginationButtonLength = Math.abs(paginationButtonLength);
			
			this.setCurrentPageIndex(this.currentPageIndex);
		}
		
		/**
		 * @purpose 设置起始页button的偏移量
		 * @param curPaginationButtonStartOffset 起始页button的偏移量
		 */
		public function setCurPaginationButtonStartOffset(curPaginationButtonStartOffset:Number):void
		{
			this.curPaginationButtonStartOffset = Math.abs(curPaginationButtonStartOffset);
			
			this.setCurrentPageIndex(this.currentPageIndex);
		}
	}
}
