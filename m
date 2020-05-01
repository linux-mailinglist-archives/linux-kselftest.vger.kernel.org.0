Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252201C1790
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 16:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgEAOTq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 10:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbgEAOTp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 10:19:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199BE20757;
        Fri,  1 May 2020 14:19:44 +0000 (UTC)
Date:   Fri, 1 May 2020 10:19:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
Message-ID: <20200501101942.5c0da986@gandalf.local.home>
In-Reply-To: <158834028054.28357.398159034694277189.stgit@devnote2>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834028054.28357.398159034694277189.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri,  1 May 2020 22:38:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since the built-in echo has different behavior in POSIX shell
> (dash) and bash, we forcibly use /bin/echo -E (not interpret
> backslash escapes) by default.
> 
> This also fixes some test cases which expects built-in
> echo command.
> 
> Reported-by: Liu Yiding <yidingx.liu@intel.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/ftrace/test.d/functions    |    3 +++
>  .../test.d/trigger/trigger-trace-marker-hist.tc    |    2 +-
>  .../trigger-trace-marker-synthetic-kernel.tc       |    4 ++++
>  .../trigger/trigger-trace-marker-synthetic.tc      |    4 ++--
>  4 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 5d4550591ff9..ea59b6ea2c3e 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -1,3 +1,6 @@
> +# Since the built-in echo has different behavior in POSIX shell (dash) and
> +# bash, we forcibly use /bin/echo -E (not interpret backslash escapes).
> +alias echo="/bin/echo -E"
>  
>  clear_trace() { # reset trace output
>      echo > trace
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> index ab6bedb25736..b3f70f53ee69 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> @@ -30,7 +30,7 @@ fi
>  
>  echo "Test histogram trace_marker tigger"
>  
> -echo 'hist:keys=common_pid' > events/ftrace/print/trigger
> +echo 'hist:keys=ip' > events/ftrace/print/trigger

This is doing more than just changing the echo being used. It's changing
the test being done.

>  for i in `seq 1 10` ; do echo "hello" > trace_marker; done
>  grep 'hitcount: *10$' events/ftrace/print/hist > /dev/null || \
>      fail "hist trigger did not trigger correct times on trace_marker"
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> index 18b4d1c2807e..c1625d945f4d 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> @@ -44,6 +44,10 @@ echo 'latency u64 lat' > synthetic_events
>  echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
>  echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat)' > events/ftrace/print/trigger
>  echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
> +
> +# We have to use the built-in echo here because waking up pid must be same
> +# as echoing pid.
> +alias echo=echo
>  sleep 1
>  echo "hello" > trace_marker
>  
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> index dd262d6d0db6..23e52c8d71de 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> @@ -36,8 +36,8 @@ fi
>  echo "Test histogram trace_marker to trace_marker latency histogram trigger"
>  
>  echo 'latency u64 lat' > synthetic_events
> -echo 'hist:keys=common_pid:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
> -echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger
> +echo 'hist:keys=ip:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
> +echo 'hist:keys=ip:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger

This too. And it's not explained in the change log why. In fact, these
changes look like they belong in a separate patch.

-- Steve

>  echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
>  echo -n "start" > trace_marker
>  echo -n "end" > trace_marker

