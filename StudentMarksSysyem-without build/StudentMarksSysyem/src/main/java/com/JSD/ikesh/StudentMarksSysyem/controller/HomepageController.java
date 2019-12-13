package com.JSD.ikesh.StudentMarksSysyem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
class HomepageController{
	
	@RequestMapping(value="/homepage", method= RequestMethod.GET )
	public String showSignupMessage() {
		return "homepage";
	}
	@RequestMapping(value="/createTest", method= RequestMethod.GET )
	public String showCreateTestMessage() {
		return "createTest";
	}
	
}