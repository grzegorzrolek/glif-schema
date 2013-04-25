GLIF XML Schema Definition
===========================

This is an XML Schema for the Glyph Interchange Format, an XML representation of a single glyph in the Unified Font Object's font data storage. Read more at [unifiedfontobject.org](http://unifiedfontobject.org)


Schema's Architecture
----------------------

Elements of both GLIF 1 & 2 Schemas are defined as independent, linked modules that are reused whenever possible. Modules of the GLIF 2 Schema that supersede the earlier format either include the old elements as is, or extend them if necessary.


The Lint Script
----------------

You can validate batches of GLIF files inside whole UFO packages against the schema by running the lint shell script with paths to the packages as arguments.

Credits & Copyright Notice
---------------------------

This work is not affiliated with the Unified Font Object format authors, nor the format itself. 

Copyright (c) 2010-2013, Grzegorz Rolek (ichosis@gmail.com)

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of the The RoboFab Developers nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[This is the BSD-3-Clause license](http://www.opensource.org/licenses/BSD-3-Clause)
