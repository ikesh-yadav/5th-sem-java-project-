package com.JSD.ikesh.StudentMarksSysyem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
class ViewTestController{
	
	@RequestMapping(value="/viewtest", method= RequestMethod.GET )
	public String showSignupMessage() {
		return "viewtest";
	}
	
}