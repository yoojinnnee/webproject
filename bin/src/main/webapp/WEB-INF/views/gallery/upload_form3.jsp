<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/gallery/upload_form3.jsp</title>
<style>
	#dropZone{
		width: 400px;
		height: 400px;
		border: 2px dashed red;
		border-radius: 20px;
		/* 아래는 자식 contents 를 상하 좌우로 가운데 정렬 하기 위한 css */
		display: flex;
		justify-content: center;
        align-items: center;
	}
	/* img 요소에 적용할 css */
	#preview{
		display: none;
		object-fit: cover;
		width: 100%;
		height: 100%;
		border-radius:20px;
	}	
	#image{
		display: none;
	}
</style>
</head>
<body>
	<div class="container">
		<h1>이미지 업로드 폼</h1>
	   	
      	<div>
         	<label for="caption">설명</label>
         	<input type="text" name="caption" id="caption"/>
      	</div>
      	
        <input type="file" name="image" id="image"
	            	accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
	  
	   	<!-- drag and drop 을 할 div -->
	   	<a href="javascript:" id="dropZoneLink" title="업로드 할 이미지 선택">
		   	<div id="dropZone">
		   		<p>이미지를 drag drop 또는 여기를 클릭하세요</p>
		   		<img src="" id="preview"/>
		   	</div>
	   	</a>
	   	<button id="submitBtn">업로드</button>
	</div>
	<script>
		//업로드 버튼을 눌렀을때 
		document.querySelector("#submitBtn").addEventListener("click", ()=>{
			//입력한 caption 을 읽어온다.
			const caption=document.querySelector("#caption").value;
			const files=document.querySelector("#image").files;
			//만일 caption 을 3글자 미만으로 입력하거나 선택한 파일이 없다면 
			if( caption.length < 3 || files.length == 0){
				alert("caption 을 3 글자 이상 입력하고 업로드할 이미지를 선택해 주세요");
				return; //함수를 여기서 종료 
			}
			
			//ajax 전송할 데이터를 FormData() 객체에 담는다.
			const data=new FormData();
			//caption 이라는 파라미터 명으로 input 요소에 입력한 문자열을 담는다. 
			data.append("caption", caption);
			//input 요소에 선택된 파일 데이터 얻어오기 
			const file=files[0];
			//image 라는 파라미터 명으로  현재 선택한 파일을 객체를 담는다.
			data.append("image", file);
			/*
				fetch() 함수를 호출하면서 method:"post", body:FormData 객체를 전달하면
				<form  method="post" enctype="multipart/form-data"> 폼을 전송한것과 같다
			*/
			fetch("${pageContext.request.contextPath }/gallery/ajax_upload", {
				method:"post",
				body:data
			})
			.then(res=>res.json())
			.then(data=>{
				console.log(data);
				if(data.isSuccess){
					alert(file.name+" 이미지를 성공적으로 업로드 했습니다.");
					//UI 를 초기상태로 되돌리기
					document.querySelector("#preview").style.display="none";
					document.querySelector("#dropZone p").style.display="block";
					// input type="file" 을 reset 하는 방법 
					document.querySelector("#image").value="";
					document.querySelector("#caption").value="";
				}
			});
		});
	
		//dropZone 을 클릭해도 파일 선택창을 띄우도록 한다.
		document.querySelector("#dropZoneLink").addEventListener("click", ()=>{
			// input type="file" 을 강제 클릭 시킨다.
			document.querySelector("#image").click();
		});	
	
		// dropZone div 의 참조값 얻어오기
		const dropZone=document.querySelector("#dropZone");
		//이벤트 리스너 함수 등록하기
		dropZone.addEventListener("dragover", (e)=>{
			e.preventDefault();
		});
		dropZone.addEventListener("drop", (e)=>{
			e.preventDefault();
			// drop 된 파일의 정보를 얻어오기
			const files=e.dataTransfer.files;
			console.log(files[0]);
			// drop 된 파일의 정보를 조사해서 이미지 파일이 아니라면 함수를 여기서 종료 시키기 
			const type=files[0].type;
			console.log(type);
			if( type != "image/png" && type != "image/jpg" && type != "image/gif"){
				alert("이미지 파일을 drop 하세요!");
				return;
			}
			
			//만일 파일 데이터가 존재한다면
			if(files.length > 0){
				//파일로 부터 데이터를 읽어들일 객체 생성
				const reader=new FileReader();
				//로딩이 완료(파일데이터를 모드 읽었을때) 되었을때 실행할 함수 등록
				reader.onload=(event)=>{
					//읽은 파일 데이터 얻어내기 
					const data=event.target.result;
					// img 요소에 이미지를 출력하고 보이게하고 p 요소를 숨긴다.
					document.querySelector("#preview").setAttribute("src", data);
					document.querySelector("#preview").style.display="block";
					document.querySelector("#dropZone p").style.display="none";
				};
				//파일을 DataURL 형식의 문자열로 읽어들이기
				reader.readAsDataURL(files[0]);
				//선택된 파일의 정보를 input type="file" 요소에 넣어주기
				document.querySelector("#image").files=files;
			}
		});
	
		document.querySelector("#image").addEventListener("change", (e)=>{
			//선택된 파일 배열 객체를 얻어낸다.
			const files = e.target.files;
			//만일 파일 데이터가 존재한다면
			if(files.length > 0){
				//파일로 부터 데이터를 읽어들일 객체 생성
				const reader=new FileReader();
				//로딩이 완료(파일데이터를 모드 읽었을때) 되었을때 실행할 함수 등록
				reader.onload=(event)=>{
					//읽은 파일 데이터 얻어내기 
					const data=event.target.result;
					//console.log(data);
					//이미지 요소에 data 를 src 속성의 value 로 넣어 보세요.
					document.querySelector("#preview").setAttribute("src", data);
					document.querySelector("#preview").style.display="block";
					document.querySelector("#dropZone p").style.display="none";
				};
				//파일을 DataURL 형식의 문자열로 읽어들이기
				reader.readAsDataURL(files[0]);
			}
		});
	</script>
</body>
</html>











