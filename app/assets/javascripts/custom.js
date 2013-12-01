// Popup Loader
// 0 == disabled; 1 == enabled
var popupLoaded = 0;
function loadPopup(el){
    if(popupLoaded==0){
        $(".popupBackground").css({"opacity": "0.7"});
        $(".popupBackground").fadeIn(200);
        $("."+el).fadeIn(200);
        popupLoaded = 1;
    };
};
function unloadPopup(el){
    if(popupLoaded==1){
        $(".popupBackground").fadeOut(200);
        $("."+el).fadeOut(200);
        popupLoaded = 0;
    };
};
function centerPopup(el){
    var windowWidth = document.documentElement.clientWidth;
    var windowHeight = document.documentElement.clientHeight;
    var popupHeight = $("."+el).height();
    var popupWidth = $("."+el).width();
    $("."+el).css({
        "position": "absolute",
        "top": windowHeight/2-popupHeight/2,
        "left": windowWidth/2-popupWidth/2
    });
    $(".popupBackground").css({
        "height": windowHeight
    });
};
// end Popup Loader

// Get generated emails 
function generateEmails(id){
    var first_name = $("#firstname").val();
    var last_name = $("#lastname").val();
    var domain_name = $("#domain").val();
    $.post(
        "/generate/",
        { first: first_name, last: last_name, domain: domain_name },
    function(response){
        $("."+id).html(response);
    });
};
// End generated emails 
