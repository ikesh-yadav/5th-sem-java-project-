package com.JSD.ikesh.StudentMarksSysyem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
class TestSaveController{
	
	@RequestMapping(value="/testSave", method= RequestMethod.POST )
	public String showTestPageMessage() {
		return "testSave";
	}
	
}