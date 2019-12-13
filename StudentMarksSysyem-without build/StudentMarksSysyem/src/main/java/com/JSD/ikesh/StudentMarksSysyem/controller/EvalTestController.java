package com.JSD.ikesh.StudentMarksSysyem.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//import com.JSD.ikesh.StudentMarksSysyem.repository.UserRepository;

@Controller
class EvalTestController{
	
	@RequestMapping(value="/evalTest", method= {RequestMethod.POST,RequestMethod.GET} )
	public String evalTestMessage() {
		return "evalTest";
	}
}