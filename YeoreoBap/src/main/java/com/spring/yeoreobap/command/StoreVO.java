package com.spring.yeoreobap.command;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
/*
 CREATE TABLE store(
	sno INT PRIMARY KEY AUTO_INCREMENT,
    siteTel VARCHAR(100) NOT NULL,
    rdnWhlAddr VARCHAR(300) NOT NULL,
    bplcNm VARCHAR(50) NOT NULL,
    uptaeNm VARCHAR(20) NOT NULL,
    x long NOT NULL, 
    y long NOT NULL
); 
*/
@Getter @Setter @ToString
public class StoreVO {
	
	private int sno; //가게 번호
	private String siteTel;	//전화번호
	private String rdnWhlAddr;	//도로명주소
	private String bplcNm;	//사업장명(가게이름)
	private String uptaeNm;	//업태구분명(한/중/일식)
	private long x;	//x축
	private long y;	//y축
	
}
