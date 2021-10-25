Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE26643A485
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbhJYU01 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhJYU0K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 16:26:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D532C04A434
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:11:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso19316367ybj.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=zTwkaja/2JWSasZvIIm+cYcdHeXbXK6HRxptMu06TGw=;
        b=sZREgtN/dQkjCL2r8YEppt69WYaT1e3YnU/lC0tSTPmcim+MfICmWIErShiU50K4Op
         0B9n9qnPvHiinHyry+vteN2f30G/5xHAB2ETMTbFOnoOAe0QJ2t8eYckiZM8AxajIi+n
         bvIFrHJ0nWgy889TgKX1F7kGNC7N/u8BjxT4PFeLTiWdfJwv5mi1xm0uSuUDDgUg9/++
         2B9iOJG3VCMSPVus4a7jVI1ngK8n3PB1YtZwz1gz46Ug6H0ZMY3nSmz9ToW5Kx/4sXd9
         tx3SXE6tj06KTd3zS1C+sPC65RTqm/ilEyguUjz+IJQOw+K0BfvoxS6XjQYn9OEAJNwn
         rt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=zTwkaja/2JWSasZvIIm+cYcdHeXbXK6HRxptMu06TGw=;
        b=0goZOsY8vbuXnwm7+zhZYxhgH42miJ4LHMn1goTlsnqGz/2Rg7UWNi5cyNw6t5iWWE
         0sUM4Z2rwct/sscwfwEXqMd89jVd0t5hcI2xfFEUFe4WdLCTSwftrKetjQ6Cl37CI11K
         Q1UUovfd8PNEJ3Vvc7QOkqKxyjdRkxj0jknG9KceJRhvBWSjfwRl0OII5UPgpTwxh8dk
         A20zqKVFyxezmLX4fBqJ9SoIql+huxSGvImNrrUkOOGG19IZcTZm46PGT4zso6FWD9sA
         heQPWtSrl+wiTFHUksI3k/EEmTcvDgCZpJ/vxZfMkHKwQUqAZCHRap9FcBwaZdxZMRjm
         s3MQ==
X-Gm-Message-State: AOAM531hfzLKSnDGHGStH/umCdHcI2zgS4SVSaoi2ufdU1vdSl15CxHd
        X+/c4hUoXNd8Qb4EpRlhWu9trOTXZzCcQ1DmWA==
X-Google-Smtp-Source: ABdhPJw96s21uhW6TUwD3SKaJ/TyObnmloSOpqPSHk2oJrvsYjzexRKFG/EL+Nu5f7CQddH+TNK5GvKpnkuG+xzRWA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a25:c5c5:: with SMTP id
 v188mr7746712ybe.34.1635192674501; Mon, 25 Oct 2021 13:11:14 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:08:38 -0700
In-Reply-To: <20211025200852.3002369-1-kaleshsingh@google.com>
Message-Id: <20211025200852.3002369-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 6/8] tracing/histogram: Optimize division by a power of 2
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The division is a slow operation. If the divisor is a power of 2, use a
shift instead.

Results were obtained using Android's version of perf (simpleperf[1]) as
described below:

1. hist_field_div() is modified to call 2 test functions:
   test_hist_field_div_[not]_optimized(); passing them the
   same args. Use noinline and volatile to ensure these are
   not optimized out by the compiler.
2. Create a hist event trigger that uses division:
      events/kmem/rss_stat$ echo 'hist:keys=common_pid:x=size/<divisor>'
         >> trigger
      events/kmem/rss_stat$ echo 'hist:keys=common_pid:vals=$x'
         >> trigger
3. Run Android's lmkd_test[2] to generate rss_stat events, and
   record CPU samples with Android's simpleperf:
      simpleperf record -a --exclude-perf --post-unwind=yes -m 16384 -g
         -f 2000 -o perf.data

== Results ==

Divisor is a power of 2 (divisor == 32):

   test_hist_field_div_not_optimized  | 8,717,091 cpu-cycles
   test_hist_field_div_optimized      | 1,643,137 cpu-cycles

If the divisor is a power of 2, the optimized version is ~5.3x faster.

Divisor is not a power of 2 (divisor == 33):

   test_hist_field_div_not_optimized  | 4,444,324 cpu-cycles
   test_hist_field_div_optimized      | 5,497,958 cpu-cycles

If the divisor is not a power of 2, as expected, the optimized version is
slightly slower (~24% slower).

[1] https://android.googlesource.com/platform/system/extras/+/master/simpleperf/doc/README.md
[2] https://cs.android.com/android/platform/superproject/+/master:system/memory/lmkd/tests/lmkd_test.cpp

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>

---
 kernel/trace/trace_events_hist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index db28bcf976f4..364cb3091789 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -304,6 +304,10 @@ static u64 hist_field_div(struct hist_field *hist_field,
 	if (!val2)
 		return -1;
 
+	/* Use shift if the divisor is a power of 2 */
+	if (!(val2 & (val2 - 1)))
+		return val1 >> __ffs64(val2);
+
 	return div64_u64(val1, val2);
 }
 
-- 
2.33.0.1079.g6e70778dc9-goog

