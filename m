Return-Path: <linux-kselftest+bounces-39789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5586DB329ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100CA3BD2BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4142D3729;
	Sat, 23 Aug 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laD9UYHq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22C212549;
	Sat, 23 Aug 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964548; cv=none; b=Kd90YKWqgymd9BnNjWCJKVL1sQUHVCS0OHr+Jd0T8nRuC8fUDu+1sZYs39vKfYt42JoS+hCPiOF2l4Mb1E6bD15yPyNWMuAwR4Pn6mNb8nascJGIoe9nLzRFJTpmTjvh1NyH+qlBhiCCKFaY7HHgYXfGWMyQXTzIobzHFoeWiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964548; c=relaxed/simple;
	bh=IwK6ZOkL3fyauMsghiEfSSZSqRTAgaGOcby6wIKtHOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Azk0g79DjIky1R1ulGcWPnctawungO2N8IwD2FB1oag1VHPUsASX2V2NfdifBflSAJmd7s2X4ZwUhzGD9IB2TmebHa2BwiyAhF3amj33QmRijQ58Qhg8XZyd/jUzIHz8swRPZTj/VP7WgRoSjDbOXcLRIS4bk9gAqOccWC0Hlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laD9UYHq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49d46a8d05so264198a12.0;
        Sat, 23 Aug 2025 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755964546; x=1756569346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHOD/XY0X+Od8iRzBJ5/06QoPuKSvzf8PdQxU6Bi+58=;
        b=laD9UYHqeHyleztjan+jh4kVwWH13hyCjBSjHUnjc8XFMZdxp+hnxU5O7KNbCufxxj
         mtyhtgvpEX2J5TcvpaEUtIVK2H99TeYw1PcWE0eZMr+8Ot5NTVT3gAPPMbobh5gvL6SY
         eFjOM11sJSUF4OeJnTyj8hsfN9RQV/aIK+B3DjVDkYHw2lhyNW1w7Valw3HD6U0XBOJI
         xuS8PJ7IbGardVsPM7gSqLoDPZGudKyzMwQ+9j17dQi4/3JGUZyJzO8J8pJVliKNrF4x
         sjvAnPygQxSZsmI1cmmkdIwAG+onDKYy91EYKFR15SCkaCMvC0zJVImmejNFPHmiQ+2y
         mgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964546; x=1756569346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHOD/XY0X+Od8iRzBJ5/06QoPuKSvzf8PdQxU6Bi+58=;
        b=f2M8Z5spiOpcuZdk+/pNLpFfPOeAojwOaP1GQ1TPSWiudNg+fXk+viPajRg1M2fQ6R
         l+zyxZiEkokdnVY5GAdEyNaM91tCAd29GH0F1SvHe3qIptltvjdQccCwIi2EZ85nptFN
         ai7yTiIFykSnq1EqwJWifbtC97mTmkHopgfpAZ944nJNcavFXOwRmzLw7LQSWaVW7FdS
         kS9QwE/p7+zRHUmrfvQLC+muBLAxYFIYovqQCcSQWaTB+jtFTnNisFXNK7qLEz+Xukju
         XLo1kCgMJy3X/TgOj9YRnvLkyaB7UJCB8Mgm4Qn/ZubQ0DKcf4GSILNIU0exvcFdbGLh
         W08w==
X-Forwarded-Encrypted: i=1; AJvYcCXjWg7EsEFGuWb08NSrZh4IenqOrw+kgzzb2h4TBQ9ilSp1gDI6z/dgpwOC4xjah4qxT8wAgkVYtNgyjo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/IGz0Ti2jfuNa71uJbDR3e8Ve/pKUXzfz+ibLtjyx9zBoTDv
	BHP2WQtZpUMEGEa7Hp/nGXJvha1PYz4pgHCn5vzr5T2ED+S1tYCrzlwwt6SUaqmR
X-Gm-Gg: ASbGncvZ0UEslgREnKRFSZc7/DpU1syPIG4fRD1as70djx3kYcsB+FaKsMsLj5aXUJe
	HsSwFzT43jztuqss5ysOZKyk49ysvlGpxAzYWwMkTiIxP9z62PeF71dWw96PH3NjW1VZ3O+URP0
	U4tAHGt3zsv7iTmvTKmGP9EJcNNnECIQTReIm5zXThIAKCRGwp+lqFJGaJPbPDn05MrQBeGOQJB
	i00ELa7WniDhqi8cBpVruUO4lhrP7mW3Khv+QEob1KXMXyF8TzhujMu5z7h+9ezVpHRKaiKvRLi
	8qxV6sKCRmLERbsC3X8bAJCucULP2khtdN7MbB8/ZyHhZuW1TFndyVMVgkmRZoVryWNEZuRCh1g
	4pZpeCOGXeD+8+eCUpiWXMahQJdzZe+9TbQ==
X-Google-Smtp-Source: AGHT+IH1dOI3lLdhA7dyJ743U8yOLELwsIVQczq7HjyWYAInVucUMxOSQYBi4rTS35zq8TJFKxGbog==
X-Received: by 2002:a17:902:fc47:b0:246:9a5f:839f with SMTP id d9443c01a7336-2469a5f8594mr10394735ad.21.1755964545838;
        Sat, 23 Aug 2025 08:55:45 -0700 (PDT)
Received: from kali ([2406:7400:75:3c04:45dc:8c83:132d:efa1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm25320815ad.66.2025.08.23.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 08:55:45 -0700 (PDT)
From: Preetpalbugs <preetpal77952@gmail.com>
X-Google-Original-From: Preetpalbugs <preetpal.singh@s.amity.edu>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Preetpalbugs <preetpal.singh@s.amity.edu>
Subject: [PATCH] selftests: timers: Fix wording and grammar in messages
Date: Sat, 23 Aug 2025 21:24:52 +0530
Message-ID: <20250823155452.198536-1-preetpal.singh@s.amity.edu>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Preetpalbugs <preetpal.singh@s.amity.edu>
---
 posix_timers.c | 290 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 290 insertions(+)
 create mode 100644 posix_timers.c

diff --git a/posix_timers.c b/posix_timers.c
new file mode 100644
index 0000000..486b71b
--- /dev/null
+++ b/posix_timers.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013 Red Hat, Inc., Frederic Weisbecker <fweisbec@redhat.com>
+ *
+ * Selftests for a few posix timers interface.
+ *
+ * Kernel loop code stolen from Steven Rostedt <srostedt@redhat.com>
+ */
+
+#include <sys/time.h>
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <time.h>
+#include <pthread.h>
+
+#include "../kselftest.h"
+
+#define DELAY 2
+#define USECS_PER_SEC 1000000
+
+static volatile int done;
+
+/* Busy loop in userspace to elapse ITIMER_VIRTUAL */
+static void user_loop(void)
+{
+	while (!done);
+}
+
+/*
+ * Try to spend as much time as possible in kernelspace
+ * to elapse ITIMER_PROF.
+ */
+static void kernel_loop(void)
+{
+	void *addr = sbrk(0);
+	int err = 0;
+
+	while (!done && !err) {
+		err = brk(addr + 4096);
+		err |= brk(addr);
+	}
+}
+
+/*
+ * Sleep until ITIMER_REAL expiration.
+ */
+static void idle_loop(void)
+{
+	pause();
+}
+
+static void sig_handler(int nr)
+{
+	done = 1;
+}
+
+/*
+ * Check the expected timer expiration matches the GTOD elapsed delta since
+ * we armed the timer. Keep a 0.5 sec error margin due to various jitter.
+ */
+static int check_diff(struct timeval start, struct timeval end)
+{
+	long long diff;
+
+	diff = end.tv_usec - start.tv_usec;
+	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
+
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
+		printf("Diff too high: %lld..", diff);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int check_itimer(int which)
+{
+	const char *name;
+	int err;
+	struct timeval start, end;
+	struct itimerval val = {
+		.it_value.tv_sec = DELAY,
+	};
+
+	if (which == ITIMER_VIRTUAL)
+		name = "ITIMER_VIRTUAL";
+	else if (which == ITIMER_PROF)
+		name = "ITIMER_PROF";
+	else if (which == ITIMER_REAL)
+		name = "ITIMER_REAL";
+	else
+		return -1;
+
+	done = 0;
+
+	if (which == ITIMER_VIRTUAL)
+		signal(SIGVTALRM, sig_handler);
+	else if (which == ITIMER_PROF)
+		signal(SIGPROF, sig_handler);
+	else if (which == ITIMER_REAL)
+		signal(SIGALRM, sig_handler);
+
+	err = gettimeofday(&start, NULL);
+	if (err < 0) {
+		ksft_perror("Can't call gettimeofday()");
+		return -1;
+	}
+
+	err = setitimer(which, &val, NULL);
+	if (err < 0) {
+		ksft_perror("Can't set timer");
+		return -1;
+	}
+
+	if (which == ITIMER_VIRTUAL)
+		user_loop();
+	else if (which == ITIMER_PROF)
+		kernel_loop();
+	else if (which == ITIMER_REAL)
+		idle_loop();
+
+	err = gettimeofday(&end, NULL);
+	if (err < 0) {
+		ksft_perror("Can't call gettimeofday()");
+		return -1;
+	}
+
+	ksft_test_result(check_diff(start, end) == 0, "%s\n", name);
+
+	return 0;
+}
+
+static int check_timer_create(int which)
+{
+	const char *type;
+	int err;
+	timer_t id;
+	struct timeval start, end;
+	struct itimerspec val = {
+		.it_value.tv_sec = DELAY,
+	};
+
+	if (which == CLOCK_THREAD_CPUTIME_ID) {
+		type = "thread";
+	} else if (which == CLOCK_PROCESS_CPUTIME_ID) {
+		type = "process";
+	} else {
+		ksft_print_msg("Unknown timer_create() type %d\n", which);
+		return -1;
+	}
+
+	done = 0;
+	err = timer_create(which, NULL, &id);
+	if (err < 0) {
+		ksft_perror("Can't create timer");
+		return -1;
+	}
+	signal(SIGALRM, sig_handler);
+
+	err = gettimeofday(&start, NULL);
+	if (err < 0) {
+		ksft_perror("Can't call gettimeofday()");
+		return -1;
+	}
+
+	err = timer_settime(id, 0, &val, NULL);
+	if (err < 0) {
+		ksft_perror("Can't set timer");
+		return -1;
+	}
+
+	user_loop();
+
+	err = gettimeofday(&end, NULL);
+	if (err < 0) {
+		ksft_perror("Can't call gettimeofday()");
+		return -1;
+	}
+
+	ksft_test_result(check_diff(start, end) == 0,
+			 "timer_create() per %s\n", type);
+
+	return 0;
+}
+
+static pthread_t ctd_thread;
+static volatile int ctd_count, ctd_failed;
+
+static void ctd_sighandler(int sig)
+{
+	if (pthread_self() != ctd_thread)
+		ctd_failed = 1;
+	ctd_count--;
+}
+
+static void *ctd_thread_func(void *arg)
+{
+	struct itimerspec val = {
+		.it_value.tv_sec = 0,
+		.it_value.tv_nsec = 1000 * 1000,
+		.it_interval.tv_sec = 0,
+		.it_interval.tv_nsec = 1000 * 1000,
+	};
+	timer_t id;
+
+	/* 1/10 seconds to ensure the leader sleeps */
+	usleep(10000);
+
+	ctd_count = 100;
+	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
+		return "Can't create timer\n";
+	if (timer_settime(id, 0, &val, NULL))
+		return "Can't set timer\n";
+
+	while (ctd_count > 0 && !ctd_failed)
+		;
+
+	if (timer_delete(id))
+		return "Can't delete timer\n";
+
+	return NULL;
+}
+
+/*
+ * Test that only the running thread receives the timer signal.
+ */
+static int check_timer_distribution(void)
+{
+	const char *errmsg;
+
+	signal(SIGALRM, ctd_sighandler);
+
+	errmsg = "Can't create thread\n";
+	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
+		goto err;
+
+	errmsg = "Cannot join thread\n";
+	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
+		goto err;
+
+	if (!ctd_failed)
+		ksft_test_result_pass("check signal distribution\n");
+	else if (ksft_min_kernel_version(6, 3))
+		ksft_test_result_fail("check signal distribution\n");
+	else
+		ksft_test_result_skip("check signal distribution (old kernel)\n");
+	return 0;
+err:
+	ksft_print_msg("%s", errmsg);
+	return -1;
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(6);
+
+	ksft_print_msg("Testing POSIX timers. False negative may happen on CPU execution \n");
+	ksft_print_msg("This may happen on CPU-based timers if other threads run on the CPU...\n");
+
+	if (check_itimer(ITIMER_VIRTUAL) < 0)
+		ksft_exit_fail();
+
+	if (check_itimer(ITIMER_PROF) < 0)
+		ksft_exit_fail();
+
+	if (check_itimer(ITIMER_REAL) < 0)
+		ksft_exit_fail();
+
+	if (check_timer_create(CLOCK_THREAD_CPUTIME_ID) < 0)
+		ksft_exit_fail();
+
+	/*
+	 * It's unfortunately hard to reliably test a timer expiration
+	 * on parallel multithread cputime. We could arm it to expire
+	 * on DELAY * nr_threads, with nr_threads busy looping, then wait
+	 * the normal DELAY since the time is elapsing nr_threads faster.
+	 * But for that we need to ensure we have real physical free CPUs
+	 * to ensure true parallelism. So test only one thread until we
+	 * find a better solution.
+	 */
+	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
+		ksft_exit_fail();
+
+	if (check_timer_distribution() < 0)
+		ksft_exit_fail();
+
+	ksft_finished();
+}
-- 
2.50.1


