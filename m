Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C0541F8D3
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 02:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhJBA4P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Oct 2021 20:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhJBA4P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Oct 2021 20:56:15 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D39AC061775
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Oct 2021 17:54:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h1so5256460pfv.12
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Oct 2021 17:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dz4gCHHRlMiAuhNya+sXKLhxyvHziFcWxfMt2VtitXk=;
        b=Y40BfZx3kfEmj6oc4wP5edmnI0YKLH+C3ENpc7kzLwXGrrHiZdQziSHpXelsyAoY1w
         EtcmpmSl5Og9+N7Kt7sCR52juVA7j2786Emq6SUx3JGVk7WjOsHCOnC+UNUb6fF1tUtL
         j2q0xpeZiIAYBBE3uA8X2a8Xtq66TpgOi+Rmh91gVo6H/e8vcEoXwUgPagHW7RsQoici
         y+5SG1wYYDRFNNsRdUegMCWSc/jDIVQl7kUuPQETyQ865ASPAmsR481VN3MQGhEjM9se
         I0zpQ+u2q8nPqA5oz+GbtEe79Hw7pE/m3iE+GccEUSu+8ZIDjVHkEtM1Om00wlKTr4cv
         zSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dz4gCHHRlMiAuhNya+sXKLhxyvHziFcWxfMt2VtitXk=;
        b=Oe5MhgPm5ef3kanuesNnekciIjCC43Vi2ies71KbQMJaHffzXa47Pa9q6+j7eZReQa
         HgooLNfj/TgH+MQ9Qf7EEEQCHesIIxgLdzyon1pjGnBVVwpwnPQoXBxzuSgpi2XkMAV3
         FOzp6FKk/IvkVtCfkOMOQwcKdaeeU03nEWUG83LXbLNNYoY9xpPmXP1b+9cs+pLQfbov
         Y0ojUPQ03nwE3Hb8VAhhGMFUVlj15WIuqEtkG+sTyrD6v5WCa7a3G0cz08b9LC0S7oBQ
         bpssCz4yijaIuOW7u5bv6e1MidtWMX3QyjKF2D91uesfQwgJi2/cpRW/cWzrZbzOdXQE
         TtEQ==
X-Gm-Message-State: AOAM531mY/X19G/bIVwr7zY5mAG+yWdFtQaC2VPZXoMg4BPwn1YbkU9F
        ZdxzwQAo7P/vtycOAXkpAJsvZXl18ioaf1aASvUsHA==
X-Google-Smtp-Source: ABdhPJxoT43ANHvidEjUrlGXpA1JKWY6SOUCbiH6H03kpY+tlMRisQkFbKCxN1Bqckr4Ege0uDyW1EzA4erC5l+jEkM=
X-Received: by 2002:a63:f346:: with SMTP id t6mr822842pgj.345.1633136069808;
 Fri, 01 Oct 2021 17:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com>
 <CAC_TJvdv7sT-FmD1S-ZHnpAGvFR=1WBc6jEKBm+q5Wpp6S34PQ@mail.gmail.com> <CAM9d7ciQC1sV8hOOsgHVLxk7sze_Qp_dBqBkK_FrtVhZ0=AzZQ@mail.gmail.com>
In-Reply-To: <CAM9d7ciQC1sV8hOOsgHVLxk7sze_Qp_dBqBkK_FrtVhZ0=AzZQ@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 1 Oct 2021 17:54:18 -0700
Message-ID: <CAC_TJvdV-WD_ChfOkErQ7znjgMur1-ubAy_4k6R1sFCPZE=DTw@mail.gmail.com>
Subject: Re: [PATCH 0/5] tracing: Extend histogram triggers expression parsing
To:     Namhyung Kim <namhyung@kernel.org>
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

On Thu, Sep 30, 2021 at 3:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Kalesh,
>
> On Wed, Sep 15, 2021 at 1:09 PM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > On Wed, Sep 15, 2021 at 12:53 PM Kalesh Singh <kaleshsingh@google.com> wrote:
> > >
> > > The frequency of the rss_stat trace event is known to be of the same
> > > magnitude as that of the sched_switch event on Android devices. This can
> > > cause flooding of the trace buffer with rss_stat traces leading to a
> > > decreased trace buffer capacity and loss of data.
> > >
> > > If it is not necessary to monitor very small changes in rss (as is the
> > > case in Android) then the rss_stat tracepoint can be throttled to only
> > > emit the event once there is a large enough change in the rss size.
> > > The original patch that introduced the rss_stat tracepoint also proposed
> > > a fixed throttling mechanism that only emits the rss_stat event
> > > when the rss size crosses a 512KB boundary. It was concluded that more
> > > generic support for this type of filtering/throttling was need, so that
> > > it can be applied to any trace event. [1]
> > >
> > > From the discussion in [1], histogram triggers seemed the most likely
> > > candidate to support this type of throttling. For instance to achieve the
> > > same throttling as was proposed in [1]:
> > >
> > >   (1) Create a histogram variable to save the 512KB bucket of the rss size
> > >   (2) Use the onchange handler to generate a synthetic event when the
> > >       rss size bucket changes.
> > >
> > > The only missing pieces to support such a hist trigger are:
> > >   (1) Support for setting a hist variable to a specific value -- to set
> > >       the bucket size / granularity.
> > >   (2) Support for division arithmetic operation -- to determine the
> > >       corresponding bucket for an rss size.
> > >
> > > This series extends histogram trigger expressions to:
> > >   (1) Allow assigning numeric literals to hist variable (eg. x=1234)
> > >       and using literals directly in expressions (eg. x=size/1234)
> > >   (2) Support division and multiplication in hist expressions.
> > >       (eg. a=$x/$y*z); and
> > >   (3) Fixes expression parsing for non-associative operators: subtraction
> > >       and division. (eg. 8-4-2 should be 2 not 6)
> > >
> > > The rss_stat event can then be throttled using histogram triggers as
> > > below:
> > >
> > >   # Create a synthetic event to monitor instead of the high frequency
> > >   # rss_stat event
> > >   echo 'rss_stat_throttled unsigned int mm_id; unsigned int curr;
> > >          int member; long size' >> tracing/synthetic_events
> > >
> > >   # Create a hist trigger that emits the synthetic rss_stat_throttled
> > >   # event only when the rss size crosses a 512KB boundary.
> > >   echo 'hist:keys=common_pid:bucket=size/0x80000:onchange($bucket)
> > >               .rss_stat_throttled(mm_id,curr,member,size)'
> > >         >> events/kmem/rss_stat/trigger
> > >
> >
> > Sorry, I have a clerical mistake here. The above key should be:
> > s/keys=common_pid/keys=keys=mm_id,member
> >
> > The rss size is specific to the mm struct's member not the pid.
> > The results below were captured with the correct key so no changes there.
> >
> > >  ------ Test Results ------
> > > Histograms can also be used to evaluate the effectiveness of this
> > > throttling by noting the Total Hits on each trigger:
> > >
> > >   echo 'hist:keys=common_pid' >> events/sched/sched_switch/trigger
> > >   echo 'hist:keys=common_pid' >> events/kmem/rss_stat/trigger
> > >   echo 'hist:keys=common_pid'
> > >            >> events/synthetic/rss_stat_throttled/trigger
> > >
> > > Allowing the above example (512KB granularity) run for 5 minutes on
> > > an arm64 device with 5.10 kernel:
> > >
> > >    sched_switch      : total hits = 147153
> > >    rss_stat          : total hits =  38863
> > >    rss_stat_throttled: total hits =   2409
> > >
> > > The synthetic rss_stat_throttled event is ~16x less frequent than the
> > > rss_stat event when using a 512KB granularity.
> > >
> > >
> > > The results are more pronounced when rss size is changing at a higher
> > > rate in small increments. For instance the following results were obtained
> > > by recording the hits on the above events for a run of Android's
> > > lmkd_unit_test [2], which continually forks processes that map anonymous
> > > memory until there is an oom kill:
> > >
> > >    sched_switch      : total hits =  148832
> > >    rss_stat          : total hits = 4754802
> > >    rss_stat_throttled: total hits =   96214
> > >
> > > In this stress this, the  synthetic rss_stat_throttled event is ~50x less
> > > frequent than the rss_stat event when using a 512KB granularity.
> > >
> > >
> > > [1] https://lore.kernel.org/lkml/20190903200905.198642-1-joel@joelfernandes.org/
> > > [2] https://cs.android.com/android/platform/superproject/+/master:system/memory/lmkd/tests/lmkd_test.cpp
> > >
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the review Namhyung!

>
> Thanks,
> Namhyung
>
>
> > >
> > > Kalesh Singh (5):
> > >   tracing: Add support for creating hist trigger variables from literal
> > >   tracing: Add division and multiplication support for hist triggers
> > >   tracing: Fix operator precedence for hist triggers expression
> > >   tracing/selftests: Add tests for hist trigger expression parsing
> > >   tracing/histogram: Document expression arithmetic and constants
> > >
> > >  Documentation/trace/histogram.rst             |  14 +
> > >  kernel/trace/trace_events_hist.c              | 318 +++++++++++++++---
> > >  .../testing/selftests/ftrace/test.d/functions |   4 +-
> > >  .../trigger/trigger-hist-expressions.tc       |  73 ++++
> > >  4 files changed, 357 insertions(+), 52 deletions(-)
> > >  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> > >
> > >
> > > base-commit: 3ca706c189db861b2ca2019a0901b94050ca49d8
> > > --
> > > 2.33.0.309.g3052b89438-goog
> > >
