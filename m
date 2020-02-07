Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1953D1553F7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2020 09:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgBGIuQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Feb 2020 03:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgBGIuQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Feb 2020 03:50:16 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B156214AF;
        Fri,  7 Feb 2020 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581065415;
        bh=VeDS/74WaXRN1rsKBHDdoMUd3DUMYXaQB/d1gb3IHUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UhvTau8yaOQZn6aM+8eYJvp7OVzLJkFW43mqCMPtk6XNyGwWSsEuinKCXAKAdTgub
         R93YHGL8vCIIcYN9TUMxmghnSdnGK9VzvReQBaoLOLmWcnboe9EDejSRCqqZran9q1
         nY35L2F+0Q1c0KIY+9FYc8Vzd1UcpsXkibbzCGZQ=
Date:   Fri, 7 Feb 2020 17:50:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     rostedt@goodmis.org, shuah@kernel.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, colin.king@canonical.com
Subject: Re: [PATCH 2/2] ftrace/selftest: absence of modules/programs should
 trigger unsupported errors
Message-Id: <20200207175011.5312fcb9be04c83ec9eb548c@kernel.org>
In-Reply-To: <alpine.LRH.2.20.2002070818310.21581@dhcp-10-175-186-149.vpn.oracle.com>
References: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com>
        <1581001760-29831-3-git-send-email-alan.maguire@oracle.com>
        <20200207134316.54cfa16707e72e50cb320f8f@kernel.org>
        <alpine.LRH.2.20.2002070818310.21581@dhcp-10-175-186-149.vpn.oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 7 Feb 2020 08:27:13 +0000 (GMT)
Alan Maguire <alan.maguire@oracle.com> wrote:

> On Fri, 7 Feb 2020, Masami Hiramatsu wrote:
> 
> > Hi Alan,
> > 
> > On Thu,  6 Feb 2020 15:09:20 +0000
> > Alan Maguire <alan.maguire@oracle.com> wrote:
> > 
> > > In a number of cases, the ftrace tests check for the presence of
> > > ftrace testing-related modules (ftrace-direct, trace-printk) and
> > > programs (checkbashisms), returning exit_unresolved if these
> > > are not found.  The problem is, exit_unresolved causes execution
> > > of ftracetest to return an error, when really our tests are
> > > failing due to not having the requisite kernel configuration/tools
> > > present, which is I think more of an unsupported error condition.
> > > With these fixed, we see no unresolved test cases and ftracetest
> > > returns success ("ok" when run via kselftest).
> > 
> > If your problem is to pass the test even if you don't test the
> > feature, please change the ftracetest itself instead of replacing
> > unresolved with unsupported. Those notice different situation.
> > 
> > unresolved - Testcase can not find some tools or helper drivers
> >              which are required for this testcase.
> > 
> > unsupported - Kernel does not have tested feature because of
> >               the version or the configuration.
> > 
> > Obviously the unresolved is a test environment issue. No test-module
> > doesn't mean no feature to be tested.
> > Could you tell me the reason why you can't install those required
> > tools and modules on the test environment?
> > 
> 
> Sure! In my case, I'm testing a distro production kernel,
> where I can't control the CONFIG variable settings.  In
> this case, ideally I'd like the tests to return success
> if no problems with ftrace were detected, even if some
> of the tests could not be run due to missing modules
> and programs.

OK, for modules, we need to find another way to solve the issue.
But how about checkbashisms? you can download and build it.

https://sources.debian.org/src/devscripts/2.20.2/

For the modules, you might be able to build it from kernel
source code as out-of-tree modules, or not?
(hmm, how do the other test handle it...?)

>  As you suggest above (unless I'm
> misunderstanding), this could be accomplished by modifying
> ftracetest itself.  Would doing something like what is done
> for UNSUPPORTED_RESULT (defaults to 0, but can be set to
> 1 via --fail-unsupported, such that ftracetest returns
> 1 if we encounter unsupported results) make sense for
> the unresolved case too?

Yes, but at first could you try to setup your testing environment?
If you are officially testing your distro kernel, the distro
might need to be tested with full-set of testcases.

If not (like you are testing kernel for fun :)), you can just
make your custom set of testcases. (just remove those test files)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
