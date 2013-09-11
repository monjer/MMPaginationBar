MMPaginationBar
===============

Flex4 simple pagination bar component , based on Flex SDK4.6

#####当前项目的部署环境:

+ Mac OS X

+ Eclipse 4.2

+ Flex SDK4.6

#####使用方式(How to use)

将工程中src下的com包及源文件导入到新建工程的根目录

1. 在以mxml为基础的自定义组件内部，可直接以标签的方式添加MMPaginationBar组件，如

	<ui:MMPaginationToolBar id="paginationToolBar" width="300" height="30"/>

2. 初始化MMPaginationBar组建，监听MMPaginationChangedEvent.PaginationIndexChanged分页事件，添加处理方法

	paginationToolBar.initPaginationModel(1000 , 1);				

	paginationToolBar.addEventListener(MMPaginationChangedEvent.PaginationIndexChanged , paginationToolBarChangedEventHandler);

	protected function paginationToolBarChangedEventHandler(event:MMPaginationChangedEvent):void
	{
		var newIndex:Number = event.currentPageIndex ;
		var perPageDataCount = event.perPageDataCount ;
		// server side request code here
		Alert.show("Request page : "+newIndex);
	}

#####一些定制化选项

1. 设置每页显示数据项个数，如

	paginationToolBar.perPageDataCount = 10 ;

2. 设置分页按钮显示的个数，如

	paginationToolBar.paginationButtonLength = 10 ;

3. 设置当前页的页偏移，页偏移长度介于 [1,paginationButtonLength) 之间如

	paginationToolBar.curPaginationButtonStartOffset = 5 ；

4. 简单的国际化处理，如

  var local:MMPaginationLocal = new MMPaginationLocal({
										headerButtonLabel:"First",
										preButtonLabel:"Pre",
										nextButtonLabel:"Next",
										tailButtonLabel:"Tail",
										curPageInforLabel:"Page {currentPageIndex} of {totalPageSize}"
									}) ;
							
	paginationToolBar.localCfg = local ;

具体的使用方法，参见MMPaginationBarDemo中的演示效果。
