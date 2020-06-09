Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C11F435C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 19:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbgFIRwo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 13:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732920AbgFIRwh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 13:52:37 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E8F207ED;
        Tue,  9 Jun 2020 17:52:36 +0000 (UTC)
Date:   Tue, 9 Jun 2020 13:52:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tools: testing: ftrace: trigger: fix spelling
 mistake
Message-ID: <20200609135235.608cdbf6@oasis.local.home>
In-Reply-To: <20200609163853.1602-1-f.suligoi@asem.it>
References: <20200609163853.1602-1-f.suligoi@asem.it>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 9 Jun 2020 18:38:53 +0200
Flavio Suligoi <f.suligoi@asem.it> wrote:

> Fix typo: "tigger" --> "trigger"

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Shuah, want to take this patch?

-- Steve

> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc   | 2 +-
>  .../selftests/ftrace/test.d/trigger/trigger-stacktrace.tc       | 2 +-
>  .../ftrace/test.d/trigger/trigger-trace-marker-hist.tc          | 2 +-
>  .../ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc      | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
> index 177e8d4c4744..bf6374e1f6ae 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
> @@ -23,7 +23,7 @@ if [ ! -f events/sched/sched_process_fork/hist ]; then
>      exit_unsupported
>  fi
>  
> -echo "Test histogram basic tigger"
> +echo "Test histogram basic trigger"
>  
>  echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
>  for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
> index 398c05c4d2a7..6248e6b40704 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
> @@ -23,7 +23,7 @@ if [ -z "$FEATURE" ]; then
>      exit_unsupported
>  fi
>  
> -echo "Test stacktrace tigger"
> +echo "Test stacktrace trigger"
>  echo 0 > trace
>  echo 0 > options/stacktrace
>  echo 'stacktrace' > events/sched/sched_process_fork/trigger
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> index ab6bedb25736..01fdfd50b4be 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> @@ -28,7 +28,7 @@ if [ ! -f events/ftrace/print/hist ]; then
>      exit_unsupported
>  fi
>  
> -echo "Test histogram trace_marker tigger"
> +echo "Test histogram trace_marker trigger"
>  
>  echo 'hist:keys=common_pid' > events/ftrace/print/trigger
>  for i in `seq 1 10` ; do echo "hello" > trace_marker; done
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
> index df246e505af7..a7fef298e476 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
> @@ -46,7 +46,7 @@ test_trace() {
>      done
>  }
>  
> -echo "Test snapshot trace_marker tigger"
> +echo "Test snapshot trace_marker trigger"
>  
>  echo 'snapshot' > events/ftrace/print/trigger
>  

