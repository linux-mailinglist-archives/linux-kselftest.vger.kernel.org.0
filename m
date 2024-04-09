Return-Path: <linux-kselftest+bounces-7483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BB989DACE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 15:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32F31C20E8E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F1812FB31;
	Tue,  9 Apr 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HO69Uw+u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A4136E1C
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669983; cv=none; b=r7MR0qzzIiriUkPeJegRIJZ6vC+lEaJ2GcwnrkftbdoWxCgnHvAP6pyx9EIS0i2phRgqy5z+Ed7GpCGCb3vMOQJOrD6ISzcYfgaQgM5ZE2gUDVlTzGmdysEmuB8L3/kSCJlfv8/Buu5L52E6awSCd1zzqJbDCfc5lq/AlWS+thw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669983; c=relaxed/simple;
	bh=KensjnedLegccSGAdNxddcu/yT/aCf00Pqp6AFK3eTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLiFc6XVazoPRioP+GFJID+iVMtiQaA7c80OZfwhmQJ4oynxHRw0f/TN82WpVtvCQRzhQlLfwo2lAXhKC9pKzhw+Vvtk+KOALr+bjpdlVcwEikdDkqPWXawE/cQhzB+1pk3a16nql6z/znnI20+6Gr3XXGMh7mkpX0NkaANC010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HO69Uw+u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712669981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHNENpIo5P3xNA2FT6uR/Fpf8icdmb0An+YCTlDYv/k=;
	b=HO69Uw+uvP7r+OZWtz2fhouFcMTBNkYWzOQm8ECquZBvJbgx4nTO5FelrdwG4N9TKKE/9p
	NntivXw6KYKoL9DWMfOw0oKprnzegn9l9nBwxb2N2nQrc7EZI5a7Ajzj6U72Je6AAsqy41
	O0dgFznlRtA4MKy8XYnIhlLiul49+UQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-I0pd653lOZ2bOgxz-s13DQ-1; Tue, 09 Apr 2024 09:39:37 -0400
X-MC-Unique: I0pd653lOZ2bOgxz-s13DQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDDDF802A6F;
	Tue,  9 Apr 2024 13:39:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.56])
	by smtp.corp.redhat.com (Postfix) with SMTP id DFF89444300;
	Tue,  9 Apr 2024 13:39:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Apr 2024 15:38:11 +0200 (CEST)
Date: Tue, 9 Apr 2024 15:38:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Vyukov <dvyukov@google.com>, John Stultz <jstultz@google.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
Message-ID: <20240409133802.GD29396@redhat.com>
References: <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
 <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com>
 <20240408184957.GD25058@redhat.com>
 <87il0r7b4k.ffs@tglx>
 <20240409111051.GB29396@redhat.com>
 <877ch67nhb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ch67nhb.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Thomas says:

	The signal distribution test has a tendency to hang for a long
	time as the signal delivery is not really evenly distributed. In
	fact it might never be distributed across all threads ever in
	the way it is written.

To me even the

	This primarily tests that the kernel does not favour any one.

comment doesn't look right. The kernel does favour a thread which hits
the timer interrupt when CLOCK_PROCESS_CPUTIME_ID expires.

The new version simply checks that the group leader sleeping in join()
never receives SIGALRM, cpu_timer_fire() should always send the signal
to the thread which burns cpu.

Without the commit bcb7ee79029d ("posix-timers: Prefer delivery of signals
to the current thread") the test-case fails immediately, the very 1st tick
wakes the leader up. Otherwise it quickly succeeds after 100 ticks.

As Thomas suggested, the new version doesn't report the failure on the
pre v6.3 kernels that do not have the commit bcb7ee79029d; this is a
feature that obviously fails on the older kernels. So the patch adds the
new simple ksft_ck_kernel_version() helper and uses ksft_test_result_skip()
if check_timer_distribution() fails on the older kernel.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 tools/testing/selftests/kselftest.h           |  14 +++
 tools/testing/selftests/timers/posix_timers.c | 103 ++++++++----------
 2 files changed, 61 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 541bf192e30e..6aab3309c6a3 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -51,6 +51,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <stdio.h>
+#include <sys/utsname.h>
 #endif
 
 #ifndef ARRAY_SIZE
@@ -388,4 +389,17 @@ static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 	exit(KSFT_SKIP);
 }
 
+static inline int ksft_ck_kernel_version(unsigned int min_major,
+					 unsigned int min_minor)
+{
+	struct utsname info;
+	unsigned int major, minor;
+
+	uname(&info);
+	if (sscanf(info.release, "%u.%u.", &major, &minor) != 2)
+		ksft_exit_fail();
+
+	return major > min_major || (major == min_major && minor >= min_minor);
+}
+
 #endif /* __KSELFTEST_H */
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index d49dd3ffd0d9..64c41463b704 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -184,80 +184,71 @@ static int check_timer_create(int which)
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
 
-	remain = nthreads + 1;  /* worker threads + this thread */
-	signal(SIGALRM, distribution_handler);
-	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
-	if (err < 0) {
-		ksft_perror("Can't create timer");
-		return -1;
-	}
-	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	/* 1/10 seconds to ensure the leader sleeps */
+	usleep(10000);
 
-	for (i = 0; i < nthreads; i++) {
-		err = pthread_create(&threads[i], NULL, distribution_thread,
-				     NULL);
-		if (err) {
-			ksft_print_msg("Can't create thread: %s (%d)\n",
-				       strerror(errno), errno);
-			return -1;
-		}
-	}
+	ctd_count = 100;
+	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
+		return "Can't create timer";
+	if (timer_settime(id, 0, &val, NULL))
+		return "Can't set timer";
 
-	/* Wait for all threads to receive the signal. */
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	while (ctd_count > 0 && !ctd_failed)
+		;
 
-	for (i = 0; i < nthreads; i++) {
-		err = pthread_join(threads[i], NULL);
-		if (err) {
-			ksft_print_msg("Can't join thread: %s (%d)\n",
-				       strerror(errno), errno);
-			return -1;
-		}
-	}
+	if (timer_delete(id))
+		return "Can't delete timer";
 
-	if (timer_delete(id)) {
-		ksft_perror("Can't delete timer");
-		return -1;
-	}
+	return NULL;
+}
+
+/*
+ * Test that only the running thread receives the timer signal.
+ */
+static int check_timer_distribution(void)
+{
+	const char *errmsg;
 
-	ksft_test_result_pass("check_timer_distribution\n");
+	signal(SIGALRM, ctd_sighandler);
+
+	errmsg = "Can't create thread";
+	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
+		goto err;
+
+	errmsg = "Can't join thread";
+	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
+		goto err;
+
+	if (!ctd_failed)
+		ksft_test_result_pass("check signal distribution\n");
+	else if (ksft_ck_kernel_version(6, 3))
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
2.25.1.362.g51ebf55



