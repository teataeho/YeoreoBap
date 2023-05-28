package com.spring.yeoreobap.user.service;

import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.util.PageVO;

public interface IUserService {

	//아이디 중복 확인
	int idCheck(String userId);

	//회원 가입
	void join(UserVO vo);

	//로그인
	String login(String userId, String userPw);

	//MyPage
	//회원 정보 얻기
	UserVO getInfo(String userId, PageVO vo);

	//회원 정보 수정
	void updateUser(UserVO vo);
	
	//거주구
	String mine(String addrMine);

	//주변구
	String close(String addrClose);
}