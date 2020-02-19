Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A741640E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 10:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBSJ5E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 04:57:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47672 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgBSJ5E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 04:57:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J9rCWD044660;
        Wed, 19 Feb 2020 09:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=D5hLOhK+GwF+BHLftwyGI3jpHA8NKMUvdykJgyA5MOk=;
 b=lf5ibYvDYUmPr2XOSNp0IjnjNNgWAjWMoEajAWWOzQ46+/7PKCrhlGkre4ZboWORXEOC
 P6AEGwWsLXC2L6ShAhBO9yzeIKS8eLfSyWieETMEi/+anXtqShzowgSUukB5mfJD0O5n
 kLyHH8rgbfOVOfd/LXqtJlsuGeVuQOa0PhCsUiAJZKGUlXxRiUGFkLF2Lssqk72MF2hB
 IM5RbJrQGBCjikIPW20PV8D7KCK6Y9XNHTkOVXGrE4hdw4UgDDBj+JbBkI/DYdZodzWu
 hclpGVwvMojLOc4dsdHlYeJFGB8jsiq9PSICNE+Pj/kOCT0BorX4tP6S/zkNqTIC3E4w Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y8udk9w4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 09:56:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J9pvBv133766;
        Wed, 19 Feb 2020 09:56:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y8ud4hmb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 09:56:30 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01J9uSNI015234;
        Wed, 19 Feb 2020 09:56:28 GMT
Received: from dhcp-10-175-189-86.vpn.oracle.com (/10.175.189.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 01:55:43 -0800
Date:   Wed, 19 Feb 2020 09:55:35 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-189-86.vpn.oracle.com
To:     Masami Hiramatsu <mhiramat@kernel.org>
cc:     Alan Maguire <alan.maguire@oracle.com>, rostedt@goodmis.org,
        shuah@kernel.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, colin.king@canonical.com
Subject: Re: [PATCH 2/2] ftrace/selftest: absence of modules/programs should
 trigger unsupported errors
In-Reply-To: <20200207175011.5312fcb9be04c83ec9eb548c@kernel.org>
Message-ID: <alpine.LRH.2.20.2002190937030.13023@dhcp-10-175-189-86.vpn.oracle.com>
References: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com> <1581001760-29831-3-git-send-email-alan.maguire@oracle.com> <20200207134316.54cfa16707e72e50cb320f8f@kernel.org> <alpine.LRH.2.20.2002070818310.21581@dhcp-10-175-186-149.vpn.oracle.com>
 <20200207175011.5312fcb9be04c83ec9eb548c@kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190073
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 7 Feb 2020, Masami Hiramatsu wrote:

> On Fri, 7 Feb 2020 08:27:13 +0000 (GMT)
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
> > On Fri, 7 Feb 2020, Masami Hiramatsu wrote:
> > 
> > > Hi Alan,
> > > 
> > > On Thu,  6 Feb 2020 15:09:20 +0000
> > > Alan Maguire <alan.maguire@oracle.com> wrote:
> > > 
> > > > In a number of cases, the ftrace tests check for the presence of
> > > > ftrace testing-related modules (ftrace-direct, trace-printk) and
> > > > programs (checkbashisms), returning exit_unresolved if these
> > > > are not found.  The problem is, exit_unresolved causes execution
> > > > of ftracetest to return an error, when really our tests are
> > > > failing due to not having the requisite kernel configuration/tools
> > > > present, which is I think more of an unsupported error condition.
> > > > With these fixed, we see no unresolved test cases and ftracetest
> > > > returns success ("ok" when run via kselftest).
> > > 
> > > If your problem is to pass the test even if you don't test the
> > > feature, please change the ftracetest itself instead of replacing
> > > unresolved with unsupported. Those notice different situation.
> > > 
> > > unresolved - Testcase can not find some tools or helper drivers
> > >              which are required for this testcase.
> > > 
> > > unsupported - Kernel does not have tested feature because of
> > >               the version or the configuration.
> > > 
> > > Obviously the unresolved is a test environment issue. No test-module
> > > doesn't mean no feature to be tested.
> > > Could you tell me the reason why you can't install those required
> > > tools and modules on the test environment?
> > > 
> > 
> > Sure! In my case, I'm testing a distro production kernel,
> > where I can't control the CONFIG variable settings.  In
> > this case, ideally I'd like the tests to return success
> > if no problems with ftrace were detected, even if some
> > of the tests could not be run due to missing modules
> > and programs.
> 
> OK, for modules, we need to find another way to solve the issue.
> But how about checkbashisms? you can download and build it.
> 
> https://sources.debian.org/src/devscripts/2.20.2/
>

Yep, I should have said that this one isn't a big issue, it's
also packaged in some distros in rpmdevtools.
 
> For the modules, you might be able to build it from kernel
> source code as out-of-tree modules, or not?
> (hmm, how do the other test handle it...?)
>

Ideally (from my perspective at least) the tests would
build the modules if needed, but I think the constraints
on kselftests are  that sometimes the kselftests are packaged
and  installed without the rest of the source tree, so I
_think_ given that the module source is in other parts of the
tree (that may not be present) we're probably stuck.  It'd be
great to have have a solution to this though, as I have a
feeling there may be more and more cases like this with the
growth of kunit.

Looks like the official way to do this sort of thing is
described in Documentation/dev-tools/kselftest.rst:

   # Assumes you have booted a fresh build of this kernel tree
   cd /path/to/linux/tree
   make kselftest-merge
   make modules
   sudo make modules_install
   make TARGETS=lib kselftest

It seems to merge existing config with the config files in the
kselftest dirs and rebuild modules; I'll give this a try.

I was hoping for a lightweight version of the above which
just builds the modules needed without rebuilding everything.

> >  As you suggest above (unless I'm
> > misunderstanding), this could be accomplished by modifying
> > ftracetest itself.  Would doing something like what is done
> > for UNSUPPORTED_RESULT (defaults to 0, but can be set to
> > 1 via --fail-unsupported, such that ftracetest returns
> > 1 if we encounter unsupported results) make sense for
> > the unresolved case too?
> 
> Yes, but at first could you try to setup your testing environment?
> If you are officially testing your distro kernel, the distro
> might need to be tested with full-set of testcases.
>

Absolutely! I'll see if I can convince the modules to
build using the above scheme.

Thanks for the review and advice!

Alan

> If not (like you are testing kernel for fun :)), you can just
> make your custom set of testcases. (just remove those test files)
> 
> Thank you,
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 
