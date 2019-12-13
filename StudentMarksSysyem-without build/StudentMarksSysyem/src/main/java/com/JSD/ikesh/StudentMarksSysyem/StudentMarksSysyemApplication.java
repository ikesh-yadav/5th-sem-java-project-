package com.JSD.ikesh.StudentMarksSysyem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com/JSD/ikesh/StudentMarksSysyem/repository")
@ComponentScan(basePackages={"com.JSD"})
public class StudentMarksSysyemApplication {

	public static void main(String[] args) {
		SpringApplication.run(StudentMarksSysyemApplication.class, args);
	}

}
