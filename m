Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE075FB2A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJKMr0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Oct 2022 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJKMrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Oct 2022 08:47:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A769080D
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Oct 2022 05:47:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u16-20020a250950000000b006be72659056so13299635ybm.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Oct 2022 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JZgfsSGBJAIpwrM+kN5gILalFFiDKNqq+i+h/f0T+1w=;
        b=Lhj7yGBgLSbssGDsd2KUsMVfq/iXui4imvLqgRv+9ymf7fd0W+VDlTKnh0f+tpRRXB
         /Br17OtlaZyA2gyUxT98PtVyrIAuDpC/pXipYVvOV8y+f8H4vW+MajDUU3phx5GVqniT
         HPzXIHjVgZ7zojUrVGN8Zida1RvUp9HXnw3R3Rm90a+ZGX1tkwsB9j+AqH0+BXbiF72l
         HQEjtC130tULmZYTQtzesNR494kbdH2bqCeNOTyjf3JroTg4WaW38z8ocmG0723+8zRd
         am3phKQ78ruIuH5HZIEE2opGxyuYN7Xbsf+A6j9hntbwWKvWdfuFZxjWS4penwRx6jCJ
         mWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZgfsSGBJAIpwrM+kN5gILalFFiDKNqq+i+h/f0T+1w=;
        b=JeC1j7Q8tyFZ9SvEVadR0a1smBtcGte/X5hr62k3t63QfekRDLMg+9Q1EdUXeNsKer
         93vNfa5n+2JXcAYFU0L+ULNFT9WmVOSShxynv8d/N2iG8tYdF2jfse+sjS2MwvdNTxEt
         ZgNNu6DqX78FQTsoGsy4ZzWBGQWD1FDa+cx5ahi4GxRF10jJEdayk1bHPxRaoOnDbFDg
         K2cI2j1lQ0lZC5e1Zf9Qg8X3WyGZ+ufbVxD5c4O3M+dTQUmP6ACtY/6QyksMJGYbthLK
         RbYzwzT3t0R2KAEMhtfoiFH7JZquXpFXc+yB0DsOyBRqQQhqCDMzZhRr5Xx0Vyyc9zpI
         eUrA==
X-Gm-Message-State: ACrzQf0qf9eLGftZsPBSfeAzNJagN+5bJ4fDqwyi1+LHeTGoe+2eJjfd
        iE8lwtBu3azMKqCsvTvhqFMAw2farA==
X-Google-Smtp-Source: AMsMyM7mLP7qxYhVaFvAfaOOBR4Ia7Pa0IN/qv4FwNg3SacUjhfZkgOXsyXoCAhZIp/qsLi2hi3T37gusQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3abd:8519:48e1:da82])
 (user=elver job=sendgmr) by 2002:a25:6dc3:0:b0:6c0:7938:5b3f with SMTP id
 i186-20020a256dc3000000b006c079385b3fmr13344582ybc.625.1665492440186; Tue, 11
 Oct 2022 05:47:20 -0700 (PDT)
Date:   Tue, 11 Oct 2022 14:45:35 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011124534.84907-1-elver@google.com>
Subject: [PATCH] selftests/perf_events: Add a SIGTRAP stress test with disables
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a SIGTRAP stress test that exercises repeatedly enabling/disabling
an event while it concurrently keeps firing.

Link: https://lore.kernel.org/all/Y0E3uG7jOywn7vy3@elver.google.com/
Signed-off-by: Marco Elver <elver@google.com>
---
 .../selftests/perf_events/sigtrap_threads.c   | 35 +++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 6d849dc2bee0..d1d8483ac628 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -62,6 +62,8 @@ static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr,
 		.remove_on_exec = 1, /* Required by sigtrap. */
 		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
 		.sig_data	= TEST_SIG_DATA(addr, id),
+		.exclude_kernel = 1, /* To allow */
+		.exclude_hv     = 1, /* running as !root */
 	};
 	return attr;
 }
@@ -93,9 +95,13 @@ static void *test_thread(void *arg)
 
 	__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
 	iter = ctx.iterate_on; /* read */
-	for (i = 0; i < iter - 1; i++) {
-		__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
-		ctx.iterate_on = iter; /* idempotent write */
+	if (iter >= 0) {
+		for (i = 0; i < iter - 1; i++) {
+			__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+			ctx.iterate_on = iter; /* idempotent write */
+		}
+	} else {
+		while (ctx.iterate_on);
 	}
 
 	return NULL;
@@ -208,4 +214,27 @@ TEST_F(sigtrap_threads, signal_stress)
 	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
 }
 
+TEST_F(sigtrap_threads, signal_stress_with_disable)
+{
+	const int target_count = NUM_THREADS * 3000;
+	int i;
+
+	ctx.iterate_on = -1;
+
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	pthread_barrier_wait(&self->barrier);
+	while (__atomic_load_n(&ctx.signal_count, __ATOMIC_RELAXED) < target_count) {
+		EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+		EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	}
+	ctx.iterate_on = 0;
+	for (i = 0; i < NUM_THREADS; i++)
+		ASSERT_EQ(pthread_join(self->threads[i], NULL), 0);
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+
+	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
+}
+
 TEST_HARNESS_MAIN
-- 
2.38.0.rc1.362.ged0d419d3c-goog

