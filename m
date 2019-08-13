Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5D8AF5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfHMGL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:11:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58758 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfHMGLZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68qlk039282;
        Tue, 13 Aug 2019 06:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=diseXHpX8dtT9/GAoXhKTt8Q+OXoOvFSdw7KaXv5xJc=;
 b=sTnVvPWPYmwU+L+op8jGwhJlHHwBT9g8tYUy9fbnm8yjze7HRLw92g7VrQTIqC8gB2kS
 9/ujgw2M2SfhH4W/vRcL/5QdjLj7Hu7YxfMcIhJLpxkMXNEecwKra/ghuXXDLlhGFCEa
 fJx6YtJ06sxvK3nfrc3fgXrNdxCYzyKcKfh2K57CFyc9phEfiQbFpD5HyO2hC8oRlAWQ
 s2c5u3FhUw+cmwySigu5CzLYHLKF6zE+3iZlCdd2VodHo2c5k3BE2N8BpjMvZHdiQjAu
 S/u70qdqkOiG1ruxuoZgbR760BNVTzEe317r9bDRPIVOdnyUzAkO5NTmEhUZfT4bG+3b JA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=diseXHpX8dtT9/GAoXhKTt8Q+OXoOvFSdw7KaXv5xJc=;
 b=HSshzBTHrCbhcZvGAkrQO1eewbvj8mZQhSOiMzNUwXrjGaueRILkd+nNdJRNvar7NA9d
 giGYMWweCPMOIXSbkpG/8giTi+O6AJTAwpdUaqnRy2KYRc2HtjLn4HoqiEZhLutBurXO
 oXo8yZuQwDfYbFQFkvUNy3yyEu562T2OTjLnjA6FBkIXx0hJKA2bKeboU+3m9GyjYxDe
 Vl9+Y/aa0cXzuZpmarcmzetuL9fPodJ1yFugUr4+imVcmsh2C5PCQvH9EoAEznQpIwzI
 yYxeK3qljydDiSaKvSR05U3wOa89fpntvOTODP4Ms7wy0z8mHZzm97/OOwvW482bRHJl BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u9nvp4178-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:10:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68Q1m056371;
        Tue, 13 Aug 2019 06:10:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u9n9hs1pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:10:55 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7D6ApwT013132;
        Tue, 13 Aug 2019 06:10:51 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:10:50 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 00/19] Integration of Kernel Test Framework (KTF) into the kernel tree
Date:   Tue, 13 Aug 2019 08:09:15 +0200
Message-Id: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KTF has already been available for a while as a separate git repository with
means to facilitate use with any kernel version.

KTF can be used both for "pure" unit testing and for more pragmatic
approaches to component testing. Apart from some useful features that
KTF uses from the kernel toolbox (such as kallsyms, kprobes),
KTF does not depend on any special environment such as UML or on a
large set of mocked up APIs to be useful. KTF basically allows test
code to be inserted and managed as separate kernel modules, while
providing the tests convenient access to almost the full range of kernel
APIs, both exposed and private. And once a KTF test set exists, it
should be fairly easy to compile and run it against older versions of
the kernel as well.

This series proposes a non-intrusive integration of KTF into the kernel
hopefully presented in digestable pieces.
For convenience, the patch set is also available on top of v5.2
at https://github.com/knuto/linux/pull/new/ktf_v1 .

The high level structure of the KTF code is as follows:

External dependencies for the user land side:
* libnl3 for netlink communication
* googletest for test runner, reporting and test selection support.

Kernel components:
* Simple core test and test suite related abstractions:
  core data structures ktf_case, ktf_test, an assertion macro "infrastructure"
  with ASSERT_* and EXPECT_* macros and helper functions
* Bookkeeping data structures:
  - ktf_map - a (key, value) mapping container used to implement management
    of instances of the higher level abstraction needs, such as ktf_handle and ktf_context.
  - ktf_handle: A global environment that a test runs within.
  - ktf_context: a test suite specific abstraction to allow a test to execute within
	one or more contexts. An example use of context can be a device
	instance: A test can be instantiated to run on all available such
	devices, according to test suite defined criteria.
* A generic netlink protocol (ktf_nl, ktf_unlproto) which defines operations to
  allow a user space part of a test to query the kernel for test information,
  invoke tests and get feedback reports about results.
* An alternative debugfs interface to allow examining and executing kernel-only tests
  without a user level program.
* Support for overriding and modifying behaviour of kernel calls.

User mode components:
* A test executor based on and integrated with Googletest.
  Googletest is one of several mature user land unit test suites for
  C/C++. The choice allowed us to focus on kernel specific
  functionality rather than having to reinvent too many wheels.
* Tools to aid in creating new test modules (suites):
  To facilitate a developer friendly way of testing internals of a module or the
  kernel itself, one of the important features of KTF, we often need to access
  symbols deliberately not exposed from a module.
  KTF contains a script used to create definitions based on kallsyms
  lookup for easy access to symbols not exposed by a module or the kernel.
  The user just provides a simple text file with a list of the symbols by
  module.

This series is an attempt to address feedback from several people
that having the functionality readily available within the kernel repository
is desired.

An in-tree KTF allows test suites to be provided with the kernel, which makes
it easy to use KTF based suites as part of the kernel selftests and driver
test suites. Having the ability to still build and run the latest versions of
test suites against older kernels should be of great value to stable maintainers,
distributions and driver maintainers, who would want to have an easy path,
with minimal backporting efforts to make sure that criterias implemented by
new test logic is also valid for these kernels.

Our definite goal moving forward is to try to satisfy both needs in a
transparent way. The plan is to let the standalone KTF repository follow the
in-kernel one, and to allow test suites to be maintained similarly,
and to support maintenance by proper tooling.

Mode of integration into the kernel
===================================

One feature of KTF is that it allows tests to work, look and feel similar
whether they execute entirely in user mode, entirely in kernel mode,
or half and half (hybrid tests). KTF consist of both user space
and kernel code. Unlike e.g. kselftest, KTF in the Github version
does not attempt to address the test runner aspects of testing.

Due to the need for building modules, KTF requires access to kernel module
build facilities (obj-m). But KTF also has nontrivial needs for user
land building, and we think it is good to keep the build structure in a way that
allows KTF to be built both in-tree and out-of-tree without
necessarily having to reconfigure the kernel.

This first version of kernel integration of KTF solves this challenge
by co-locating everything associated with KTF under ktf/ as in the
github version, but use the little used hostprogs-y and hostlibs-y
features to build the user space side. The first patch in the series is
fixes to make it work in a natural way to suit our needs.

Positioning for natural building within the kernel tree
=======================================================

Currently we find significant amount of C level tests within the following paths:

tools/testing/selftests/  (kselftests, almost entirely user space so far)
lib/  			  (various kernel level mostly unit tests)

and in the making::

kunit/			  (kernel only (UML))

So all kernel code are currently located directly within the kernel
build paths, accessed from the top level Makefile, to allow everything
to be controlled by config and from the main build targets for the
kernel. But this also poses challenges, in that .config has to be
modified to build tests. And once a .config is changed, we no longer
in principle logically operate on the same kernel.

A better approach seems to be to follow the principle
taken by kselftest: To have all the logic associated with the test
inside the test tree, and make it available for building separately
from the kernel itself. This require us to have a means to build
kernel modules from within the test tree, separately from the main
kernel paths. Currently this seems to only by supported via the M=
option used to build out-of-tree modules. This was also easy to get to work
for the kernel parts, based on the Github version of KTF, where we
already do this. With the additional need to compile user land code,
using the corresponding hostprogs-y and hostNNlibs-y seemed natural,
but this has been challenging: The build macros does not really
support hostprogs-y etc as "first class citizens" so some amount of
hacking is in there in this first draft version.
Using hostprogs-y etc is also a different approach that what is used
for C code in kselftest today, but we imagine that there's room for
unification here to get the best of both worlds, with the help of
the wider Kbuild community.

As an initial proposal, we have positioned ktf as an additional
kselftest target, under tools/testing/selftests/ktf, and the recommended:

make TARGETS="ktf" kselftest

way of building and running should work, even from normal user accounts,
if the user running it has sudo rights (for the kernel module insertion
and removal). This will run the selftests for KTF itself, and should
be a good starting point for adding more test cases. We also have had
activities going to take some of the existing test suites under lib/
and convert them into KTF based test suites, and will get back to this
later.

A trimmed down output from the above make target would look like this:

  ...
  CC [M]  tools/testing/selftests/ktf/kernel/ktf_override.o
  LD [M]  tools/testing/selftests/ktf/kernel/ktf.o
  HOSTCC  -fPIC tools/testing/selftests/ktf/lib/ktf_unlproto.o
  HOSTCXX -fPIC tools/testing/selftests/ktf/lib/ktf_int.o
  KTFSYMS tools/testing/selftests/ktf/selftest/ktf_syms.h
  CC [M]  tools/testing/selftests/ktf/selftest/self.o
  LD [M]  tools/testing/selftests/ktf/selftest/selftest.o
  HOSTCXX tools/testing/selftests/ktf/user/ktftest.o
  HOSTCXX tools/testing/selftests/ktf/user/hybrid.o
  HOSTLD  tools/testing/selftests/ktf/user/ktftest
  Building modules, stage 2.
  MODPOST 7 modules
  LD [M]  tools/testing/selftests/ktf/kernel/ktf.ko
  LD [M]  tools/testing/selftests/ktf/selftest/selftest.ko
  running tests
make BUILD=/net/abi/local/abi/build/kernel/ktf/tools/testing/selftests -f scripts/runtests.mk run_tests
TAP version 13
1..1
...
ok 1 selftests: ktf: runtests.sh

We're looking forward to feedback on this, and also to more discussion
around unit testing at the testing & fuzzing workshop at LPC!

Alan Maguire (3):
  ktf: Implementation of ktf support for overriding function entry and return.
  ktf: A simple debugfs interface to test results
  ktf: Simple coverage support

Knut Omang (16):
  kbuild: Fixes to rules for host-cshlib and host-cxxshlib
  ktf: Introduce the main part of the kernel side of ktf
  ktf: Introduce a generic netlink protocol for test result communication
  ktf: An implementation of a generic associative array container
  ktf: Configurable context support for network info setup
  ktf: resolve: A helper utility to aid in exposing private kernel symbols to KTF tests.
  ktf: Add documentation for Kernel Test Framework (KTF)
  ktf: Add a small test suite with a few tests to test KTF itself
  ktf: Main part of user land library for executing tests
  ktf: Integration logic for running ktf tests from googletest
  ktf: Internal debugging facilities
  ktf: Some simple examples
  ktf: Some user applications to run tests
  ktf: Toplevel ktf Makefile/makefile includes and scripts to run from kselftest
  kselftests: Enable building ktf
  Documentation/dev-tools: Add index entry for KTF documentation

 Documentation/dev-tools/index.rst                   |    1 +-
 Documentation/dev-tools/ktf/concepts.rst            |  242 +++-
 Documentation/dev-tools/ktf/debugging.rst           |  248 +++-
 Documentation/dev-tools/ktf/examples.rst            |   26 +-
 Documentation/dev-tools/ktf/features.rst            |  307 ++++-
 Documentation/dev-tools/ktf/implementation.rst      |   70 +-
 Documentation/dev-tools/ktf/index.rst               |   14 +-
 Documentation/dev-tools/ktf/installation.rst        |   73 +-
 Documentation/dev-tools/ktf/introduction.rst        |  134 ++-
 Documentation/dev-tools/ktf/progref.rst             |  144 ++-
 scripts/Makefile.host                               |   17 +-
 tools/testing/selftests/Makefile                    |    1 +-
 tools/testing/selftests/ktf/Makefile                |   21 +-
 tools/testing/selftests/ktf/examples/Makefile       |   17 +-
 tools/testing/selftests/ktf/examples/h2.c           |   45 +-
 tools/testing/selftests/ktf/examples/h3.c           |   84 +-
 tools/testing/selftests/ktf/examples/h4.c           |   62 +-
 tools/testing/selftests/ktf/examples/hello.c        |   38 +-
 tools/testing/selftests/ktf/examples/kgdemo.c       |   61 +-
 tools/testing/selftests/ktf/kernel/Makefile         |   15 +-
 tools/testing/selftests/ktf/kernel/ktf.h            |  604 +++++++-
 tools/testing/selftests/ktf/kernel/ktf_context.c    |  409 +++++-
 tools/testing/selftests/ktf/kernel/ktf_cov.c        |  690 ++++++++-
 tools/testing/selftests/ktf/kernel/ktf_cov.h        |   94 +-
 tools/testing/selftests/ktf/kernel/ktf_debugfs.c    |  356 ++++-
 tools/testing/selftests/ktf/kernel/ktf_debugfs.h    |   34 +-
 tools/testing/selftests/ktf/kernel/ktf_map.c        |  261 +++-
 tools/testing/selftests/ktf/kernel/ktf_map.h        |  154 ++-
 tools/testing/selftests/ktf/kernel/ktf_netctx.c     |  132 ++-
 tools/testing/selftests/ktf/kernel/ktf_netctx.h     |   64 +-
 tools/testing/selftests/ktf/kernel/ktf_nl.c         |  516 ++++++-
 tools/testing/selftests/ktf/kernel/ktf_nl.h         |   15 +-
 tools/testing/selftests/ktf/kernel/ktf_override.c   |   45 +-
 tools/testing/selftests/ktf/kernel/ktf_override.h   |   15 +-
 tools/testing/selftests/ktf/kernel/ktf_test.c       |  397 +++++-
 tools/testing/selftests/ktf/kernel/ktf_test.h       |  381 ++++-
 tools/testing/selftests/ktf/kernel/ktf_unlproto.h   |  105 +-
 tools/testing/selftests/ktf/lib/Makefile            |   21 +-
 tools/testing/selftests/ktf/lib/ktf.h               |  114 +-
 tools/testing/selftests/ktf/lib/ktf_debug.cc        |   20 +-
 tools/testing/selftests/ktf/lib/ktf_debug.h         |   59 +-
 tools/testing/selftests/ktf/lib/ktf_int.cc          | 1031 ++++++++++++-
 tools/testing/selftests/ktf/lib/ktf_int.h           |   84 +-
 tools/testing/selftests/ktf/lib/ktf_run.cc          |  177 ++-
 tools/testing/selftests/ktf/lib/ktf_unlproto.c      |   21 +-
 tools/testing/selftests/ktf/scripts/ktf_syms.mk     |   16 +-
 tools/testing/selftests/ktf/scripts/resolve         |  188 ++-
 tools/testing/selftests/ktf/scripts/runtests.mk     |    3 +-
 tools/testing/selftests/ktf/scripts/runtests.sh     |  100 +-
 tools/testing/selftests/ktf/scripts/top_make.mk     |   14 +-
 tools/testing/selftests/ktf/selftest/Makefile       |   17 +-
 tools/testing/selftests/ktf/selftest/context.c      |  149 ++-
 tools/testing/selftests/ktf/selftest/context.h      |   15 +-
 tools/testing/selftests/ktf/selftest/context_self.h |   34 +-
 tools/testing/selftests/ktf/selftest/hybrid.c       |   35 +-
 tools/testing/selftests/ktf/selftest/hybrid.h       |   24 +-
 tools/testing/selftests/ktf/selftest/hybrid_self.h  |   27 +-
 tools/testing/selftests/ktf/selftest/ktf_syms.txt   |   17 +-
 tools/testing/selftests/ktf/selftest/self.c         |  661 ++++++++-
 tools/testing/selftests/ktf/user/Makefile           |   26 +-
 tools/testing/selftests/ktf/user/hybrid.cc          |   39 +-
 tools/testing/selftests/ktf/user/ktfcov.cc          |   68 +-
 tools/testing/selftests/ktf/user/ktfrun.cc          |   20 +-
 tools/testing/selftests/ktf/user/ktftest.cc         |   46 +-
 64 files changed, 8909 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/dev-tools/ktf/concepts.rst
 create mode 100644 Documentation/dev-tools/ktf/debugging.rst
 create mode 100644 Documentation/dev-tools/ktf/examples.rst
 create mode 100644 Documentation/dev-tools/ktf/features.rst
 create mode 100644 Documentation/dev-tools/ktf/implementation.rst
 create mode 100644 Documentation/dev-tools/ktf/index.rst
 create mode 100644 Documentation/dev-tools/ktf/installation.rst
 create mode 100644 Documentation/dev-tools/ktf/introduction.rst
 create mode 100644 Documentation/dev-tools/ktf/progref.rst
 create mode 100644 tools/testing/selftests/ktf/Makefile
 create mode 100644 tools/testing/selftests/ktf/examples/Makefile
 create mode 100644 tools/testing/selftests/ktf/examples/h2.c
 create mode 100644 tools/testing/selftests/ktf/examples/h3.c
 create mode 100644 tools/testing/selftests/ktf/examples/h4.c
 create mode 100644 tools/testing/selftests/ktf/examples/hello.c
 create mode 100644 tools/testing/selftests/ktf/examples/kgdemo.c
 create mode 100644 tools/testing/selftests/ktf/kernel/Makefile
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_context.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_cov.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_cov.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_debugfs.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_debugfs.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_map.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_map.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_netctx.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_netctx.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_nl.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_nl.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_override.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_override.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_test.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_test.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_unlproto.h
 create mode 100644 tools/testing/selftests/ktf/lib/Makefile
 create mode 100644 tools/testing/selftests/ktf/lib/ktf.h
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_debug.cc
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_debug.h
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_int.cc
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_int.h
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_run.cc
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_unlproto.c
 create mode 100644 tools/testing/selftests/ktf/scripts/ktf_syms.mk
 create mode 100755 tools/testing/selftests/ktf/scripts/resolve
 create mode 100644 tools/testing/selftests/ktf/scripts/runtests.mk
 create mode 100755 tools/testing/selftests/ktf/scripts/runtests.sh
 create mode 100644 tools/testing/selftests/ktf/scripts/top_make.mk
 create mode 100644 tools/testing/selftests/ktf/selftest/Makefile
 create mode 100644 tools/testing/selftests/ktf/selftest/context.c
 create mode 100644 tools/testing/selftests/ktf/selftest/context.h
 create mode 100644 tools/testing/selftests/ktf/selftest/context_self.h
 create mode 100644 tools/testing/selftests/ktf/selftest/hybrid.c
 create mode 100644 tools/testing/selftests/ktf/selftest/hybrid.h
 create mode 100644 tools/testing/selftests/ktf/selftest/hybrid_self.h
 create mode 100644 tools/testing/selftests/ktf/selftest/ktf_syms.txt
 create mode 100644 tools/testing/selftests/ktf/selftest/self.c
 create mode 100644 tools/testing/selftests/ktf/user/Makefile
 create mode 100644 tools/testing/selftests/ktf/user/hybrid.cc
 create mode 100644 tools/testing/selftests/ktf/user/ktfcov.cc
 create mode 100644 tools/testing/selftests/ktf/user/ktfrun.cc
 create mode 100644 tools/testing/selftests/ktf/user/ktftest.cc

base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
-- 
git-series 0.9.1
