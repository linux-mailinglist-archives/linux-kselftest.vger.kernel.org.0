Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C016BCF8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 13:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCPMcF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCPMcD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 08:32:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B90ECA1CE
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 05:32:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d7-20020a25adc7000000b00953ffdfbe1aso1669590ybe.23
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678969920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgf7EduwhN6551MQujeSUTn74g+txYbPhrHuCm2tsLY=;
        b=AyWoKrQzAyrLTzIXGUwTfXlrMUQUEzcdqf58netne9uKl/Mp/DJZVbiMFCi75BVjg+
         37c6H916KKaLMAgkXrmdOY8pnJVXd4UEw39b1nnvb+SPDcNuL1VNWE8CcpNXuYM7sQuJ
         zyD77kK2ta0teFzQHy6va89aFHW5sPOGNWgZV3p1aK/SSz2v/ay4t5IsUhsPe/LYFgzg
         n/f5CzIIYi4gIevSJE6Q0bWZMZi42L4mD5RRoh5vBVKr8UHiha9Zev2fizVH/+a7lykf
         qQQIICCLpehxLMZbHdpUvlgFU0WCE9A2i6/fLSSJVd8/iXqmMiSLyDZdu7DN3D6qQv0k
         xt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678969920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgf7EduwhN6551MQujeSUTn74g+txYbPhrHuCm2tsLY=;
        b=Re4dmS1jGg3R7eLe4+fjW1PMaRFBtp93wf7TT1P2dstgnzkveodXAfGT+xcYOyqAy7
         0Vm30/xm5FyLgeL1y1mCs3mPnUia8rMbzK+ZPX6L1+4Y3VPeDSEsXkFSOmARtPcfahXJ
         CSjHLaWstfwoovjhnDf2kTWoZvun8fDKQEOQgDY/JuovkfOfn8xl/bcCtIDoGvxmhjNC
         GNPizMRnrKChD0FdnhPvF9ZAY0Gc6Q9ruNJnYUt1SPv9pQtCfS5SnRKajOUU6rpe1u2t
         4Z9usjOY4fVx8IbO0JErFYGbRcROxpU9neqAgsoGHGYdeZLfIjdV3it4P5ZuKVN+cyt4
         BJdw==
X-Gm-Message-State: AO0yUKXIGUeZ6ABFTndu700WSdoNcNpUX4HI8Gn1wC7FmsI3JvwHZb+m
        k7T9gPJGTtQkQrYb++9Otzl5V/1wiQ==
X-Google-Smtp-Source: AK7set/u/hog7qriGRuTm81gsBOhizqGgDKI210by82U6cLVLThJ5+FWaQSPpbb1TmvQ5L53tUN4kqsCHQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:f359:6b95:96e:1317])
 (user=elver job=sendgmr) by 2002:a81:e508:0:b0:544:5fc7:f01f with SMTP id
 s8-20020a81e508000000b005445fc7f01fmr2036499ywl.4.1678969920431; Thu, 16 Mar
 2023 05:32:00 -0700 (PDT)
Date:   Thu, 16 Mar 2023 13:30:28 +0100
In-Reply-To: <20230316123028.2890338-1-elver@google.com>
Mime-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316123028.2890338-2-elver@google.com>
Subject: [PATCH v6 2/2] selftests/timers/posix_timers: Test delivery of
 signals across threads
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
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

From: Dmitry Vyukov <dvyukov@google.com>

Test that POSIX timers using CLOCK_PROCESS_CPUTIME_ID eventually deliver
a signal to all running threads.  This effectively tests that the kernel
doesn't prefer any one thread (or subset of threads) for signal delivery.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v6:
- Update wording on what the test aims to test.
- Fix formatting per checkpatch.pl.
---
 tools/testing/selftests/timers/posix_timers.c | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 0ba500056e63..8a17c0e8d82b 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -188,6 +188,80 @@ static int check_timer_create(int which)
 	return 0;
 }
 
+int remain;
+__thread int got_signal;
+
+static void *distribution_thread(void *arg)
+{
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	return NULL;
+}
+
+static void distribution_handler(int nr)
+{
+	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
+		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
+}
+
+/*
+ * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
+ * timer signals. This primarily tests that the kernel does not favour any one.
+ */
+static int check_timer_distribution(void)
+{
+	int err, i;
+	timer_t id;
+	const int nthreads = 10;
+	pthread_t threads[nthreads];
+	struct itimerspec val = {
+		.it_value.tv_sec = 0,
+		.it_value.tv_nsec = 1000 * 1000,
+		.it_interval.tv_sec = 0,
+		.it_interval.tv_nsec = 1000 * 1000,
+	};
+
+	printf("Check timer_create() per process signal distribution... ");
+	fflush(stdout);
+
+	remain = nthreads + 1;  /* worker threads + this thread */
+	signal(SIGALRM, distribution_handler);
+	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
+	if (err < 0) {
+		perror("Can't create timer\n");
+		return -1;
+	}
+	err = timer_settime(id, 0, &val, NULL);
+	if (err < 0) {
+		perror("Can't set timer\n");
+		return -1;
+	}
+
+	for (i = 0; i < nthreads; i++) {
+		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
+			perror("Can't create thread\n");
+			return -1;
+		}
+	}
+
+	/* Wait for all threads to receive the signal. */
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+
+	for (i = 0; i < nthreads; i++) {
+		if (pthread_join(threads[i], NULL)) {
+			perror("Can't join thread\n");
+			return -1;
+		}
+	}
+
+	if (timer_delete(id)) {
+		perror("Can't delete timer\n");
+		return -1;
+	}
+
+	printf("[OK]\n");
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	printf("Testing posix timers. False negative may happen on CPU execution \n");
@@ -217,5 +291,8 @@ int main(int argc, char **argv)
 	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
 		return ksft_exit_fail();
 
+	if (check_timer_distribution() < 0)
+		return ksft_exit_fail();
+
 	return ksft_exit_pass();
 }
-- 
2.40.0.rc1.284.g88254d51c5-goog

