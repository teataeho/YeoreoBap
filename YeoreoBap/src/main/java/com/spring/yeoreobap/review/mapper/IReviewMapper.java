package com.spring.yeoreobap.review.mapper;

import java.util.List;

import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.util.PageVO;

public interface IReviewMapper {

	//글 등록
	void regist(ReviewVO vo);

	//글 목록
	List<ReviewVO> getList(PageVO vo);

	//총 게시물 수 구하기
	int getTotal(PageVO vo);

	//상세보기
	ReviewVO getContent(int bno);

	//수정
	void update(ReviewVO vo);

	//삭제
	void delete(int bno);

}