Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1D11928BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 13:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgCYMm6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 08:42:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51710 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgCYMm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 08:42:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PCdUAM052990;
        Wed, 25 Mar 2020 12:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=4CxQcsvrlZYbDGdz/Ttr6KfahZweiekg6E11FnAAvqQ=;
 b=uk1q+G09jPjs/Xk0XW9zqaw5RKL8v9liO+PN/isnJJAvmqlwJeuzWLdeNdbKib3e+mmO
 L7LX4yKvvkLumMwzcBqMQQsFo5DfEJKlHwTjETBuRLEfz6O+eHkUfRcOoZL1/rN1PgY2
 TZihFYkzEPRuZQTKYRp08Cqx1mkDSd//FEaAhiEdEGsTD+bbo2kBNmwfxt+Dw5CG1o8t
 dyuEFEwRn3XWvLVtDxgsT+AAwrCQ6Rf3vsrPSNyKkXaiYW/uUdGl9UtXK8eOSVhmdp/m
 lFXlfYtIW6nfwVO65+IRRxNSwK1rQeK5YREWN/BWkhlAwNtC+JwLSveakxxHnQBywlCl nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ywavm9dj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 12:42:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PCfbXI165088;
        Wed, 25 Mar 2020 12:42:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3003ghnayj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 12:42:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PCgh08017482;
        Wed, 25 Mar 2020 12:42:43 GMT
Received: from dhcp-10-175-163-133.vpn.oracle.com (/10.175.163.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 05:42:43 -0700
Date:   Wed, 25 Mar 2020 12:42:36 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Patricia Alfonso <trishalfonso@google.com>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/3] Add KUnit Struct to Current Task
In-Reply-To: <CAKFsvULUx3qi_kMGJx69ndzCgq=m2xf4XWrYRYBCViud0P7qqA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2003251242200.9650@localhost>
References: <20200319164227.87419-1-trishalfonso@google.com> <20200319164227.87419-2-trishalfonso@google.com> <alpine.LRH.2.21.2003241635230.30637@localhost> <CAKFsvULUx3qi_kMGJx69ndzCgq=m2xf4XWrYRYBCViud0P7qqA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=3 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250105
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Tue, 24 Mar 2020, Patricia Alfonso wrote:

> On Tue, Mar 24, 2020 at 9:40 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> >
> > On Thu, 19 Mar 2020, Patricia Alfonso wrote:
> >
> > > In order to integrate debugging tools like KASAN into the KUnit
> > > framework, add KUnit struct to the current task to keep track of the
> > > current KUnit test.
> > >
> > > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > > ---
> > >  include/linux/sched.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 04278493bf15..1fbfa0634776 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1180,6 +1180,10 @@ struct task_struct {
> > >       unsigned int                    kasan_depth;
> > >  #endif
> > >
> > > +#if IS_BUILTIN(CONFIG_KUNIT)
> >
> > This patch set looks great! You might have noticed I
> > refreshed the kunit resources stuff to incorporate
> > feedback from Brendan, but I don't think any API changes
> > were made that should have consequences for your code
> > (I'm building with your patches on top to make sure).
> > I'd suggest promoting from RFC to v3 on the next round
> > unless anyone objects.
> >
> > As Dmitry suggested, the above could likely be changed to be
> > "#ifdef CONFIG_KUNIT" as kunit can be built as a
> > module also. More on this in patch 2..
> >
> I suppose this could be changed so that this can be used in possible
> future scenarios, but for now, since built-in things can't rely on
> modules, the KASAN integration relies on KUnit being built-in.
>

I think we can get around that. I've tried tweaking the resources
patchset such that the functions you need in KASAN (which
is builtin) are declared as "static inline" in include/kunit/test.h;
doing this allows us to build kunit and test_kasan as a
module while supporting the builtin functionality required to
retrieve and use kunit resources within KASAN itself.  

The impact of this amounts to a few functions, but it would
require a rebase of your changes. I'll send out a  v3 of the
resources patches shortly; I just want to do some additional
testing on them. I can also send you the modified versions of
your patches that I used to test with.

With these changes I can run the tests on baremetal
x86_64 by modprobe'ing test_kasan. However I see a few failures:

[   87.577012]  # kasan_memchr: EXPECTATION FAILED at lib/test_kasan.c:509
        Expected kasan_data->report_expected == kasan_data->report_found, 
but
                kasan_data->report_expected == 1
                kasan_data->report_found == 0
[   87.577104]  not ok 30 - kasan_memchr
[   87.603823]  # kasan_memcmp: EXPECTATION FAILED at lib/test_kasan.c:523
        Expected kasan_data->report_expected == kasan_data->report_found, 
but
                kasan_data->report_expected == 1
                kasan_data->report_found == 0
[   87.603929]  not ok 31 - kasan_memcmp
[   87.630644]  # kasan_strings: EXPECTATION FAILED at 
lib/test_kasan.c:544
        Expected kasan_data->report_expected == kasan_data->report_found, 
but
                kasan_data->report_expected == 1
                kasan_data->report_found == 0
[   87.630910]  # kasan_strings: EXPECTATION FAILED at 
lib/test_kasan.c:546
        Expected kasan_data->report_expected == kasan_data->report_found, 
but
                kasan_data->report_expected == 1
                kasan_data->report_found == 0
[   87.654037]  # kasan_strings: EXPECTATION FAILED at 
lib/test_kasan.c:548
        Expected kasan_data->report_expected == kasan_data->report_found, 
but
                kasan_data->report_expected == 1
                kasan_data->report_found == 0
[   87.677179]  # kasan_strings: EXPECTATION FAILED at 
lib/test_kasan.c:550
        Expected kasan_data->report_expected == kasan_data->report_found, 
but
                kasan_data->report_expected == 1
                kasan_data->report_found == 0
[   87.700242]  # kasan_strings: EXPECTATION FAILED at 
lib/test_kasan.c:552
        Expected kasan_data->report_expected == kasan_data->report_found, 
but
                kasan_data->report_expected == 1
                kasan_data->report_found == 0
[   87.723336]  # kasan_strings: EXPECTATION FAILED at 
lib/test_kasan.c:554
        Expected kasan_data->report_expected == kasan_data->report_found, 
but
                kasan_data->report_expected == 1
                kasan_data->report_found == 0
[   87.746304]  not ok 32 - kasan_strings

The above three tests consistently fail while everything
else passes, and happen irrespective of whether kunit
is built as a module or built-in.  Let me know if you 
need any more info to debug (I built the kernel with
CONFIG_SLUB=y if that matters).

Thanks!

Alan


> > > +     struct kunit                    *kunit_test;
> > > +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> > > +
> > >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > >       /* Index of current stored address in ret_stack: */
> > >       int                             curr_ret_stack;
> > > --
> > > 2.25.1.696.g5e7596f4ac-goog
> > >
> > >
> 
> -- 
> Best,
> Patricia
> 
