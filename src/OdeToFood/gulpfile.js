var gulp = require('gulp')
var livereload = require('gulp-livereload')
var shell = require('gulp-shell')

var paths = {
    app_file_path: ['./**/*.cs',
                    './**/*.js']
};

gulp.task('restart-kestrel', shell.task(['supervisorctl restart kestrel']));

gulp.task('watch', function() {
    var pollPerSecond = {interval: 5000, mode: 'poll'};
    livereload.listen();
    gulp.watch(paths.app_file_path, pollPerSecond, ['restart-kestrel']);
});