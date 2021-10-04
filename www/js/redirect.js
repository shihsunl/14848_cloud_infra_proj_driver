
function redirect(path, port) {
    var current_host = window.location.hostname;
    var redirect_url = "http://"+current_host+"/"+path+":"+port
    console.log(redirect_url);
    window.location.href = redirect_url;
    //window.location.replace(redirect_url)
    //window.location = redirect_url;
}
