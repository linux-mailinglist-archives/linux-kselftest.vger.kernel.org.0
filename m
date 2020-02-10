Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 618AD1585C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2020 23:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJWxa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 17:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBJWx3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 17:53:29 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5A22051A;
        Mon, 10 Feb 2020 22:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581375209;
        bh=a8ChlAs1X2BTRLNb92AceNi3XKeTbTaJUZdnEPuWRLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uh6i/ttIKwArP26pBZNXA0Nrs9ryWsk2Lyy/53tD6LOnLg3H350CXiI7pJha12oa+
         VX9i+vC1atAMnDGk8YHQibuoAE8qavlN1YjC4VtCarx1t+5t1+wHZuHDS9x4CgD3S1
         UqbQDN8URkVvwHBr5IWJ4h1KuMqEC1Ctly/fanmE=
Date:   Tue, 11 Feb 2020 07:53:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>, shuah@kernel.org,
        mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        colin.king@canonical.com
Subject: Re: [PATCH 1/2] ftrace/selftests: workaround cgroup RT scheduling
 issues
Message-Id: <20200211075324.101aab59e06aaabaea648cc4@kernel.org>
In-Reply-To: <20200210171801.521e5faa@gandalf.local.home>
References: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com>
        <1581001760-29831-2-git-send-email-alan.maguire@oracle.com>
        <20200207151456.4177c8974b779a45520b93d7@kernel.org>
        <20200210171801.521e5faa@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 10 Feb 2020 17:18:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Feb 2020 15:14:56 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu,  6 Feb 2020 15:09:19 +0000
> > Alan Maguire <alan.maguire@oracle.com> wrote:
> > 
> > > wakeup_rt.tc and wakeup.tc tests in tracers/ subdirectory
> > > fail due to the chrt command returning:
> > > 
> > >  chrt: failed to set pid 0's policy: Operation not permitted.
> > > 
> > > To work around this, temporarily disable grout RT scheduling
> > > during ftracetest execution.  Restore original value on
> > > test run completion.  With these changes in place, both
> > > tests consistently pass.  
> > 
> > OK, this looks good to me.
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Thanks!
> > 
> > > 
> > > Fixes: c575dea2c1a5 ("selftests/ftrace: Add wakeup_rt tracer testcase")
> > > Fixes: c1edd060b413 ("selftests/ftrace: Add wakeup tracer testcase")
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > ---
> > >  tools/testing/selftests/ftrace/ftracetest | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> > > index 063ecb2..3207bbf 100755
> > > --- a/tools/testing/selftests/ftrace/ftracetest
> > > +++ b/tools/testing/selftests/ftrace/ftracetest
> > > @@ -29,8 +29,26 @@ err_ret=1
> > >  # kselftest skip code is 4
> > >  err_skip=4
> > >  
> > > +# cgroup RT scheduling prevents chrt commands from succeeding, which
> > > +# induces failures in test wakeup tests.  Disable for the duration of
> > > +# the tests.
> > > +sched_rt_runtime=$(sysctl -n kernel.sched_rt_runtime_us)  
> > 
> > OK, but can you 
> 
> ??
> 
> Masami?

Oops, I missed to fill the comment. I meant

"but can you consider to use /proc/sys directly instead of sysctl command,
because other test cases uses /proc/sys (ftrace/fgraph-filter-stack.tc and
ftrace/func_stack_tracer.tc)?"

Thank you,

> 
> -- Steve
> 
> > 
> > > +
> > > +set_sysctl() {
> > > +  sysctl -qw ${1}=${2} >/dev/null 2>&1
> > > +}
> > > +


-- 
Masami Hiramatsu <mhiramat@kernel.org>
