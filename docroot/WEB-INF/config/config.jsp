<%@page import="com.njshido.component.ShidoImageGalleryConfigurationAction" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>

<portlet:defineObjects />

<liferay-theme:defineObjects />

<%
	String maxWidth = String.valueOf(request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_MAX_WIDTH));
	String cellNumber = String.valueOf(request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_NUMBER));	
	String cellHeight = String.valueOf(request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_HEIGHT));
	String align = String.valueOf(request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_ALIGN));
	
	String[] urls = (String[]) request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_URL);
	pageContext.setAttribute("urls", urls);
	String[] bgImgUrls = (String[]) request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_BACKGROUND_IMG_URL);
	pageContext.setAttribute("bgImgUrls", bgImgUrls);
	String[] fgImgUrls = (String[]) request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_FOREGROUND_IMG_URL);
	pageContext.setAttribute("fgImgUrls", fgImgUrls);
	String[] titles = (String[]) request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_TITLE);
	pageContext.setAttribute("titles", titles);
	String[] summaries = (String[]) request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_SUMMARY);
	pageContext.setAttribute("summaries", summaries);
	String[] tags = (String[]) request.getAttribute(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_TAG);
	pageContext.setAttribute("tags", tags);
%>
<liferay-ui:success key="success" message="your-configuration-was-saved-sucessfully"/>
<form action="<liferay-portlet:actionURL portletConfiguration='true' />" method="post">
	<input type="button" value="添加条目" onclick="addItem();"/>
	<div id="" style="background:#ddd;padding:20px 0px;opacity:0.8">
		<ul>
			<li>
				<span>画廊最大宽度：</span>
				<input name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_MAX_WIDTH%>" type="number" style="width:30%;" value="<%=maxWidth%>"/>
			</li>
			<li>
				<span>每行显示个数：</span>
				<input name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_NUMBER%>" type="number" style="width:30%;"  value="<%=cellNumber%>"/>
			</li>
			<li>
				<span>每个单元高度：</span>
				<input name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_HEIGHT%>" type="number" style="width:30%;"  value="<%=cellHeight%>"/>
			</li>
			<li>
				<span>文字对齐方式：</span>
				<input name='<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_ALIGN%>' 
					type="radio" value="left" <%="left".equals(align) ? "checked":"" %> />居左
				<input name='<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_ALIGN%>' 
					type="radio" value="center" <%="center".equals(align) ? "checked":"" %>/>居中
				<input name='<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_ALIGN%>' 
					type="radio" value="right" <%="right".equals(align) ? "checked":"" %>/>居右
			</li>
		</ul>
	</div>
	
	<div id="<portlet:namespace />itemsConfigurationPanel" style="padding:20px 0px;">
		<c:forEach items="${urls}" var="url" varStatus="status">
			<ul id="<portlet:namespace/>url_${status.index}">
			   	<li>
			   		<span>图片地址：</span>
			   		<input type="text" style="width:50%;" value="${fgImgUrls[status.index]}" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_FOREGROUND_IMG_URL%>"/>
			   	</li>
			   	<li>
			   		<span>标题：</span>
			   		<textarea style="width:50%;" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_TITLE%>">${titles[status.index]}</textarea>
			   	</li>
			   	<li>
			   		<span>简介：</span>
			   		<input type="text" style="width:50%;" value="${summaries[status.index]}" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_SUMMARY%>"/>
			   	</li>
			   	<li>
			   		<span>标签(用逗号隔开)：</span>
			   		<input type="text" style="width:50%;" value="${tags[status.index]}" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_TAG%>"/>
			   	</li>
			   	<li>
			   		<span>背景图片地址：</span>
			   		<input type="text" style="width:50%;" value="${bgImgUrls[status.index]}" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_BACKGROUND_IMG_URL%>"/>
			   	</li>
			   	<li>
			   		<span>链接地址：</span>
			   		<input type="text" required="required" style="width:50%;" value="${url}" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_URL%>"/>
			   	</li>
			   	<li>
			   		<input type="button" value="删除" onclick="removeItem('<portlet:namespace/>url_${status.index}')"/>
			   	</li>
		   	</ul>
		</c:forEach>
	</div>
	<input type="submit" value="save"/>
</form>

<script type="text/javascript">
	function addItem() {
		var itemsConfigurationPanel = $('#<portlet:namespace />itemsConfigurationPanel');
		var id = new Date().getTime();
		var section = ['<ul id="'+ id +'">',
	   				   '<li>',
   					   '<span>图片地址：</span>',
   					   '<input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_FOREGROUND_IMG_URL%>"/>',
   					   '</li>',
   					   '<li>',
   					   '<span>标题：</span>',
   					   '<textarea style="width:50%;" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_TITLE%>"></textarea>',
   					   '</li>',
   					   '<li>',
   					   '<span>简介：</span>',
   					   '<input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_SUMMARY%>"/>',
   					   '</li>',
   					   '<li>',
   					   '<span>标签(用逗号隔开)：</span>',
   					   '<input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_TAG%>"/>',
   					   '</li>',
   					   '<li>',
   					   '<span>背景图片地址：</span>',
   					   '<input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_BACKGROUND_IMG_URL%>"/>',
   					   '</li>',
   					   '<li>',
   					   '<span>链接地址：</span>',
   					   '<input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_URL%>"/>',
   					   '</li>',
   					   '<li>',
   			   		   '<input type="button" value="删除" onclick="removeItem('+ id +')"/>',
   			   		   '</li>',
					   '</ul>'];
		itemsConfigurationPanel.append(section.join(''));
	}
	
	function removeItem(id) {
		$('#' + id).remove();
	}
</script>