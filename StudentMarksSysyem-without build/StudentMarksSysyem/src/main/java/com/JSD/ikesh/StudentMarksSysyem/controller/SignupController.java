
package com.JSD.ikesh.StudentMarksSysyem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
class SignupController{
	
	@RequestMapping(value="/signup", method= { RequestMethod.GET,RequestMethod.POST } )
	public String showSignupMessage() {
		return "signup";
	}
	
}