document.addEventListener('turbolinks:load', function() {
  var instrumentImage = document.querySelector('.instrument-image');

  function handleFileSelector(event) {
    var files = event.target.files;

    for(var i = 0, f; f = files[i]; i++){
      if (!f.type.match('image.*')) continue

      var reader = new FileReader();
      // Closure to capture the file information
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail
          var span = document.createElement('span');
          span.innerHTML = `<img class="instrument-preview-thumb" src="${e.target.result}" title="${escape(theFile.name)}" />`;
          document.getElementById('list').insertBefore(span, null);
        };
      })(f);
      reader.readAsDataURL(f);
    }
  }

  if (instrumentImage) {
    this.addEventListener('change', handleFileSelector, false);
  }
});
