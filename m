Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3953C115187
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2019 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLFNys (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Dec 2019 08:54:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59360 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfLFNyr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Dec 2019 08:54:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6DsLMA189904;
        Fri, 6 Dec 2019 13:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=mnbDjzi+t8U359ofhgGJEJTb4vIsS6/RiU9IOJRnczw=;
 b=fQpEoIR3DU8LApVJVbMF+hPqXvUW+V9cbqH516L2mmSa6bW3kp8BByYh0G3ogenxXe8S
 x7XuDELaCdpb6emkhLYihYZM/rG+eDe3vSaXt/X3lLo3CFXul4jxwEeHqdWEUoVDQPpz
 LX4zdgcQdBUqJ1A+QU74pHtlU/Eo7U+inIsjcULS1xpmKy4t4UujGFGXXPlMIqEAz8f6
 4ZX4stfp6rC7Tfprfm1WOuO8IDyKYoXZ+T/thEZG0xaCvBpy7LiZ57nlljkbB0Gm0cOT
 drZ3npH4TE5udLGxxLcDIVBqQUTFQ8CVSATdLnPJHLvUqFexGRA20r4344Jp/dwDep9q JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wkh2rv513-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 13:54:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6Ds686156099;
        Fri, 6 Dec 2019 13:54:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wqerahcpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 13:54:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB6DrqtH013467;
        Fri, 6 Dec 2019 13:53:52 GMT
Received: from dhcp-10-175-208-120.vpn.oracle.com (/10.175.208.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Dec 2019 05:53:51 -0800
Date:   Fri, 6 Dec 2019 13:53:38 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-208-120.vpn.oracle.com
To:     Iurii Zaikin <yzaikin@google.com>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
In-Reply-To: <CAAXuY3qekjWBUTxzAjCs+87nVXpigvzqm7TpG7MtJagTSG-xtg@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1912061349001.28856@dhcp-10-175-208-120.vpn.oracle.com>
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-4-git-send-email-alan.maguire@oracle.com> <CAFd5g47dRP9HvsZD3sqzzfbAthNq8gxEdh57owo3CqVHLNOf6w@mail.gmail.com> <20191204003851.GF86484@mit.edu>
 <alpine.LRH.2.20.1912041531160.5511@dhcp-10-175-179-22.vpn.oracle.com> <CAAXuY3qekjWBUTxzAjCs+87nVXpigvzqm7TpG7MtJagTSG-xtg@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912060120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912060120
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Wed, 4 Dec 2019, Iurii Zaikin wrote:

> > I've also got a patch that I was hoping to send out soon
> > that might help.  The idea is that each test suite would create
> > a debugfs representation under /sys/kernel/debug/kunit;
> > specifically:
> >
> > /sys/kernel/debug/kunit/results/<suite>
> > /sys/kernel/debug/kunit/results/<suite>-tests
> >
> > ...where cat'ing the former shows the full set of results,
> > and the latter is a directory within which we can display
> > individual test results in test-case-specific files.
> >
> > This is all done by ensuring that when tests log information,
> > they log to a per-test-case log buffer as well as to dmesg.
> >
> > If the above sounds useful, I'll try and polish up the patch
> > for submission. Thanks!
> What would be the best way for kunit_tool to:
> 1. Know that the tests have completed as QEMU will be just sitting
> there with kernel complaining about the absence of init (or running
> whatever we give it as init)?
> 2. Read the test results from debugfs under QEMU virtual machine while
> the kernel is still there?
> I think supplying an init script/binary that copies the
> /sys/kernel/debug/kunit/results/* to a 9p shared dir set up by
> kunit_tool would work but it would add a step of cross-compiling and
> packaging a userspace binary.
> 

I confess I'd only been thinking about supporting the case of a user 
modprobe-ing a kunit test suite module directly and wanting a clean set 
of results separated from other dmesg output. However the scheme you 
describe does seem workable for the UML case also.  With the 
late_initcalls the builtin kunit suites will likely run early in boot but perhaps we could tweak the 
semantics such that the full results debugfs file is not populated until 
the tests have run to simplify script-based probing. I'll try some 
experiments with the debugfs patch once it's ready. Thanks!

Alan 

