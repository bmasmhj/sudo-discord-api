const queryString = window.location.search;  
const urlParams = new URLSearchParams(queryString);   
console.log(urlParams.has('c'));
const chat = urlParams.get('c');

var r = Bots.sendMessage("Sudo", chat, { "USER": "mrfishie" });
if(r.length >0 ){
    for (var i = 0; i < r.length; i++) {
        var reply = r[i];
        // document.write(`{"reply" : "${reply}" }`);
        // return replies;
        location.href = `reply.php?r={"reply" : "${reply}" }`;

    }
}
else {
    document.write(`{"reply" : "Sorry, I can't understand you" }`);
}
