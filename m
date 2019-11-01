Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDCB5EC2AF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2019 13:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfKAMan (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Nov 2019 08:30:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44128 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfKAMam (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Nov 2019 08:30:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1CT2SV029640;
        Fri, 1 Nov 2019 12:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=vwH+H5vdPVCLDFF7q/yE8iJeIEk7TaoKYEKRySZW4G8=;
 b=YSt34bQC5PEGhIi+jnBnEVl4kwrMnqNKNuhEZ795rp2D3TXeNCmoHiyWLgSQFHSjpAHc
 A01OmoAZ7zcjZbYENyf7PKnpasUyJPAxEJaUPb2r/W7yDKyrimGkbc/VWoEaEkx9Yax6
 yV91GmU9v8LMMCjF4bztB0g+psRwwYseDE52OSr8Sm26JZsnbnmcx3qpYaKsUePrdnda
 qOuu7r0XLRgeQaTIDF/k9xCyM8IHsCMYnDqst7nbKOcWCYQLOwp5mWxr/7ZFM26oy2yN
 qWtYt0FMuWCSNKlhIR9QThDQKpQ4aoO+N52XobpyQL738BE8YGhmFR9upnY74uuVkhul Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vxwhg1hjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 12:30:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1CTEi2038007;
        Fri, 1 Nov 2019 12:30:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vyqpg55ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 12:30:20 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA1CUG3q007065;
        Fri, 1 Nov 2019 12:30:17 GMT
Received: from dhcp-10-175-177-231.vpn.oracle.com (/10.175.177.231)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Nov 2019 05:30:16 -0700
Date:   Fri, 1 Nov 2019 12:30:08 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-177-231.vpn.oracle.com
To:     Brendan Higgins <brendanhiggins@google.com>
cc:     Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
In-Reply-To: <CAFd5g45V-iYaAhHwoaUPoPYUBud-5vxbBkApp-h5O6J8trnPRA@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1911011142160.15982@dhcp-10-175-177-231.vpn.oracle.com>
References: <20191018001816.94460-1-brendanhiggins@google.com> <20191018122949.GD11244@42.do-not-panic.com> <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com> <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com> <201910301205.74EC2A226D@keescook> <CAFd5g45V-iYaAhHwoaUPoPYUBud-5vxbBkApp-h5O6J8trnPRA@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911010125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911010125
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 31 Oct 2019, Brendan Higgins wrote:

> On Wed, Oct 30, 2019 at 12:09 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Oct 24, 2019 at 10:15:29AM +0000, Luis Chamberlain wrote:
> > > On Wed, Oct 23, 2019 at 05:42:18PM -0700, Brendan Higgins wrote:
> > > > With that, I think the best solution in this case will be the
> > > > "__visible_for_testing" route. It has no overhead when testing is
> > > > turned off (in fact it is no different in anyway when testing is
> > > > turned off). The downsides I see are:
> > > >
> > > > 1) You may not be able to test non-module code not compiled for
> > > > testing later with the test modules that Alan is working on (But the
> > > > only way I think that will work is by preventing the symbol from being
> > > > inlined, right?).
> > > >
> > > > 2) I think "__visible_for_testing" will be prone to abuse. Here, I
> > > > think there are reasons why we might want to expose these symbols for
> > > > testing, but not otherwise. Nevertheless, I think most symbols that
> > > > should be tested should probably be made visible by default. Since you
> > > > usually only want to test your public interfaces. I could very well
> > > > see this getting used as a kludge that gets used far too frequently.
> > >
> > > There are two parts to your statement on 2):
> > >
> > >   a) possible abuse of say __visible_for_testing
> >
> > I really don't like the idea of littering the kernel with these. It'll
> 
> Yeah, I kind of hope that it would make people think more
> intentionally about what is a public interface so that they wouldn't
> litter the kernel with those. But I agree that in the world where
> people *didn't* do that. Lots of these sprinkled around would be
> annoying.
> 
> > also require chunks in header files wrapped in #ifdefs. This is really
> 
> Why would it require header files wrapped in #ifdefs?
> 
> We could put all the ifdeffery logic in the __visible_for_testing
> macro so that nothing in the original code has to change except for
> adding an #include and replacing a couple of `static`s with
> `__visible_for_testing`.
> 

FWIW I think this approach, if used sparingly, is fine.  However I'd
propose a hierarchy of options when looking to expose interfaces for 
testing.

1. For small, largely self-contained functions, move their definitions 
from .c files to a .h file where those functions are defined as "static 
inline".  That way the original code and tests can included them and we 
have solved function availability for both the cases where the tests are 
built-in and compiled as a module.  The apparmor interfaces here seem to 
be candidates for that approach.

2. For more complex cases, __visible_for_testing (for built-in visbility)
and some sort of equivalent EXPORT_FOR_TESTING (for module 
visibility) would work, or the kunit_find_symbol() based lookup approach I 
suggested in the module patches.  Either of these allows for building 
tests as modules or builtin.

3. For some cases, module support will probably be impossible or difficult 
to maintain.  In such cases, builtin tests make most sense so any 
questions about symbol visibility would largely concern changing static 
definitions to be __visibile_for_testing, with no need for any symbol 
export for module visibility.


> > ugly.
> >
> > >   b) you typically only want to test your public interfaces
> >
> > True, but being able to test the little helper functions is a nice
> > starting point and a good building block.
> 
> Yeah, I think I have come to accept that. We can argue about how this
> should change and how people need to learn to be more intentional
> about which interfaces are public and many other high minded ideas,
> but when it comes down to it, we need to provide a starting point that
> is easy.
> 
> If our nice starting point becomes a problem, we can always improve it later.
> 
> > Why can't unit tests live with the code they're testing? They're already
> > logically tied together; what's the harm there? This needn't be the case
> > for ALL tests, etc. The test driver could still live externally. The
> > test in the other .c would just have exported functions... ?
> 
> Well, for one, it totally tanks certain cases for building KUnit tests
> as modules. I don't care about this point *too* much personally, but I
> accept that there are others that want this, and I don't want to make
> these people's lives too difficult.
>

Appreciated.  I think at this point it might be useful to lay out my 
thinking on why being able to build tests as modules may be helpful moving 
forward.

- First and foremost, if the functionality itself is predominantly 
delivered in module form, or indeed is simply tristate, having a way to 
test kernel code when built as a module seems to me to be necessary. To 
test module code with built-in test code seems broken, and even if it 
could be made to work we'd end up having to invent a bunch of the mechanisms
we'd need for building tests as modules anyway.

- Running tests on demand.  From previous discussions, I think this is 
wanted for kselftest, and if we have a set of modules with a conventional 
prefix (e.g. kunit-*), running tests becomes simply a "find + modprobe" in 
the kernel module tree.  Results could be harvested from debugfs (I have a 
WIP patch to store logging data in the per-test data structures such that 
"cat /sys/kernel/debug/kunit-results/kunit-foo" will display results for 
that test suite).  There are other ways to achieve this goal, and it's 
a crude method without any test selection beyond which modules are 
loaded, but this path is noticeably shorter to having a simple way to 
execute tests in a kselftest-friendly way I think. 

- Developing tests. I've also found this model to be neat for test 
development; add a test, build, load the module to test the test, add 
another test, build, unload/load etc. 

- The late_initcall() initialization of tests may not always be appropriate
for subsystems under test, and as the number of tests grow (a good 
problem to have!), it will likely become infeasible.

Anyway I'm not sure if any of the above resonates with others as being 
useful, but hopefully it clarifies why module support might matter moving 
forward.

If it makes sense, I can look at tweaking the module patchset to remove
the kunit_find_symbol() stuff so that we can punt on specific mechanisms 
for now; my main aim at this point is to ensure we're thinking about 
providing mechanisms for testing modules. 

Thanks!

Alan
