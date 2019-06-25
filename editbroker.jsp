<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css" />
<title>UAS Application Admin</title>
<link rel="icon" type="image/ico" href="Tokio_Marine_Kiln - 2.ico">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<script type='text/javascript'
	src='//ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js'></script>
</head>

<body>

	<div id="header-title" align="center">
		<h1>UAS Application Administration</h1>
	</div>
	<div id="tmk-logo">
		<img src="Tokio_Marine_Kiln.png" alt="TMK Logo"
			style="width: 120px; height: 110px;">
	</div>

	<!-- Navigation Menu -->
	<div class="nav">
		<ul>
			<li><a class="active" href="SearchBroker.jsp"
				style="cursor: pointer"><i class="fas fa-search"></i> Search
					Broker</a></li>
			<li><a href="AddBroker.jsp"><i class="fas fa-address-book"></i>
					Add Broker</a></li>
		</ul>
	</div>

	<!-- Edit Broker Form Container -->
	<div class="container2">

		<div id="edit-broker-header">
			<h2>
				<i class="far fa-edit"
					style="color: #009adf; text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000;"></i>
				<span class="add-text">Edit Broker</span>
			</h2>
		</div>
		<div class="fancy-line"></div>

		<form id="editForm" method="post"
			action="${pageContext.request.contextPath}/AddingServlet">

			<input type="hidden" id='brokerEntityId' name="brokerEntityId"
				readonly /><br> <input type="hidden" id='brokerGroupId'
				name="brokerGroupId" style="color: #616161;" readonly /><br> <label
				for="bname" style="color: #616161;"><font color="red">*</font><font
				style="font-weight: bold;"> Broker Name:</font></label> <input
				style="width: 100%;" type="text" id='bname' name="brokerName"
				style="color: #616161;" placeholder="Enter Broker Name..."
				pattern="[a-zA-Z0-9() ]+"
				title="Only alpha-numeric characters and parentheses allowed"
				required /> <label for="location" style="color: #616161;"><font
				color="red">*</font><font style="font-weight: bold;">
					Location:</font></label> <input style="width: 100%;" type="text" id='location'
				name="brokerLocation" style="color: #616161;"
				placeholder="Enter Broker Location..." pattern="[A-Za-z ]+"
				title="Special Characters / Numbers not allowed" required />
			<div id="addLocation">
				<label for="location" style="color: #616161;"><font
					style="font-weight: bold;">Additional Location:</font></label> <input
					style="width: 100%;" type="text" id="location2"
					name="brokerLocation2" style="color: #616161;"
					placeholder="Enter Additional Broker Location..." />
			</div>
			<label for=btype style="color: #616161;"><font
				style="font-weight: bold;">Broker Type ( BIBA / Non-BIBA ? ):</font></label>
			<select id="btype" name="btype" style="width: 100%; color: #616161;">
				<option value="BIBA">BIBA</option>
				<option value="Non-BIBA">Non-BIBA</option>
			</select>

			<!-- Hidden BIBA Text Field for populating DB -->
			<input type="hidden" id="btype2" name="btype2" readonly /> <label
				for="rbteamname" style="color: #616161;"><font color="red">*</font><font
				style="font-weight: bold;"> Rulebook Team Name:</font></label> <input
				style="width: 100%;" type="text" id='rbteamname'
				name="rulebookTeamName" style="color: #616161;"
				placeholder="Enter Rulebook Team Name..." required />
				
				<input type="hidden" id="ruleBookTeamNameTracker" name="ruleBookTeamNameTracker" /><br>

			<div id="mandatory-field">
				<font color="red">*</font> Mandatory Field
			</div>

			<div id="new-broker-add-button">
				<input type="submit" name="updateBroker" value="Update">
			</div>

			<div id="new-broker-location-button"
				style="display: flex; justify-content: center;">
				<input type="submit" name="updateBroker" value="Add New Location">
			</div>

			<button id="addLocationButton">+ Additional Broker Location</button>

			<button type="submit" name="showBrokerEditPage"
				id="previous-page-button">Back</button>
		</form>

	</div>

	<div id="validationMessageBox"
		style="vertical-align: middle; height: 30px; color: white; background-color: #94c11e; text-align: center; font-weight: bold; border-radius: 5px;">
		<i class="fas fa-info-circle fa-lg"></i>${message}
	</div>

	<script>
		jQuery(document).ready(
				function() {

					jQuery("#addLocation").hide();
					jQuery("#new-broker-location-button").hide();
					jQuery("#addLocationButton").click(
							function() {
								jQuery("#new-broker-add-button").hide();
								jQuery("#new-broker-location-button").show();
								jQuery("#addLocation").show();
								jQuery("#location2").attr('required', true);
								jQuery("#location")
										.attr('readonly', 'readonly').css(
												"background-color", "#dcdad1");
								jQuery("#bname").attr('readonly', 'readonly')
										.css("background-color", "#dcdad1");
								jQuery("#bname").attr('required', true);
								jQuery("#addLocationButton").hide();
							});

					jQuery("#new-broker-add-button").click(function() {
						jQuery("#validationMessageBox").show();
					})

					/* Make fields optional when clicking back button */
					jQuery("#previous-page-button").click(function() {
						jQuery("#bname").attr('required', false);
						jQuery("#location").attr('required', false);
						jQuery("#rbteamname").attr('required', false);
						jQuery("#location2").attr('required', false);
					});
					
					// Set initial value of ruleBookTeamNameTracker to 'unchanged'
					$("#ruleBookTeamNameTracker").val("Unchanged");

					// Check if Rulebook Team Name input field has been changed
					$("#rbteamname").change(function() {
						$("#rbteamname").data("changed", true);
						$('#ruleBookTeamNameTracker').val("Changed");
					});

					if ($("#rbteamname").data("changed")) {
						// change value of ruleBookTeamNameTracker to 'Changed'
						$('#ruleBookTeamNameTracker').val("Changed");
					}

					
				});
		
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

		var biba = getParameterByName('rbScheme');

		if (biba == 'D0650594-C11C-4BA2-8A1B-F3397FED25E9') {
			biba = 'BIBA';
		} else {
			biba = 'Non-BIBA';
		}

		var bEntityName = getParameterByName('brokerEntityName');
		var bLocation = getParameterByName('brokerLocation');
		var rbId = getParameterByName('ruleBookId');
		var bEntityId = getParameterByName('brokerEntityId');
		var bGroupId = getParameterByName('brokerGroupId');

		document.getElementById("bname").value = bEntityName;
		document.getElementById("location").value = bLocation;
		document.getElementById("rbteamname").value = rbId;
		document.getElementById("brokerEntityId").value = bEntityId;
		document.getElementById("brokerGroupId").value = bGroupId;
		document.getElementById("btype").value = biba;
		document.getElementById("btype2").value = biba;
	</script>

</body>
</html>
