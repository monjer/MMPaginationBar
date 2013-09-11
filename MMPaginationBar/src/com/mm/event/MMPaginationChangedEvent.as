package com.mm.event
{
	import flash.events.Event;
	
	/**
	 * @author manjun.han
	 * @date 2013.9.10
	 * @purpose 分页索引变化事件
	 */
	
	public class MMPaginationChangedEvent extends Event
	{
		//----------------------------------
		// 构造器
		//----------------------------------
		
		public function MMPaginationChangedEvent(type:String,  currentPageIndex:Number , perPageDataCount:Number , bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.currentPageIndex = currentPageIndex ;
			
			this.perPageDataCount = perPageDataCount ;
		}
		
		//----------------------------------
		// 属性
		//----------------------------------
		
		public var currentPageIndex:Number = 0 ; // 当前选中页索引
		
		public var perPageDataCount:Number = 0 ;// 每页个数
		
		//----------------------------------
		// 静态属性
		//----------------------------------
		
		public static var PaginationIndexChanged:String = "PaginationIndexChangedEvent" ; // 事件类型名称
	}
}