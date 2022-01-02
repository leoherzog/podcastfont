function copy() {
  if(this.dataset.clipboardContent){
    navigator.clipboard.writeText(this.dataset.clipboardContent);
  } else {
    navigator.clipboard.writeText(this.innerText);
  }
}

function updateFilter(){
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

var links = document.querySelectorAll("[data-type='clipboard']");

if (links) {
      for (var i = 0; i < links.length; i++) {  
        links[i].addEventListener("click", copy);
    }
}

document.querySelector('#listener').addEventListener("change", updateFilter);
document.querySelector('#podcaster').addEventListener("change", updateFilter);
document.querySelector('#directory').addEventListener("change", updateFilter);
document.querySelector('#misc').addEventListener("change", updateFilter);
document.querySelector('#podcasting20certified').addEventListener("change", updateFilter);
document.querySelector('#opensource').addEventListener("change", updateFilter);
document.querySelector('#filter').addEventListener("keyup", updateFilter);
document.querySelector('#filter').focus();
