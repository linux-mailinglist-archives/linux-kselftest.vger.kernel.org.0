Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99418108599
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 00:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfKXXgR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Nov 2019 18:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKXXgR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Nov 2019 18:36:17 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E6C020718;
        Sun, 24 Nov 2019 23:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574638577;
        bh=iB/Oa/iihBYoB1/ANEWB3bGeCJwRbX8FrKU/p3OELT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UAfY1kc2v+aEMuZ8aP2vsuT7x2DA3Zo/92UPhMeGlUr8PFhujUy81YxZHg2Hc4NIz
         1Ynm3RK2WcXGh1WV5rRakpmccNX+FhDGtiIffIHD3BVGAHIxdS2oomHjtCflg1haw1
         tvzoxIJjtE5u+PxxtxTHOxgqGALcNQFZj9V9428s=
Date:   Mon, 25 Nov 2019 08:36:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 2/3] selftests/ftrace: Fix ftrace test cases to
 check unsupported
Message-Id: <20191125083614.6f45d239c54c2df8601fa505@kernel.org>
In-Reply-To: <20191124163957.6ff9d4e4@oasis.local.home>
References: <157457133001.25666.5309062776021151107.stgit@devnote2>
        <157457134852.25666.7660419621672440723.stgit@devnote2>
        <20191124163957.6ff9d4e4@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 24 Nov 2019 16:39:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 24 Nov 2019 13:55:48 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since function tracer can be disabled, set_ftrace_filter can be
> > disappeared. The test cases must check whether the set_ftrace_filter
> > exists or not before testing and if not, return it as unsupported.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 ++
> >  .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    5 +++++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
> > index 36fb59f886ea..1a52f2883fe0 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
> > @@ -3,6 +3,8 @@
> >  # description: ftrace - stacktrace filter command
> >  # flags: instance
> >  
> > +[ ! -f set_ftrace_filter ] && exit_unsupported
> > +
> >  echo _do_fork:stacktrace >> set_ftrace_filter
> >  
> >  grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> > index 86a1f07ef2ca..7757b549f0b6 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> > @@ -15,6 +15,11 @@ if [ $NP -eq 1 ] ;then
> >    exit_unresolved
> >  fi
> >  
> > +if ! grep -q function available_tracers ; then
> > +  echo "Function trace is not enabled"
> > +  exit_unsupported
> > +fi
> 
> This change is not described in the change log.

Oops, my mistake. Thanks!

> 
> -- Steve
> 
> > +
> >  ORIG_CPUMASK=`cat tracing_cpumask`
> >  
> >  do_reset() {
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
