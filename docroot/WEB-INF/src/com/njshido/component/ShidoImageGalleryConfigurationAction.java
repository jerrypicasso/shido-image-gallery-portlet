package com.njshido.component;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portlet.PortletPreferencesFactoryUtil;

public class ShidoImageGalleryConfigurationAction extends DefaultConfigurationAction {
	
	public static final String SHIDO_IMAGE_GALLERY_MAX_WIDTH = "shido_image_gallery_max_width";
	public static final String SHIDO_IMAGE_GALLERY_CELL_NUMBER = "shido_image_gallery_cell_number";
	public static final String SHIDO_IMAGE_GALLERY_CELL_HEIGHT = "shido_image_gallery_cell_height";
	public static final String SHIDO_IMAGE_GALLERY_ALIGN = "shido_image_gallery_align";
	
	public static final String SHIDO_IMAGE_GALLERY_CELL_URL = "shido_image_gallery_cell_url";
	public static final String SHIDO_IMAGE_GALLERY_BACKGROUND_IMG_URL = "shido_image_gallery_background_img_url";
	public static final String SHIDO_IMAGE_GALLERY_FOREGROUND_IMG_URL = "shido_image_gallery_foreground_img_url";
	public static final String SHIDO_IMAGE_GALLERY_TITLE = "shido_image_gallery_title";
	public static final String SHIDO_IMAGE_GALLERY_SUMMARY = "shido_image_gallery_summary";
	public static final String SHIDO_IMAGE_GALLERY_TAG = "shido_image_gallery_tag";
	
	private static final String CONFIG_JSP = "/WEB-INF/config/config.jsp";
	private static final String SUCCESS = "success";
	public static final String SHIDO_IMAGE_GALLERY_CELL_HEIGHT_DEFAULT_VAL = "250";
	public static final String SHIDO_IMAGE_GALLERY_MAX_WIDTH_DEFAULT_VAL = "910";
	public static final String SHIDO_IMAGE_GALLERY_CELL_NUMBER_DEFAULT_VAL = "3";
	public static final String SHIDO_IMAGE_GALLERY_ALIGN_DEFAULT_VAL = "left";
	
	@Override
	public String render(PortletConfig portletConfig, RenderRequest renderRequest, RenderResponse renderResponse) throws Exception {
		String portletId = renderRequest.getParameter("portletResource");
		PortletPreferences preferences = PortletPreferencesFactoryUtil.getPortletSetup(renderRequest, portletId);
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_MAX_WIDTH, preferences.getValue(SHIDO_IMAGE_GALLERY_MAX_WIDTH, SHIDO_IMAGE_GALLERY_MAX_WIDTH_DEFAULT_VAL));
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_CELL_NUMBER, preferences.getValue(SHIDO_IMAGE_GALLERY_CELL_NUMBER, SHIDO_IMAGE_GALLERY_CELL_NUMBER_DEFAULT_VAL));
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_CELL_HEIGHT, preferences.getValue(SHIDO_IMAGE_GALLERY_CELL_HEIGHT, SHIDO_IMAGE_GALLERY_CELL_HEIGHT_DEFAULT_VAL));
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_CELL_URL, preferences.getValues(SHIDO_IMAGE_GALLERY_CELL_URL, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_BACKGROUND_IMG_URL, preferences.getValues(SHIDO_IMAGE_GALLERY_BACKGROUND_IMG_URL, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_FOREGROUND_IMG_URL, preferences.getValues(SHIDO_IMAGE_GALLERY_FOREGROUND_IMG_URL, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_TITLE, preferences.getValues(SHIDO_IMAGE_GALLERY_TITLE, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_SUMMARY, preferences.getValues(SHIDO_IMAGE_GALLERY_SUMMARY, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_TAG, preferences.getValues(SHIDO_IMAGE_GALLERY_TAG, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_IMAGE_GALLERY_ALIGN, preferences.getValue(SHIDO_IMAGE_GALLERY_ALIGN, SHIDO_IMAGE_GALLERY_ALIGN_DEFAULT_VAL));
		return CONFIG_JSP;
	}
	
	@Override
	public void processAction(PortletConfig portletConfig, ActionRequest actionRequest, ActionResponse actionResponse) throws Exception {
		String portletResource = ParamUtil.getString(actionRequest, "portletResource");
		PortletPreferences preferences = PortletPreferencesFactoryUtil.getPortletSetup(actionRequest, portletResource);
		if (Validator.isNotNull(preferences)) {
			String maxWidth = ParamUtil.getString(actionRequest, SHIDO_IMAGE_GALLERY_MAX_WIDTH);
			String cellNumber = ParamUtil.getString(actionRequest, SHIDO_IMAGE_GALLERY_CELL_NUMBER);
			String cellHeight = ParamUtil.getString(actionRequest, SHIDO_IMAGE_GALLERY_CELL_HEIGHT);
			String align = ParamUtil.getString(actionRequest, SHIDO_IMAGE_GALLERY_ALIGN);
			String[] urls = ParamUtil.getParameterValues(actionRequest, SHIDO_IMAGE_GALLERY_CELL_URL);
			String[] bgImgUrls = ParamUtil.getParameterValues(actionRequest, SHIDO_IMAGE_GALLERY_BACKGROUND_IMG_URL);
			String[] fgImgUrls = ParamUtil.getParameterValues(actionRequest, SHIDO_IMAGE_GALLERY_FOREGROUND_IMG_URL);
			String[] titles = ParamUtil.getParameterValues(actionRequest, SHIDO_IMAGE_GALLERY_TITLE);
			String[] summaries = ParamUtil.getParameterValues(actionRequest, SHIDO_IMAGE_GALLERY_SUMMARY);
			String[] tags = ParamUtil.getParameterValues(actionRequest, SHIDO_IMAGE_GALLERY_TAG);
			
			preferences.setValue(SHIDO_IMAGE_GALLERY_MAX_WIDTH, maxWidth);
			preferences.setValue(SHIDO_IMAGE_GALLERY_CELL_NUMBER, cellNumber);
			preferences.setValue(SHIDO_IMAGE_GALLERY_CELL_HEIGHT, cellHeight);
			preferences.setValue(SHIDO_IMAGE_GALLERY_ALIGN, align);
			preferences.setValues(SHIDO_IMAGE_GALLERY_CELL_URL, urls);
			preferences.setValues(SHIDO_IMAGE_GALLERY_BACKGROUND_IMG_URL, bgImgUrls);
			preferences.setValues(SHIDO_IMAGE_GALLERY_FOREGROUND_IMG_URL, fgImgUrls);
			preferences.setValues(SHIDO_IMAGE_GALLERY_TITLE, titles);
			preferences.setValues(SHIDO_IMAGE_GALLERY_SUMMARY, summaries);
			preferences.setValues(SHIDO_IMAGE_GALLERY_TAG, tags);
			preferences.store();
			
			SessionMessages.add(actionRequest, SUCCESS);
		}
		super.processAction(portletConfig, actionRequest, actionResponse);
	}
}
