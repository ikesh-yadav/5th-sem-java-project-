package com.JSD.ikesh.StudentMarksSysyem.repository;


import org.springframework.data.jpa.repository.*;

import com.JSD.ikesh.StudentMarksSysyem.models.user;


public interface UserRepository extends JpaRepository<user , Integer>{
	
}