package com.JSD.ikesh.StudentMarksSysyem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
class TakeTestController{
	
	@RequestMapping(value="/takeTest", method= RequestMethod.GET )
	public String takeTestMessage() {
		return "takeTest";
	}
	
}