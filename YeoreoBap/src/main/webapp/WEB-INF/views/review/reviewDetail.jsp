﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp"%>

<section>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-9 write-wrap">
				<div class="titlebox">
					<p>상세보기</p>
				</div>

				<form action="<c:url value='/review/update' />" method="post">
					<div>
						<label>DATE</label>
						<c:if test="${article.updateDate == null}">
							<p>
								<fmt:parseDate value="${article.regDate}"
									pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime"
									type="both" />
								<fmt:formatDate value="${parsedDateTime}"
									pattern="yyyy년 MM월 dd일 HH시 mm분" />

							</p>
						</c:if>
						<c:if test="${article.updateDate != null}">
							<p>
								<fmt:parseDate value="${article.updateDate}"
									pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime"
									type="both" />
								<fmt:formatDate value="${parsedDateTime}"
									pattern="yyyy년 MM월 dd일 HH시 mm분" />

							</p>
						</c:if>
					</div>
					<div class="form-group">
						<label>번호</label> <input class="form-control" name="reviewNo"
							value="${article.review_no}" readonly>
					</div>
					<div class="form-group">
						<label>작성자</label> <input class="form-control" name="writer"
							value="${article.writer}" readonly>
					</div>
					<div class="form-group">
						<label>제목</label> <input class="form-control" name="title"
							value="${article.title}" readonly>
					</div>

					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" name="content" readonly>${article.content}</textarea>
					</div>

					<button type="submit" class="btn btn-primary"
						onclick="return confirm('변경 페이지로 이동합니다.')">변경</button>
					<button type="button" class="btn btn-dark"
						onclick="location.href='${pageContext.request.contextPath}/review/reviewList?pageNum=${p.pageNum}&cpp=${p.cpp}&keyword=${p.keyword}&condition=${p.condition}'">목록</button>
					<!--    목록 누르면 화면 페이지 유지하기    -->
				</form>
			</div>
		</div>
	</div>
</section>

<!-- 댓글 영역 시작 -->
<section style="margin-top: 80px;">
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-9 write-wrap">
				<form class="review-wrap">
					<div class="review-image">
						<img src="${pageContext.request.contextPath}/img/profile.png">
					</div>
					<!--form-control은 부트스트랩의 클래스입니다-->
					<div class="review-content">
						<textarea class="form-control" rows="3" id="review"></textarea>
						<div class="review-group">
							<div class="review-input">
								<input type="text" class="form-control" id="reviewId"
									placeholder="이름"> <input type="password"
									class="form-control" id="reviewPw" placeholder="비밀번호">
							</div>

							<button type="button" id="reviewRegist" class="right btn btn-info">등록하기</button>
						</div>

					</div>
				</form>

				<!--여기에 접근 반복-->
				<div id="reviewList">
					<!-- js단에서 반복문을 이용해서 댓글의 개수만큼 반복 표현 
                        <div class='review-wrap'>
                        <div class='review-image'>
                            <img src='${pageContext.request.contextPath}/img/profile.png'>
                        </div>
                        <div class='review-content'>
                            <div class='review-group'>
                                <strong class='left'>honggildong</strong> 
                                <small class='left'>2019/12/10</small>
                                <a href='#' class='right'><span class='glyphicon glyphicon-pencil'></span>수정</a>
                                <a href='#' class='right'><span class='glyphicon glyphicon-remove'></span>삭제</a>
                            </div>
                            <p class='clearfix'>여기는 댓글영역</p>
                        </div>
                    </div>-->
				</div>
				<button type="button" class="form-control" id="moreList"
					style="display: none;">더보기(페이징)</button>
			</div>
		</div>
	</div>
</section>

<!-- 모달 -->
<div class="modal fade" id="reviewModal" role="dialog">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="btn btn-default pull-right"
					data-dismiss="modal">닫기</button>
				<h4 class="modal-title">댓글수정</h4>
			</div>
			<div class="modal-body">
				<!-- 수정폼 id값을 확인하세요-->
				<div class="review-content">
					<textarea class="form-control" rows="4" id="modalreview"
						placeholder="내용입력"></textarea>
					<div class="review-group">
						<div class="review-input">
							<input type="hidden" id="modalRno"> <input
								type="password" class="form-control" placeholder="비밀번호"
								id="modalPw">
						</div>
						<button class="right btn btn-info" id="modalModBtn">수정하기</button>
						<button class="right btn btn-info" id="modalDelBtn">삭제하기</button>
					</div>
				</div>
				<!-- 수정폼끝 -->
			</div>
		</div>
	</div>
</div>


<%@ include file="../../include/footer.jsp"%>

<script>
window.onload = function() {
    document.getElementById('reviewRegist').onclick = function () {
        const reviewNo = '${article.reviewNo}';   //현재 게시글 번호
        const review = document.getElementById('review').value;
        const restId = document.getElementById('reviewId').value;
        const reviewPw = document.getElementById('reviewPw').value;

        if (review === '' || reviewId=== '' || reviewPw === '') {
            alert('이름, 비밀번호, 내용을 입력하세요');
            return;
        }

        //요청에 관련된 정보 객체
        const reqObj = {
            method: 'post', 
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify( {
                'review_no' : reviewNo,
                'review' : review,
                'reviewId' : reviewId,
                'reviewPw' : reviewPw
            })
        };

        fetch('${pageContext.request.contextPath}/review/regist', reqObj)
            .then(res => res.text())
            .then(data => {
                console.log('통신 성공!: ' + data);
                document.getElementById('review').value = '';
                document.getElementById('reviewId').value = '';
                document.getElementById('reviewPw').value = '';
                //등록 완료 후 댓글 목록 함수를 호출해서 비동기식으로 목록 표현
                getList(1, true);
                //더보기버튼 눌러서 댓글 더 보려하면 false
            });

    }   //댓글 등록 이벤트 끝

    //더보기 버튼 처리(클릭시 전역변수 page에 +1한 값을 요청)
    document.getElementById('moreList').onclick = () => {
        /*
        왜 false?
        더보기  댓글을 누적해서 보여준다.
        1페이지 댓글 내용 밑에 2페이지 누적해서 깔아야 한다.
        1페이지 삭제 후 2페이지 출력이 아니다.
        */
        getList(++page, false);
    }


    let page = 1;   //전역 의미로 사용할 페이지 번호
    let strAdd = '';    //화면에 그려넣을 태그를 문자열의 형태로 추가할 변수
    const $reviewList = document.getElementById('reviewList');

    //게시글 상세보기 화면에 처음 진입했을 시 댓글 리스트 호출
    getList(1, true);   

    //댓글 목록 호출 함수
    //getList의 매개값으로 뭘 줄것인가
    //요청된 페이지 번호와, 화면을 리셋할 것인지의 여부를 boolean 타입의 reset으로 받는다.
    //(페이지가 그대로 머물며 댓글이 밑에 계속 쌓이기 때문에, 상황에 따라 유동적 처리.. 페이지 리셋/누적)

    function getList(pageNum, reset) {
        strAdd = '';
        const review_no = '${article.reviewNo}'; //게시글 번호

        //get방식으로 댓글 목록을 요청(비동기)
        fetch('${pageContext.request.contextPath}/review/reviewList/' + review_no + '/' + pageNum)
        												  ///??
        .then(res => res.json())
        .then(data => {
            console.log(data);
            
            let total = data.total; //총 댓글 수
            let reviewList = data.list;  //후기 리스트

            //insert, update, delete 작업 후에는
            //댓글 내용 태그를 누적하고 있는 strAdd 변수를 초기화해서 
            //마치 화면이 리셋된 것처럼 보여줘야 한다.
            if(reset){
                while ($reviewList.firstChild) {
                    $reviewList.firstChild.remove();
                }
                page = 1;
            }

            //응답 데이터의 길이가 0과 같거나 더 작으면 함수를 종료
            if (reviewList.length <= 0) return;

            //페이지번호 * 이번 요청으로 받은 댓글 수보다 전체 댓글 개수가 적다면 더보기 버튼 없어도 된다.
            console.log('현재 페이지: ' + page);
            if (total <= page * 5) {
                document.getElementById('moreList').style.display = 'none';
            } else {
                document.getElementById('moreList').style.display = 'block';
            }

            //reviewList의 개수만큼 태그를 문자열 형태로 직접 그린것
            //중간에 들어갈 댓글 글쓴이, 날짜, 댓글 내용은 목록에서 꺼내서 표현
            for(let i=0; i<reviewList.length; i++) {
                strAdd += 
                `<div class='review-wrap'>
                        <div class='review-image'>
                            <img src='${pageContext.request.contextPath}/img/profile.png'>
                        </div>
                        <div class='review-content'>
                            <div class='review-group'>
                                <strong class='left'>` + reviewList[i].reviewId + `</strong> 
                                <small class='left'>` + (reviewList[i].updateDate != null ? parseTime(reviewList[i].updateDate) + ' (수정됨)' : parseTime(reviewList[i].reviewDate)) + `</small>
                                <a href='` + reviewList[i].rno + `' class='right reviewDelete'><span class='glyphicon glyphicon-remove'></span>삭제</a> &nbsp;
                                <a href='` + reviewList[i].rno + `' class='right reviewModify'><span class='glyphicon glyphicon-pencil'></span>수정</a>
                            </div>
                            <p class='clearfix'>` + reviewList[i].review + `</p>
                        </div>
                    </div>`;
            }

            //id가 reviewList라는 div 영역에 문자열 형식으로 모든 댓글을 추가.
            if(!reset) {
                document.getElementById('reviewList').insertAdjacentHTML('beforeend', strAdd);
            }else {                                                     //position      값    
                document.getElementById('reviewList').insertAdjacentHTML('afterbegin', strAdd);
            }                                                           //position      값
                                                                        
        });
    }   //end getList();

    //수정, 삭제
    /*
    document.querySelector('#reviewList').addEventListener('click', function(e){
        e.preventDefault();
        console.log('수정 버튼 클릭 이벤트 발생');
    });
    동작 안함
    .reviewModify 요소는 실제 존재하는 요소가 아니라 비동기 통신을 통해 생성되는 요소이다.
    그러므로 이벤트가 등록된 시점보다 fetch 함수의 실행이 먼저 끝날 것이라는 보장이 없으므로
    해당 방식은 이벤트 등록이 불가능하다.
    이때, 이미 실존하는 #reviewList에 등록하고, 이벤트를 자식에게 위임하여 사용하는
    addEventListener를 통해 처리해야 한다.
    */

    document.getElementById('reviewList').addEventListener('click', function(e){
        e.preventDefault(); //태그의 고유 기능을 중지
        
        //1. 이벤트가 발생한 target이 a태그가 아니라면 이벤트 종료
        if (!e.target.matches('a')) {
            return;
        }

        //2. a태그가 두개(수정, 삭제)이므로 어떤 링크인지를 확인
        //댓글 여러개 -> 수정,삭제가 발생하는 댓글이 몇 번인지도 확인
        const rno = e.target.getAttribute('href');
        console.log('댓글 번호: ' + rno);
        document.getElementById('modalRno').value = rno;
        //모달 내부에 숨겨진 input 태그에 댓글 번호 담기

        const content = e.target.parentNode.nextElementSibling.textContent;
        console.log('댓글 내용: ' + content);

        //3. 모달 창 하나를 이용해서 상황에 따라 수정/삭제 모달을 구분하기 위해
        //조건문을 작성(모달 하나로 수정, 삭제를 같이 처리. 디자인 조정)
        if(e.target.classList.contains('reviewModify')){
            //수정 버튼을 눌렀으므로 수정 모달 형식을 꾸며준다.
            document.querySelector('.modal-title').textContent = '댓글 수정';
            document.getElementById('modalreview').style.display = 'inline';    //댓글창
            document.getElementById('modalreview').value = content;
            document.getElementById('modalModBtn').style.display = 'inline';    //수정 버튼
            document.getElementById('modalDelBtn').style.display = 'none';  //삭제 버튼
            //inline <-> none
            
            //jQuery를 이용해서 bootstrap 모달을 여는 방법
            $('#reviewModal').modal('show'); 
        } else {
            //삭제 버튼을 눌렀으므로 삭제 모달 형식으로 꾸며준다
            document.querySelector('.modal-title').textContent = '댓글 삭제';
            document.getElementById('modalreview').style.display = 'none';    //댓글창
            
            document.getElementById('modalModBtn').style.display = 'none';  //수정 버튼
            document.getElementById('modalDelBtn').style.display = 'inline';    //삭제 버튼
            $('#reviewModal').modal('show');
        }
    }); //수정 / 삭제 버튼 클릭 이벤트 끝

    //수정 처리 함수. (수정 모달을 열어서 수정 내용을 작성 후 수정 버튼을 클릭했을 때)
    document.getElementById('modalModBtn').onclick = () => {
        const review = document.getElementById('modalreview').value;
        const rno = document.getElementById('modalRno').value;
        const reviewPw = document.getElementById('modalPw').value;

        if(review === '' || reviewPw === '') {
            alert('내용, 비밀번호를 확인하세요!');
            return;
        }

         //요청에 관련된 정보 객체
         const reqObj = {
            method: 'post', 
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify( {
                'review' : review,
                'reviewPw' : reviewPw
            })
        };

        fetch('${pageContext.request.contextPath}/review/' + rno, reqObj)
                .then(res => res.text())
                .then(data => {
                    if(data === 'pwFail') {
                        alert('비밀번호를 확인하세요.');
                        document.getElementById('modalPw').value = '';
                        //값 비워주기
                        document.getElementById('modalPw').focus();
                    } else {
                        alert('정상 수정 되었습니다.');
                        document.getElementById('modalreview').value = '';
                        document.getElementById('modalPw').value = '';
                        //제이쿼리 문법으로 bootstrap 모달 닫아주기
                        $('#reviewModal').modal('hide');
                        getList(1, true);
                    }
                });

    }//end update event

    //삭제 이벤트
    document.getElementById('modalDelBtn').onclick = () => {
        /*
        1. 모달창에 rno값, reviewPw값을 얻는다
        2. fetch 함수를 이용해서 DELETE 방식으로 review/{rno} 요청
        3. 서버에서는 요청을 받아서 비밀번호를 확인하고, 비밀번호가 맞으면 삭제 진행
        4. 만약 비밀번호가 틀렸다면 문자열 반환해서 '비밀번호가 틀렸습니다.' 경고창

        삭제 완료되면 모달 닫고 목록 요청 다시 보내기 (reset 여부 판단)
        */

        const rno = document.getElementById('modalRno').value;
        const reviewPw = document.getElementById('modalPw').value;

        if (reviewPw === '') {
            alert('비밀번호를 확인하세요!');
            return;
        }
        fetch('${pageContext.request.contextPath}/review/' + rno, {
            method: 'delete', 
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify( {
                // 'rno' : rno,
                'reviewPw' : reviewPw
            })
        })
            .then(res => res.text())
            .then(data => {
                if(data === 'pwFail') {
                    alert('비밀번호 확인하세요.')
                    document.getElementById('modalPw').value ='';
            		document.getElementById('modalPw').focus();
                } else {    //deleteSuccess
                    alert('삭제되었습니다.');
                    document.getElementById('modalPw').value ='';
                    $('#reviewModal').modal('hide');
                    getList(1, true);
                }
            });
    }   //end delete

    //댓글 날짜 변환 함수
    function parseTime(regDateTime) {
        let year, month, day, hour, minute, second;
        if(regDateTime.length === 5)  {
             [year, month, day, hour, minute] = regDateTime;
             second = 0;
        } else {
             [year, month, day, hour, minute, second] = regDateTime;
        }
        
        //원하는 날짜로 객체를 생성
        const regTime = new Date(year, month - 1, day, hour, minute, second);
        console.log(regTime);
        const date = new Date();
        console.log(date);
        const gap = date.getTime() - regTime.getTime();

        let time;
        if (gap < 60 * 60 * 24 * 1000) {
            if (gap < 60 * 60 * 1000) {
            time = '방금 전';
            } else {
            time = parseInt(gap / (1000 * 60 * 60)) + '시간 전';
            }
        } else if (gap < 60 * 60 * 24 * 30 * 1000) {
            time = parseInt(gap / (1000 * 60 * 60 * 24)) + '일 전';
        } else {
            time = `${regTime.getFullYear()}년 ${regTime.getMonth() + 1}월 ${regTime.getDate()}일`;
        }
        return time;
    }

}   //window.onload

</script>