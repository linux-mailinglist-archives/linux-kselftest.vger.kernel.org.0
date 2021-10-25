Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4043A46B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbhJYUZ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 16:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbhJYUZV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 16:25:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E569EC04640D
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:09:00 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id jz23-20020a17090b14d700b001a1d69b0215so209469pjb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=yVyWdyfXHZ3pBBwGK5eO+moipbm7bhYPbjTGw1dCfng=;
        b=paU2f9WAMWO8SuGFnY/Kf+ctPro0KZXFza3R2Go6L1ENoF+xpIVaiQv4dgzruOjST0
         yeqxlawObXEBfUtTYms0QSZvEhpZMK3cL1EIi9bIXJW6RYt20TIBwkzpMBaMhrtC8D4l
         giVB1OC1OlMV84o9DFVWF6CH6j+1KgLU+hLaCnQ4xN8po4KWpRePDpZvdUrWJ0wQiWWk
         huc6vEISE+lYfJLS2Ib3sT8eDtopwh4XbczD452jbp6UDRPJ0cdDwCE5LTUgHAEBsaOL
         To3KR/ygMlCO+QpCkSHq4iAa/miQNd9z3zdt6AatGyrFTlAsNri1Ph98OXJyHSdjfPPD
         qRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=yVyWdyfXHZ3pBBwGK5eO+moipbm7bhYPbjTGw1dCfng=;
        b=4LjupbOXBONg7tDdkKkBTVZbFgDX0X1kR/xQ127Y8x9mEkxO+9a14Twk0fZJT9phtR
         GflT+zUAMW7D8NnHbdRecRa0nWDwAqQPTgcRKef+9HpSCIaoNUQ1jlrj9uZYJsjm9MWT
         6QkcTWgTjV2z9aH9lfIRqSFxiH06fBYmeFeh1svigh+enguSprhofbMvfLv8TxtiJTZC
         q25hBtmED+z7rKCy1tceB6ZOJS9Rky8KNblpNWn5SVVN8v+gGhvy1wOOHf36AfOwfbLq
         fmr2tNRyFdI5q8UQ4FnTtntY09R5ePWlFidypff8OJ2HNHSiJs+2wSl1shyyo81/xoo6
         cwyQ==
X-Gm-Message-State: AOAM530sWmLOSnJ9zde0Fq4bFptZGYelzsK6u+wgXvFDzYPWQRXbK+BU
        +NqpTi6XkdGRfwr6gH+m10/g3AC93RAa70fFSw==
X-Google-Smtp-Source: ABdhPJwKwboqqT191iT/YhdgeTOe2w0PYPuFItvV8w/w98mDq9AdbEtpY1CwTYX1s4LJcHwFfppa4za2fDs73QVjMg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6a00:216f:b0:44b:6212:4967 with
 SMTP id r15-20020a056a00216f00b0044b62124967mr21060858pff.23.1635192540392;
 Mon, 25 Oct 2021 13:09:00 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:08:32 -0700
Message-Id: <20211025200852.3002369-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 0/8] tracing: Extend histogram triggers expression parsing
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

The v4 of the extending histogram exprssions series. The previous versions
were posted at:

v3: https://lore.kernel.org/r/20211025192330.2992076-1-kaleshsingh@google.com/
v2: https://lore.kernel.org/r/20211020013153.4106001-1-kaleshsingh@google.com/
v1: https://lore.kernel.org/r/20210915195306.612966-1-kaleshsingh@google.com/

Patches 4 through 6 are new and adds some optimizations/improvements
suggested by Steven Rostedt.

Removes the Change-Id tags that were inadvertently added in v3.

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

