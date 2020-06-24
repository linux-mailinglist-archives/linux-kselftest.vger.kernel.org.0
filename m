Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB61F206FA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgFXJE2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 05:04:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41800 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgFXJE1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 05:04:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O8ueHj171497;
        Wed, 24 Jun 2020 09:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=ZYQ2xCkDc27HNFzn89I9CQa/ymQsML6ht09SlJYJgJE=;
 b=t1xUB6mnXyrnfTu6YBtn1eobBVCaBWBiZPLUGGYC4VDjZvr1AP6tr3zuxQROYA0zXbxG
 z8GnBvbVb/wUEWlH9HZdVmuY4GoEG0x1glJ7xRYGzGdhahkkQsR5XZerFW3zU673dIXj
 wDkgcMOpdFTSbehO3PsKC2z7vvGsaO523XziDQAsa2AQl6+95Xjo4JDIWcrlZic5ycED
 z74P5zt0WLgBmgmYWrEb/2PSTKylC8AG0Ak1e+Un+g/1beAJ2RNUFA8wb5RiyAss9XG/
 VWt7dHBXHQpwvx+N8LRM/wCXtWFYuciiDYZl0DYwWVW95RGw51pWwFcGMRJQE5CdvNCo Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31uut5hrnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 09:04:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O93HHq066120;
        Wed, 24 Jun 2020 09:04:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31uurqgms8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 09:04:16 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05O94EIe006865;
        Wed, 24 Jun 2020 09:04:14 GMT
Received: from dhcp-10-175-205-73.vpn.oracle.com (/10.175.205.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 09:04:13 +0000
Date:   Wed, 24 Jun 2020 10:04:05 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     David Gow <davidgow@google.com>
cc:     Frank Rowand <frowand.list@gmail.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RFC: KTAP documentation - expected messages
In-Reply-To: <CABVgOSkwZUAEjxrqO46kqj=uY5HDzr-E_LR9i04yXEKqjp91Og@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2006240954590.25863@localhost>
References: <d38bf9f9-8a39-87a6-8ce7-d37e4a641675@gmail.com> <CABVgOSkwZUAEjxrqO46kqj=uY5HDzr-E_LR9i04yXEKqjp91Og@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 impostorscore=0 cotscore=-2147483648 priorityscore=1501
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006240066
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 23 Jun 2020, David Gow wrote:

> On Mon, Jun 22, 2020 at 6:45 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > Tim Bird started a thread [1] proposing that he document the selftest result
> > format used by Linux kernel tests.
> >
> > [1] https://lore.kernel.org/r/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com
> >
> > The issue of messages generated by the kernel being tested (that are not
> > messages directly created by the tests, but are instead triggered as a
> > side effect of the test) came up.  In this thread, I will call these
> > messages "expected messages".  Instead of sidetracking that thread with
> > a proposal to handle expected messages, I am starting this new thread.
> 
> Thanks for doing this: I think there are quite a few tests which could
> benefit from something like this.
> 
> I think there were actually two separate questions: what do we do with
> unexpected messages (most of which I expect are useless, but some of
> which may end up being related to an unexpected test failure), and how
> to have tests "expect" a particular message to appear. I'll stick to
> talking about the latter for this thread, but even there there's two
> possible interpretations of "expected messages" we probably want to
> explicitly distinguish between: a message which must be present for
> the test to pass (which I think best fits the "expected message"
> name), and a message which the test is likely to produce, but which
> shouldn't alter the result (an "ignored message"). I don't see much
> use for the latter at present, but if we wanted to do more things with
> messages and had some otherwise very verbose tests, it could
> potentially be useful.
> 
> The other thing I'd note here is that this proposal seems to be doing
> all of the actual message filtering in userspace, which makes a lot of
> sense for kselftest tests, but does mean that the kernel can't know if
> the test has passed or failed. There's definitely a tradeoff between
> trying to put too much needless string parsing in the kernel and
> having to have a userland tool determine the test results. The
> proposed KCSAN test suite[1] is using tracepoints to do this in the
> kernel. It's not the cleanest thing, but there's no reason KUnit or
> similar couldn't implement a nicer API around it.
> 
> [1]: https://lkml.org/lkml/2020/6/22/1506
>

For KTF the way we handled this was to use the APIs for catching
function entry and return (via kprobes), specifying printk as the
function to catch, and checking its argument string to verify
the expected message was seen. That allows you to verify
that messages appear in kernel testing context, but it's
not ideal as printk() has not yet filled in the arguments in
the buffer for display (there may be a better place to trace).
If it seems like it could be useful I  could have a go at 
porting the kprobe stuff to KUnit, as it helps expand the vocabulary 
for what can be tested in kernel context; for example we can 
also override return values for kernel functions to simulate errors.

Alan
