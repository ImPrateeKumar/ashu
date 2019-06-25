<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="com.tmk.hibernate.annotations.BrokerGroup"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<title>UAS Application Admin</title>
<script type='text/javascript' src='//ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js'></script>
<link rel="icon" type="image/ico" href="Tokio_Marine_Kiln - 2.ico">

<script>

		jQuery("#addLocationButton").click(function(){
			jQuery("#addLocation").show();
			jQuery("#location").attr('disabled', 'disabled');
			jQuery("#btype").attr('disabled', 'disabled');
			jQuery("#rbteamname").attr('disabled', 'disabled');
			jQuery("#addLocationButton").hide();

	});

	$(document).on("click", "#brokerAddButton", function() {
		$.get("AddingServlet.java", function(responseText) {
			$("#validationMessageBox").text(responseText);
			$("#urlMessageBox").text(responseText);
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

	<div class="nav">
		<ul>
			<li><a href="SearchBroker.jsp"><i class="fas fa-search"></i> Search Broker</a></li>
			<li><a class="active" href="AddBroker.jsp" style="cursor: pointer"><i class="fas fa-address-book"></i> Add Broker</a></li>
		</ul>
	</div>

	<div class="container2">

		<div id="add-broker-header">
			<h2>
				<i class="fas fa-folder-plus" style="color: #009adf; font-size: 30px; text-shadow: -1px -1px 0 #000, -1px 0 #000, -1px 0 #000;"></i>
				<span class="add-text">Add New Broker</span>
			</h2>
		</div>
		<div class="fancy-line"></div>

		<form name="addForm" id="addForm" method="post" action="${pageContext.request.contextPath}/AddingServlet" onsubmit="showHide(); return false;">
 
			<label for="bname" style="color: #616161;"><font color="red">*</font><font style="font-weight: bold;"> Broker Name:</font></label> 
				<input style="width: 100%" type="text" id="bname" name="brokerName" placeholder="Enter Broker Name..." pattern="[a-zA-Z0-9() ]+" title="Only alpha-numeric characters, hyphens and parentheses allowed" required />
			<label for="location" style="color: #616161;"><font color="red">*</font><font style="font-weight: bold;"> Location:</font></label>
				<input style="width: 100%" type="text" id="location" name="brokerLocation" placeholder="Enter Broker Location..." pattern="[A-Za-z ]+" title="Special Characters / Numbers not allowed" required />
			<label for=btype style="color: #616161;"><font style="font-weight: bold;">Broker Type ( BIBA / Non-BIBA ? ):</font></label> 
				<select id="btype" name="btype" style="width: 100%; color: #616161">
					<option value="BIBA">BIBA</option>
					<option value="Non-BIBA">Non-BIBA</option>
				</select>
			<label for="rbteamname" style="color: #616161;"><font color="red">*</font><font style="font-weight: bold;"> Rulebook Team Name:</font></label> 
				<input style="width: 100%" type="text" id="rbteamname" name="rulebookTeamName" placeholder="Enter Rulebook Team Name..." required />

			<div id="mandatory-field">
				<font color="red">*</font> Mandatory Field
			</div>

			<div id="new-broker-add-button">
				<input id="brokerAddButton" type="submit" name="addBroker" value="Add">
			</div>

		</form>

	</div>

	<div id="validationMessageBox" style="vertical-align: middle; height: auto; color: white; background-color: #94c11e; text-align: center; font-weight: bold; border-radius: 5px;"><i class="fas fa-info-circle fa-lg"></i> ${message}</div>
	
	<div id="urlMessageBox" style="vertical-align: middle; height: 30px; text-align: center; font-weight: bold; border-radius: 5px;">${url}</div>

</body>
</html>
