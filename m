Return-Path: <linux-kselftest+bounces-8594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D64B8AC417
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 08:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E880D28237D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 06:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DB33FB3B;
	Mon, 22 Apr 2024 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRTcbJQG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D593F9D5
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766923; cv=none; b=W4r0OeixPffg7IJgcGA/2PN39rc2ttD63h4UqDX8lq0r7s2IvoAya/ndgrafbO9dyUOA7Fc6WpaJmZEkXUA6qj3UZzVKxSb4rwpWPb0A8tufWjaW5J8b//3ZKPFuMQx7TxJSilqWbLfxI/VJ3gifCdjLKOxzSZxiodv5OqnidDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766923; c=relaxed/simple;
	bh=SGZSK0ustsY1Lf9KVstOIQKwZBL7OEMrqFJf4TCxONU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jek5lfa3F8cYHO1xyVcVkV/mtWsEPf6fF5aHE+8aQOzkNtozDH6wFpIqv4XfayHAY8uA4eI5A5ZQU/pBy9OS89a86HcDNWygb2nGiExQRUKXnQSFfCANPTFCjMJSfEXSMmGjUql2MES/A3FH6Gyo+C6f1hcWwuM4d/Jphm/PHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRTcbJQG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8bcf739e5so4984065a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713766921; x=1714371721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BgHnvH0SifwgzbjlbM6L8Ym3RK63epZLUnxr0JyiQ3A=;
        b=jRTcbJQGaunoOGQvCeHdIQpMCAL92UC8oPiuo6XwcMDQD+lMDPqm143TjC/wcb83Jy
         okV0zAUbq74VH4+Tv99GuwuM+CrqDWr+FDgOl6UMPCvJnGQfFaTY4luWfgh9Z7AoI80k
         uF/v+Us0YZrONkl5Slm23pmHNAnTIK5bsCf3cZ9sLJ2TFMItf33Kvftuyh9yTNHAh/xp
         9naCsyAWV95cqGROrCRtImhKcLHZAikYWXQbEO1PTzhurOnhj0+tP/4hmKyX9uYKFVNm
         /DupFhSee9qpkJsRuBv0S3We0Q9lnUDqExpke9SzkvAXkBOAyJd/IImD43/OYN2BA5Y3
         gTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713766921; x=1714371721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgHnvH0SifwgzbjlbM6L8Ym3RK63epZLUnxr0JyiQ3A=;
        b=Gg87jiSq8NtQ3lRTXKyDBKRhG/5lLHR958/Ja2WvTzNcFZawayAFvC1VsByuHXZS/Q
         sAAzB4knLF13N2QDcHQbIc4Ab0sdR3hhLn93tltYaK4+ReSUTWyrWl0VBTqeCVFJWNFt
         ZYBj3UiGtv+YgDk4oPi5uuRXBj4TsfAZSstxVC5MdGgEgZszBe04+TWTJr/yG1sHDOpv
         y4+MnLapeEFWAF503rIzdiDdk+VKb332oy86KJWyFqTQh6znTRQLX480mgoIrlQTDVwJ
         UVj5Kyq98r7VwFilFwmpK2Hr5jVKFjbJaP58Hxu53vsewIR0dowYhLtAJv4Px5yhtqTO
         HAtw==
X-Forwarded-Encrypted: i=1; AJvYcCX6g8kGwRh4LBsZNxP+/tNaBskD64D2HLsMt06vLQsgUk7094VkrssZjPJqbWLcdloVnta0OFA6RGd3I0n1BpFIncHejMucLo2eU6fh6VH7
X-Gm-Message-State: AOJu0Yw+vcHFIjn9cYvLBrEdY2d6nfbgpc3c26HbB7wtSSmAJgmIO+rl
	VIt+E+5jPRvx1VSlqsp25lFt2WjqeiqvsvkTMwPYwbcC9fuSraILEAaaEJN/ga+csmWaJJzbXvQ
	irA==
X-Google-Smtp-Source: AGHT+IG60hX85zyqhoN/GGQeaHC9TWv2bBTAYTzrGgW8aBKeakB6ufmF0DHNgdD+A/EpTFGn21ykx8dr8NA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:8c3:b0:5fc:52b3:a014 with SMTP id
 ch3-20020a056a0208c300b005fc52b3a014mr21986pgb.4.1713766921226; Sun, 21 Apr
 2024 23:22:01 -0700 (PDT)
Date: Mon, 22 Apr 2024 06:21:43 +0000
In-Reply-To: <2024041509-triangle-parlor-1783@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024041509-triangle-parlor-1783@gregkh>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422062148.642140-1-edliaw@google.com>
Subject: [PATCH 6.6.y] selftests/timers/posix_timers: Reimplement check_timer_distribution()
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Cc: kernel-team@android.com, Oleg Nesterov <oleg@redhat.com>, 
	Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Oleg Nesterov <oleg@redhat.com>

check_timer_distribution() runs ten threads in a busy loop and tries to
test that the kernel distributes a process posix CPU timer signal to every
thread over time.

There is not guarantee that this is true even after commit bcb7ee79029d
("posix-timers: Prefer delivery of signals to the current thread") because
that commit only avoids waking up the sleeping process leader thread, but
that has nothing to do with the actual signal delivery.

As the signal is process wide the first thread which observes sigpending
and wins the race to lock sighand will deliver the signal. Testing shows
that this hangs on a regular base because some threads never win the race.

The comment "This primarily tests that the kernel does not favour any one."
is wrong. The kernel does favour a thread which hits the timer interrupt
when CLOCK_PROCESS_CPUTIME_ID expires.

Rewrite the test so it only checks that the group leader sleeping in join()
never receives SIGALRM and the thread which burns CPU cycles receives all
signals.

In older kernels which do not have commit bcb7ee79029d ("posix-timers:
Prefer delivery of signals to the current thread") the test-case fails
immediately, the very 1st tick wakes the leader up. Otherwise it quickly
succeeds after 100 ticks.

CI testing wants to use newer selftest versions on stable kernels. In this
case the test is guaranteed to fail.

So check in the failure case whether the kernel version is less than v6.3
and skip the test result in that case.

[ tglx: Massaged change log, renamed the version check helper ]
[ edliaw: 071af0c9e582 ("selftests: timers: Convert posix_timers test to
  generate KTAP output") wasn't merged to 6.6.y, so resolved merge
  conflicts. ]

Fixes: e797203fb3ba ("selftests/timers/posix_timers: Test delivery of signals across threads")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240409133802.GD29396@redhat.com
(cherry picked from commit 6d029c25b71f2de2838a6f093ce0fa0e69336154)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kselftest.h           | 13 +++
 tools/testing/selftests/timers/posix_timers.c | 99 +++++++++----------
 2 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 529d29a35900..68d5a93dff8d 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -49,6 +49,7 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include <stdio.h>
+#include <sys/utsname.h>
 #endif
 
 #ifndef ARRAY_SIZE
@@ -327,4 +328,16 @@ static inline int ksft_exit_skip(const char *msg, ...)
 	exit(KSFT_SKIP);
 }
 
+static inline int ksft_min_kernel_version(unsigned int min_major,
+					  unsigned int min_minor)
+{
+	unsigned int major, minor;
+	struct utsname info;
+
+	if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
+		ksft_exit_fail_msg("Can't parse kernel version\n");
+
+	return major > min_major || (major == min_major && minor >= min_minor);
+}
+
 #endif /* __KSELFTEST_H */
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 9a42403eaff7..aaec7f9845c5 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -188,78 +188,71 @@ static int check_timer_create(int which)
 	return 0;
 }
 
-int remain;
-__thread int got_signal;
+static pthread_t ctd_thread;
+static volatile int ctd_count, ctd_failed;
 
-static void *distribution_thread(void *arg)
+static void ctd_sighandler(int sig)
 {
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
-	return NULL;
+	if (pthread_self() != ctd_thread)
+		ctd_failed = 1;
+	ctd_count--;
 }
 
-static void distribution_handler(int nr)
+static void *ctd_thread_func(void *arg)
 {
-	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
-		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
-}
-
-/*
- * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
- * timer signals. This primarily tests that the kernel does not favour any one.
- */
-static int check_timer_distribution(void)
-{
-	int err, i;
-	timer_t id;
-	const int nthreads = 10;
-	pthread_t threads[nthreads];
 	struct itimerspec val = {
 		.it_value.tv_sec = 0,
 		.it_value.tv_nsec = 1000 * 1000,
 		.it_interval.tv_sec = 0,
 		.it_interval.tv_nsec = 1000 * 1000,
 	};
+	timer_t id;
 
-	printf("Check timer_create() per process signal distribution... ");
-	fflush(stdout);
+	/* 1/10 seconds to ensure the leader sleeps */
+	usleep(10000);
 
-	remain = nthreads + 1;  /* worker threads + this thread */
-	signal(SIGALRM, distribution_handler);
-	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
-	if (err < 0) {
-		perror("Can't create timer\n");
-		return -1;
-	}
-	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		perror("Can't set timer\n");
-		return -1;
-	}
+	ctd_count = 100;
+	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
+		return "Can't create timer\n";
+	if (timer_settime(id, 0, &val, NULL))
+		return "Can't set timer\n";
 
-	for (i = 0; i < nthreads; i++) {
-		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
-			perror("Can't create thread\n");
-			return -1;
-		}
-	}
+	while (ctd_count > 0 && !ctd_failed)
+		;
 
-	/* Wait for all threads to receive the signal. */
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	if (timer_delete(id))
+		return "Can't delete timer\n";
 
-	for (i = 0; i < nthreads; i++) {
-		if (pthread_join(threads[i], NULL)) {
-			perror("Can't join thread\n");
-			return -1;
-		}
-	}
+	return NULL;
+}
 
-	if (timer_delete(id)) {
-		perror("Can't delete timer\n");
-		return -1;
-	}
+/*
+ * Test that only the running thread receives the timer signal.
+ */
+static int check_timer_distribution(void)
+{
+	const char *errmsg;
 
-	printf("[OK]\n");
+	signal(SIGALRM, ctd_sighandler);
+
+	errmsg = "Can't create thread\n";
+	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
+		goto err;
+
+	errmsg = "Can't join thread\n";
+	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
+		goto err;
+
+	if (!ctd_failed)
+		ksft_test_result_pass("check signal distribution\n");
+	else if (ksft_min_kernel_version(6, 3))
+		ksft_test_result_fail("check signal distribution\n");
+	else
+		ksft_test_result_skip("check signal distribution (old kernel)\n");
 	return 0;
+err:
+	ksft_print_msg(errmsg);
+	return -1;
 }
 
 int main(int argc, char **argv)
-- 
2.44.0.769.g3c40516874-goog


