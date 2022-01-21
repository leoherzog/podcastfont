function copy() {
  if(this.dataset.clipboardContent){
    navigator.clipboard.writeText(this.dataset.clipboardContent);
  } else {
    navigator.clipboard.writeText(this.innerText);
  }
  registerEvent(this.dataset.clipboardAnalytics);
}

function runFilter(){
  document.querySelectorAll(".box").forEach(x => x.style.display = (
    document.querySelector('#filter').value==''
    || x.id.indexOf(document.querySelector('#filter').value.toLowerCase())!=-1
    ?
      (
        (!document.querySelector('#listener').checked && !document.querySelector('#podcaster').checked && !document.querySelector('#directory').checked && !document.querySelector('#misc').checked)
        || (document.querySelector('#listener').checked && x.classList.contains('box-listener'))
        || (document.querySelector('#podcaster').checked && x.classList.contains('box-podcaster'))
        || (document.querySelector('#directory').checked && x.classList.contains('box-directory'))
        || (document.querySelector('#misc').checked && x.classList.contains('box-misc'))
        ?
        (
          (!document.querySelector('#podcasting20certified').checked && !document.querySelector('#opensource').checked)
          || (document.querySelector('#podcasting20certified').checked && document.querySelector('#opensource').checked && x.classList.contains('box-podcasting20certifiedbadge') && x.classList.contains('box-opensource'))
          || (document.querySelector('#podcasting20certified').checked && !document.querySelector('#opensource').checked && x.classList.contains('box-podcasting20certifiedbadge'))
          || (document.querySelector('#opensource').checked && !document.querySelector('#podcasting20certified').checked && x.classList.contains('box-opensource'))
          ?
          "block"
          :
          "none"
        )
        :
        "none"
      )
    :
    "none")
  );
}

function updateFilter(){
  location.hash = 
    escape(document.querySelector('#filter').value) +
    (document.querySelector('#podcasting20certified').checked?'&podcasting20certified':'') +
    (document.querySelector('#opensource').checked?'&opensource':'') +
    (document.querySelector('#listener').checked?'&listener':'') +
    (document.querySelector('#podcaster').checked?'&podcaster':'') +
    (document.querySelector('#directory').checked?'&directory':'') +
    (document.querySelector('#misc').checked?'&misc':'');
  runFilter();
}

/**
* Iterate Elements and add event listener
*
* @param {NodeList} Array of elements
* @param {string} callback function name
*/
function registerAnalyticsEvents(elements, callback) {
    for (let i = 0; i < elements.length; i++) {
        elements[i].addEventListener('click', callback);
        elements[i].addEventListener('auxclick', callback);
    }
}

/**
* Handle Link Events with plausible
* https://github.com/plausible/analytics/blob/e1bb4368460ebb3a0bb86151b143176797b686cc/tracker/src/plausible.js#L74
*
* @param {Event} click
*/
function handleLinkEvent(event) {
    let link = event.target;
    let middle = event.type == "auxclick" && event.which == 2;
    let click = event.type == "click";
    while (link && (typeof link.tagName == 'undefined' || link.tagName.toLowerCase() != 'a' || !link.href)) {
        link = link.parentNode;
    }

    if (middle || click)
        registerEvent(link.getAttribute('data-analytics'));

    // Delay navigation so that Plausible is notified of the click
    if (!link.target) {
        if (!(event.ctrlKey || event.metaKey || event.shiftKey) && click) {
            setTimeout(function () {
                location.href = link.href;
            }, 150);
            event.preventDefault();
        }
    }
}

/**
* Parse data and call plausible
* Using data attribute in html eg. data-analytics='"Register", {"props":{"plan":"Starter"}}'
*
* @param {string} data - plausible event "Register", {"props":{"plan":"Starter"}}
*/
function registerEvent(data) {
    // break into array
    let attributes = data.split(/,(.+)/);

    // Parse it to object
    let events = [JSON.parse(attributes[0]), JSON.parse(attributes[1] || '{}')];

    plausible(...events);
}



window.addEventListener("load", function(event){
  if(document.querySelector('#filter')){
    let filters=location.hash.split('&');
    if(filters[0].startsWith('#')){
      document.querySelector('#filter').value = unescape(filters[0].substring(1));
    }
    document.querySelector('#podcasting20certified').checked = (filters.includes('podcasting20certified'));
    document.querySelector('#opensource').checked = (filters.includes('opensource'));
    document.querySelector('#listener').checked = (filters.includes('listener'));
    document.querySelector('#podcaster').checked = (filters.includes('podcaster'));
    document.querySelector('#directory').checked = (filters.includes('directory'));
    document.querySelector('#misc').checked = (filters.includes('misc'));
    runFilter();
    document.querySelector('#listener').addEventListener("change", updateFilter);
    document.querySelector('#podcaster').addEventListener("change", updateFilter);
    document.querySelector('#directory').addEventListener("change", updateFilter);
    document.querySelector('#misc').addEventListener("change", updateFilter);
    document.querySelector('#podcasting20certified').addEventListener("change", updateFilter);
    document.querySelector('#opensource').addEventListener("change", updateFilter);
    document.querySelector('#filter').addEventListener("keyup", updateFilter);
    document.querySelector('#filter').focus();
  }
  let links = document.querySelectorAll("[data-type='clipboard']");
  for (let i = 0; i < links.length; i++) {  
    links[i].addEventListener("click", copy);
  }
  // Handle link events - those that have data-analytics
  let elements = document.querySelectorAll("a[data-analytics]");
  for (let i = 0; i < elements.length; i++) {
    elements[i].addEventListener('click', handleLinkEvent);
    elements[i].addEventListener('auxclick', handleLinkEvent);
  }


});
