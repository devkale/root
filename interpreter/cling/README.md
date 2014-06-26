```
                         ______  __      ____  _   __  ______
                        / ____/ / /     /  _/ / | / / / ____/
                       / /     / /      / /  /  |/ / / / __  
                      / /___  / /___  _/ /  / /|  / / /_/ /  
                      \____/ /_____/ /___/ /_/ |_/  \____/   
                                                         
```

##DESCRIPTION  
Cling is an interactive C++ interpreter, built on top of Clang and LLVM compiler infrastructure. Cling realizes the read-print-evaluate-loop concept, in order to leverage rapid application development. Implemented as a small extension to LLVM and Clang, the interpreter reuses their strengths such as the praised concise and expressive compiler diagnostics.  

### Further information & demos  
  Please note that some of the resources are rather old and most of the stated limitations are outdated.  
  * https://github.com/vgvassilev/cling/tree/master/www/docs/talks  
  * http://blog.coldflake.com/posts/2012-08-09-On-the-fly-C++.html  
  * http://solarianprogrammer.com/2012/08/14/cling-cpp-11-interpreter/  
  * https://www.youtube.com/watch?v=f9Xfh8pv3Fs  
  * https://www.youtube.com/watch?v=BrjV1ZgYbbA  
  * https://www.youtube.com/watch?v=wZZdDhf2wDw  
  * https://www.youtube.com/watch?v=eoIuqLNvzFs  

##INSTALLATION  
###Binaries  
  We offer binary snapshots for download at https://ecsft.cern.ch/dist/cling

###Source  
  CLING source depends on the LLVM[1] and CLANG[2] headers and libraries.
You will also need CMake[3] >= 2.6.1 or GNU Make to build all of those
packages and subversion[4] and git[5] to get the source code.

   [1] http://llvm.org  
   [2] http://clang.llvm.org  
   [3] http://cmake.org  
   [4] http://subversion.tigris.org  
   [5] http://git-scm.com
   
####Building  
  Building LLVM and CLANG you must:
   * Check out the sources:  
```bash
    git clone http://root.cern.ch/git/llvm.git src
    cd src
    git checkout cling-patches
    cd tools
    git clone http://root.cern.ch/git/cling.git
    git clone http://root.cern.ch/git/clang.git
    cd clang
    git checkout cling-patches
```
   * Configure, build and install them, either using CMake:  
   
```bash
    cd ..
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/some/install/dir \
          -DLLVM_TARGETS_TO_BUILD=CBackend\;CppBackend\;X86 \
          -DCMAKE_BUILD_TYPE=Debug \
          ../src
    make
    make install
```
   * or GNU Make (see ../src/configure --help for all options):  

```bash
    cd ..
    mkdir build
    cd build
    ../src/configure --prefix=/some/install/dir
    make
    make install
```

##USAGE  
   To get started run: `/some/install/dir/bin/cling --help`
   or type
   `/some/install/dir/bin/cling`
   `[cling]$ .help`

##DEVELOPERS' CORNER:  
   We have doxygen documentation of cling's code at:
http://cling.web.cern.ch/cling/doxygen/
###CONTRIBUTIONS  
  Every contribution is very welcome. It is considered as a donation and its copyright and any other related 
rights become exclusive ownership of the person merged the code or in any other case the main developers.  
  In order for a contribution to be accepted it has to obey the previously 
established rules for contribution acceptance in cling's work flow and rules.  
