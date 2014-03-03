function validateFiles(inputFile) {
    var file = inputFile.files[0];
    var ext =file.name.split('.').pop().toLowerCase();
    var extenstion = ['mp3']
    if (jQuery.inArray( ext, extenstion ) == -1)
    {
    new Messi('Please select MP3 file format only', {
      title : "Info",
      titleClass: 'anim error',
      autoclose : 1700,
      buttons: true,
      height: 'auto',
      modal: true    }, {
        center : true,
        closeButton: true,
        viewport : {
          top : '760px',
          left : '0px'
        }
      });
    $(inputFile).val('');
  };
}