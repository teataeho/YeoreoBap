package com.spring.yeoreobap.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.review.mapper.IReviewMapper;
import com.spring.yeoreobap.util.PageVO;

@Service
public class ReviewService implements IReviewService {

	@Autowired
	private IReviewMapper mapper;
	
	@Override
	public void regist(ReviewVO vo) {
		mapper.regist(vo);

	}

	@Override
	public List<ReviewVO> getList(PageVO vo) {
		return mapper.getList(vo);
	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}

	@Override
	public ReviewVO getContent(int bno) {
		return mapper.getContent(bno);
	}

	@Override
	public void update(ReviewVO vo) {
		mapper.update(vo);

	}

	@Override
	public void delete(int bno) {
		mapper.delete(bno);

	}

}