package com.spring.yeoreobap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.yeoreobap.review.service.IReviewBoardService;
import com.spring.yeoreobap.util.PageCreator;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/review")
@Slf4j
public class ReviewController {

	private IReviewService service;
	
	@GetMapping("/reviewList")
	public void reviewList(PageVO vo, Model model) {
		PageCreator pc = new PageCreator(vo, service.getTotal(vo));
		System.out.println("store: " + pc.toString());
		log.info(pc.toString());
		
		model.addAttribute("storeList",service.getList(vo));
		model.addAttribute("pc", pc);
	}
}
