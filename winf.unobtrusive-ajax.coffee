###
Better Unobtrusive Ajax for ASP.NET MVC
version 0.1 (2012-05-24)
(c) 2012 Dusan Hlavaty, WorkInField s.r.o.
freely distributable under The MIT License (MIT)
https://github.com/dhlavaty/winf.unobtrusiveAjax.js
###
#
# Purpose of this library is to be 100% compatible with 'Microsofts Unobtrusive Ajax support library for jQuery'
# found in ASP.NET MVC3 and MVC4 but without bugs, with new features, clean and well documented code and compatible
# with latest jQuery.
#
# Usage:
#   Just replace original 'jquery.unobtrusive-ajax.js' or 'jquery.unobtrusive-ajax.min.js' with our
#   'winf.unobtrusive-ajax.js' and you are all set. All other requirements are the same as with original script
#   from Microsoft, see tutorial at http://goo.gl/3DTJY
#
# Docs:
# ( all ajax data attributes are 100% compatible with Microsoft ASP.NET MVC 3 - http://www.asp.net/mvc/mvc3 )
#
# data-ajax-loading          - attribute which contains element selector to element showing "LOADING IN PROGRESS" text
#
# data-ajax-loading-duration - how long should show/hide animation of "LOADING IN PROGRESS" text take.
#                              Animation duration is given in milliseconds. Default is 0.
#
#                              Example:
#                                   <div id="loading">AJAX IS IN PROGRESS</div>
#                                   <a data-ajax-loading="#loading" data-ajax-loading-duration="1000" ... />
#
#
# data-ajax-confirm - attribute contains a confirmation question. If user hit CANCEL button on a confirmation dialog,
#                     AJAX call will NOT be fired.
#                     Example:
#                         <a data-ajax-confirm="Are you sure to delete entry ?" ... />
#
# data-ajax-method  - The type of request to make ("POST" or "GET").
#                     jQuery DOCUMENTATION NOTE: Other HTTP request methods, such as "PUT" and "DELETE",
#                     can also be used here, but they are not supported by all browsers.
#
#                     Example:
#                         <a data-ajax-method="post" ... />
#
# data-ajax-mode    - Mode of displaying ajax response sent from server. Can be "BEFORE", "AFTER" or "REPLACE" (default)
#                     Every other settings is threated as "REPLACE".
#
#                     "BEFORE"  - response data is prepended as a first child of target ('data-ajax-update') element.
#                                 Note: Target element is NOT emptied before inserting.
#                     "AFTER"   - response data is appended as a last child of target ('data-ajax-update') element.
#                                 Note: Target element is NOT emptied before inserting.
#                     "REPLACE" - response data replaces inner content of target ('data-ajax-update') element and
#                                 NOT an element itseft. So every attribute (e.g. <div id="someId">) of target element
#                                 will stay intact.
#                                 Note: Target element IS emptied before inserting.
#
#                     Example:
#                         <a data-ajax-mode="replace" ... />
#
# data-ajax-update  - attribute which contains element selector to element in which ajax response will be shown.
#
#                     Example:
#                         <div id="ajaxTarget">...this will be replaced with ajax response...</div>
#                         <a data-ajax-update="#ajaxTarget" data-ajax-mode="replace" ... />
#
# data-ajax-url     - URL of ajax request to perform. If this attribute is not defined in <a /> element,
#                     the 'href' attribute will be used.
#
#                     Example:
#                         <a data-ajax-url="http://www.acme.com/ajax" href="http://www.acme.com/nonajax" ... />
#
# data-ajax-begin   - event callback, which is called before ajax request itself is fired.
#                     Returning "false" from this callback will cancel the request.
#                     If attribute contains an function name, this function is called with signature:
#                     function beforeAjaxRequest(jqXHR)
#                       Returns: boolean
#                       Params:                        
#                                jqXHR - is an jQuery XHR object (see http://api.jquery.com/Types/#jqXHR
#                                        and http://api.jquery.com/jQuery.ajax/#jqXHR )
#
#                       Example 1:
#                           <script> function BeforeSendFunctionName(jqXHR) { return true; } </script>
#                           <a data-ajax-begin="BeforeSendFunctionName" ... />
#
#                       Example 2:
#                           <a data-ajax-begin="alert('We stop AJAX at all costs.');return false;" ... />
#
# data-ajax-complete - event callback, which is called when ajax request itself was completed.
#                      A function will be called after 'success' and 'error' callbacks are executed.
#                      If attribute contains an function name, this function is called with signature:
#                      function completeAjaxRequest(jqXHR, textStatus)
#                       Returns: undefined
#                       Params:                        
#                                jqXHR - is an jQuery XHR object (see http://api.jquery.com/Types/#jqXHR
#                                        and http://api.jquery.com/jQuery.ajax/#jqXHR )
#                                textStatus - can be "success", "notmodified", "error", "timeout",
#                                             "abort" or "parsererror"
#                                             (see paragraph "complete(jqXHR, textStatus)" at http://api.jquery.com/jQuery.ajax/)
#
#                       Example 1:
#                           <script> function CompleteSendFunctionName(jqXHR, textStatus) { alert('All done'); } </script>
#                           <a data-ajax-complete="CompleteSendFunctionName" ... />
#
#                       Example 2:
#                           <a data-ajax-complete="alert('All done');" ... />
#
# data-ajax-success  - event callback, which is called if ajax request succeeds.
#                      If attribute contains an function name, this function is called with signature:
#                      function successAjaxRequest(data, textStatus, jqXHR)
#                       Returns: undefined
#                       Params:                        
#                                data       - the data returned from the server
#                                textStatus - a string describing the status
#                                             (see paragraph "success(data, textStatus, jqXHR)" at http://api.jquery.com/jQuery.ajax/)
#                                jqXHR      - is an jQuery XHR object (see http://api.jquery.com/Types/#jqXHR
#                                             and http://api.jquery.com/jQuery.ajax/#jqXHR )
#
#                       Example 1:
#                           <script> function SuccessSendFunctionName(data, textStatus, jqXHR) { alert('Success'); } </script>
#                           <a data-ajax-success="SuccessSendFunctionName" ... />
#
#                       Example 2:
#                           <a data-ajax-success="alert('Success');" ... />
#
# data-ajax-error    - event callback, which is called if ajax request fails.
#                      Note: This handler is not called for cross-domain script and JSONP requests.
#                      If attribute contains an function name, this function is called with signature:
#                      function errorAjaxRequest(jqXHR, textStatus, errorThrown)
#                       Returns: undefined
#                       Params:                        
#                                jqXHR       - is an jQuery XHR object (see http://api.jquery.com/Types/#jqXHR
#                                              and http://api.jquery.com/jQuery.ajax/#jqXHR )
#                                textStatus  - "timeout", "error", "abort", and "parsererror" (or null)
#                                              (see paragraph "error(jqXHR, textStatus, errorThrown)" at http://api.jquery.com/jQuery.ajax/)
#                                errorThrown - when an HTTP error occurs, errorThrown receives the textual portion
#                                              of the HTTP status, such as "Not Found" or "Internal Server Error."
#
#                       Example 1:
#                           <script> function ErrorSendFunctionName(jqXHR, textStatus, errorThrown) { alert('Sorry error !'); } </script>
#                           <a data-ajax-error="ErrorSendFunctionName" ... />
#
#                       Example 2:
#                           <a data-ajax-error="alert('Sorry error !');" ... />
#

$ = jQuery
DATA_CLICK_ATTRIBUTE = "unobtrusiveAjaxClick"
DATA_VALIDATION_ATTRIBUTE = "unobtrusiveValidation"

createFunctionFromCode = (jsCode, argNames) ->
    fn = window
    parts = (jsCode or "").split(".")
    # .shift() removes the first element from an array and returns that element
    fn = fn[parts.shift()]  while fn and parts.length
    if typeof (fn) is "function"    
        # if jsCode contains function, just return it
        return fn

    # if jsCode contains code block, create a Function from it...
    argNames.push jsCode
    # ...and return it
    return Function.constructor.apply null, argNames



# Many (if not all) browsers only allow a form to GET or POST. So this
# function returns 'false' if method is not one of these.
isHttpMethodSafe = (method) ->
    method = method.toUpperCase()
    return method == "GET" || method == "POST"



# We need to reinitialize unobtrusive validators after some AJAX DOM manipulation, because someone from
# MS forgotten :-(
resetUnobtrusiveValidators = () ->
    if (typeof ($.validator) is "function") and (typeof ($.validator.unobtrusive) is "object")
        $("form").removeData "validator"
        $.validator.unobtrusive.parse $("form")
    return



processDataOnSuccess = (element, data, contentType) ->
    if contentType.indexOf("application/x-javascript") != -1
        return

    jqElement = jQuery element

    mode = jqElement.data("ajax-mode") or ""

    jqElementToUpdate = $(jqElement.data("ajax-update"))

    # Toto je len jednoducha kontrola, ci 'data-ajax-update' atribut sa odkazuje na spravny element na stranke.
    # Tato kontrola nam moze odhalit chyby v nasom kode. V produkcnej verzii by sme to ale mali odstranit, resp.
    # tam by uz mali byt stranky odladene. ;-)
    if jqElementToUpdate.length < 1
        console?.log "winf.unobtrusive-ajax warning: Cannot find element from 'data-ajax-update' on a page. Do you have a correct BrowserRowId ?"
    else
        switch mode.toUpperCase()
            # this is not really BEFORE, but it is a first child of target (data-ajax-update) element. But we keep compatibility with MS
            when "BEFORE"
                jqElementToUpdate.prepend data

            # this is not really AFTER, but it is a last child of target (data-ajax-update) element. But we keep compatibility with MS
            when "AFTER"
                jqElementToUpdate.append data

            # Note: "REPLACE" will replace inner content of (data-ajax-update) element and NOT an element itseft. So every attribute
            # of this element will stay intact.
            else 
                # Note: In Internet Explorer up to and including version 9, setting the text content
                # of an HTML element may corrupt the text nodes of its children that are being removed
                # from the document as a result of the operation. If you are keeping references to these
                # DOM elements and need them to be unchanged, use .empty().html(string) instead of .html(string)
                # so that the elements are removed from the document before the new string is assigned to the element.
                jqElementToUpdate.empty().html data # volanie .empty() je kvoli IE
  
    resetUnobtrusiveValidators()
    return



# Vykona celu logiku AJAX volania
makeAjaxCall = (jqElement, ajaxSettings) ->
    # jqElement - element nad ktorym bol vyvolany event (napr klik na <a />)

    # zabezpecime, aby jqElement bol naozaj jQuery objekt (ak by niekto kto tuto metodu zavolal a zabudol na to)
    if not jqElement.jquery?
        jqElement = jQuery jqElement

    # debugger

    # Najpr (ak treba) polozime uzivatelovi otazku ci suhlasi s AJAX requestom
    questionToConfirm = jqElement.data "ajax-confirm"
    if questionToConfirm?
        # ak uzivatel v confirm dialogu zvoli CANCEL, tak sa AJAX call nezavola
        return if not window.confirm questionToConfirm
    
    # zistime z 'data-ajax-loading', v ktorom elemente mame ulozeny 'LOADING IN PROGRESS' text
    loadingElement = $(jqElement.data("ajax-loading"))
    # zistime ako dlho ma trvat animacia show/hide 'LOADING IN PROGRESS' textu
    loadingDuration = jqElement.data("ajax-loading-duration") or 0 # Duration is given in milliseconds

    defaultSettings =
        type: jqElement.data("ajax-method") or `undefined` # The type of request to make ("POST" or "GET").
        url: jqElement.data("ajax-url") or `undefined`     # URL of ajax call
        beforeSend: (jqXHR, settings) ->
            # pre-request callback function that can be used to modify
            # the jqXHR (in jQuery 1.4.x, XMLHTTPRequest) object before it is sent.
            
            # overridneme HTTP metodu ak treba
            if settings.typeOriginal?
                # While not normally an issue with thick clients, accessing full RESTful capabilities of available services
                # via browsers often is problematic as many (if not all) browsers only allow a form to GET or POST. They
                # don't allow for other HTTP methods, like HEAD, PUT, or DELETE. Google realized this and offers a solution,
                # which is to add a header to the HTTP request, X-HTTP-Method-Override, that is supposed to be interpreted
                # by the service and acted upon regardless of the actual HTTP method used.
                # This comment is from: http://www.endurasoft.com/Blog/post/X-HTTP-Method-Override.aspx
                if not isHttpMethodSafe(settings.typeOriginal)
                    # .setRequestHeader() method departs from the standard by replacing the old value with the new one
                    # rather than concatenating the new value to the old one
                    jqXHR.setRequestHeader "X-HTTP-Method-Override", settings.typeOriginal
 
            # zavolame kod/funkciu uvedenu v 'data-ajax-begin'
            result = createFunctionFromCode(jqElement.data("ajax-begin"), [ "jqXHR" ]).apply(this, arguments)
            # zobrazime 'LOADING IN PROGRESS' text
            loadingElement.show loadingDuration  if result isnt false # loadingElement je jQuery objekt takze nemusime testovat na null
            # Returning false in the beforeSend function will cancel the request
            return result

        complete: (jqXHR, textStatus) ->
            # A function will be called after 'success' and 'error' callbacks are executed
            # 'textStatus' == "success", "notmodified", "error", "timeout", "abort", or "parsererror"

            # schovame 'LOADING IN PROGRESS' text
            loadingElement.hide loadingDuration # loadingElement je jQuery objekt takze nemusime testovat na null
            # zavolame kod/funkciu uvedenu v 'data-ajax-complete'
            createFunctionFromCode(jqElement.data("ajax-complete"), [ "jqXHR", "textStatus" ]).apply(this, arguments)
            # koniec
            return

        success: (data, textStatus, jqXHR) ->
            # A function to be called if the request succeeds.

            processDataOnSuccess jqElement, data, jqXHR.getResponseHeader("Content-Type") or "text/html"

            # zavolame kod/funkciu uvedenu v 'data-ajax-success'
            createFunctionFromCode(jqElement.data("ajax-success"), [ "data", "textStatus", "jqXHR" ]).apply(this, arguments)

            return

        error: (jqXHR, textStatus, errorThrown) ->
            # A function to be called if the request fails.
            # textStatus == "timeout", "error", "abort", and "parsererror" (or null)
            # Note: This handler is not called for cross-domain script and JSONP requests.
    
            # zavolame kod/funkciu uvedenu v 'data-ajax-failure'
            createFunctionFromCode(jqElement.data("ajax-failure"), [ "jqXHR", "textStatus", "errorThrown" ])
            return

    $.extend ajaxSettings, defaultSettings

    # insert 'X-Requested-With' to DATA sent to server (not sure why, but we want to be compatible with original MS library)
    ajaxSettings.data.push
        name: "X-Requested-With"
        value: "XMLHttpRequest"

    # Ensure that Http method is uppercase
    httpMethod = ajaxSettings.type.toUpperCase()
    ajaxSettings.type = httpMethod

    # We must change non safe http method ('PUT', 'DELETE', ...) for a safe one
    if not isHttpMethodSafe(httpMethod)
        ajaxSettings.typeOriginal = httpMethod # typeOriginal is NOT a jQuery property, it is our own one
        ajaxSettings.type = "POST" # every non safe method will be replace by 'POST'
        # insert 'X-HTTP-Method-Override' to DATA sent to server (not sure why, but we want to be compatible with original MS library)
        ajaxSettings.data.push
            name: "X-HTTP-Method-Override"
            value: httpMethod

    # finally perform ajax call
    $.ajax ajaxSettings
    return



# vrati true, false alebo (void 0)
validateForm = (jqForm) ->
    validationInfo = jqForm.data(DATA_VALIDATION_ATTRIBUTE)
    return validationInfo?.validate?()



# Odosle obsah formulara pomocou ajax-u
submitFormAsAjax = (jqForm, jqOriginalTarget, additionalDataToSend = []) ->
    # perform form validations, if we have some
    if validateForm(jqForm) == false
        return

    # get some ajax settings from form element
    ajaxSettings =
        url: jqForm.data("ajax-url") or jqForm.attr("action") # data-ajax-url ma prednost pred <form action/>
        type: jqForm.data("ajax-method") or jqForm.attr("method") or "GET" # data-ajax-method ma prednost pred <form method/>
        data: jqForm.serializeArray().concat(additionalDataToSend) # zoserializujeme formularove data a pridame 'dodatocne data'

    # perform ajax call
    makeAjaxCall jqOriginalTarget, ajaxSettings

    return



$(document).ready ->

    # click na ajaxovy <a />
    $(document).on "click", "a[data-ajax=true]", (eventObject) ->
        # 'this' = When jQuery calls a handler, the this keyword is a reference
        #          to the element where the event is being delivered; for directly
        #          bound events this is the element where the event was attached
        #          and for delegated events this is an element matching selector.
        #          (Note that this may not be equal to 'event.target' if the event
        #          has bubbled from a descendant element.)
        # 'eventObject' = jQuery event ( see http://api.jquery.com/category/event-object/ )
        eventObject.preventDefault() # Cancels only the default action by using the preventDefault method.
        #debugger
        ajaxSettings =
            url: this.href # default adresu pre AJAX si zoberieme z 'href' atributu <a /> elementu; da sa prepisat pomocou 'data-ajax-url'
            type: "GET"    # toto je len default ak to uzivatel neprepise pomocou 'data-ajax-method'
            data: []
        makeAjaxCall this, ajaxSettings
        return
    


    # klik na <input type="image" ... />
    $(document).on "click", "form[data-ajax=true] input[type=image]", (eventObject) ->

        # do not make any default action, because we do the 'send form' logic itself
        eventObject.preventDefault()

        jqTarget = $(eventObject.target)
        name = jqTarget.attr("name")
        # najdeme prvy najblizsi rodicovsky <form> element
        jqForm = jqTarget.parents("form").first()
        # Get the current coordinates of element relative to the document
        offset = jqTarget.offset()

        # Calculate image click coords inside form-image and set .x and .y attributes accordingly
        dataToSend = []
        dataToSend.push
            'name' : name + ".x"
            'value': Math.round(eventObject.pageX - offset.left)
        dataToSend.push
            'name' : name + ".y"
            'value': Math.round(eventObject.pageY - offset.top)

        # send form using ajax call
        submitFormAsAjax jqForm, jqTarget, dataToSend

        return

    

    # klik na <input type="submit" ... />
    $(document).on "click", "form[data-ajax=true] :submit", (eventObject) ->

        # do not make any default action, because we do the 'send form' logic itself
        eventObject.preventDefault()
        #eventObject.stopPropagation()
    
        jqTarget = $(eventObject.target)
        name = jqTarget.attr("name")
        # najdeme prvy najblizsi rodicovsky <form> element
        jqForm = jqTarget.parents("form").first()
    
        dataToSend = []
        if name?
            dataToSend.push
                'name' : name
                'value': jqTarget.val()

        # send form using ajax call
        submitFormAsAjax jqForm, jqTarget, dataToSend

        return



    # ak sa niekto pokusi odoslat formular inym sposobom a nie klikom
    # na tlacidlo, obrazok, ... (napada ma napr. ENTER na klavesnici)
    $(document).on "submit", "form[data-ajax=true]", (eventObject) ->
        console?.log "k tomuto by sme sa nemali dostat"

        # do not make any default action, because we do the 'send form' logic itself
        eventObject.preventDefault()

        jqTarget = $(eventObject.target)

        submitFormAsAjax jqTarget, jqTarget, []
        
        return

    # END document.ready
    return