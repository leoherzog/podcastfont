function copy() {
  if(this.dataset.clipboardContent){
    navigator.clipboard.writeText(this.dataset.clipboardContent);
  } else {
    navigator.clipboard.writeText(this.innerText);
  }
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

window.addEventListener("load", function(event){
  var links = document.querySelectorAll("[data-type='clipboard']");
  if (links) {
        for (var i = 0; i < links.length; i++) {  
          links[i].addEventListener("click", copy);
      }
  }
  var filters=location.hash.split('&');
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
});
