Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76DE19C5DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 17:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbgDBP1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 11:27:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47426 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgDBP1t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 11:27:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032F9e4V135610;
        Thu, 2 Apr 2020 15:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=tKbW8WiccK8T9qHRo3CiDK1BXJGOvdvbe+/YRvvy+dM=;
 b=qx+gFGYu6+2AXwUgzfrSkhERelzTGHaMfE0CeJfjXOH1b77jO4UlYsyABPi1FvuXveXB
 a3eASmkKe5Kwu0mmpVa4c1RQnEpRuzPFAmJm1+U6lnhFlp1OQIdYZbtpKo2OmmZHQUrg
 ys0Lv2LfCeDePiiKsPKTpNv3c8jst+gg0UfkJaX/QyUDOO4nhkKTZGsoYGwfS/jYWUS6
 b6qQlt5CdCt4rKp1g1BEFuvOINWbfyQZPghwnCzEMjShbtYhBKHiMqOn/Q3Td6BFFPjx
 wgdr/ZWpkl+uh4g6O2O/HA9/MyvPSkDdIXEmGLNx+4Kdjlyu9w1B8Gs2Syjefu4NmL0F Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 303cevc5n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 15:27:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032F8UCl188474;
        Thu, 2 Apr 2020 15:27:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 302g4vqbbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 15:27:41 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 032FRe3U027186;
        Thu, 2 Apr 2020 15:27:40 GMT
Received: from localhost.localdomain (/95.45.14.174)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 08:27:39 -0700
Date:   Thu, 2 Apr 2020 16:27:35 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     shuah <shuah@kernel.org>
cc:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 kunit-next 1/4] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
In-Reply-To: <0d310181-a172-dec9-19aa-337ece9d7380@kernel.org>
Message-ID: <alpine.LRH.2.21.2004021624400.21551@localhost>
References: <1585232710-322-1-git-send-email-alan.maguire@oracle.com> <1585232710-322-2-git-send-email-alan.maguire@oracle.com> <0d310181-a172-dec9-19aa-337ece9d7380@kernel.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 1 Apr 2020, shuah wrote:

> Hi Alan,
> 
> On 3/26/20 8:25 AM, Alan Maguire wrote:
> > add debugfs support for displaying kunit test suite results; this is
> > especially useful for module-loaded tests to allow disentangling of
> > test result display from other dmesg events.  debugfs support is
> > provided if CONFIG_KUNIT_DEBUGFS=y.
> > 
> > As well as printk()ing messages, we append them to a per-test log.
> > 
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> > ---
> >   include/kunit/test.h   |  54 +++++++++++++++---
> >   lib/kunit/Kconfig      |   8 +++
> 
> Missing defaults for config options?
> 
> >   lib/kunit/Makefile     |   4 ++
> >   lib/kunit/debugfs.c    | 116 ++++++++++++++++++++++++++++++++++++++
> >   lib/kunit/debugfs.h    |  30 ++++++++++
> >   lib/kunit/kunit-test.c |   4 +-
> >   lib/kunit/test.c       | 147
> >   ++++++++++++++++++++++++++++++++++++++-----------
> >   7 files changed, 322 insertions(+), 41 deletions(-)
> >   create mode 100644 lib/kunit/debugfs.c
> >   create mode 100644 lib/kunit/debugfs.h
> > 
> 
> snip
> 
> > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > index 065aa16..95d12e3 100644
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -14,6 +14,14 @@ menuconfig KUNIT
> >   
> >   if KUNIT
> >   
> > +config KUNIT_DEBUGFS
> > +	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
> > +	help
> > +	  Enable debugfs representation for kunit.  Currently this consists
> > +	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
> > +	  test suite, which allow users to see results of the last test suite
> > +	  run that occurred.
> > +
> 
> Any reason why there is default for this option?
> 
> Same for all other options. I am sending pull request for now without
> defaults. Would like to see this fixed for rc2.
>

Sure, I'll send a patch shortly. Just wanted to get opinions
on what those defaults should be; my working assumption is

- CONFIG_KUNIT should be default n; 
- CONFIG_KUNIT_DEBUGFS should be default y (enabled by default
  if CONFIG_KUNIT is set);
- CONFIG_KUNIT_TEST, CONFIG_KUNIT_EXAMPLE_TEST should be default n

Does this sound right? Thanks!

Alan

> thanks,
> -- Shuah
> 
