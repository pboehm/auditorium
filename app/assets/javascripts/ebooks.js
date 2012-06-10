$(document).ready(function() {
    var url = 'http://ebooks.i77i.de/studip?callback=?';

    $.getJSON(url, function(data) {

        $.each(data, function(subject, ebooks) {
            var html = '<h3>' + subject + '</h3>';

            html = html + '<table class="table table-striped table-condensed"><tbody>';

            $.each(ebooks, function(index, ebook) {

                html = html + '<tr><td><a target="_blank" href="' +
                    ebook.url + '">' + ebook.name + '</td></tr>';
            });

            html = html + '</tbody></table>';

            $('#ebooks_box').append(html);

        });

    });

});
