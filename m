Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB741E454
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 00:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhI3XAF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 19:00:05 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:40888 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348921AbhI3XAC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 19:00:02 -0400
Received: by mail-lf1-f46.google.com with SMTP id b15so31326655lfe.7;
        Thu, 30 Sep 2021 15:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyaNvh9Xs6AkDGl/pcn1sfY9JyqCtB/i0b3ibbUEjPU=;
        b=dWqMuUqkRrK6htRz3LMLeJzisXgwrZsCZuI7aS//dKPSNb9eFu4DVsqJr43k/XO3vG
         6lhHTMzGMaz/7lrReHe4o3eT1nk1WaadvzcRhwCM1FArnv0/IvfOd+u8vzm8sPXpDxCW
         2Wn66oXGiaFbZZiiElTmbzlg7T3VyTmKu2KAAESoWiBjo4tNIBhCHh3J59LNuTuZNYel
         IBMvm9nvEEXTjI/TmPNdWyUyJR2VJFKySIhcwhfE7BzLcxe91OetrEoLJNN8ye6BgzhE
         x5A3CF4ODdgkZw+jRea4dXLhMgujUyvf3ceB9cyNZCNHODvvkHCieD0HdBtZwFd5CLD1
         gFxQ==
X-Gm-Message-State: AOAM531czLgECHirXnN+SGI5xr+zcWz3XCbL7m4uZeWEiZoP4sGJF03+
        E5Iqg1aizKAQG9JLMUFzj6PJr8+BtXnHFjkqGnU=
X-Google-Smtp-Source: ABdhPJy5CVwrSpfRhPw00RtBuvbmvtiTNsnmpjnMCPQ6mTw1yTZs90kdBTwdZwETe3ArmExmBZzDAcGFyzLu0CyxgVI=
X-Received: by 2002:a2e:1609:: with SMTP id w9mr5346671ljd.90.1633042697541;
 Thu, 30 Sep 2021 15:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com> <CAC_TJvdv7sT-FmD1S-ZHnpAGvFR=1WBc6jEKBm+q5Wpp6S34PQ@mail.gmail.com>
In-Reply-To: <CAC_TJvdv7sT-FmD1S-ZHnpAGvFR=1WBc6jEKBm+q5Wpp6S34PQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 30 Sep 2021 15:58:06 -0700
Message-ID: <CAM9d7ciQC1sV8hOOsgHVLxk7sze_Qp_dBqBkK_FrtVhZ0=AzZQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] tracing: Extend histogram triggers expression parsing
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kalesh,

On Wed, Sep 15, 2021 at 1:09 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> On Wed, Sep 15, 2021 at 12:53 PM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > The frequency of the rss_stat trace event is known to be of the same
> > magnitude as that of the sched_switch event on Android devices. This can
> > cause flooding of the trace buffer with rss_stat traces leading to a
> > decreased trace buffer capacity and loss of data.
> >
> > If it is not necessary to monitor very small changes in rss (as is the
> > case in Android) then the rss_stat tracepoint can be throttled to only
> > emit the event once there is a large enough change in the rss size.
> > The original patch that introduced the rss_stat tracepoint also proposed
> > a fixed throttling mechanism that only emits the rss_stat event
> > when the rss size crosses a 512KB boundary. It was concluded that more
> > generic support for this type of filtering/throttling was need, so that
> > it can be applied to any trace event. [1]
> >
> > From the discussion in [1], histogram triggers seemed the most likely
> > candidate to support this type of throttling. For instance to achieve the
> > same throttling as was proposed in [1]:
> >
> >   (1) Create a histogram variable to save the 512KB bucket of the rss size
> >   (2) Use the onchange handler to generate a synthetic event when the
> >       rss size bucket changes.
> >
> > The only missing pieces to support such a hist trigger are:
> >   (1) Support for setting a hist variable to a specific value -- to set
> >       the bucket size / granularity.
> >   (2) Support for division arithmetic operation -- to determine the
> >       corresponding bucket for an rss size.
> >
> > This series extends histogram trigger expressions to:
> >   (1) Allow assigning numeric literals to hist variable (eg. x=1234)
> >       and using literals directly in expressions (eg. x=size/1234)
> >   (2) Support division and multiplication in hist expressions.
> >       (eg. a=$x/$y*z); and
> >   (3) Fixes expression parsing for non-associative operators: subtraction
> >       and division. (eg. 8-4-2 should be 2 not 6)
> >
> > The rss_stat event can then be throttled using histogram triggers as
> > below:
> >
> >   # Create a synthetic event to monitor instead of the high frequency
> >   # rss_stat event
> >   echo 'rss_stat_throttled unsigned int mm_id; unsigned int curr;
> >          int member; long size' >> tracing/synthetic_events
> >
> >   # Create a hist trigger that emits the synthetic rss_stat_throttled
> >   # event only when the rss size crosses a 512KB boundary.
> >   echo 'hist:keys=common_pid:bucket=size/0x80000:onchange($bucket)
> >               .rss_stat_throttled(mm_id,curr,member,size)'
> >         >> events/kmem/rss_stat/trigger
> >
>
> Sorry, I have a clerical mistake here. The above key should be:
> s/keys=common_pid/keys=keys=mm_id,member
>
> The rss size is specific to the mm struct's member not the pid.
> The results below were captured with the correct key so no changes there.
>
> >  ------ Test Results ------
> > Histograms can also be used to evaluate the effectiveness of this
> > throttling by noting the Total Hits on each trigger:
> >
> >   echo 'hist:keys=common_pid' >> events/sched/sched_switch/trigger
> >   echo 'hist:keys=common_pid' >> events/kmem/rss_stat/trigger
> >   echo 'hist:keys=common_pid'
> >            >> events/synthetic/rss_stat_throttled/trigger
> >
> > Allowing the above example (512KB granularity) run for 5 minutes on
> > an arm64 device with 5.10 kernel:
> >
> >    sched_switch      : total hits = 147153
> >    rss_stat          : total hits =  38863
> >    rss_stat_throttled: total hits =   2409
> >
> > The synthetic rss_stat_throttled event is ~16x less frequent than the
> > rss_stat event when using a 512KB granularity.
> >
> >
> > The results are more pronounced when rss size is changing at a higher
> > rate in small increments. For instance the following results were obtained
> > by recording the hits on the above events for a run of Android's
> > lmkd_unit_test [2], which continually forks processes that map anonymous
> > memory until there is an oom kill:
> >
> >    sched_switch      : total hits =  148832
> >    rss_stat          : total hits = 4754802
> >    rss_stat_throttled: total hits =   96214
> >
> > In this stress this, the  synthetic rss_stat_throttled event is ~50x less
> > frequent than the rss_stat event when using a 512KB granularity.
> >
> >
> > [1] https://lore.kernel.org/lkml/20190903200905.198642-1-joel@joelfernandes.org/
> > [2] https://cs.android.com/android/platform/superproject/+/master:system/memory/lmkd/tests/lmkd_test.cpp
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> >
> > Kalesh Singh (5):
> >   tracing: Add support for creating hist trigger variables from literal
> >   tracing: Add division and multiplication support for hist triggers
> >   tracing: Fix operator precedence for hist triggers expression
> >   tracing/selftests: Add tests for hist trigger expression parsing
> >   tracing/histogram: Document expression arithmetic and constants
> >
> >  Documentation/trace/histogram.rst             |  14 +
> >  kernel/trace/trace_events_hist.c              | 318 +++++++++++++++---
> >  .../testing/selftests/ftrace/test.d/functions |   4 +-
> >  .../trigger/trigger-hist-expressions.tc       |  73 ++++
> >  4 files changed, 357 insertions(+), 52 deletions(-)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> >
> >
> > base-commit: 3ca706c189db861b2ca2019a0901b94050ca49d8
> > --
> > 2.33.0.309.g3052b89438-goog
> >
