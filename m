Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B117640CD80
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 21:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhIOTyj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 15:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhIOTyj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 15:54:39 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E57C061575
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:53:19 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id f34-20020a05622a1a2200b0029c338949c1so6659256qtb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=ZN8L1SRgYQneOokAyF/YDPfiVZ2ZJf5kUNPTEXGrDyM=;
        b=oOWHam1LZ3eZVZuUUKQnwIZD45mGvoGWhDIGGcaJ/ZVuaxJgr9C12nV1IedLU0nJUK
         rPAvCc0ieMBeNadMOasQbF021ZURMfXk3HM1Hx28jK9CP0R9rAiqoXXBWM2zoPdrFZx5
         5CIEkMxg5A7eeCUu5e7QpVjIo50IneSZIba6f7dwTlDzcMSqUnTCLUs8t8GNYWz1RirZ
         gZ1O5YVjciLF2y565msC2T0fJe/tyM8XRS1SxvHRKdzAt9PbzKEUaNXz1RheFKUK+x/L
         Yv5GsRq+7WsmVaMUo2k83oTrKFmm+N/ujJBzn6NIFv+tXxi8JPdqdAdhBNfPUitdZm3L
         ewvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=ZN8L1SRgYQneOokAyF/YDPfiVZ2ZJf5kUNPTEXGrDyM=;
        b=1b1rZG98wdnSbVH58vFZ3XV6Eg4s43P0+trL72s0PhfC4xntIfhBwoa8vDZ/pqsk6b
         nXGsMfFap6W3G6ooJXuW3tWGcA7HpZnvUDJeEXIALAtZlaT7qjUPZhiOSgJz4RtejpDn
         QFxayX9axjtEk+/xtrXrtbY5vL8zhh+QsUGQORKLTUogiMPZMw8z/ZGlKyTsnQcnqHUg
         eIyg9qTJV96oQd+TRfVcWmYNpUl0l39mjbQydrQ2nmXh5HNruLiwStejlaTns+kRnfal
         twiT4xStmDVHL6i6l9Y691J6Xsqc7y7u9meNsHttaV+tKT7NK4Q+QPKPUZ+3eQlrcXix
         GlYA==
X-Gm-Message-State: AOAM531YeAzXaJEIItuc1z/kPMVaK9CGPu6dyyqWJiWYWpFVDCqlXGgP
        5g3hw6m4zuAQqnGPmIrDNvk8Fu7wNFrV5AVb7w==
X-Google-Smtp-Source: ABdhPJyi27fA7iU5UGtpeuYB5pqLFXaWsK5XRc4GI4VOmjlh0qYYnWCd1v1FR24xxOzz+cwyWWbIz0v2Qb/QaMlZlQ==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:13e9:: with SMTP id
 ch9mr1497532qvb.45.1631735598972; Wed, 15 Sep 2021 12:53:18 -0700 (PDT)
Date:   Wed, 15 Sep 2021 19:52:44 +0000
Message-Id: <20210915195306.612966-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 0/5] tracing: Extend histogram triggers expression parsing
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
  echo 'hist:keys=common_pid:bucket=size/0x80000:onchange($bucket)
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

In this stress this, the  synthetic rss_stat_throttled event is ~50x less
frequent than the rss_stat event when using a 512KB granularity.


[1] https://lore.kernel.org/lkml/20190903200905.198642-1-joel@joelfernandes.org/
[2] https://cs.android.com/android/platform/superproject/+/master:system/memory/lmkd/tests/lmkd_test.cpp

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Kalesh Singh (5):
  tracing: Add support for creating hist trigger variables from literal
  tracing: Add division and multiplication support for hist triggers
  tracing: Fix operator precedence for hist triggers expression
  tracing/selftests: Add tests for hist trigger expression parsing
  tracing/histogram: Document expression arithmetic and constants

 Documentation/trace/histogram.rst             |  14 +
 kernel/trace/trace_events_hist.c              | 318 +++++++++++++++---
 .../testing/selftests/ftrace/test.d/functions |   4 +-
 .../trigger/trigger-hist-expressions.tc       |  73 ++++
 4 files changed, 357 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc


base-commit: 3ca706c189db861b2ca2019a0901b94050ca49d8
-- 
2.33.0.309.g3052b89438-goog

