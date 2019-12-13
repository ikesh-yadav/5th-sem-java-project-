package com.JSD.ikesh.StudentMarksSysyem.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Table(name="user")
@EntityListeners(AuditingEntityListener.class)
public class user {
@Id
@GeneratedValue(strategy=GenerationType.AUTO)
@Column(name="name")
String name;


@Column(name="password")
String password;


@Column(name="sem")
int sem;

@Column(name="sec")
int sec;

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getPassword() {
	return password;
}

public void setPassword(String password) {
	this.password = password;
}

public int getSem() {
	return sem;
}

public void setSem(int sem) {
	this.sem = sem;
}

public int getSec() {
	return sec;
}

public void setSec(int sec) {
	this.sec = sec;
}
}

