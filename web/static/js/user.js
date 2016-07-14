import socket from "./socket"

$(function() {
  let ul = $("ul#em")
//let message = $("div#message") 
  if (ul.length) {
    var token = ul.data("id")
    var topic = "users:" + token
		
    // Join the topic
    let channel = socket.channel(topic, {})
    channel.join()
      .receive("ok", data => {
        console.log("Joined topic", topic)
      })
      .receive("error", resp => {
        console.log("Unable to join topic", topic)
      })
			channel.on("change", toy => {
					console.log("Change:", toy);
					$("#message").append(toy["body"])
			})

			$("#on").click(function(){
					channel.push("control", {val: "on"});
			})
			$("#off").click(function(){
					channel.push("control", {val: "off"})
			})

			channel.on("control", data => {
					console.log("Recieved: ", data.val);
			})
			channel.on("sensor_output", data => {
				$("#load").html(data['load']);
				$("#pf").html(data['pf']);
				$("#thd").html(data['thd']);
				$("#reading").html(data['reading']);
			})
			//channel.on("shout", msg => {
				//console.log("Shout:", msg);
				//$("#message").append(msg["body"])
			//})
  }
});
