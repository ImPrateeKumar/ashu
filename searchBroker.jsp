<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="com.tmk.hibernate.annotations.BrokerGroup"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@page import="com.tmk.hibernate.dao.BrokerDAO"%>
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<title>UAS Application Admin</title>
<link rel="icon" type="image/ico" href="Tokio_Marine_Kiln - 2.ico">

<script type='text/javascript' src='//ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js'></script>

<script>
	$(document).ready(
			function() {

				$('.purpleHorizon').after('<div id="nav"></div>');
				var rowsShown = 12;
				var rowsTotal = $('.purpleHorizon tbody tr').length;
				var numPages = rowsTotal / rowsShown;
				
				for (i = 0; i < numPages; i++) {
					var pageNum = i + 1;
					$('#nav').append(
							'<a href="#" rel="' + i + '">' + pageNum + '</a> ');
				}
				
				$('#nav').css("border-style", "solid");
				$('#nav').css("border-width", "2px");
				$('#nav').css("border-color", "grey");
				$('#nav').css("background-color", "#f2f2f2");
				
				$('.purpleHorizon tbody tr').hide();
				$('.purpleHorizon tbody tr').slice(0, rowsShown).show();
				$('#nav a:first').addClass('active');
				$('#nav a').bind(
						'click',
						function() {

							$('#nav a').removeClass('active');
							$(this).addClass('active');
							var currPage = $(this).attr('rel');
							var startItem = currPage * rowsShown;
							var endItem = startItem + rowsShown;
							$('.purpleHorizon tbody tr').css('opacity', '0.0')
									.hide().slice(startItem, endItem).css(
											'display', 'table-row').animate({
										opacity : 1
									}, 300);
						});
			});
</script>
</head>

<body>

	<div id="header-title" align="center">
		<h1>UAS Application Administration</h1>
	</div>
	<div id="tmk-logo">
		<img src="Tokio_Marine_Kiln.png" alt="TMK Logo" style="width: 120px; height: 110px;">
	</div>
	
	<!-- Navigation Menu -->
	<div class="nav">
		<ul>
			<li><a class="active" href="SearchBroker.jsp" style="cursor: pointer"><i class="fas fa-search"></i> Search Broker</a></li>
			<li><a href="AddBroker.jsp"><i class="fas fa-address-book"></i> Add Broker</a></li>
		</ul>
	</div>

	<!-- Search Broker Form Container -->
	<div class="container">

		<div id="search-broker-header">
			<h2>
				<i class="fas fa-search" style="color: #009adf; text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #009adf;"></i> 
				<span class="search-text">Search Existing Broker</span>
			</h2>
		</div>
		<div class="fancy-line"></div>

		<form method="get"
			action="${pageContext.request.contextPath}/AddingServlet" class="form1">
			
			<section>
			<div style="float: left; margin-right: 20px;">
				<label for="bname" style="text-align: center; display: block; color: #616161;"><font style="font-weight: bold; font-size: 18px;">Broker Name:</font></label>
					<input type="text" id="bname" name="brokerName" autocomplete="on">
			</div>
			<div style="float: left;">
 				<label for="rbteamname" style="text-align: center; display: block; color: #616161;"><font style="font-weight: bold; font-size: 18px;">Location:</font></label>
					<input type="text" id="rbteamname" name="location" autocomplete="on">
			</div>
			</section>
			
			<br style="clear: both;">
			
			<div id = "search-button">
			<input type="submit" name="showBroker" value="Search" id="searchButton">
			</div>			
		</form>

	</div>

	<table class="purpleHorizon">
		
		<thead>
			<tr>
				<th>Broker Name <i class="fas fa-signature"></i></th>
				<th>Location <i class="far fa-compass"></i></th>
				<th>Rulebook Scheme <i class="fas fa-scroll"></i></th>
				<th>URL <i class="fas fa-link"></i></th>
				<th>Edit <i class="fas fa-pencil-alt"></i></th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach items="${brokerEntitiesList}" var="brokers" varStatus="status">
					<tr style="text-align: left;">
						<td style="padding-left: 20px;">${brokers.getBrokerEntity().brokerEntityName}</td>
						<td style="padding-left: 20px;">${brokers.brokerLocation}</td>
						<td style="text-align: center;">${brokers.ruleBook_Scheme}</td>
						<td style="padding-left: 20px;">${brokerURLFirstPart}${brokers.getBrokerEntity().brokerEntityName}${brokerURLSecondPart}${brokers.brokerLocation}</td>
						<td width="106px"><span style="cursor: pointer;"
							onClick="javascript:window.location='EditBroker.jsp?brokerEntityName=${brokers.getBrokerEntity().brokerEntityName}&brokerLocation=${brokers.brokerLocation}&ruleBookId=${brokers.ruleBookId}&brokerEntityId=${brokers.getBrokerEntity().brokerEntityId}&brokerGroupId=${brokers.brokerGroupId}&rbScheme=${brokers.ruleBook_Scheme}';">
								<button type="submit2" name="edit" value="Edit" id="search-edit-button">Edit</button>
							</span>
						</td>
					</tr>
			</c:forEach>
		</tbody>
		
	</table>
	
	<script>
	
	function getParameterByName(name, url) {
		if (!url)
			url = window.location.href;
		name = name.replace(/[\[\]]/g, '\\$&');
		var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'), results = regex
				.exec(url);
		if (!results)
			return null;
		if (!results[2])
			return '';
		return decodeURIComponent(results[2].replace(/\+/g, ' '));
	}

	var bEntityName = getParameterByName('brokerName');
	var bLocation = getParameterByName('location');
	
		jQuery( document ).ready(function() {
		
			jQuery(".links").hide();

		});

		$("#searchButton").click(function() {
		$(".links").show();

		});
	</script>
	
</body>
</html>
