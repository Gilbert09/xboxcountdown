var itemArr = [];
var currentSort = "*";
var overlayActive = false;

$(document).ready(function() {
	
	$.getJSON("http://xboxcountdown.com/upcoming_games.json", function(data) {
		$.each(data, function(key, val) {
			var dateSplit = val.Date.split("/");
			var date = new Date(dateSplit[2], dateSplit[1] - 1, dateSplit[0]);
			if (date < Date.now()) return;

			var consoleClass = "xbox360";
			if (val.Console.indexOf("One") != -1)  consoleClass = "xboxone";

			var html = "<div data-time-tick=\"" + date.getTime() + "\" class=\"item " + consoleClass + "\"><img style=\"padding: 5px;\" src=\"img/" + val.Img + "\" width=\"290\" height=\"200\" />";
			html += "<div style=\"padding: 0 10px 10px 10px;\"><span class=\"large title-overflow\" title=\"" + val.Title + "\">" + val.Title + "</span>";
			html += "<span class=\"italic small " + (val.Console == "Xbox 360" ? "xbox" : "one") + "\">" + val.Console + "</span><span class=\"time\" title=\"" + val.Date + "\"></span></div></div>";
			var item = $.parseHTML(html);
			setTimer(dateSplit[2], dateSplit[1], dateSplit[0], $(item).find(".time"));
			itemArr.push(item);
			$('#container').isotope('insert', item);
		});
		
		var randomElement = itemArr[Math.floor(Math.random() * itemArr.length)];
		var randomTick = $(randomElement).attr("data-time-tick") + 1;
		var advert = "<div data-time-tick=\"" + randomTick + "\" class=\"item xbox360 xboxone\"><ins class=\"adsbygoogle\" style=\"display:inline-block;width:300px;height:270px\"";
		advert += "data-ad-client=\"ca-pub-2874390533750539\" data-ad-slot=\"6969436610\"></ins></div>";
		var adEle = $.parseHTML(advert);
		$('#container').isotope('insert', adEle);
		
		(adsbygoogle = window.adsbygoogle || []).push({});
		
		if(document.getElementsByTagName("iframe").item(0) == null) {
			$('#container').isotope('remove', adEle);
		}
	});

	$.getJSON("http://xboxcountdown.com/games_with_gold.json", function(data) {
		$.each(data, function(key, val) {
			var startDateSplit = val.StartDate.split("/");
			var startDate = new Date(startDateSplit[2], startDateSplit[1] - 1, startDateSplit[0]);
			var endDateSplit = val.EndDate.split("/");
			var endDate = new Date(endDateSplit[2], endDateSplit[1] - 1, endDateSplit[0]);
			if (endDate < Date.now()) return;

			var consoleClass = "xbox360";
			if (val.Console.indexOf("One") != -1)  consoleClass = "xboxone";

			var html = "<div data-time-tick=\"" + endDate.getTime() + "\" class=\"item " + consoleClass + "\"><img style=\"padding: 5px;\" src=\"img/" + val.Img + "\" width=\"290\" height=\"200\" />";
			html += "<div style=\"padding: 0 10px 10px 10px;\"><span class=\"large title-overflow\" title=\"" + val.Title + "\">" + val.Title + "</span>";
			html += "<span class=\"italic small " + (val.Console == "Xbox 360" ? "xboxgold" : "onegold") + "\">" + val.Console + "</span>";
			html += "<span class=\"time\" title=\"Games With Gold\">Ends: " + endDate.getDate() + " " + getMonth(endDate.getMonth()) + " " + endDate.getFullYear() + "</span></div></div>";
			var item = $.parseHTML(html);
			//setTimer(dateSplit[2], dateSplit[1], dateSplit[0], $(item).find(".time"));
			itemArr.push(item);
			$('#container').isotope('insert', item);
		});
	});

	$('#container').isotope({
	  itemSelector: '.item',
	  getSortData: {
	  	date : '[data-time-tick]'
	  },
	  sortBy: 'date'
	});
	
	$(document).on("click touchstart", "#nav span", function() {
		var clicked = $(this);
		$("#nav span.selected").removeClass("selected");
		$(clicked).addClass("selected");

		if ($(this).text() == "All") {
			currentSort = "*";
			filter();
			updateHistory();
			ga('send', 'event', 'LinkClick', 'All');
		} else if ($(this).text() == "Xbox One") {
			currentSort = "xboxone";
			filter();
			updateHistory();
			ga('send', 'event', 'LinkClick', 'Xbox One');
		} else if ($(this).text() == "Xbox 360") {
			currentSort = "xbox360";
			filter();
			updateHistory();
			ga('send', 'event', 'LinkClick', 'Xbox 360');
		}
		
		//$("#search").val("");
	});

	if (location.search.indexOf("360") == 1) {
		$("#nav span.selected").removeClass("selected");
		currentSort = "xbox360";
		filter();
		$("#xbox360span").addClass("selected");
	} else if (location.search.indexOf("one") == 1) {
		$("#nav span.selected").removeClass("selected");
		currentSort = "xboxone";
		filter();
		$("#xboxonespan").addClass("selected");
	}

	if (location.search.indexOf("s=") != -1) {
		var query = location.search.substring(location.search.indexOf("s=") + 2, location.search.length);
		$("#search").val(query);
		filter();
	}
	
	$("#search").on("keyup", function() {
		updateHistory();
		filter();
	});

	$(document).on("click", "#menuButton", function() {
		if ($("#menuButton div").css("display") == "none") {
			$("#menuButton div").css("display", "block");
			$("#menuButton").css("color", "rgb(84, 84, 84)");
		} else {
			$("#menuButton div").css("display", "none");
			$("#menuButton").css("color", "rgb(174, 174, 174)");
		}
	});

	$(document).on('click', function(event) {
		if (!$(event.target).closest('#menuButton').length) {
			$("#menuButton div").css("display", "none");
			$("#menuButton").css("color", "rgb(174, 174, 174)");
		}
	});

	$(document).on('click', '#overlay', function() {
		$("#overlay").css("display", "none");
		$("#popup").css("display", "none");
	});

	$(document).on('click', '#menuButton li:nth-child(1)', function() {
		$("#overlay").css("display", "block");
		$("#popup").css("display", "block");
		ga('send', 'event', 'LinkClick', 'What is This?');
	});

	$(document).on('click', '#menuButton li:nth-child(2)', function() {
		window.location = "mailto:tom@dysign.co.uk";
		ga('send', 'event', 'LinkClick', 'Contact Me');
	});

	//setTimer(2015, 3, 25, $(".block"));
});

function setTimer(year, month, day, span) {
	timeTick(year, month, day, span);
	setInterval(function() {
		timeTick(year, month, day, span);
	}, 1000);
}

function timeTick(year, month, day, span) {
	var now = new Date();
	now.setMinutes(now.getMinutes()+now.getTimezoneOffset());
	
	//if (tz == "CST") now.addHours(-6);
	//else if (tz == "EST") now.addHours(-5);
	//else if (tz == "PDT") now.addHours(-8);
	//else if (tz == "GMT") now.addHours(0);
	
	var seconds = 1000;
	var minutes = seconds * 60;
	var hours = minutes * 60;
	var days = hours * 24;	

	var then = new Date(year, month - 1, day);
	var diff = then - now;
	
	var daysLeft = Math.floor(diff / days);
	var hoursLeft = Math.floor((diff % days) / hours);
	var minutesLeft = Math.floor((diff % hours) / minutes);
	var secondsLeft = Math.floor((diff % minutes) / seconds);

	$(span).text(daysLeft + " Days " + hoursLeft + " Hours " + minutesLeft + " Minutes " + secondsLeft + " Seconds");
}

function getMonth(month) {
	return ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][month]
}

function updateHistory() {
	if (typeof history === 'object') history.pushState({}, '', queryParameters());
}

function queryParameters() {
	var query = "/";
	if (currentSort == "xboxone") query += "?one";
	else if (currentSort == "xbox360") query += "?360";

	if ($("#search").val().trim() != "") {
		if (query === "/") {
			query += "?s=" + $("#search").val().trim();
		} else query += "&s=" + $("#search").val().trim();
	}

	return query;
}

function filter() {
	$('#container').isotope({
		filter: function() {
			var name = $(this).find(".large").text().toLowerCase();
			var nameMatch = false;
			if (name.indexOf($("#search").val().toLowerCase()) != -1) nameMatch = true;
			
			if (currentSort != "*") {
				if($(this).hasClass(currentSort)) {
					return nameMatch;
				} else return false;
			}
			
			return nameMatch;
		}
	});
}

if (window.location.host.indexOf("dev") == -1) {
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	ga('create', 'UA-33193139-7', 'xboxcountdown.com');
	ga('send', 'pageview');
}