Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65F1BE3D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Apr 2020 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2Q27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Apr 2020 12:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Q27 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Apr 2020 12:28:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1718620787;
        Wed, 29 Apr 2020 16:28:57 +0000 (UTC)
Date:   Wed, 29 Apr 2020 12:28:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, mingo@redhat.com,
        shuah@kernel.org, colin.king@canonical.com, mhiramat@kernel.org,
        yangx.jy@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: treat module requirement unmet
 situation as unsupported
Message-ID: <20200429122855.02594f33@gandalf.local.home>
In-Reply-To: <20200429095044.24625-1-po-hsu.lin@canonical.com>
References: <20200429095044.24625-1-po-hsu.lin@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 29 Apr 2020 17:50:44 +0800
Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:

> When the required module for the test does not exist, use
> exit_unsupported instead of exit_unresolved to indicate this test is
> not supported.
> 
> By doing this we can make test behaviour in sync with the
> irqsoff_tracer.tc test in preemptirq, which is also treating module
> existence in this way. Moreover, the test won't exit with a non-zero
> return value if the module does not exist.
> 
> Fixes: 646f01ccdd59 ("ftrace/selftest: Add tests to test register_ftrace_direct()")
> Fixes: 4d23e9b4fd2e ("selftests/ftrace: Add trace_printk sample module test")
> Fixes: 7bc026d6c032 ("selftests/ftrace: Add function filter on module testcase")
> Fixes: af2a0750f374 ("selftests/ftrace: Improve kprobe on module testcase to load/unload module")

I don't think this deserves the Fixes tags.

> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 2 +-
>  tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 2 +-
>  tools/testing/selftests/ftrace/test.d/event/trace_printk.tc    | 2 +-
>  tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc | 2 +-
>  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc  | 2 +-

I'm fine with these changes if Masami is. But it is Masami's call as his
infrastructure is more sensitive to the return calls than mine. I just run
the test and see what passes. I don't actually look at the return codes.

-- Steve


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

