Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDB8B6D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 13:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfHMLaU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 07:30:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39626 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfHMLaR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 07:30:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DBTE1j110780;
        Tue, 13 Aug 2019 11:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=6zIN+c1btfbDF+wKvp/Hqn3SicNRgTuywg05n6QypFw=;
 b=UmIgW1i0oeuPGhNFUrAPK/SzbFScwAWwkwK21TWGjhEukKs9S1L8Am+6QREDvTGV41Zm
 TQWEvv4a4iP0Pkvv9jxwA9vk2YK1wRtfUr4KJKJ1WJJmnzopnqyEFUFUj8WHf42mcN0E
 CAoPjkaDYykJPYBe8GG7DGf88SCV8YhAEGb/z94ibOeLc8UDOIncsvXyxXH1X/k/4OPO
 Y6Dvt52q6TO+KI6LnsiE6NFMg0QXQZJynicYoOXo+1n3p/nMhrL3xtbirCcCZ95uVPqW
 ZbUhyRKH3Poqf6/V1hYJCe8J9RLk2+00EM6/gbifnH/aODxecsMdnQk5beQvNBE2K6pP 9A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u9pjqdkdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 11:29:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DBTNPK150717;
        Tue, 13 Aug 2019 11:29:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u9n9j3me3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 11:29:50 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7DBTiZk010616;
        Tue, 13 Aug 2019 11:29:45 GMT
Received: from abi.no.oracle.com (/141.143.213.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 04:29:44 -0700
Message-ID: <b4d2cf8635103e30313773761b095f3a1cfd9a82.camel@oracle.com>
Subject: Re: [RFC 00/19] Integration of Kernel Test Framework (KTF) into the
 kernel tree
From:   Knut Omang <knut.omang@oracle.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 13 Aug 2019 13:29:40 +0200
In-Reply-To: <CAFd5g47bK2hv6dRvqE3hOyq-FrgrR8NJo__HonHFoYOOMkWh6w@mail.gmail.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
         <CAFd5g47bK2hv6dRvqE3hOyq-FrgrR8NJo__HonHFoYOOMkWh6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130125
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2019-08-13 at 01:17 -0700, Brendan Higgins wrote:
> On Mon, Aug 12, 2019 at 11:11 PM Knut Omang <knut.omang@oracle.com> wrote:
> [...]
> > Alan Maguire (3):
> >   ktf: Implementation of ktf support for overriding function entry and return.
> >   ktf: A simple debugfs interface to test results
> >   ktf: Simple coverage support
> > 
> > Knut Omang (16):
> >   kbuild: Fixes to rules for host-cshlib and host-cxxshlib
> >   ktf: Introduce the main part of the kernel side of ktf
> >   ktf: Introduce a generic netlink protocol for test result communication
> >   ktf: An implementation of a generic associative array container
> >   ktf: Configurable context support for network info setup
> >   ktf: resolve: A helper utility to aid in exposing private kernel symbols to KTF tests.
> >   ktf: Add documentation for Kernel Test Framework (KTF)
> >   ktf: Add a small test suite with a few tests to test KTF itself
> >   ktf: Main part of user land library for executing tests
> >   ktf: Integration logic for running ktf tests from googletest
> >   ktf: Internal debugging facilities
> >   ktf: Some simple examples
> >   ktf: Some user applications to run tests
> >   ktf: Toplevel ktf Makefile/makefile includes and scripts to run from kselftest
> >   kselftests: Enable building ktf
> >   Documentation/dev-tools: Add index entry for KTF documentation
> > 
> >  Documentation/dev-tools/index.rst                   |    1 +-
> >  Documentation/dev-tools/ktf/concepts.rst            |  242 +++-
> >  Documentation/dev-tools/ktf/debugging.rst           |  248 +++-
> >  Documentation/dev-tools/ktf/examples.rst            |   26 +-
> >  Documentation/dev-tools/ktf/features.rst            |  307 ++++-
> >  Documentation/dev-tools/ktf/implementation.rst      |   70 +-
> >  Documentation/dev-tools/ktf/index.rst               |   14 +-
> >  Documentation/dev-tools/ktf/installation.rst        |   73 +-
> >  Documentation/dev-tools/ktf/introduction.rst        |  134 ++-
> >  Documentation/dev-tools/ktf/progref.rst             |  144 ++-
> >  scripts/Makefile.host                               |   17 +-
> >  tools/testing/selftests/Makefile                    |    1 +-
> >  tools/testing/selftests/ktf/Makefile                |   21 +-
> >  tools/testing/selftests/ktf/examples/Makefile       |   17 +-
> >  tools/testing/selftests/ktf/examples/h2.c           |   45 +-
> >  tools/testing/selftests/ktf/examples/h3.c           |   84 +-
> >  tools/testing/selftests/ktf/examples/h4.c           |   62 +-
> >  tools/testing/selftests/ktf/examples/hello.c        |   38 +-
> >  tools/testing/selftests/ktf/examples/kgdemo.c       |   61 +-
> >  tools/testing/selftests/ktf/kernel/Makefile         |   15 +-
> >  tools/testing/selftests/ktf/kernel/ktf.h            |  604 +++++++-
> >  tools/testing/selftests/ktf/kernel/ktf_context.c    |  409 +++++-
> >  tools/testing/selftests/ktf/kernel/ktf_cov.c        |  690 ++++++++-
> >  tools/testing/selftests/ktf/kernel/ktf_cov.h        |   94 +-
> >  tools/testing/selftests/ktf/kernel/ktf_debugfs.c    |  356 ++++-
> >  tools/testing/selftests/ktf/kernel/ktf_debugfs.h    |   34 +-
> >  tools/testing/selftests/ktf/kernel/ktf_map.c        |  261 +++-
> >  tools/testing/selftests/ktf/kernel/ktf_map.h        |  154 ++-
> >  tools/testing/selftests/ktf/kernel/ktf_netctx.c     |  132 ++-
> >  tools/testing/selftests/ktf/kernel/ktf_netctx.h     |   64 +-
> >  tools/testing/selftests/ktf/kernel/ktf_nl.c         |  516 ++++++-
> >  tools/testing/selftests/ktf/kernel/ktf_nl.h         |   15 +-
> >  tools/testing/selftests/ktf/kernel/ktf_override.c   |   45 +-
> >  tools/testing/selftests/ktf/kernel/ktf_override.h   |   15 +-
> >  tools/testing/selftests/ktf/kernel/ktf_test.c       |  397 +++++-
> >  tools/testing/selftests/ktf/kernel/ktf_test.h       |  381 ++++-
> >  tools/testing/selftests/ktf/kernel/ktf_unlproto.h   |  105 +-
> >  tools/testing/selftests/ktf/lib/Makefile            |   21 +-
> >  tools/testing/selftests/ktf/lib/ktf.h               |  114 +-
> >  tools/testing/selftests/ktf/lib/ktf_debug.cc        |   20 +-
> >  tools/testing/selftests/ktf/lib/ktf_debug.h         |   59 +-
> >  tools/testing/selftests/ktf/lib/ktf_int.cc          | 1031 ++++++++++++-
> >  tools/testing/selftests/ktf/lib/ktf_int.h           |   84 +-
> >  tools/testing/selftests/ktf/lib/ktf_run.cc          |  177 ++-
> >  tools/testing/selftests/ktf/lib/ktf_unlproto.c      |   21 +-
> >  tools/testing/selftests/ktf/scripts/ktf_syms.mk     |   16 +-
> >  tools/testing/selftests/ktf/scripts/resolve         |  188 ++-
> >  tools/testing/selftests/ktf/scripts/runtests.mk     |    3 +-
> >  tools/testing/selftests/ktf/scripts/runtests.sh     |  100 +-
> >  tools/testing/selftests/ktf/scripts/top_make.mk     |   14 +-
> >  tools/testing/selftests/ktf/selftest/Makefile       |   17 +-
> >  tools/testing/selftests/ktf/selftest/context.c      |  149 ++-
> >  tools/testing/selftests/ktf/selftest/context.h      |   15 +-
> >  tools/testing/selftests/ktf/selftest/context_self.h |   34 +-
> >  tools/testing/selftests/ktf/selftest/hybrid.c       |   35 +-
> >  tools/testing/selftests/ktf/selftest/hybrid.h       |   24 +-
> >  tools/testing/selftests/ktf/selftest/hybrid_self.h  |   27 +-
> >  tools/testing/selftests/ktf/selftest/ktf_syms.txt   |   17 +-
> >  tools/testing/selftests/ktf/selftest/self.c         |  661 ++++++++-
> >  tools/testing/selftests/ktf/user/Makefile           |   26 +-
> >  tools/testing/selftests/ktf/user/hybrid.cc          |   39 +-
> >  tools/testing/selftests/ktf/user/ktfcov.cc          |   68 +-
> >  tools/testing/selftests/ktf/user/ktfrun.cc          |   20 +-
> >  tools/testing/selftests/ktf/user/ktftest.cc         |   46 +-
> >  64 files changed, 8909 insertions(+), 9 deletions(-)
> 
> It also looks like all your test code lives outside of the kernel
> source dir. I take it you intend for tests to live in
> tools/testing/selftests/ktf/ ?

Good point,
with this RFC it would be just to add another directory under ktf/
but this was just to find a simple way to integrate it below selftests,
without interfering with the current structure. 

I imagine a tighter integration/unification between normal Kbuild targets and selftests 
targets that also took kernel module building into consideration would be a better solution.

I think this is a good topic for discussion.
As I indicate above, I think it is problematic that test code has to be explicitly 
configured in as we configure code features of the kernel, which changes the "logical" 
kernel we build.

So some more "native" support for test modules are desired, IMHO.

Knut

> [...]

