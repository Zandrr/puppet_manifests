###instsphinx.pp

### previous sphinx == 1.0.4
        define sphinx::instsphinx($pythonvers = 'default', $sphinxvers = '1.2b1'){

        include python::instpython2_7

                $_sphinxvers = $sphinxvers
                $_pythonvers = $pythonvers


                if $_pythonvers == '2.7.3' {
                        $_cutpython = '2.7'
                }

#               file{"/opt/sphinx/$_sphinxvers/python$_cutpython/site-packages":
#                       ensure => directory,
#               }

                if $_pythonvers == 'default' {  #what exactly is this checking?
                        exec{"inst sphinx $_sphinxversion":
                                command => "tar -zxvf $_instbase/sphinx/Sphinx-${_sphinxvers}.tar.gz -C /tmp; cd /tmp/Sphinx-${_sphinxvers}; python setup.py build && python setup.py install;",
                                unless => "python -c 'import sphinx ; print sphinx.__version__' | grep $_sphinxvers",  ##i don't understand this
                                notify => Exec["cln sphinx $_sphinxvers"],
                        }
                }
                else{

                        exec{"inst sphinx $_sphinxvers":
                                command => "tar -zxvf $_instbase/sphinx/Sphinx-${_sphinxvers}.tar.gz -C /tmp; cp $_instbase/sphinx/setuptools-0.6c11-py2.7.egg /tmp/Sphinx-${_sphinxvers}; cd /tmp/Sphinx-${_sphinxvers}; /opt/python-$_pythonvers/bin/python setup.py build && /opt/python-$_pythonvers/bin/python setup.py install --prefix=/opt/sphinx/$_sphinxvers;",
                                #unless => "python -c 'import sphinx ; print sphinx.__version__' | grep $_sphinxvers",
                                creates => "/opt/sphinx/$_sphinxvers/",
                                notify => Exec["cln sphinx $_sphinxvers"],
                        }
                }