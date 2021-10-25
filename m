Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E1A43A3D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 22:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhJYUFS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbhJYUCV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 16:02:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C1EC0432F5
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 12:25:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so18917247yba.11
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=zTwkaja/2JWSasZvIIm+cYcdHeXbXK6HRxptMu06TGw=;
        b=es0PIzo5QRe/gNbKP/B9WOwdGUjl3l9nyAvVGwTkzf/E0vFbRT43d5JLLX+0lCXYrj
         IuV1P8y4Zn0oRJfSwiaEGxa/UiAZz8da4/F8a5EHSpnbwDi+6C0PA/Lnnyz29lNBruSh
         BEGlpTgEM0+76Ouvm072oqAOIMtPb9D7p+/gImv+17JnzOioFBRX0d4dWauFZr5olSzv
         UhAfDvqixN7XGXm2cyzJHyg8HKcwCorh+H8p1i15l4RoGG8g0z94TwyT/Skl05dI3NSQ
         h9ac+zm++4zhUn2z0dbq4Z7N72HhEcHJQV0eDJka8cAB4CrPam/tgATotv94uLIo0ENt
         s3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=zTwkaja/2JWSasZvIIm+cYcdHeXbXK6HRxptMu06TGw=;
        b=UpniewnyVsqOIdGZJz8ww5qwxYy9GpfTgY5C1gAGnq2CjpN7wPrvsLq+xtws878KzQ
         0k/hgfnoU10JvqNoyaIBRkdcAALdwNDI1Vvv36T1YfvOUtjZqAnypxuUnnpsoKf/YdIf
         oRby3WeCauhCUJqivOrCDZjXxHvVvv/jhR6/2TOHf4qjmRa5vFB5ABcyCyMf0duDUPS7
         87qXdTM3T5VAMyX9EIF7Aa3pk3noUU+faY9HDk8gpWAESajAFvtO6b1mkRyHa4RvtUgQ
         p8iqj3QeYpMIM2Uf0sJiVmzpkM31dMNjJ+LGJROpe2J2hqa7aUyKyZEgx4wmw6yRekBI
         kHnA==
X-Gm-Message-State: AOAM530L87kHMPejcCgg8Y7ReRLEkAwHu7RS0uvGxKO8zaU5witofZCS
        37KoHMi+sBIIOQIeGHW8zKY2n1sG3DRy8o+1nQ==
X-Google-Smtp-Source: ABdhPJynb9pf2F0DjhOaAmMkHMZpmL6519gTydu0ZsQZU9+8HWvfo2CFsZGDTuGlxXOTmpzBjpkKiYIVVkTGlU3T6g==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a25:400f:: with SMTP id
 n15mr21239484yba.497.1635189929323; Mon, 25 Oct 2021 12:25:29 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:23:17 -0700
In-Reply-To: <20211025192330.2992076-1-kaleshsingh@google.com>
Message-Id: <20211025192330.2992076-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211025192330.2992076-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 6/8] tracing/histogram: Optimize division by a power of 2
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

