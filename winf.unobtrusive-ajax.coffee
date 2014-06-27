###
Better Unobtrusive Ajax (not only for ASP.NET MVC)
==================================================
version 0.2.0 (2013-11-06)  
(c) 2012 Dusan Hlavaty, WorkInField s.r.o.  
freely distributable under The MIT License (MIT)  
https://github.com/dhlavaty/winf.unobtrusiveAjax.js  
Development sponsored by http://www.vezma.com/
###
# 
# Purpose:
# --------
# 
# Purpose of this library is to be 100% compatible with 'Microsofts Unobtrusive Ajax support library for jQuery'
# found in ASP.NET MVC3 and MVC4 but without bugs, with new features, clean and well documented code and compatible
# with latest jQuery. Library is also fully usable without ASP.NET MVC.
# 
# Library development is sponsored and heavily used in production
# by [VEZMA GPS Mileage and MPG Tracker](http://www.vezma.com/).
# 
# Usage:
# ------
# 
# If you use ASP.NET MVC, just replace original `jquery.unobtrusive-ajax.js` or `jquery.unobtrusive-ajax.min.js`
# with our `winf.unobtrusive-ajax.js` and you are all set. All other requirements are the same as with original script
# from Microsoft, see tutorial at [http://goo.gl/3DTJY](http://goo.gl/3DTJY)
# 
# Changelog:
# ----------
# 
# * 2013-11-06 ver 0.2.0
#    - ADD: After DOM insertion, we focus on inserted element with autofocus attribute
# * 2013-07-17 ver 0.1.9
#    - ADD: new `data-ajax-disable-onclick="true"` introduced
# * 2012-11-23 ver 0.1.8
#    - ADD: new `data-ajax="false"` support
# * 2012-08-28 ver 0.1.7
#    - ADD: new `data-ajax-mode="beforeelement"` and `data-ajax-mode="afterelement"` introduced
# * 2012-08-03 ver 0.1.6
#    - ADD: new `data-ajax-update-closest=""` attribute introduced
#    - ADD: automatically ajax-submit 'select' element, if it has `data-ajax="true"` attribute
# * 2012-06-06 ver 0.1.5
#    - FIX: unobtrusive Ajax always expects 'html' code to be returned from server, so we set `dataType: "html"`. Now MVC controller can return `null` and this library behaves correctly.
# * 2012-06-05 ver 0.1.4
#    - FIX: error handler was commented out by mistake
#    - CHANGE: some minor documentation changes
# * 2012-05-31 ver 0.1.3
#    - ADD: new `data-ajax-mode="realreplace"` introduced
# * 2012-05-29 ver 0.1.2
#    - ADD: some improvements inspired by Brant Burnett (http://btburnett.com/2011/01/mvc-3-unobtrusive-ajax-improvements.html)
# * 2012-05-25 ver 0.1.1
#    - FIX: ajaxError event handler was not fired correctly
#    - ADD: you can use `<form data-ajax='true'><input type='image'>` or `<form><input type='image' data-ajax='true'>` also
# * 2012-05-25 ver 0.1
#    - All code comments are in English, no code changes
# * 2012-05-24 ver 0.1
#    - Initial version
# 
#
# Docs:
# -----
# 
# All ajax data attributes are 100% compatible with Microsoft ASP.NET MVC 3 - [http://www.asp.net/mvc/mvc3](http://www.asp.net/mvc/mvc3)
# 
# 
# ### data-ajax="true"
# 
# attribute activates Unobtrusive Ajax library. It can be used on `form`, `a`, `input[type="image"]` and/or `select` element.
# 
#     Example 1:
#     <form data-ajax="true" ... ><!-- Performs AJAX on entire form -->
#     ...</form>
# 
#     Example 2:
#     <a data-ajax="true" ... >Link text - performs AJAX only on this anchor</a>
# 
#     Example 3:
#     <input type="image" data-ajax="true" ... />
# 
#     Example 4:
#     <select name="selectName" data-ajax="true" data-ajax-url="http://example-url/" ... >
#       <option value="1">Option 1</option>
#     </select>
# 
# 
# ### data-ajax="false"
# 
# attribute explicitly deactivates Unobtrusive Ajax library. It can be used on `button`, `a`, `input` and/or `select` element.
# 
#     Example:
#     <form data-ajax="true" ... ><!-- Performs AJAX on entire form except where data-ajax=='false' -->
#       <button data-ajax="false">THIS WILL NOT USE AJAX</button>
#       <button>THIS WILL USE AJAX</button>
#     ...</form>
# 
# 
# 
# ### data-ajax-loading
# 
# attribute which contains element selector to element showing "LOADING IN PROGRESS" text
# 
# 
# ### data-ajax-loading-duration
# 
# how long should show/hide animation of "LOADING IN PROGRESS" text take. Animation duration is given in milliseconds. Default is 0.
# 
#     Example:
#     <div id="loading">AJAX IS IN PROGRESS</div>
#     <a data-ajax="true" data-ajax-loading="#loading" data-ajax-loading-duration="1000" ... />
# 
# 
# ### data-ajax-confirm
# 
# attribute contains a confirmation question. If user hit CANCEL button on a confirmation dialog, AJAX call will NOT be fired.
# 
#     Example:
#     <a data-ajax-confirm="Are you sure to delete entry ?" ... />
# 
# 
# ### data-ajax-disable-onclick="true"
# 
# Disable element after user clicks on it, to prevent multiple postbacks to server. It can be used on `button`, `input` or `a` element.
# 
#     Example:
#       <button data-ajax="true" data-ajax-disable-onclick="true">Disables after click</button>
# 
# 
# ### data-ajax-method
# 
# The type of request to make (`POST` or `GET`). *jQuery documentation note: Other HTTP request methods, such as `PUT` and `DELETE`, can also be used here, but they are not supported by all browsers.*
# This library uses `X-HTTP-Method-Override` HTTP header command to support `PUT` and `DELETE` in these browsers too.
# 
#     Example:
#     <a data-ajax-method="post" ... />
# 
# 
# ### data-ajax-mode
# 
# Mode of displaying ajax response sent from server. Can be `BEFORE`, `AFTER`, `REPLACE` or `REALREPLACE`
# 
# + **"BEFORE"**  - response data is prepended with [jQuery.prepend()](http://api.jquery.com/prepend/) as a first child of target (`data-ajax-update`) element. Note: Target element is NOT emptied before inserting.
# + **"AFTER"** - response data is appended with [jQuery.append()](http://api.jquery.com/append/) as a last child of target (`data-ajax-update`) element. Note: Target element is NOT emptied before inserting.
# + **"REPLACE"** - response data replaces with [jQuery.empty()](http://api.jquery.com/empty/).[html()](http://api.jquery.com/html/) inner content of target (`data-ajax-update`) element and NOT an element itseft. So every attribute (e.g. `<div id="someId">`) of target element will stay intact. Note: Target element IS emptied before inserting.
# + **"REALREPLACE"** - will replace (`data-ajax-update`) element itself with all its content. Uses [jQuery.after()](http://api.jquery.com/after/) and [jQuery.remove()](http://api.jquery.com/remove/) combo.
# + **"BEFOREELEMENT"** - response data is inserted before (`data-ajax-update`) element. Uses [jQuery.before()](http://api.jquery.com/before/)
# + **"AFTERELEMENT"** - response data is inserted after (`data-ajax-update`) element. Uses [jQuery.after()](http://api.jquery.com/after/)
# 
# 
#     Example:
#     < a data-ajax-mode="replace" ... >Some link< /a>
# 
# 
# ### data-ajax-update
# 
# attribute which contains element selector to element in which ajax response will be shown.
# 
#     Example:
#     <div id="ajaxTarget">...this will be replaced with ajax response...</div>
#     <a data-ajax-update="#ajaxTarget" data-ajax-mode="replace" ... />
# 
# 
# ### data-ajax-update-closest
# 
# attribute which contains closest element selector from current element in which ajax response will be shown.
# It uses .closest(selector) jQuery method, so look for documentation at http://api.jquery.com/closest/
# 
#     Example:
#     <div>...this will be replaced with ajax response...
#     <a data-ajax-update-closest="div" data-ajax-mode="replace" ... /></div>
# 
# 
# ### data-ajax-url
# 
# URL of ajax request to perform. If this attribute is not defined in <a /> element, the `href` attribute will be used.
# 
#     Example:
#     <a data-ajax-url="http://www.acme.com/ajax" href="http://www.acme.com/nonajax" ... />
# 
# 
# ### data-ajax-begin
# 
# event callback, which is called before ajax request itself is fired.
# Returning `false` from this callback will cancel the request.
# If attribute contains an function name, this function is called with signature:
# 
# `function beforeAjaxRequest(jqXHR)`  
# Returns: boolean  
# Params:  
# **jqXHR** - is an jQuery XHR object (see http://api.jquery.com/Types/#jqXHR
#             and http://api.jquery.com/jQuery.ajax/#jqXHR )
# 
#     Example 1:
#     <script> function BeforeSendFunctionName(jqXHR) { return true; } </script>
#     <a data-ajax-begin="BeforeSendFunctionName" ... />
# 
#     Example 2:
#     <a data-ajax-begin="alert('We stop AJAX at all costs.');return false;" ... />
# 
# 
# ### data-ajax-complete
# 
# event callback, which is called when ajax request itself was completed.
# A function will be called after 'success' and 'error' callbacks are executed.
# If attribute contains an function name, this function is called with signature:
# 
# `function completeAjaxRequest(jqXHR, textStatus)`  
# Returns: undefined  
# Params:  
# **jqXHR** - is an jQuery XHR object (see http://api.jquery.com/Types/#jqXHR
#             and http://api.jquery.com/jQuery.ajax/#jqXHR )
# 
# **textStatus** - can be `success`, `notmodified`, `error`, `timeout`, `abort` or `parsererror`
#                  (see paragraph `complete(jqXHR, textStatus)` at http://api.jquery.com/jQuery.ajax/)
# 
#     Example 1:
#     <script> function CompleteSendFunctionName(jqXHR, textStatus) { alert('All done'); } </script>
#     <a data-ajax-complete="CompleteSendFunctionName" ... />
# 
#     Example 2:
#     <a data-ajax-complete="alert('All done');" ... />
# 
# 
# ### data-ajax-success
# event callback, which is called if ajax request succeeds.
# If attribute contains an function name, this function is called with signature:
# 
# `function successAjaxRequest(data, textStatus, jqXHR)`  
# Returns: undefined  
# Params:  
# **data** - the data returned from the server
# 
# **textStatus** - a string describing the status
#                  (see paragraph `success(data, textStatus, jqXHR)` at http://api.jquery.com/jQuery.ajax/)
# 
# **jqXHR** - is an jQuery XHR object (see http://api.jquery.com/Types/#jqXHR
#             and http://api.jquery.com/jQuery.ajax/#jqXHR )
# 
#     Example 1:
#     <script> function SuccessSendFunctionName(data, textStatus, jqXHR) { alert('Success'); } </script>
#     <a data-ajax-success="SuccessSendFunctionName" ... />
# 
#     Example 2:
#     <a data-ajax-success="alert('Success');" ... />
# 
# 
# ### data-ajax-error
# 
# event callback, which is called if ajax request fails.
# Note: This handler is not called for cross-domain script and JSONP requests.
# If attribute contains an function name, this function is called with signature:
# 
# `function errorAjaxRequest(jqXHR, textStatus, errorThrown)`  
# Returns: undefined  
# Params:  
# **jqXHR** - is an jQuery XHR object (see http://api.jquery.com/Types/#jqXHR
#             and http://api.jquery.com/jQuery.ajax/#jqXHR )
# 
# **textStatus** - `timeout`, `error`, `abort`, and `parsererror` or `null`
#                  (see paragraph `error(jqXHR, textStatus, errorThrown)` at http://api.jquery.com/jQuery.ajax/)
# 
# **errorThrown** - when an HTTP error occurs, errorThrown receives the textual portion
#                   of the HTTP status, such as `Not Found` or `Internal Server Error.`
# 
#     Example 1:
#     <script> function ErrorSendFunctionName(jqXHR, textStatus, errorThrown) { alert('Sorry error !'); } </script>
#     <a data-ajax-error="ErrorSendFunctionName" ... />
# 
#     Example 2:
#     <a data-ajax-error="alert('Sorry error !');" ... />
#
#
# Better Unobtrusive Form Validation
# ----------------------------------
#
# This library plays nice with original `jquery.validate.unobtrusive.js` library from MVC3. It is even better.
# You can now add any forms after AJAX request, and all validations will still work.
#
#
# Global AJAX Events
# ------------------
#
# Using this library rather original from MS, you can attach a global AJAX event handlers (e.g. $(document).ajaxSuccess() ) that specifically handle only
# the MVC related AJAX events. In ajaxOptions you have a variable "isMvcAjax: true" and "mvcTagetElement" is your target element as an jQuery object.
#
#     Example:
#     jQuery(document).ajaxSuccess(function(event, XMLHttpRequest, ajaxOptions) 
#                                  {
#                                      if (ajaxOptions.isMvcAjax === true) { 
#                                          ajaxOptions.mvcTagetElement.prepend('<p>Prepend something to MVC target.</p>');
#                                      }
#                                  });
#
#
# The end.

$ = jQuery
DATA_CLICK_ATTRIBUTE = "unobtrusiveAjaxClick"
DATA_VALIDATION_ATTRIBUTE = "unobtrusiveValidation"



# This function take either a function name or inline javascript code from 'jsCode'
# and return it as a function. If no jsCode is given, it returns jQuery.noop()
createFunctionFromCode = (jsCode, argNames) ->
    return $.noop if not jsCode?
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

    closestSelector = jqElement.data "ajax-update-closest"
    if closestSelector?
        # If we have 'data-ajax-update-closest' attribute, we use .closest() jQuery method to find a target
        jqElementToUpdate = jqElement.closest closestSelector
    else
        # otherwise we use 'ajax-update'
        jqElementToUpdate = $(jqElement.data("ajax-update"))

    # We change data to jQuery object before inserting into DOM (this helps us autofocus after DOM insertion)
    data = jQuery data

    # This is just a simple validation, that 'data-ajax-update' points to an existing element on a page
    if jqElementToUpdate.length < 1
        console?.log "winf.unobtrusive-ajax warning: Cannot find element from 'data-ajax-update' on a page."
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
            when "REPLACE"
                # Note: In Internet Explorer up to and including version 9, setting the text content
                # of an HTML element may corrupt the text nodes of its children that are being removed
                # from the document as a result of the operation. If you are keeping references to these
                # DOM elements and need them to be unchanged, use .empty().html(string) instead of .html(string)
                # so that the elements are removed from the document before the new string is assigned to the element.
                jqElementToUpdate.empty().html data # volanie .empty() je kvoli IE

            # "REALREPLACE" will replace (data-ajax-update) element itself with all its content.
            when "REALREPLACE"
                jqElementToUpdate.after data
                jqElementToUpdate.remove()

            # BEFORE ELEMENT insert content before (data-ajax-update) element.
            when "BEFOREELEMENT"
                jqElementToUpdate.before data

            # BEFORE ELEMENT insert content after (data-ajax-update) element.
            when "AFTERELEMENT"
                jqElementToUpdate.after data
            
            else
                if console?
                    err = "winf.unobtrusive-ajax error: Unknown 'data-ajax-mode' = '" + mode + "'"
                    console.log err
                    alert err
  
    resetUnobtrusiveValidators()

    # Try autofocus on element with autofocus attribute
    data.find('[autofocus]').focus()
    return



# Perform a whole AJAX call logic
makeAjaxCall = (jqElement, ajaxSettings) ->
    # jqElement - element on which event was triggered (e.g. click on a <a />)

    # we ensure that jqElement is really an jQuery object
    if not jqElement.jquery?
        jqElement = jQuery jqElement

    # First - we ask user a question, if he agree with ajax request
    questionToConfirm = jqElement.data "ajax-confirm"
    if questionToConfirm?
        # if user hits CANCEL in a dialog, no AJAX call will be made
        return if not window.confirm questionToConfirm
    
    # get element ('data-ajax-loading') for 'LOADING IN PROGRESS' message
    loadingElement = $(jqElement.data("ajax-loading"))
    # how long should show or hide animation of 'LOADING IN PROGRESS' message perform (Duration is given in milliseconds)
    loadingDuration = jqElement.data("ajax-loading-duration") or 0

    # disable element (anchor or button) when it was clicked
    disableOnClick = jqElement.data("ajax-disable-onclick")
    if disableOnClick? and disableOnClick != "false"
        # disable
        jqElement.attr "disabled", "disabled"
        # remove all events
        jqElement.off().on "click", (event) ->
            event.preventDefault()
            return false
        # set '#disabled' as anchor href
        jqElement.filter("a").attr "href", "#disabled"

    defaultSettings =
        # Returns HTML as plain text; included script tags are evaluated when inserted in the DOM.
        dataType: "html"
        # The type of request to make ("POST" or "GET")
        type: jqElement.data("ajax-method") or `undefined`
        # URL of ajax call
        url: jqElement.data("ajax-url") or `undefined`
        # set 'isMvcAjax' to 'true', so that any global ajax handler can disquinish between classical 'ajax' and our 'mvc ajax'
        isMvcAjax: true
        # set 'mvcTagetElement' to original target, for any purposes
        mvcTagetElement: jqElement
        # This will force requested pages not to be cached by the browser. It also appends a query string parameter, "_=[TIMESTAMP]", to the URL.
        cache: false

        beforeSend: (jqXHR, settings) ->
            # pre-request callback function that can be used to modify
            # the jqXHR (in jQuery 1.4.x, XMLHTTPRequest) object before it is sent.
            
            # we override HTTP method if neccessary
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
 
            # we call code/function stored in 'data-ajax-begin'
            result = createFunctionFromCode(jqElement.data("ajax-begin"), [ "jqXHR" ]).apply(this, arguments)
            # show 'LOADING IN PROGRESS' message
            loadingElement.show loadingDuration  if result isnt false # loadingElement je jQuery objekt takze nemusime testovat na null
            # returning false in the beforeSend function will cancel the request
            return result

        complete: (jqXHR, textStatus) ->
            # A function will be called after 'success' and 'error' callbacks are executed
            # 'textStatus' == "success", "notmodified", "error", "timeout", "abort", or "parsererror"

            # hide 'LOADING IN PROGRESS' message
            loadingElement.hide loadingDuration # loadingElement je jQuery objekt takze nemusime testovat na null
            # we call code/function stored in 'data-ajax-complete'
            createFunctionFromCode(jqElement.data("ajax-complete"), [ "jqXHR", "textStatus" ]).apply(this, arguments)
            
            return

        success: (data, textStatus, jqXHR) ->
            # A function to be called if the request succeeds.

            processDataOnSuccess jqElement, data, jqXHR.getResponseHeader("Content-Type") or "text/html"

            # we call code/function stored in 'data-ajax-success'
            createFunctionFromCode(jqElement.data("ajax-success"), [ "data", "textStatus", "jqXHR" ]).apply(this, arguments)

            return

        error: (jqXHR, textStatus, errorThrown) ->
            # A function to be called if the request fails.
            # textStatus == "timeout", "error", "abort", and "parsererror" (or null)
            # Note: This handler is not called for cross-domain script and JSONP requests.

            # we call code/function stored in 'data-ajax-failure'
            createFunctionFromCode(jqElement.data("ajax-failure"), [ "jqXHR", "textStatus", "errorThrown" ]).apply(this, arguments)
            return

    # combine ajax settings (defaultSettings has precedence)
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
        # typeOriginal is NOT a jQuery property of ajaxSettings, it is our own one
        ajaxSettings.typeOriginal = httpMethod
        # every non safe method will be replaced by 'POST'
        ajaxSettings.type = "POST"
        # insert 'X-HTTP-Method-Override' to DATA sent to server (not sure why, but we want to be compatible with original MS library)
        ajaxSettings.data.push
            name: "X-HTTP-Method-Override"
            value: httpMethod

    # finally perform ajax call
    $.ajax ajaxSettings
    return



# returns true, false or (void 0); we only test it on a 'false'
validateForm = (jqForm) ->
    validationInfo = jqForm.data(DATA_VALIDATION_ATTRIBUTE)
    return validationInfo?.validate?()



# sends form content using ajax call
submitFormAsAjax = (jqForm, jqOriginalTarget, additionalDataToSend = []) ->
    # perform form validations, if we have some
    if validateForm(jqForm) == false
        return

    # get some ajax settings from form element
    ajaxSettings =
        url: jqForm.data("ajax-url") or jqForm.attr("action") # data-ajax-url has precedence over <form action/>
        type: jqForm.data("ajax-method") or jqForm.attr("method") or "GET" # data-ajax-method has precedence over <form method/>
        data: jqForm.serializeArray().concat(additionalDataToSend) # serialize form data and append additional data 'additionalDataToSend'

    # perform ajax call
    makeAjaxCall jqOriginalTarget, ajaxSettings

    return



$(document).ready ->

    # click on a ajax link <a />
    $(document).on "click", "a[data-ajax=true]", (eventObject) ->
        # 'this' = When jQuery calls a handler, the this keyword is a reference
        #          to the element where the event is being delivered; for directly
        #          bound events this is the element where the event was attached
        #          and for delegated events this is an element matching selector.
        #          (Note that this may not be equal to 'event.target' if the event
        #          has bubbled from a descendant element.)
        # 'eventObject' = jQuery event ( see http://api.jquery.com/category/event-object/ )
        
        # do not make any default action, because we do the 'send form' logic itself
        eventObject.preventDefault()
        
        ajaxSettings =
            url: this.href # default adress for AJAX call is from 'href' attribute of <a /> element; it can be overriden by 'data-ajax-url'
            type: "GET"    # this is only a default method; can be overriden by 'data-ajax-method'
            data: []
        makeAjaxCall this, ajaxSettings
        return
    


    $(document).on "change", "select[data-ajax=true]", (eventObject) ->

        # do not make any default action, because we do the 'send' logic itself
        eventObject.preventDefault()

        jqTarget = $(eventObject.target)
        #name = jqTarget.attr("name")

        # we need to send a 'name' of element, which triggered this send action
        #dataToSend = []
        #if name?
        #    dataToSend.push
        #        'name' : name
        #        'value': jqTarget.val()

        #console?.log 'change event', dataToSend
        
        # submitFormAsAjax() is good even when we are not really sending a form
        submitFormAsAjax jqTarget, jqTarget, []
        return



    # click on ajax <input type="image" ... />
    $(document).on "click", "form[data-ajax=true] input[type=image], form input[type=image][data-ajax=true]", (eventObject) ->

        # do not make any default action, because we do the 'send form' logic itself
        eventObject.preventDefault()

        jqTarget = $(eventObject.target)
        name = jqTarget.attr("name")
        # find first closest parent <form> element
        jqForm = jqTarget.closest("form")
        # get the current coordinates of element relative to the document
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

    

    # click on ajax <input type="submit" ... />
    $(document).on "click", "form[data-ajax=true] :submit", (eventObject) ->
        jqTarget = $(eventObject.target)

        # if clicked input or button has explicitly 'data-ajax' set to 'false'...
        if jqTarget.data("ajax") == "false" or jqTarget.data("ajax") == false
            # ...we immediatelly stop by unbinding events from form
            $(document).off()
            return true

        # do not make any default action, because we do the 'send form' logic itself
        eventObject.preventDefault()
    
        name = jqTarget.attr("name")
        # find first closest parent <form> element
        jqForm = jqTarget.closest("form")
    
        # we need to send a form 'name' of element, which triggered this send action
        dataToSend = []
        if name?
            dataToSend.push
                'name' : name
                'value': jqTarget.val()

        # send form using ajax call
        submitFormAsAjax jqForm, jqTarget, dataToSend

        return



    # if someone tries to send form a different way (not really sure if any different way exist or whats the case ;-) )
    # we do it here
    $(document).on "submit", "form[data-ajax=true]", (eventObject) ->
        console?.log "winf.unobtrusive-ajax.js warning - form submit was triggered directly. Please inspect the case."

        # do not make any default action, because we do the 'send form' logic itself
        eventObject.preventDefault()

        # target should be a form itself
        jqTarget = $(eventObject.target)

        # submit form using ajax call
        submitFormAsAjax jqTarget, jqTarget, []
        
        return

    # END document.ready
    return