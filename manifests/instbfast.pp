class bfast::instbfastinitial {
        $iamempty = true
        package {"bzip2-devel":
                ensure => installed,
        }

}

define bfast::instbfast ($version='') {
        $_bfastvers = '0.6.4'
        $_bfastpath = "/opt/bfast/$_bfastvers"

        file {["/opt/bfast/","/opt/bfast/$_bfastvers"]:
                ensure => directory,
        }

        package {"bzip2-devel":
                ensure => installed,
        }

        exec {"inst bfast $_bfastvers":
                 command => "tar -zxf $_instbase/bfast/bfast-${_bfastvers}f.tar.gz -C /tmp; cd /tmp/bfast-${_bfastvers}f; ./configure --prefix=$_bfastpath; make && make install;",
                creates => "${_bfastpath}/bin/bfast",
                require => File["/opt/bfast/$_bfastvers"],
                notify => Exec["bfast cln $_bfastvers"],
        }

        exec {"bfast cln $_bfastvers":
                command => "rm -rf /tmp/bfast-${_bfastvers}f;",
                refreshonly => true,
        }

        modules::module {"bfast_$bfastvers":
                filename => "bfast",
                version => $_bfastvers,
                path => "$_bfastpath/bin",
        }

}