package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PartyVO {
/*
 CREATE TABLE party(
 	party_board_no INT PRIMARY KEY AUTO_INCREMENT,
 	rest_id VARCHAR(50),
 	writer VARCHAR(50),
 	title VARCHAR(50),
 	content VARCHAR(200),
 	reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 	update_date DATETIME DEFAULT NULL
 	max INT NOT NULL
 );*/	
	private int partyNo;
	private String restId;
	private String writer, title, content;
	private LocalDateTime regDate, updateDate;	
	private int max;

}
