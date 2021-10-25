Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8943A4BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 22:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhJYUeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhJYUeW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 16:34:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FD1C061348
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:31:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u12so5133406pjy.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=HJmGycFGoUFY0YYPO0NfXp79t1BMUVQFPsPn0hSQHBU=;
        b=FZhJzTVN33R/nuZDmu2Bmpq97DpPu7KV4CGl6RBBLzUBLHLpOdUSHAG9ei44KqogyG
         lHsXn4pv/Iqd1TxhomrIc5JjBuEtNHiz52fC/Aa+C9tzlPaj8/CZbvs1oVTs249SwUXi
         0yAWyY/PY/5GJXFEMMNizwXzSwei7UxhAxM7RQfr2cPmmufNwY5IpWPI6SViWXrLgnlz
         iu+9eJpmLkuunqa6ugD336gkEfHEvL6/qu2BLDKAvkXazoawblH//+tXnTfNt+6oOaVs
         9SjTvdLhyKeCgp4hGqv7dEopJd8Jdbvs3JbR4eAYGhPN76z2qEZv01CgWjHgGFiuvpJl
         gdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=HJmGycFGoUFY0YYPO0NfXp79t1BMUVQFPsPn0hSQHBU=;
        b=HqviKjRuMy+bZ5uHR6mhgCkkuhLp2b2gvG9SjCRLiWz8znDJeTNcsOGX6CM5Q4J4bN
         bQc7TYICtXHUrxoaQjshiyKzRuTN5DwrGnaNBCsOurJZCu4mi3kbTu0R/hAu05XYREJy
         z4afc4OLEMY3LwTB8BORu3OlaGLXzwENdaomzkXBElTyCGuGkVQuL2A+TodNdLKLNJ/3
         gfaHJlaRiFVY5+wNa2PZCWqxGK9DeabaSDPb8pI9fPzlTE4eEBJ/gjmE/VF+RZkJ24R8
         X+tFJFAV2IwvnKSihZ3vn9GoFOfwGrlHJaAYMQsxewMx/8J/6uoZ00UJMhpHCIExVMfq
         Z6DQ==
X-Gm-Message-State: AOAM5309BTccT8SMtqWo+gFT9QBbNLGaG1ITxpuPIDYKX9hn/YONiB6k
        yRnQLoN8F67gr1N1uzC1WaoD6lj4RC0/MKyr4/NkQg==
X-Received: by 2002:a17:90a:b288:: with SMTP id c8mt14525269pjr.67.1635193918881;
 Mon, 25 Oct 2021 13:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192330.2992076-1-kaleshsingh@google.com>
In-Reply-To: <20211025192330.2992076-1-kaleshsingh@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 25 Oct 2021 13:31:48 -0700
Message-ID: <CAC_TJvd01w9AE5FvJPQFfXL93QPrELJqih=70jJLrBryPQmqhw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] tracing: Extend histogram triggers expression parsing
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 25, 2021 at 12:23 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Hi all,
>
> The v3 of the extending histogram exprssions series. The previous versions

I accidentally left some Change-Id tags in this version. Please ignore
this. v4 is posted at:
https://lore.kernel.org/r/20211025200852.3002369-1-kaleshsingh@google.com/

Thanks,
Kalesh

> were posted at:
>
> v2: https://lore.kernel.org/r/20211020013153.4106001-1-kaleshsingh@google.com/
> v1: https://lore.kernel.org/r/20210915195306.612966-1-kaleshsingh@google.com/
>
> Patches 4 through 6 are new and adds some optimizations/improvements
> suggested by Steven Rostedt.
>
> The cover letter is copied below for convenience.
>
> Thanks,
> Kalesh
>
> ---
>
> The frequency of the rss_stat trace event is known to be of the same
> magnitude as that of the sched_switch event on Android devices. This can
> cause flooding of the trace buffer with rss_stat traces leading to a
> decreased trace buffer capacity and loss of data.
>
> If it is not necessary to monitor very small changes in rss (as is the
> case in Android) then the rss_stat tracepoint can be throttled to only
> emit the event once there is a large enough change in the rss size.
> The original patch that introduced the rss_stat tracepoint also proposed
> a fixed throttling mechanism that only emits the rss_stat event
> when the rss size crosses a 512KB boundary. It was concluded that more
> generic support for this type of filtering/throttling was need, so that
> it can be applied to any trace event. [1]
>
> From the discussion in [1], histogram triggers seemed the most likely
> candidate to support this type of throttling. For instance to achieve the
> same throttling as was proposed in [1]:
>
>   (1) Create a histogram variable to save the 512KB bucket of the rss size
>   (2) Use the onchange handler to generate a synthetic event when the
>       rss size bucket changes.
>
> The only missing pieces to support such a hist trigger are:
>   (1) Support for setting a hist variable to a specific value -- to set
>       the bucket size / granularity.
>   (2) Support for division arithmetic operation -- to determine the
>       corresponding bucket for an rss size.
>
> This series extends histogram trigger expressions to:
>   (1) Allow assigning numeric literals to hist variable (eg. x=1234)
>       and using literals directly in expressions (eg. x=size/1234)
>   (2) Support division and multiplication in hist expressions.
>       (eg. a=$x/$y*z); and
>   (3) Fixes expression parsing for non-associative operators: subtraction
>       and division. (eg. 8-4-2 should be 2 not 6)
>
> The rss_stat event can then be throttled using histogram triggers as
> below:
>
>   # Create a synthetic event to monitor instead of the high frequency
>   # rss_stat event
>   echo 'rss_stat_throttled unsigned int mm_id; unsigned int curr;
>          int member; long size' >> tracing/synthetic_events
>
>   # Create a hist trigger that emits the synthetic rss_stat_throttled
>   # event only when the rss size crosses a 512KB boundary.
>   echo 'hist:keys=mm_id,member:bucket=size/0x80000:onchange($bucket)
>               .rss_stat_throttled(mm_id,curr,member,size)'
>         >> events/kmem/rss_stat/trigger
>
>  ------ Test Results ------
> Histograms can also be used to evaluate the effectiveness of this
> throttling by noting the Total Hits on each trigger:
>
>   echo 'hist:keys=common_pid' >> events/sched/sched_switch/trigger
>   echo 'hist:keys=common_pid' >> events/kmem/rss_stat/trigger
>   echo 'hist:keys=common_pid'
>            >> events/synthetic/rss_stat_throttled/trigger
>
> Allowing the above example (512KB granularity) run for 5 minutes on
> an arm64 device with 5.10 kernel:
>
>    sched_switch      : total hits = 147153
>    rss_stat          : total hits =  38863
>    rss_stat_throttled: total hits =   2409
>
> The synthetic rss_stat_throttled event is ~16x less frequent than the
> rss_stat event when using a 512KB granularity.
>
>
> The results are more pronounced when rss size is changing at a higher
> rate in small increments. For instance the following results were obtained
> by recording the hits on the above events for a run of Android's
> lmkd_unit_test [2], which continually forks processes that map anonymous
> memory until there is an oom kill:
>
>    sched_switch      : total hits =  148832
>    rss_stat          : total hits = 4754802
>    rss_stat_throttled: total hits =   96214
>
> In this stress test, the synthetic rss_stat_throttled event is ~50x less
> frequent than the rss_stat event when using a 512KB granularity.
>
> [1] https://lore.kernel.org/lkml/20190903200905.198642-1-joel@joelfernandes.org/
> [2] https://cs.android.com/android/platform/superproject/+/master:system/memory/lmkd/tests/lmkd_test.cpp
>
>
> Kalesh Singh (8):
>   tracing: Add support for creating hist trigger variables from literal
>   tracing: Add division and multiplication support for hist triggers
>   tracing: Fix operator precedence for hist triggers expression
>   tracing/histogram: Simplify handling of .sym-offset in expressions
>   tracing/histogram: Covert expr to const if both operands are constants
>   tracing/histogram: Optimize division by a power of 2
>   tracing/selftests: Add tests for hist trigger expression parsing
>   tracing/histogram: Document expression arithmetic and constants
>
>  Documentation/trace/histogram.rst             |  14 +
>  kernel/trace/trace_events_hist.c              | 400 ++++++++++++++----
>  .../testing/selftests/ftrace/test.d/functions |   4 +-
>  .../trigger/trigger-hist-expressions.tc       |  72 ++++
>  4 files changed, 412 insertions(+), 78 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
>
>
> base-commit: ac8a6eba2a117e0fdc04da62ab568d1b7ca4c8f6
> --
> 2.33.0.1079.g6e70778dc9-goog
>
