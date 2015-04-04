<%@ page pageEncoding="utf-8"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="javax.portlet.PortletPreferences"%>
<%@page import="com.njshido.component.ShidoImageGalleryConfigurationAction" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<portlet:defineObjects />

<%
	PortletPreferences preferences = renderRequest.getPreferences();
	float maxWidth = Float.parseFloat(preferences.getValue(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_MAX_WIDTH, ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_HEIGHT_DEFAULT_VAL));
	float cellNumber = Float.parseFloat(preferences.getValue(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_NUMBER, ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_NUMBER_DEFAULT_VAL));
	float cellWidth = maxWidth/cellNumber - 20f;//(int)(100/cellNumber);
	float cellHeight = Float.parseFloat(preferences.getValue(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_HEIGHT, ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_MAX_WIDTH_DEFAULT_VAL));
	String align = preferences.getValue(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_ALIGN, ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_ALIGN_DEFAULT_VAL);
	
	String[] urls = preferences.getValues(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_CELL_URL, StringPool.EMPTY_ARRAY);
	String[] bgImgUrls = preferences.getValues(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_BACKGROUND_IMG_URL, StringPool.EMPTY_ARRAY);
	String[] fgImgUrls = preferences.getValues(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_FOREGROUND_IMG_URL, StringPool.EMPTY_ARRAY);
	String[] titles = preferences.getValues(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_TITLE, StringPool.EMPTY_ARRAY);
	String[] summaries = preferences.getValues(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_SUMMARY, StringPool.EMPTY_ARRAY);
	String[] tags = preferences.getValues(ShidoImageGalleryConfigurationAction.SHIDO_IMAGE_GALLERY_TAG, StringPool.EMPTY_ARRAY);
%>
<div id="<portlet:namespace/>shido-image-gallery" class="shido-image-gallery">
	<ul style="max-width:<%=maxWidth%>px;">
<%
	for(int i = 0; i < urls.length; i++) {
%>
			<li style="width:<%=cellWidth%>px;height:<%=cellHeight%>px;max-width:350px;
<%
	if(i < bgImgUrls.length && bgImgUrls[i] != null && bgImgUrls[i].length() > 0) {
%>
				background-image:url(<%= bgImgUrls[i]%>);background-repeat: no-repeat;
				background-size:100% 100%;background-position:center;
<%
	}
%>
				">
				<a href="<%= urls[i]%>" target="_blank" style="text-decoration:none;" target="_blank">
<%
	if(i < fgImgUrls.length && fgImgUrls[i] != null && fgImgUrls[i].length() > 0) {
%>
					<img src="<%= fgImgUrls[i]%>" style="width:100%;"/>
<%
	}
%>
				</a>
<%
	if(i < titles.length && titles[i] != null && titles[i].length() > 0) {
%>
				<br/><span class="img-title" style="text-align:<%= align%>;"><%= titles[i].replaceAll("\\n", "<br/>")%></span>
<%
	}
	if(i < summaries.length && summaries[i] != null && summaries[i].length() > 0) {
%>
				<span class="img-summary" style="text-align:<%= align%>;"><%= summaries[i]%></span>
<%
	}
	if(i < tags.length && tags[i] != null && tags[i].length() > 0) {
%>
				<span class="img-tags" onclick="playVideo();" ><%= tags[i]%></span>
<%
	}
%>
			</li>
<%
	}
%>
	</ul>
</div>
<script type="text/javascript">
	
	function playVideo() {
        var sUserAgent = navigator.userAgent.toLowerCase();
        var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
        var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
        var bIsMidp = sUserAgent.match(/midp/i) == "midp";
        var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
        var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
        var bIsAndroid = sUserAgent.match(/android/i) == "android";
        var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
        var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
        if (bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM) {
            window.location.href = "http://beetle.de/static/videos/beetle_cabrio_product_video.mp4";
            //"http://192.168.1.102:8080/documents/10184/0/test+video/aaba090d-4b63-43fa-acbe-700654a9d756";
        } else {
        	$.layer({
        		type: 1,
        		title: false,
        		area: ['800px','600px'],
        		border: [0],
        		shade: [0.7, '#000'],
        		page: {html: '<video preload="auto" autoplay="true" width="800" height="600" controls="controls" src="http://beetle.de/static/videos/beetle_cabrio_product_video.mp4"></video>'}
        	});
        }
    }
</script>
