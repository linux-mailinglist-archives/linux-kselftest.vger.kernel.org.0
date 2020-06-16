Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED621FACE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgFPJks (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 05:40:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42412 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPJkr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 05:40:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05G9bma4018047;
        Tue, 16 Jun 2020 09:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=0k9VuDdTDWXk37fKxUhfT5zXgR3Jcl5X9ukJ/elWqSU=;
 b=IZbmgH1JhopTT6UpKIysdT7cL61M5dBliI2/Cgaj1xTVW5AHyHxw1OL1oB5MtAEqnJ9k
 lxYiz1cRaWZJ9ymXK/qNVaBTjWqS31qGEAh7amXyPnUd13sV8EA9fMmXP6spuZItahRU
 r1T/WYzVRENzUcKT6hmlMaiivC6WZJ11e+0QfexGtgryLqvwcS2a08FRjwhmLezF1JMZ
 OUk5ag3nP+feATyDlblaElJOHOIhJgY8kg1a1J/MXzPsvU1ADP02zj6FrgddQhUOcGJC
 9iT51qxVVHCnzhT2zMt7FGxSavh9NhsmJDxr2iNrk2KGflzMpI4DMSfaF2JDTN5NYRuW 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31p6s25r9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 09:40:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05G9d6F4149496;
        Tue, 16 Jun 2020 09:40:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31p6s6xj33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 09:40:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05G9eXn5008473;
        Tue, 16 Jun 2020 09:40:36 GMT
Received: from dhcp-10-175-214-123.vpn.oracle.com (/10.175.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 02:40:32 -0700
Date:   Tue, 16 Jun 2020 10:40:22 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     David Gow <davidgow@google.com>
cc:     Kees Cook <keescook@chromium.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: common KUnit Kconfig and file naming (was: Re: [PATCH] lib:
 kunit_test_overflow: add KUnit test of check_*_overflow functions)
In-Reply-To: <CABVgOSkPYBL8Qy9Fsr0owNhh2=tXZmdwCsWhnq+PshJLr06YKA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2006160956170.16027@localhost>
References: <20200611215501.213058-1-vitor@massaru.org> <202006121403.CF8D57C@keescook> <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com> <202006141005.BA19A9D3@keescook>
 <CABVgOSkPYBL8Qy9Fsr0owNhh2=tXZmdwCsWhnq+PshJLr06YKA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=3 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=3 spamscore=0 cotscore=-2147483648 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160071
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 16 Jun 2020, David Gow wrote:

> CONFIG_PM_QOS_KUNIT_TESTOn Mon, Jun 15, 2020 at 1:48 AM Kees Cook
> <keescook@chromium.org> wrote:
> >
> > On Sat, Jun 13, 2020 at 02:51:17PM +0800, David Gow wrote:
> > > Yeah, _KUNIT_TEST was what we've sort-of implicitly decided on for
> > > config names, but the documentation does need to happen.
> >
> > That works for me. It still feels redundant, but all I really want is a
> > standard name. :)
> >
> > > We haven't put as much thought into standardising the filenames much, though.
> >
> > I actually find this to be much more important because it is more
> > end-user-facing (i.e. in module naming, in build logs, in scripts, on
> > filesystem, etc -- CONFIG is basically only present during kernel build).
> > Trying to do any sorting or greping really needs a way to find all the
> > kunit pieces.
> >
> 
> Certainly this is more of an issue now we support building KUnit tests
> as modules, rather than having them always be built-in.
> 
> Having some halfway consistent config-name <-> filename <-> test suite
> name could be useful down the line, too. Unfortunately, not
> necessarily a 1:1 mapping, e.g.:
> - CONFIG_KUNIT_TEST compiles both kunit-test.c and string-stream-test.c
> - kunit-test.c has several test suites within it:
> kunit-try-catch-test, kunit-resource-test & kunit-log-test.
> - CONFIG_EXT4_KUNIT_TESTS currently only builds ext4-inode-test.c, but
> as the plural name suggests, might build others later.
> - CONFIG_SECURITY_APPARMOR_KUNIT_TEST doesn't actually have its own
> source file: the test is built into policy_unpack.c
> - &cetera
> 
> Indeed, this made me quickly look up the names of suites, and there
> are a few inconsistencies there:
> - most have "-test" as a suffix
> - some have "_test" as a suffix
> - some have no suffix
> 
> (I'm inclined to say that these don't need a suffix at all.)
> 

A good convention for module names - which I _think_ is along the lines
of what Kees is suggesting - might be something like

<subsystem>[_<optional_test-area>]_kunit.ko

So for example

kunit_test -> test_kunit.ko
string_stream_test.ko -> test_string_stream_kunit.ko
kunit_example_test -> example_kunit.ko
ext4_inode_test.ko -> ext4_inode_kunit.ko

For the kunit selftests, "selftest_" might be a better name
than "test_", as the latter might encourage people to reintroduce
a redundant "test" into their module name.  

> Within test suites, we're also largely prefixing all of the tests with
> a suite name (even if it's not actually the specified suite name). For
> example, CONFIG_PM_QOS_KUNIT_TEST builds
> drivers/base/power/qos-test.c which contains a suite called
> "qos-kunit-test", with tests prefixed "freq_qos_test_". Some of this
> clearly comes down to wanting to namespace things a bit more
> ("qos-test" as a name could refer to a few things, I imagine), but
> specifying how to do so consistently could help.
> 

Could we add some definitions to help standardize this?
For example, adding a "subsystem" field to "struct kunit_suite"?

So for the ext4 tests the "subsystem" would be "ext4" and the
name "inode" would specify the test area within that subsystem.
For the KUnit selftests, the subsystem would be "test"/"selftest".
Logging could utilize the subsystem definition to allow test
writers to use less redundant test names too.  For example
the suite name logged could be constructed from the
subsystem + area values associated with the kunit_suite,
and individual test names could be shown as the
suite area + test_name.

Thanks!

Alan
