Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA9F4FB2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 16:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKHPa4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 10:30:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39332 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfKHPa4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 10:30:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8FTYvv090092;
        Fri, 8 Nov 2019 15:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=muD44DGlPRkW2gSEnldlhZU2cQzKDgKv2ZzPgutoDZk=;
 b=qc/H4WjZXVN4KToLhXVmcMHuaYggGM9Iyt3RH+4umpdrZyKUqEnEX75UpQMgLNXwu10P
 PCRWLxeGF+lKPVpvPnC3VjFFtLxdn1rZOXdKqPSeGWfS+pyw6Ig7+vcIFWkKvRiJ3/oS
 OZ2046xNGy97ebwuHE2KFYIsrW2HMHDMkSGG34oLbvsJdr78I++Tj0IhzeVxcOW+b+fB
 v7lUHSeIVJE96+xg3sKNxSfidNAu58LboyysZubkL+TUPEPRDWSTb+57A63/nxpgcfaz
 qbxnqneL8LrJcsP/ijctS0YIHNiDQDLoxJbrefNRUOKqO6a9o0gVDoOBkqpBwEIp9AUl dQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w41w1609m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 15:30:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8FTYSS102648;
        Fri, 8 Nov 2019 15:30:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w50m5g2ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 15:30:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA8FUP7i019013;
        Fri, 8 Nov 2019 15:30:25 GMT
Received: from dhcp-10-175-178-67.vpn.oracle.com (/10.175.178.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 07:30:25 -0800
Date:   Fri, 8 Nov 2019 15:30:15 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-178-67.vpn.oracle.com
To:     Brendan Higgins <brendanhiggins@google.com>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v3 linux-kselftest-test 5/6] kunit: allow kunit to be
 loaded as a module
In-Reply-To: <CAFd5g46s4eY4qEB5UZPeOKNdZXm4+sA9N=4g8gDYAhyhMahZKw@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1911081520550.24027@dhcp-10-175-178-67.vpn.oracle.com>
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com> <1571335639-21675-6-git-send-email-alan.maguire@oracle.com> <CAFd5g46s4eY4qEB5UZPeOKNdZXm4+sA9N=4g8gDYAhyhMahZKw@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080154
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 7 Nov 2019, Brendan Higgins wrote:

> On Thu, Oct 17, 2019 at 11:09 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > Making kunit itself buildable as a module allows for "always-on"
> > kunit configuration; specifying CONFIG_KUNIT=m means the module
> > is built but only used when loaded.  Kunit test modules will load
> > kunit.ko as an implicit dependency, so simply running
> > "modprobe my-kunit-tests" will load the tests along with the kunit
> > module and run them.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > ---
> >  lib/kunit/Kconfig     | 2 +-
> >  lib/kunit/Makefile    | 4 +++-
> >  lib/kunit/test.c      | 2 ++
> >  lib/kunit/try-catch.c | 3 +++
> >  4 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > index 9ebd5e6..065aa16 100644
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -3,7 +3,7 @@
> >  #
> >
> >  menuconfig KUNIT
> > -       bool "KUnit - Enable support for unit tests"
> > +       tristate "KUnit - Enable support for unit tests"
> >         help
> >           Enables support for kernel unit tests (KUnit), a lightweight unit
> >           testing and mocking framework for the Linux kernel. These tests are
> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index 769d940..8e2635a 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -1,4 +1,6 @@
> > -obj-$(CONFIG_KUNIT) +=                 test.o \
> > +obj-$(CONFIG_KUNIT) +=                 kunit.o
> > +
> > +kunit-objs +=                          test.o \
> >                                         string-stream.o \
> >                                         assert.o \
> >                                         try-catch.o
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index e8b2443..c0ace36 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -523,3 +523,5 @@ void *kunit_find_symbol(const char *sym)
> >         return ERR_PTR(-ENOENT);
> >  }
> >  EXPORT_SYMBOL(kunit_find_symbol);
> > +
> > +MODULE_LICENSE("GPL");
> > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > index 1c1e9af..72fc8ed 100644
> > --- a/lib/kunit/try-catch.c
> > +++ b/lib/kunit/try-catch.c
> > @@ -31,6 +31,8 @@ static int kunit_generic_run_threadfn_adapter(void *data)
> >         complete_and_exit(try_catch->try_completion, 0);
> >  }
> >
> > +KUNIT_VAR_SYMBOL(sysctl_hung_task_timeout_secs, unsigned long);
> 
> Can you just export sysctl_hung_task_timeout_secs?
> 
> I don't mean to make you redo all this work for one symbol twice, but
> I thought we agreed on just exposing this symbol, but in a namespace.
> It seemed like a good use case for that namespaced exporting thing
> that Luis was talking about. As I understood it, you would have to
> export it in the module that defines it, and then use the new
> MODULE_IMPORT_NS() macro here.
>

Sure, I can certainly look into that, though I wonder if we should 
consider another possibility - should kunit have its own sysctl table for 
things like configuring timeouts? I can look at adding a patch for that 
prior to the module patch so the issues with exporting the hung task 
timeout would go away. Now the reason I suggest this isn't as much a hack 
to solve this specific problem, rather it seems to fit better with the 
longer-term intent expressed by the comment around use of the field (at 
least as I read it, I may be wrong).

Exporting the symbol does allow us to piggy-back on an existing value, but 
maybe we should support out our own tunable "kunit_timeout_secs" here?
Doing so would also lay the groundwork for supporting other kunit 
tunables in the future if needed. What do you think?

Many thanks for the review! I've got an updated patchset almost 
ready with the symbol lookup stuff removed; the above is the last issue 
outstanding from my side.

Thanks!

Alan

> > +
> >  static unsigned long kunit_test_timeout(void)
> >  {
> >         unsigned long timeout_msecs;
> > @@ -52,6 +54,7 @@ static unsigned long kunit_test_timeout(void)
> >          * For more background on this topic, see:
> >          * https://mike-bland.com/2011/11/01/small-medium-large.html
> >          */
> > +       KUNIT_INIT_VAR_SYMBOL(NULL, sysctl_hung_task_timeout_secs);
> >         if (sysctl_hung_task_timeout_secs) {
> >                 /*
> >                  * If sysctl_hung_task is active, just set the timeout to some
> > --
> > 1.8.3.1
> >
> 
