
function redirect(postfix, port) {
    var current_host = window.location.host;
    var redirect_url = "http://"+current_host+":"+port+"/"+postfix
    console.log(redirect_url);
    window.location.href = redirect_url;
    //window.location.replace(redirect_url)
    //window.location = redirect_url;
}
