Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6FC1C82C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 08:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgEGGpY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 02:45:24 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27832 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725914AbgEGGpX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 02:45:23 -0400
X-IronPort-AV: E=Sophos;i="5.73,362,1583164800"; 
   d="scan'208";a="91512021"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 May 2020 14:45:18 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 071414BCC8A6;
        Thu,  7 May 2020 14:45:18 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 7 May 2020 14:45:17 +0800
Message-ID: <5EB3AE7C.5@cn.fujitsu.com>
Date:   Thu, 7 May 2020 14:45:16 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
References: <158834025077.28357.15141584656220094821.stgit@devnote2> <158834028054.28357.398159034694277189.stgit@devnote2>
In-Reply-To: <158834028054.28357.398159034694277189.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 071414BCC8A6.AFDAF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020/5/1 21:38, Masami Hiramatsu wrote:
> Since the built-in echo has different behavior in POSIX shell
> (dash) and bash, we forcibly use /bin/echo -E (not interpret
> backslash escapes) by default.
>
> This also fixes some test cases which expects built-in
> echo command.
>
> Reported-by: Liu Yiding<yidingx.liu@intel.com>
> Signed-off-by: Masami Hiramatsu<mhiramat@kernel.org>
> ---
>   tools/testing/selftests/ftrace/test.d/functions    |    3 +++
>   .../test.d/trigger/trigger-trace-marker-hist.tc    |    2 +-
>   .../trigger-trace-marker-synthetic-kernel.tc       |    4 ++++
>   .../trigger/trigger-trace-marker-synthetic.tc      |    4 ++--
>   4 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 5d4550591ff9..ea59b6ea2c3e 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -1,3 +1,6 @@
> +# Since the built-in echo has different behavior in POSIX shell (dash) and
> +# bash, we forcibly use /bin/echo -E (not interpret backslash escapes).
> +alias echo="/bin/echo -E"
Hi Masami, Steven

It seems that only kprobe_syntax_errors.tc is impacted by the issue 
currently.  Is it necessary for all tests to use /bin/echo and could we 
just make kprobe_syntax_errors.tc use /bin/echo?

Best Regards,
Xiao Yang

>
>   clear_trace() { # reset trace output
>       echo>  trace
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> index ab6bedb25736..b3f70f53ee69 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> @@ -30,7 +30,7 @@ fi
>
>   echo "Test histogram trace_marker tigger"
>
> -echo 'hist:keys=common_pid'>  events/ftrace/print/trigger
> +echo 'hist:keys=ip'>  events/ftrace/print/trigger
>   for i in `seq 1 10` ; do echo "hello">  trace_marker; done
>   grep 'hitcount: *10$' events/ftrace/print/hist>  /dev/null || \
>       fail "hist trigger did not trigger correct times on trace_marker"
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> index 18b4d1c2807e..c1625d945f4d 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> @@ -44,6 +44,10 @@ echo 'latency u64 lat'>  synthetic_events
>   echo 'hist:keys=pid:ts0=common_timestamp.usecs'>  events/sched/sched_waking/trigger
>   echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat)'>  events/ftrace/print/trigger
>   echo 'hist:keys=common_pid,lat:sort=lat'>  events/synthetic/latency/trigger
> +
> +# We have to use the built-in echo here because waking up pid must be same
> +# as echoing pid.
> +alias echo=echo
>   sleep 1
>   echo "hello">  trace_marker
>
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> index dd262d6d0db6..23e52c8d71de 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> @@ -36,8 +36,8 @@ fi
>   echo "Test histogram trace_marker to trace_marker latency histogram trigger"
>
>   echo 'latency u64 lat'>  synthetic_events
> -echo 'hist:keys=common_pid:ts0=common_timestamp.usecs if buf == "start"'>  events/ftrace/print/trigger
> -echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"'>>  events/ftrace/print/trigger
> +echo 'hist:keys=ip:ts0=common_timestamp.usecs if buf == "start"'>  events/ftrace/print/trigger
> +echo 'hist:keys=ip:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"'>>  events/ftrace/print/trigger
>   echo 'hist:keys=common_pid,lat:sort=lat'>  events/synthetic/latency/trigger
>   echo -n "start">  trace_marker
>   echo -n "end">  trace_marker
>
>
>
> .
>



