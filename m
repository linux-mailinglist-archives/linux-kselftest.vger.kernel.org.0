Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD1519D632
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390894AbgDCL6l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 07:58:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47052 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390891AbgDCL6l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 07:58:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033BqkTx062593;
        Fri, 3 Apr 2020 11:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=EY7GLrgtSs1FHcvLOyhhBbPOTYU0IWoLz9crxErYRF4=;
 b=hW10NssBiNmiZRzAxjLDjm1HtFA8pzJyYZiZeplWQ+FW56J4Xl7T8UeKeG/1ZT98VS8s
 ZnKk3CNH4qHDGAkPY93s72v+wE1L1I5mK/91zv/iY3qs4SsQSuK7mB+/zg7hrz47FQQ3
 /5DT9ev0Zpx7arSACpo2wn331XfRm7OUS/369C/yxHsxNqxFZdDwaH8wj7RJGIQpG87j
 BTGin9mvu2e3ZD6I8q1dIcyro/jIoCrD3NkBZ4i3ncQJ8Gn+94XiMs4jpyEbWXXDJGmC
 hC76jwArUKRRCZ4RO9wtTE8HjHbXdnbsrZNn4f5mrZtvxEkhZIFHDq+FhDcl7ClHifoB Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 303aqj13wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 11:58:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033BwDCJ119036;
        Fri, 3 Apr 2020 11:58:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 302ga4gagp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 11:58:31 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033BwTrc000999;
        Fri, 3 Apr 2020 11:58:29 GMT
Received: from localhost.localdomain (/95.45.14.174)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 04:58:28 -0700
Date:   Fri, 3 Apr 2020 12:58:21 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Alan Maguire <alan.maguire@oracle.com>, shuah <shuah@kernel.org>,
        brendanhiggins@google.com, frowand.list@gmail.com,
        linux-kselftest@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 kunit-next 1/4] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
In-Reply-To: <20200402183839.GB3234477@kroah.com>
Message-ID: <alpine.LRH.2.21.2004031255450.5001@localhost>
References: <1585232710-322-1-git-send-email-alan.maguire@oracle.com> <1585232710-322-2-git-send-email-alan.maguire@oracle.com> <0d310181-a172-dec9-19aa-337ece9d7380@kernel.org> <alpine.LRH.2.21.2004021624400.21551@localhost>
 <20200402183839.GB3234477@kroah.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030104
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2 Apr 2020, Greg KH wrote:

> On Thu, Apr 02, 2020 at 04:27:35PM +0100, Alan Maguire wrote:
> > On Wed, 1 Apr 2020, shuah wrote:
> > 
> > > Hi Alan,
> > > 
> > > On 3/26/20 8:25 AM, Alan Maguire wrote:
> > > > add debugfs support for displaying kunit test suite results; this is
> > > > especially useful for module-loaded tests to allow disentangling of
> > > > test result display from other dmesg events.  debugfs support is
> > > > provided if CONFIG_KUNIT_DEBUGFS=y.
> > > > 
> > > > As well as printk()ing messages, we append them to a per-test log.
> > > > 
> > > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > > Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> > > > ---
> > > >   include/kunit/test.h   |  54 +++++++++++++++---
> > > >   lib/kunit/Kconfig      |   8 +++
> > > 
> > > Missing defaults for config options?
> > > 
> > > >   lib/kunit/Makefile     |   4 ++
> > > >   lib/kunit/debugfs.c    | 116 ++++++++++++++++++++++++++++++++++++++
> > > >   lib/kunit/debugfs.h    |  30 ++++++++++
> > > >   lib/kunit/kunit-test.c |   4 +-
> > > >   lib/kunit/test.c       | 147
> > > >   ++++++++++++++++++++++++++++++++++++++-----------
> > > >   7 files changed, 322 insertions(+), 41 deletions(-)
> > > >   create mode 100644 lib/kunit/debugfs.c
> > > >   create mode 100644 lib/kunit/debugfs.h
> > > > 
> > > 
> > > snip
> > > 
> > > > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > > > index 065aa16..95d12e3 100644
> > > > --- a/lib/kunit/Kconfig
> > > > +++ b/lib/kunit/Kconfig
> > > > @@ -14,6 +14,14 @@ menuconfig KUNIT
> > > >   
> > > >   if KUNIT
> > > >   
> > > > +config KUNIT_DEBUGFS
> > > > +	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
> > > > +	help
> > > > +	  Enable debugfs representation for kunit.  Currently this consists
> > > > +	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
> > > > +	  test suite, which allow users to see results of the last test suite
> > > > +	  run that occurred.
> > > > +
> > > 
> > > Any reason why there is default for this option?
> > > 
> > > Same for all other options. I am sending pull request for now without
> > > defaults. Would like to see this fixed for rc2.
> > >
> > 
> > Sure, I'll send a patch shortly. Just wanted to get opinions
> > on what those defaults should be; my working assumption is
> > 
> > - CONFIG_KUNIT should be default n; 
> 
> No default means 'n', so there's no need to say that at all.
> 

Great!

> > - CONFIG_KUNIT_DEBUGFS should be default y (enabled by default
> >   if CONFIG_KUNIT is set);
> 
> Why?  If it's is 'y', then don't even make it an option at all, just
> always have it :)
> 
> 'y' is almost always reserved for "your machine will not function
> properly without this enabled".
>

Okay, so in this case not having a default makes sense I think
(we added the option as saying 'n' avoids allocating per-test
loggging memory which might cause problems on low-memory systems).

> > - CONFIG_KUNIT_TEST, CONFIG_KUNIT_EXAMPLE_TEST should be default n
> 
> So no need to specify anything, 'n' is the default.
>

Excellent! So based on the above seems like we don't need
to add any defaults here I think.  Shuah/Brendan, let me know
if I'm missing anything here. Thanks!

Alan

> thanks,
> 
> greg k-h
> 
