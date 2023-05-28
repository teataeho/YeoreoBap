package com.spring.yeoreobap.store.service;

import java.util.List;

import com.spring.yeoreobap.command.StoreVO;
import com.spring.yeoreobap.util.PageVO;

public interface IStoreService {

	
	List<StoreVO> getList(PageVO vo);
	
	
	StoreVO getContent(int sno);
	
	//목록
	List<StoreVO> getList(PageVO vo);
	
	//상세
	StoreVO getContent(int sno);
	
	//전체
	int getTotal(PageVO vo);
}
