Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1763B4342E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 03:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJTBft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 21:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTBft (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 21:35:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9EC06161C
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 18:33:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j193-20020a2523ca000000b005b789d71d9aso27783427ybj.21
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=/oNbKuNJ/NjBt3tvnnNN1bQs/FW9O8UfHJkwZ8aGpZU=;
        b=M+Jr9PYocMzl6Julf6MHH8OFUtoGTsZ6C2FC9ZjP1oLOhPs842mxdaStpR/DbNmFJV
         qTAXIcUAYNodjHS9JhdZvBPqEoD4vv/+Kucw9SZhVA/69GiniAGs9w8CpAPtC55yPIxO
         olhLgmFjZpfAhfD7cpghWOZinz7pJUrNx99NWWjgltjEjNIQ1xM/0NHUdcwk/ZfoAJz5
         gbmg88R62x0cu4BU0S+98i9qHaWvw6C1TuqVKnr9PIEBxelaeb/6VSozoNu1Shwl2z89
         b/rFwrIT98z538zjqI02P5Jd2hHBxOdaKdCrkWI86s1vhuK3VaWFKslF0dVuCdvOSMK2
         sQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=/oNbKuNJ/NjBt3tvnnNN1bQs/FW9O8UfHJkwZ8aGpZU=;
        b=sw9eTiAf6HrSFzUKsMgYMelFr/N86WY4IpQ7b54jKtqu+L/RJg12EHtuDfp/HtQeAf
         rmWn1UT4mco6TDvOKePQB6oQZ1sMgt0GhHbMHvgMPzI9NmaZUZAGdvuiGEwFF3C5diLL
         8+2uNiqWKq3RnQqK3RxUd/PsNKxVyDvZ3jVSeRcxZhyL2goZueZTh4D7C1o26QsuISoA
         KAfgNf6d6vv1RgPfJr+oWemVTXUMP2k6JZz2QObXTt2dzSOWfQwnfI2d7WFuUOGu2wnT
         oYPYlNrvcrVkuPad3afKzIzj0hhYTBOruVjoCZUXJu4sDSONd0MTEedm3RX1aSJkgMgd
         YU/g==
X-Gm-Message-State: AOAM533995XzIb7WHKkQ5/Rm2wWGoq4KKi4kQFoyZtuqoSYsiBHAI6xZ
        QK9uNRVnabclo5N1QwAlvaPw0Hv54oOIN7yKXg==
X-Google-Smtp-Source: ABdhPJx8xkUizpCZjRlUmsBfpykOEkGUKPa4YE8/chpH8tDveWIr3wf26Nf0Ec8J5Y45sqxmmgi3UvjEKL8DgEp3Yg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:1953:b886:7a6c:bf0])
 (user=kaleshsingh job=sendgmr) by 2002:a25:3487:: with SMTP id
 b129mr36817302yba.249.1634693614938; Tue, 19 Oct 2021 18:33:34 -0700 (PDT)
Date:   Tue, 19 Oct 2021 18:31:37 -0700
Message-Id: <20211020013153.4106001-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 0/5] tracing: Extend histogram triggers expression parsing
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

The v1 of this series was posted at:
https://lore.kernel.org/r/20210915195306.612966-1-kaleshsingh@google.com/

The cover letter here is mostly identical to that in v1, with a
correction to how the results were obtained.
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


Kalesh Singh (5):
  tracing: Add support for creating hist trigger variables from literal
  tracing: Add division and multiplication support for hist triggers
  tracing: Fix operator precedence for hist triggers expression
  tracing/selftests: Add tests for hist trigger expression parsing
  tracing/histogram: Document expression arithmetic and constants

 Documentation/trace/histogram.rst             |  14 +
 kernel/trace/trace_events_hist.c              | 318 +++++++++++++++---
 .../testing/selftests/ftrace/test.d/functions |   4 +-
 .../trigger/trigger-hist-expressions.tc       |  74 ++++
 4 files changed, 358 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc


base-commit: d9abdee5fd5abffd0e763e52fbfa3116de167822
-- 
2.33.0.1079.g6e70778dc9-goog

