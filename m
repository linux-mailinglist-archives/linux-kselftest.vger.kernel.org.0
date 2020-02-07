Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8EE155193
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2020 05:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGEnV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 23:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGEnV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 23:43:21 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F6222464;
        Fri,  7 Feb 2020 04:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581050600;
        bh=+3xB+sHsSQQfV04IaewdRRy2mUuiGKP7QHpWG0DL6h0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QkguPQrSwg0/EOT4N+UxMfL5BUr1KAgVIxlL076WSM8VvDFNSWAwihWA/Kdik+syD
         xRr37MuioyHtcGbxPpO9CVjhhuCHYYmVtnJycAaHtKXuERY4xvb+Y2eatu4MBoKyyu
         3azV2nXgOUI3Ya/gBz2TXTe1xqbZBwaI8VvKxPhc=
Date:   Fri, 7 Feb 2020 13:43:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     rostedt@goodmis.org, shuah@kernel.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, colin.king@canonical.com
Subject: Re: [PATCH 2/2] ftrace/selftest: absence of modules/programs should
 trigger unsupported errors
Message-Id: <20200207134316.54cfa16707e72e50cb320f8f@kernel.org>
In-Reply-To: <1581001760-29831-3-git-send-email-alan.maguire@oracle.com>
References: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com>
        <1581001760-29831-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alan,

On Thu,  6 Feb 2020 15:09:20 +0000
Alan Maguire <alan.maguire@oracle.com> wrote:

> In a number of cases, the ftrace tests check for the presence of
> ftrace testing-related modules (ftrace-direct, trace-printk) and
> programs (checkbashisms), returning exit_unresolved if these
> are not found.  The problem is, exit_unresolved causes execution
> of ftracetest to return an error, when really our tests are
> failing due to not having the requisite kernel configuration/tools
> present, which is I think more of an unsupported error condition.
> With these fixed, we see no unresolved test cases and ftracetest
> returns success ("ok" when run via kselftest).

If your problem is to pass the test even if you don't test the
feature, please change the ftracetest itself instead of replacing
unresolved with unsupported. Those notice different situation.

unresolved - Testcase can not find some tools or helper drivers
             which are required for this testcase.

unsupported - Kernel does not have tested feature because of
              the version or the configuration.

Obviously the unresolved is a test environment issue. No test-module
doesn't mean no feature to be tested.
Could you tell me the reason why you can't install those required
tools and modules on the test environment?

Thank you,



> 
> Fixes: 646f01ccdd59 ("ftrace/selftest: Add tests to test register_ftrace_direct()")
> Fixes: 4d23e9b4fd2e ("selftests/ftrace: Add trace_printk sample module test")
> Fixes: 7bc026d6c032 ("selftests/ftrace: Add function filter on module testcase")
> Fixes: ff431b1390cb ("selftests/ftrace: Add a test to probe module functions")
> Fixes: 4a075bd4e13f ("selftests/ftrace: Add checkbashisms meta-testcase")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 2 +-
>  tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 2 +-
>  tools/testing/selftests/ftrace/test.d/event/trace_printk.tc    | 2 +-
>  tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc | 2 +-
>  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc  | 2 +-
>  tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc     | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
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
> index 9330c87..fc22ac0 100644
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
> diff --git a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
> index 1b081e9..1b339bd 100644
> --- a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
> +++ b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
> @@ -9,7 +9,7 @@ fi
>  
>  if ! which checkbashisms > /dev/null 2>&1 ; then
>    echo "No checkbashisms found. skipped."
> -  exit_unresolved
> +  exit_unsupported
>  fi
>  
>  checkbashisms $FTRACETEST_ROOT/ftracetest
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
