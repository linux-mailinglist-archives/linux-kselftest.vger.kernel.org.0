Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5256843A30F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 21:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbhJYTzw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 15:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbhJYTwg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 15:52:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F20C110F03
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 12:23:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h185-20020a256cc2000000b005bdce4db0easo18763219ybc.12
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=45dqToEc/K+4qvYglXNOL6jPB2qE5YwQ6TIrSNdSsg0=;
        b=eQn5ZLssxldFFEhxptajYXoZMGs9HV23dovilifJseP8RIL4qBMurKl7iRcuLjZE6o
         r6cCPI9WTfczLdj4jvolDqW7hIvzRcX10cFFN8pJUPJWwIrAiNF9dLx9v9rDAhLO5j0g
         tnDckqwa3XkLFDIqwGnPJO7xY7+k2S52pjOKX8T8a1liNS15NQQMfXvCz9Q8sbVUgS9i
         xGifvwdfMhU0uJiv0aWTfRJCCJVFdvOC2dKQ0U01PPy6xFfpcbG9hs1pZC0BtKDbI6mP
         Iz4akSgkmSTn5yAKKyBrXimeu/macRug4e9BTx/cn2DAsZ9cRfBfrEFyUtb+v4BP8flJ
         njXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=45dqToEc/K+4qvYglXNOL6jPB2qE5YwQ6TIrSNdSsg0=;
        b=thRoJC/0NaLXATgWn0/9SWVAq5MdH/KQJziLq4KH/E6mS1KfEMop3N+ChslPo4lbJI
         wCap20+J/mLjyNNmnVfGmaAz1wbbTmUaM2g2tKRu7FVqkGNZDkEPXda9Y5dTVzzpGilE
         pThYVdbK/UNJkmaH7xfDoSD4iQBZopFy0AE1B2nLUTrz5Vnpx8YeCxFaSHHlSXDbjYaa
         VJII3JCk2ycZ/xu6zp+xWc3IH2+4ZWcQQNphdRdJ2OD4h+QKA0FhWCXokyoig5WZJGCK
         7drNvZWZaNE3Cau9R5DopiC9bcMZfQgKDp8/LxkcJYNxRagm7F6Jm/hEYld288juVT/R
         d5Lg==
X-Gm-Message-State: AOAM530zjEWzt8yiDLvqGcREIFxHuuH8zd9YixTknjiGrT8Abhr1EZux
        3KTPaRssGFBpYTzBPs6e30QE7pO5AiwrZLC1Bw==
X-Google-Smtp-Source: ABdhPJxAredXlOjmRY+6CJVip/EoCfl8kgLTlcCmq4qx/3/Y9vNX8QPG8INl8LYUDvSsD121Ne63S2SXRngvuf0jDg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a25:bd93:: with SMTP id
 f19mr17888618ybh.23.1635189815637; Mon, 25 Oct 2021 12:23:35 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:23:11 -0700
Message-Id: <20211025192330.2992076-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 0/8] tracing: Extend histogram triggers expression parsing
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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

Hi all,

The v3 of the extending histogram exprssions series. The previous versions
were posted at:

v2: https://lore.kernel.org/r/20211020013153.4106001-1-kaleshsingh@google.com/
v1: https://lore.kernel.org/r/20210915195306.612966-1-kaleshsingh@google.com/

Patches 4 through 6 are new and adds some optimizations/improvements
suggested by Steven Rostedt.

The cover letter is copied below for convenience.

Thanks,
Kalesh

---

The frequency of the rss_stat trace event is known to be of the same
magnitude as that of the sched_switch event on Android devices. This can
cause flooding of the trace buffer with rss_stat traces leading to a
decreased trace buffer capacity and loss of data.

If it is not necessary to monitor very small changes in rss (as is the
case in Android) then the rss_stat tracepoint can be throttled to only
emit the event once there is a large enough change in the rss size.
The original patch that introduced the rss_stat tracepoint also proposed
a fixed throttling mechanism that only emits the rss_stat event
when the rss size crosses a 512KB boundary. It was concluded that more
generic support for this type of filtering/throttling was need, so that
it can be applied to any trace event. [1]

From the discussion in [1], histogram triggers seemed the most likely
candidate to support this type of throttling. For instance to achieve the
same throttling as was proposed in [1]:

  (1) Create a histogram variable to save the 512KB bucket of the rss size
  (2) Use the onchange handler to generate a synthetic event when the
      rss size bucket changes.

The only missing pieces to support such a hist trigger are:
  (1) Support for setting a hist variable to a specific value -- to set
      the bucket size / granularity.
  (2) Support for division arithmetic operation -- to determine the
      corresponding bucket for an rss size.

This series extends histogram trigger expressions to:
  (1) Allow assigning numeric literals to hist variable (eg. x=1234)
      and using literals directly in expressions (eg. x=size/1234)
  (2) Support division and multiplication in hist expressions.
      (eg. a=$x/$y*z); and
  (3) Fixes expression parsing for non-associative operators: subtraction
      and division. (eg. 8-4-2 should be 2 not 6)

The rss_stat event can then be throttled using histogram triggers as
below:

  # Create a synthetic event to monitor instead of the high frequency
  # rss_stat event
  echo 'rss_stat_throttled unsigned int mm_id; unsigned int curr;
         int member; long size' >> tracing/synthetic_events

  # Create a hist trigger that emits the synthetic rss_stat_throttled
  # event only when the rss size crosses a 512KB boundary.
  echo 'hist:keys=mm_id,member:bucket=size/0x80000:onchange($bucket)
              .rss_stat_throttled(mm_id,curr,member,size)'
        >> events/kmem/rss_stat/trigger

 ------ Test Results ------
Histograms can also be used to evaluate the effectiveness of this
throttling by noting the Total Hits on each trigger:

  echo 'hist:keys=common_pid' >> events/sched/sched_switch/trigger
  echo 'hist:keys=common_pid' >> events/kmem/rss_stat/trigger
  echo 'hist:keys=common_pid'
           >> events/synthetic/rss_stat_throttled/trigger

Allowing the above example (512KB granularity) run for 5 minutes on
an arm64 device with 5.10 kernel:

   sched_switch      : total hits = 147153
   rss_stat          : total hits =  38863
   rss_stat_throttled: total hits =   2409

The synthetic rss_stat_throttled event is ~16x less frequent than the
rss_stat event when using a 512KB granularity.


The results are more pronounced when rss size is changing at a higher
rate in small increments. For instance the following results were obtained
by recording the hits on the above events for a run of Android's
lmkd_unit_test [2], which continually forks processes that map anonymous
memory until there is an oom kill:

   sched_switch      : total hits =  148832
   rss_stat          : total hits = 4754802
   rss_stat_throttled: total hits =   96214

In this stress test, the synthetic rss_stat_throttled event is ~50x less
frequent than the rss_stat event when using a 512KB granularity.

[1] https://lore.kernel.org/lkml/20190903200905.198642-1-joel@joelfernandes.org/
[2] https://cs.android.com/android/platform/superproject/+/master:system/memory/lmkd/tests/lmkd_test.cpp


Kalesh Singh (8):
  tracing: Add support for creating hist trigger variables from literal
  tracing: Add division and multiplication support for hist triggers
  tracing: Fix operator precedence for hist triggers expression
  tracing/histogram: Simplify handling of .sym-offset in expressions
  tracing/histogram: Covert expr to const if both operands are constants
  tracing/histogram: Optimize division by a power of 2
  tracing/selftests: Add tests for hist trigger expression parsing
  tracing/histogram: Document expression arithmetic and constants

 Documentation/trace/histogram.rst             |  14 +
 kernel/trace/trace_events_hist.c              | 400 ++++++++++++++----
 .../testing/selftests/ftrace/test.d/functions |   4 +-
 .../trigger/trigger-hist-expressions.tc       |  72 ++++
 4 files changed, 412 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc


base-commit: ac8a6eba2a117e0fdc04da62ab568d1b7ca4c8f6
-- 
2.33.0.1079.g6e70778dc9-goog

