package com.spring.yeoreobap.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.user.mapper.IUserMapper;
import com.spring.yeoreobap.util.PageVO;

@Service
public class UserService implements IUserService {

	@Autowired
	private IUserMapper mapper;
	
	@Override
	public int idCheck(String userId) {
		return mapper.idCheck(userId);
	}

	@Override
	public void join(UserVO vo) {
		mapper.join(vo);
	}

	@Override
	public String login(String userId, String userPw) {
		return mapper.login(userId);
	}

	@Override
	public UserVO getInfo(String userId, PageVO vo) {
		return mapper.getInfo(userId, vo);
	}

	@Override
	public void updateUser(UserVO vo) {
		mapper.updateUser(vo);
	}
	
	@Override
	public String mine(String addrMine) {
		return mapper.mine(addrMine);
	}
	
	@Override
	public String close(String addrClose) {
		return mapper.close(addrClose);
	}

}
