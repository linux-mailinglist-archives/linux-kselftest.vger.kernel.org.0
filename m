Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46FC1C0BDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 03:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEAB7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Apr 2020 21:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgEAB7h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Apr 2020 21:59:37 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CEB2073E;
        Fri,  1 May 2020 01:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588298376;
        bh=g2hwclVCUBczJZ9RWLHqpl8JeVGCkUqHYN4ogYSqJwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2EAjPKXw72MRxeIxrZAx/aV/4038w8R8FYfvEQ5h0y19vYAZT8IJ8/LnINGGB0aPH
         S0+OrCZgAV3TCtx9xnnrAdaiZLdQPBaC+ysdk5qrbiuj2tVij5JF0Sk/xOop/pEXmM
         JmiJccWFCRuT5MVa4lfHRZu1/xuWqo1L+vMfpMRc=
Date:   Fri, 1 May 2020 10:59:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, shuah@kernel.org, colin.king@canonical.com,
        mhiramat@kernel.org, yangx.jy@cn.fujitsu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: treat module requirement unmet
 situation as unsupported
Message-Id: <20200501105933.8ebf317da9be19884c7cd33e@kernel.org>
In-Reply-To: <20200429095044.24625-1-po-hsu.lin@canonical.com>
References: <20200429095044.24625-1-po-hsu.lin@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Wed, 29 Apr 2020 17:50:44 +0800
Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:

> When the required module for the test does not exist, use
> exit_unsupported instead of exit_unresolved to indicate this test is
> not supported.

Hmm, this doesn't mean "the function is not supported" but
"we can not resolve this because of the environmental issue".
For example, if you forgot to install the modules, but the
function itself is enabled, that can not be tested, but the
system supports that feature.

> 
> By doing this we can make test behaviour in sync with the
> irqsoff_tracer.tc test in preemptirq, which is also treating module
> existence in this way. Moreover, the test won't exit with a non-zero
> return value if the module does not exist.

It is OK to return zero even if the result is "unresolved", but
I don't want to change the result of each test cases, because
it clarify that you must install modules correctly, instead of
enabling the feature.

And OK, I found irqsoff_tracer.tc IS incorrect. It should be fixed to
return UNRESOLVED if there is no test module.

If you still think UNRESOLVED is unneeded, please propose the patch
which removes all UNRESOLVED related code. That can start another
discussion.

Thank you,


> 
> Fixes: 646f01ccdd59 ("ftrace/selftest: Add tests to test register_ftrace_direct()")
> Fixes: 4d23e9b4fd2e ("selftests/ftrace: Add trace_printk sample module test")
> Fixes: 7bc026d6c032 ("selftests/ftrace: Add function filter on module testcase")
> Fixes: af2a0750f374 ("selftests/ftrace: Improve kprobe on module testcase to load/unload module")
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 2 +-
>  tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 2 +-
>  tools/testing/selftests/ftrace/test.d/event/trace_printk.tc    | 2 +-
>  tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc | 2 +-
>  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> index d75a869..3d6189e 100644
> --- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> +++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> @@ -5,7 +5,7 @@
>  rmmod ftrace-direct ||:
>  if ! modprobe ftrace-direct ; then
>    echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
> -  exit_unresolved;
> +  exit_unsupported;
>  fi
>  
>  echo "Let the module run a little"
> diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> index 801ecb6..3d0e3ca 100644
> --- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> +++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> @@ -5,7 +5,7 @@
>  rmmod ftrace-direct ||:
>  if ! modprobe ftrace-direct ; then
>    echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"
> -  exit_unresolved;
> +  exit_unsupported;
>  fi
>  
>  if [ ! -f kprobe_events ]; then
> diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> index b02550b..dd8b10d 100644
> --- a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> +++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> @@ -5,7 +5,7 @@
>  rmmod trace-printk ||:
>  if ! modprobe trace-printk ; then
>    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
> -  exit_unresolved;
> +  exit_unsupported;
>  fi
>  
>  echo "Waiting for irq work"
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> index 1a4b4a4..26dc06a 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> @@ -13,7 +13,7 @@ echo '*:mod:trace_printk' > set_ftrace_filter
>  if ! modprobe trace-printk ; then
>    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
>  m"
> -  exit_unresolved;
> +  exit_unsupported;
>  fi
>  
>  : "Wildcard should be resolved after loading module"
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> index d861bd7..4e07c69 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> @@ -8,7 +8,7 @@ rmmod trace-printk ||:
>  if ! modprobe trace-printk ; then
>    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
>  m"
> -  exit_unresolved;
> +  exit_unsupported;
>  fi
>  
>  MOD=trace_printk
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
