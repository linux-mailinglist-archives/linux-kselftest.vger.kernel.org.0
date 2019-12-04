Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D2112EC1
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 16:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfLDPmH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 10:42:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59640 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfLDPmG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 10:42:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FXeEH113462;
        Wed, 4 Dec 2019 15:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=KgsAba1FdT9OQZ+ZSq4w/XKsZDjEGA6oMyloCPN9eIU=;
 b=IyO4AiioCxPSvnIBR60Gx8+6/zbnxC3Nr0zZbI8gxtmQjaXg3QS831XlTqTLJ9eoRQhJ
 MiZvAkk9XjgI/wOUEnAbEUyivTvS0l6nuPv0a99wcxBuSWwjKfYVaXqsv8SUKnaQIojN
 KnUwKX9Y/WrvIHMablpjqMOv3X/BwIYO7BK3QAIk9bej1FOloQpk+YM9xlT2fRkYKOr6
 RvMSmRNHHnVJ/BmT4UFYPlsHVhaSYvuHwJSCR6Camsy30FE5IrTgEAssGlfqW8jnGy0g
 gwKYwkMO87BK6j7jmuADxmKKxlqc/j0HQGjc3cqb0tPUgVKS+DEVROn7IfcblYbwzYOu lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wkh2rf330-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:41:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FdIdo027892;
        Wed, 4 Dec 2019 15:41:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wp16b0b15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:41:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB4FfdM3023513;
        Wed, 4 Dec 2019 15:41:39 GMT
Received: from dhcp-10-175-179-22.vpn.oracle.com (/10.175.179.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 07:41:38 -0800
Date:   Wed, 4 Dec 2019 15:41:28 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-179-22.vpn.oracle.com
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
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
In-Reply-To: <20191204003851.GF86484@mit.edu>
Message-ID: <alpine.LRH.2.20.1912041531160.5511@dhcp-10-175-179-22.vpn.oracle.com>
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-4-git-send-email-alan.maguire@oracle.com> <CAFd5g47dRP9HvsZD3sqzzfbAthNq8gxEdh57owo3CqVHLNOf6w@mail.gmail.com> <20191204003851.GF86484@mit.edu>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040130
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 3 Dec 2019, Theodore Y. Ts'o wrote:

> On Tue, Dec 03, 2019 at 09:54:25AM -0800, Brendan Higgins wrote:
> > On Tue, Dec 3, 2019 at 4:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > As tests are added to kunit, it will become less feasible to execute
> > > all built tests together.  By supporting modular tests we provide
> > > a simple way to do selective execution on a running system; specifying
> > >
> > > CONFIG_KUNIT=y
> > > CONFIG_KUNIT_EXAMPLE_TEST=m
> > >
> > > ...means we can simply "insmod example-test.ko" to run the tests.
> > >
> > > To achieve this we need to do the following:
> > >
> > > o export the required symbols in kunit
> > > o string-stream tests utilize non-exported symbols so for now we skip
> > >   building them when CONFIG_KUNIT_TEST=m.
> > > o support a new way of declaring test suites.  Because a module cannot
> > >   do multiple late_initcall()s, we provide a kunit_test_suites() macro
> > >   to declare multiple suites within the same module at once.
> > > o some test module names would have been too general ("test-test"
> > >   and "example-test" for kunit tests, "inode-test" for ext4 tests);
> > >   rename these as appropriate ("kunit-test", "kunit-example-test"
> > >   and "ext4-inode-test" respectively).
> > >
> > > Co-developed-by: Knut Omang <knut.omang@oracle.com>
> > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > 
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Acked-by: Theodore Ts'o <tytso@mit.edu> # for ext4 bits
> 

Thanks for taking a look!

> 
> I do have one question, out of curiosity --- for people who aren't
> using UML to run Kunit tests, and are either running the kunit tests
> during boot, or when the module is loaded, is there the test framework
> to automatically extract the test reports out of dmesg?
> 
> I can boot a kernel with kunit tests enabled using kvm, and I see it
> splatted intermixed with the rest of the kernel boot messages.  This
> is how I tested the 32-bit ext4 inode test fix.  But I had to manually
> find the test output.  Is that the expected way people are supposed to
> be using Kunit tests w/o using UML and the python runner?
>

Looks like Brendan's got something coming to resolve this;
I've also got a patch that I was hoping to send out soon
that might help.  The idea is that each test suite would create
a debugfs representation under /sys/kernel/debug/kunit;
specifically:

/sys/kernel/debug/kunit/results/<suite>
/sys/kernel/debug/kunit/results/<suite>-tests

...where cat'ing the former shows the full set of results,
and the latter is a directory within which we can display
individual test results in test-case-specific files.

This is all done by ensuring that when tests log information,
they log to a per-test-case log buffer as well as to dmesg.

If the above sounds useful, I'll try and polish up the patch
for submission. Thanks!

Alan

> Thanks,
> 
> 						- Ted
> 
