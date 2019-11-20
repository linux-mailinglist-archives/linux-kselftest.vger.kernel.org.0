Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7633103CB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 14:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfKTN53 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Nov 2019 08:57:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53840 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfKTN52 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Nov 2019 08:57:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKDsQCo145409;
        Wed, 20 Nov 2019 13:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=V/DFRPYzZOalGnsH/AEEGn8n7Gic4vXnO/GK2SB+TOg=;
 b=IeSv2+O3ui/2wSCpPrho1PV53YzwyB2YAQgyhfMZIBjm0nGKzPyyX0LihDMcUh0intIK
 x7YYGCP4psTF+42oxtrzaie5/S5pHp/jMWZCk6jlqezLOwPltRbGEkLalkL8AgLVBKrU
 hrHwt9mQe2yKeUOuA7lxQUMedNgcSLcFjKvn8vSbnWECJMUsuz0E4T3Rz1ripER4DZwa
 CPHwRvn9xWM2sM/FDv6+eNWdsvfGsZUBkDbNwc4XK8joYaZQOwi7aYKVA8D/12SulvAq
 6Msd4Hs1IWi3ACmWNkkv1AhjWVUneXZHF2PPr2Ggws6wuixhgru4kmRhyru6Nk4ESnds yA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htwpu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 13:57:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKDrYqn104080;
        Wed, 20 Nov 2019 13:57:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2wd46wf44t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 13:57:05 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAKDv2kK028577;
        Wed, 20 Nov 2019 13:57:02 GMT
Received: from dhcp-10-175-162-125.vpn.oracle.com (/10.175.162.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Nov 2019 05:57:02 -0800
Date:   Wed, 20 Nov 2019 13:56:52 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-162-125.vpn.oracle.com
To:     Brendan Higgins <brendanhiggins@google.com>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-ext4@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v4 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
In-Reply-To: <CAFd5g473rHeUk6EJ_KnvRin5LrKyW4cNQxNHXmT2zkai5V=q1w@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1911201347190.19458@dhcp-10-175-162-125.vpn.oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com> <1573812972-10529-4-git-send-email-alan.maguire@oracle.com> <CAFd5g473rHeUk6EJ_KnvRin5LrKyW4cNQxNHXmT2zkai5V=q1w@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200125
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Nov 2019, Brendan Higgins wrote:

> On Fri, Nov 15, 2019 at 2:16 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > As tests are added to kunit, it will become less feasible to execute
> > all built tests together.  By supporting modular tests we provide
> > a simple way to do selective execution on a running system; specifying
> >
> > CONFIG_KUNIT=y
> > CONFIG_KUNIT_EXAMPLE_TEST=m
> >
> > ...means we can simply "insmod example-test.ko" to run the tests.
> >
> > To achieve this we need to do the following:
> >
> > o export the required symbols in kunit
> > o string-stream tests utilize non-exported symbols so for now we skip
> >   building them when CONFIG_KUNIT_TEST=m.
> > o support a new way of declaring test suites.  Because a module cannot
> >   do multiple late_initcall()s, we provide a kunit_test_suites() macro
> >   to declare multiple suites within the same module at once.
> > o some test module names would have been too general ("test-test"
> >   and "example-test" for kunit tests, "inode-test" for ext4 tests);
> >   rename these as appropriate ("kunit-test", "kunit-example-test"
> >   and "ext4-inode-test" respectively).
> 
> Hmm...should we maybe apply this naming scheme to all the tests then?
> I think Kees might have suggested this. I am actually not sure whether
> or not we should and would like to get other people's input.
> 

I'd be interested in other opinions here too; the approach I took here was 
to apply the convention [subsystem]-[optional-suite]-test.ko. So for 
example kunit-test.ko because the subsystem under test is kunit, etc.
Implicit in this is the reasoning that the framework used isn't relevant 
to the naming of the test module, but I'm happy to tweak the naming 
scheme if another approach is preferred.  The current names from the 
patchset are:

kunit-test.ko		- tests for kunit itself
kunit-example-test.ko	- example test using the kunit framework
sysctl-test.ko		- sysctl kunit tests
list-test.ko		- list kunit tests
ext4-inode-test.ko	- ext4 kunit tests
 
> It is a valid point that test-test or example-test are too general of
> names for modules, but if this is the case, I think that inode-test is
> probably too general as well. But if we are going that far, maybe we
> should rename everything *-kunit-test.c.
> 

Yep, I figured inode-test.ko was too general also, so the Makefile 
builds ext4-inode-test.ko from inode-test.c. See fs/ext4/Makefile.

Thanks!

Alan
