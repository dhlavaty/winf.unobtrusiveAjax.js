
/*
Better Unobtrusive Ajax for ASP.NET MVC
version 0.1 (2012-05-24)
(c) 2012 Dusan Hlavaty, WorkInField s.r.o.
freely distributable under The MIT License (MIT)
https://github.com/dhlavaty/winf.unobtrusiveAjax.js
*/


(function() {
  var $, DATA_CLICK_ATTRIBUTE, DATA_VALIDATION_ATTRIBUTE, createFunctionFromCode, isHttpMethodSafe, makeAjaxCall, processDataOnSuccess, resetUnobtrusiveValidators, submitFormAsAjax, validateForm;

  $ = jQuery;

  DATA_CLICK_ATTRIBUTE = "unobtrusiveAjaxClick";

  DATA_VALIDATION_ATTRIBUTE = "unobtrusiveValidation";

  createFunctionFromCode = function(jsCode, argNames) {
    var fn, parts;
    fn = window;
    parts = (jsCode || "").split(".");
    while (fn && parts.length) {
      fn = fn[parts.shift()];
    }
    if (typeof fn === "function") {
      return fn;
    }
    argNames.push(jsCode);
    return Function.constructor.apply(null, argNames);
  };

  isHttpMethodSafe = function(method) {
    method = method.toUpperCase();
    return method === "GET" || method === "POST";
  };

  resetUnobtrusiveValidators = function() {
    if ((typeof $.validator === "function") && (typeof $.validator.unobtrusive === "object")) {
      $("form").removeData("validator");
      $.validator.unobtrusive.parse($("form"));
    }
  };

  processDataOnSuccess = function(element, data, contentType) {
    var jqElement, jqElementToUpdate, mode;
    if (contentType.indexOf("application/x-javascript") !== -1) {
      return;
    }
    jqElement = jQuery(element);
    mode = jqElement.data("ajax-mode") || "";
    jqElementToUpdate = $(jqElement.data("ajax-update"));
    if (jqElementToUpdate.length < 1) {
      if (typeof console !== "undefined" && console !== null) {
        console.log("winf.unobtrusive-ajax warning: Cannot find element from 'data-ajax-update' on a page. Do you have a correct BrowserRowId ?");
      }
    } else {
      switch (mode.toUpperCase()) {
        case "BEFORE":
          jqElementToUpdate.prepend(data);
          break;
        case "AFTER":
          jqElementToUpdate.append(data);
          break;
        default:
          jqElementToUpdate.empty().html(data);
      }
    }
    resetUnobtrusiveValidators();
  };

  makeAjaxCall = function(jqElement, ajaxSettings) {
    var defaultSettings, httpMethod, loadingDuration, loadingElement, questionToConfirm;
    if (!(jqElement.jquery != null)) {
      jqElement = jQuery(jqElement);
    }
    questionToConfirm = jqElement.data("ajax-confirm");
    if (questionToConfirm != null) {
      if (!window.confirm(questionToConfirm)) {
        return;
      }
    }
    loadingElement = $(jqElement.data("ajax-loading"));
    loadingDuration = jqElement.data("ajax-loading-duration") || 0;
    defaultSettings = {
      type: jqElement.data("ajax-method") || undefined,
      url: jqElement.data("ajax-url") || undefined,
      beforeSend: function(jqXHR, settings) {
        var result;
        if (settings.typeOriginal != null) {
          if (!isHttpMethodSafe(settings.typeOriginal)) {
            jqXHR.setRequestHeader("X-HTTP-Method-Override", settings.typeOriginal);
          }
        }
        result = createFunctionFromCode(jqElement.data("ajax-begin"), ["jqXHR"]).apply(this, arguments);
        if (result !== false) {
          loadingElement.show(loadingDuration);
        }
        return result;
      },
      complete: function(jqXHR, textStatus) {
        loadingElement.hide(loadingDuration);
        createFunctionFromCode(jqElement.data("ajax-complete"), ["jqXHR", "textStatus"]).apply(this, arguments);
      },
      success: function(data, textStatus, jqXHR) {
        processDataOnSuccess(jqElement, data, jqXHR.getResponseHeader("Content-Type") || "text/html");
        createFunctionFromCode(jqElement.data("ajax-success"), ["data", "textStatus", "jqXHR"]).apply(this, arguments);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        createFunctionFromCode(jqElement.data("ajax-failure"), ["jqXHR", "textStatus", "errorThrown"]);
      }
    };
    $.extend(ajaxSettings, defaultSettings);
    ajaxSettings.data.push({
      name: "X-Requested-With",
      value: "XMLHttpRequest"
    });
    httpMethod = ajaxSettings.type.toUpperCase();
    ajaxSettings.type = httpMethod;
    if (!isHttpMethodSafe(httpMethod)) {
      ajaxSettings.typeOriginal = httpMethod;
      ajaxSettings.type = "POST";
      ajaxSettings.data.push({
        name: "X-HTTP-Method-Override",
        value: httpMethod
      });
    }
    $.ajax(ajaxSettings);
  };

  validateForm = function(jqForm) {
    var validationInfo;
    validationInfo = jqForm.data(DATA_VALIDATION_ATTRIBUTE);
    return validationInfo != null ? typeof validationInfo.validate === "function" ? validationInfo.validate() : void 0 : void 0;
  };

  submitFormAsAjax = function(jqForm, jqOriginalTarget, additionalDataToSend) {
    var ajaxSettings;
    if (additionalDataToSend == null) {
      additionalDataToSend = [];
    }
    if (validateForm(jqForm) === false) {
      return;
    }
    ajaxSettings = {
      url: jqForm.data("ajax-url") || jqForm.attr("action"),
      type: jqForm.data("ajax-method") || jqForm.attr("method") || "GET",
      data: jqForm.serializeArray().concat(additionalDataToSend)
    };
    makeAjaxCall(jqOriginalTarget, ajaxSettings);
  };

  $(document).ready(function() {
    $(document).on("click", "a[data-ajax=true]", function(eventObject) {
      var ajaxSettings;
      eventObject.preventDefault();
      ajaxSettings = {
        url: this.href,
        type: "GET",
        data: []
      };
      makeAjaxCall(this, ajaxSettings);
    });
    $(document).on("click", "form[data-ajax=true] input[type=image]", function(eventObject) {
      var dataToSend, jqForm, jqTarget, name, offset;
      eventObject.preventDefault();
      jqTarget = $(eventObject.target);
      name = jqTarget.attr("name");
      jqForm = jqTarget.parents("form").first();
      offset = jqTarget.offset();
      dataToSend = [];
      dataToSend.push({
        'name': name + ".x",
        'value': Math.round(eventObject.pageX - offset.left)
      });
      dataToSend.push({
        'name': name + ".y",
        'value': Math.round(eventObject.pageY - offset.top)
      });
      submitFormAsAjax(jqForm, jqTarget, dataToSend);
    });
    $(document).on("click", "form[data-ajax=true] :submit", function(eventObject) {
      var dataToSend, jqForm, jqTarget, name;
      eventObject.preventDefault();
      jqTarget = $(eventObject.target);
      name = jqTarget.attr("name");
      jqForm = jqTarget.parents("form").first();
      dataToSend = [];
      if (name != null) {
        dataToSend.push({
          'name': name,
          'value': jqTarget.val()
        });
      }
      submitFormAsAjax(jqForm, jqTarget, dataToSend);
    });
    $(document).on("submit", "form[data-ajax=true]", function(eventObject) {
      var jqTarget;
      if (typeof console !== "undefined" && console !== null) {
        console.log("k tomuto by sme sa nemali dostat");
      }
      eventObject.preventDefault();
      jqTarget = $(eventObject.target);
      submitFormAsAjax(jqTarget, jqTarget, []);
    });
  });

}).call(this);
