Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61E615855D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2020 23:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgBJWSF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 17:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgBJWSE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 17:18:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B5CE2072C;
        Mon, 10 Feb 2020 22:18:03 +0000 (UTC)
Date:   Mon, 10 Feb 2020 17:18:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>, shuah@kernel.org,
        mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        colin.king@canonical.com
Subject: Re: [PATCH 1/2] ftrace/selftests: workaround cgroup RT scheduling
 issues
Message-ID: <20200210171801.521e5faa@gandalf.local.home>
In-Reply-To: <20200207151456.4177c8974b779a45520b93d7@kernel.org>
References: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com>
        <1581001760-29831-2-git-send-email-alan.maguire@oracle.com>
        <20200207151456.4177c8974b779a45520b93d7@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 7 Feb 2020 15:14:56 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu,  6 Feb 2020 15:09:19 +0000
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
> > wakeup_rt.tc and wakeup.tc tests in tracers/ subdirectory
> > fail due to the chrt command returning:
> > 
> >  chrt: failed to set pid 0's policy: Operation not permitted.
> > 
> > To work around this, temporarily disable grout RT scheduling
> > during ftracetest execution.  Restore original value on
> > test run completion.  With these changes in place, both
> > tests consistently pass.  
> 
> OK, this looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks!
> 
> > 
> > Fixes: c575dea2c1a5 ("selftests/ftrace: Add wakeup_rt tracer testcase")
> > Fixes: c1edd060b413 ("selftests/ftrace: Add wakeup tracer testcase")
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  tools/testing/selftests/ftrace/ftracetest | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> > index 063ecb2..3207bbf 100755
> > --- a/tools/testing/selftests/ftrace/ftracetest
> > +++ b/tools/testing/selftests/ftrace/ftracetest
> > @@ -29,8 +29,26 @@ err_ret=1
> >  # kselftest skip code is 4
> >  err_skip=4
> >  
> > +# cgroup RT scheduling prevents chrt commands from succeeding, which
> > +# induces failures in test wakeup tests.  Disable for the duration of
> > +# the tests.
> > +sched_rt_runtime=$(sysctl -n kernel.sched_rt_runtime_us)  
> 
> OK, but can you 

??

Masami?

-- Steve

> 
> > +
> > +set_sysctl() {
> > +  sysctl -qw ${1}=${2} >/dev/null 2>&1
> > +}
> > +
