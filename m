Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6B2297A2F
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Oct 2020 03:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759114AbgJXBbC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 21:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758421AbgJXBbC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 21:31:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3605924248;
        Sat, 24 Oct 2020 01:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603503077;
        bh=3bvdQpcDajIOAP+NZa60PaBpOWVSUIRRs73iCB/PJYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VJUuzDMyLzhSfjNDGnzhTiRlYAJygQ/WpGw+lktpMqgGFJ4vREbf0tzwRqvCNARyX
         RTQjhCmSQ2v7r0dRb4dSrUAZ3NHGoLu+81ygMn80B2WQYanEcxkOeuZd4blB8xwuxH
         85GJL0KHhX2ffLQk/i048N6ieHn/9Z5XM8wAgnVo=
Date:   Sat, 24 Oct 2020 10:31:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: remove _do_fork() leftovers
Message-Id: <20201024103112.64372203e6729279e9ef92f5@kernel.org>
In-Reply-To: <20201023093523.65c495f8@gandalf.local.home>
References: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
        <20201023093523.65c495f8@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 23 Oct 2020 09:35:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 23 Oct 2020 10:52:03 +0200
> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> > index acb17ce..0ddb948 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> > @@ -39,7 +39,7 @@ do_test() {
> >      disable_tracing
> >  
> >      echo do_execve* > set_ftrace_filter
> > -    echo *do_fork >> set_ftrace_filter
> > +    echo kernel_clone >> set_ftrace_filter
> >  
> >      echo $PID > set_ftrace_notrace_pid
> >      echo function > current_tracer
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> > index 9f0a968..71319b3 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> > @@ -39,7 +39,7 @@ do_test() {
> >      disable_tracing
> >  
> >      echo do_execve* > set_ftrace_filter
> > -    echo *do_fork >> set_ftrace_filter
> > +    echo kernel_clone >> set_ftrace_filter
> >  
> >      echo $PID > set_ftrace_pid
> >      echo function > current_tracer
> 
> The issue I have with this, is that I run these tests on older kernels too,
> and tests that use to work on older kernels should still work. In fact,
> this fails on the kernel I'm currently adding new changes to!
> 
> Perhaps we should have:
> 
> 	# older kernels have do_fork, but newer kernels have kernel_clone
> 	echo kernel_clone >> set_ftrace_filter || echo *do_fork >> set_ftrace_filter

Good catch. BTW, can we check the filter-bility by grep the pattern from set_ftrace_filter?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
