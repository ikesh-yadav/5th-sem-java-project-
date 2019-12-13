package com.JSD.ikesh.StudentMarksSysyem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
class LoginAutenticateController{
	
	@RequestMapping(value="/loginAutenticate", method= RequestMethod.POST )
	public String loginAutenticateMessage() {
		return "loginAutenticate";
	}
	
}