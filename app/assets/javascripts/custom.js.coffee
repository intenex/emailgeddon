// Popup Loader
// 0 == disabled; 1 == enabled
popupLoaded = 0
loadPopup = (el) ->
    if popupLoaded is 0
        $(".popupBackground").css({"opacity": "0.7"})
        $(".popupBackground").fadeIn(200)
        $("."+el).fadeIn(200)
        popupLoaded = 1

unloadPopup = (el) ->
    if popupLoaded is 1
        $(".popupBackground").fadeOut(200)
        $("."+el).fadeOut(200)
        popupLoaded = 0

/*
centerPopup = (el) ->
    windowWidth = document.documentElement.clientWidth
    windowHeight = document.documentElement.clientHeight
    popupHeight = $("."+el).height()
    popupWidth = $("."+el).width()
    $("."+el).css({
        "position": "absolute",
        "top": windowHeight/2-popupHeight/2,
        "left": windowWidth/2-popupWidth/2
    })
    $(".popupBackground").css({"height": windowHeight})
*/

// end Popup Loader

// Get generated emails 
/*
generateEmails = (id) ->
    first_name = $("#firstname").val()
    last_name = $("#lastname").val()
    domain_name = $("#domain").val()
    $.post(
        "/generate/",
        { first: first_name, last: last_name, domain: domain_name },
    (response) -> $("."+id).html(response)
    )
*/
// End generated emails