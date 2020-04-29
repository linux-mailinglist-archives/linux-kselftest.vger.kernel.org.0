Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A231BDA9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Apr 2020 13:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD2L3o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Apr 2020 07:29:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32553 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726743AbgD2L3o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Apr 2020 07:29:44 -0400
X-IronPort-AV: E=Sophos;i="5.73,331,1583164800"; 
   d="scan'208";a="90776150"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Apr 2020 19:29:39 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 3E3D14BCC883;
        Wed, 29 Apr 2020 19:29:38 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 29 Apr 2020 19:29:38 +0800
Message-ID: <5EA96520.3070200@cn.fujitsu.com>
Date:   Wed, 29 Apr 2020 19:29:36 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
CC:     <linux-kselftest@vger.kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <shuah@kernel.org>, <colin.king@canonical.com>,
        <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: treat module requirement unmet situation
 as unsupported
References: <20200429095044.24625-1-po-hsu.lin@canonical.com>
In-Reply-To: <20200429095044.24625-1-po-hsu.lin@canonical.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 3E3D14BCC883.AE6E6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Lin,

It looks fine to me.
Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks,
Xiao Yang
On 2020/4/29 17:50, Po-Hsu Lin wrote:
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
> Signed-off-by: Po-Hsu Lin<po-hsu.lin@canonical.com>
> ---
>   tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 2 +-
>   tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 2 +-
>   tools/testing/selftests/ftrace/test.d/event/trace_printk.tc    | 2 +-
>   tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc | 2 +-
>   tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc  | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> index d75a869..3d6189e 100644
> --- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> +++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> @@ -5,7 +5,7 @@
>   rmmod ftrace-direct ||:
>   if ! modprobe ftrace-direct ; then
>     echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
> -  exit_unresolved;
> +  exit_unsupported;
>   fi
> 
>   echo "Let the module run a little"
> diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> index 801ecb6..3d0e3ca 100644
> --- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> +++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> @@ -5,7 +5,7 @@
>   rmmod ftrace-direct ||:
>   if ! modprobe ftrace-direct ; then
>     echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"
> -  exit_unresolved;
> +  exit_unsupported;
>   fi
> 
>   if [ ! -f kprobe_events ]; then
> diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> index b02550b..dd8b10d 100644
> --- a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> +++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> @@ -5,7 +5,7 @@
>   rmmod trace-printk ||:
>   if ! modprobe trace-printk ; then
>     echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
> -  exit_unresolved;
> +  exit_unsupported;
>   fi
> 
>   echo "Waiting for irq work"
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> index 1a4b4a4..26dc06a 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> @@ -13,7 +13,7 @@ echo '*:mod:trace_printk'>  set_ftrace_filter
>   if ! modprobe trace-printk ; then
>     echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
>   m"
> -  exit_unresolved;
> +  exit_unsupported;
>   fi
> 
>   : "Wildcard should be resolved after loading module"
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> index d861bd7..4e07c69 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> @@ -8,7 +8,7 @@ rmmod trace-printk ||:
>   if ! modprobe trace-printk ; then
>     echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
>   m"
> -  exit_unresolved;
> +  exit_unsupported;
>   fi
> 
>   MOD=trace_printk



