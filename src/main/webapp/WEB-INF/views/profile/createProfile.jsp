<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2019-05-07
  Time: 오후 4:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.openpaas.paasta.marketplace.web.seller.common.Constants" %>
<html>
<head>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
    <title>프로필 등록</title>

    <%@include file="../common/commonLibs.jsp" %>
</head>
<body>
<table>
    <tr>
        <td>판매자명</td>
        <td><input type="text" id="sellerName"></td>
    </tr>
    <tr>
        <td>유형</td>
        <td>
        <select onchange="selectBox();" id="businessGroup">
        </select>
        </td>
    </tr>
    <tr>
        <td>담당자명</td>
        <td><input type="text" id="managerName"></td>
    </tr>
    <tr>
        <td>메일 주소</td>
        <td><input type="text" id="emailAddress"></td>
    </tr>
    <tr>
        <td>홈페이지 주소</td>
        <td><input type="text" id="homepageUrl"></td>
    </tr>
</table>
<div>
    <button type="button" onclick="createProfile();">등록하기</button>
</div>
</body>
</html>
<script type="text/javascript">

    var BUSINESS_TYPE_GROUP = [];
    var codeUnitValue;


    var getBusinessGroup = function () {
        var groupTypeName = "<%= Constants.BUSINESS_GROUP_TYPE %>";
        var reqUrl = "<%= Constants.URI_MARKET_API_CODE %>/"  + groupTypeName;

        procCallAjax(reqUrl, "GET", null, null, callbackGetBusinessGroup);
    };

    var callbackGetBusinessGroup = function (data) {
        console.log("비즈니스 코드 List :::" + JSON.stringify(data));

        BUSINESS_TYPE_GROUP = data;

        var businessGroupArea = $("#businessGroup");
        var htmlString = [];
        var option = "<option selected='selected'>선택</option>";


        for(var i = 0; i < data.length; i++){
            option += "<option value=" + data[i].codeUnit + ">" + data[i].codeUnitName + "</option>"
        }

        htmlString.push(option);
        businessGroupArea.html(htmlString);

    };

    var selectBox = function () {
      codeUnitValue = $("#businessGroup option:selected").val();
      console.log("선택된 값은? " + codeUnitValue);
    };


    var createProfile = function () {
        var reqUrl = "<%= Constants.URI_MARKET_API_PROFILE %>";

        var sellerName = $('#sellerName').val();
        var businessType = codeUnitValue;
        var managerName = $('#managerName').val();
        var email = $('#emailAddress').val();
        var homepageUrl = $('#homepageUrl').val();

        var param = {
            "userId": USER_NAME,
            "sellerName": sellerName,
            "businessType": businessType,
            "managerName": managerName,
            "email": email,
            "homepageUrl": homepageUrl
        };

        procCallAjax(reqUrl, "POST", JSON.stringify(param), null, callbackCreateProfile);

    };

    var callbackCreateProfile = function(data){
        alert("저장 완료!!! " + JSON.stringify(data));
    };



    // ON LOAD
    $(document).ready(function() {
        getBusinessGroup();
    });

</script>
