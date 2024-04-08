Return-Path: <linux-kselftest+bounces-7437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039B89CE5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 00:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3753F282F57
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1799149C49;
	Mon,  8 Apr 2024 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQn0DlXC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tsU0bRX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C0148FE3;
	Mon,  8 Apr 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614640; cv=none; b=Dgq3iD0b8qGzpG4z16HPnkhttgeUHEnwfqJ8B0wGFeSdg3Oes77Zn6x0LR3IK7aYbMCDaHeyzDXCUmsiLhKLyIb+1Prdbhg2VyCyh+EW2NsyHQm3LQAr3SWCiayk/Soa93NiVFi4J61jGO3Rg67BW4PSjCimn7i1ipapwd0QiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614640; c=relaxed/simple;
	bh=whQdxiq0EcWkxnnWUTp+6cxyZsM42KKWCB84lKtU8d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rkEUb+8Ky+hkONSJRcWrbYbAI13xziCnozYZs/WPxmWBiDzDpFmf8mD83XIPZ7lia+lC7IrDf6XnvBCxNPF7JwccVRtwBnUm5LJfX4EfdIgXhzMz3eR4j4jC64lzrObgBVhzqiYHoCI1qD6mTmkj+9aY8jJRNYm3xvnOiDEICCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HQn0DlXC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tsU0bRX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712614636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mmbn5DsA9ubK+0jZ4PQnylXNHi12qhjspWzNa9zKp8Q=;
	b=HQn0DlXCU8VSOIC30XSbmso5sXg0l225Uki7Vl+M20aIEvF9KkWjo6In6VrbRrfdmijDUz
	OscXcKvbdP24s7cumZJt+yanfArOKRDxAjB7TRxVu7GAyyen9SgfpgpwMjdPrKInsAOiaV
	350rax9nHGT+Dq8zbJkXQMIjzLQ+FLpNUJCQBenPLrGGnFCceoZSNteKDlmD+kJO2c+2YI
	vRnE8+YX7KHtuhg79ZQpc0aW7I1UcwlSSGdAkudwVnX/Smp5ZLTYWr5Q25dvIbnzel5K5H
	nWvcigoxriS6yD0jTWzzUBQBMcuJWZvtJ/qs6yZKOfrBh2xSmXovPwg0YGExew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712614636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mmbn5DsA9ubK+0jZ4PQnylXNHi12qhjspWzNa9zKp8Q=;
	b=2tsU0bRXVb9M89ctOJ/7UxL8bF9gx83mqL04zlDseQBw8ToliZXoI1z0RZwNkNhBVIDhuZ
	cybOcN/doI2DqRDg==
To: Oleg Nesterov <oleg@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, Edward Liaw
 <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
In-Reply-To: <20240408184957.GD25058@redhat.com>
References: <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx> <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx> <20240406150950.GA3060@redhat.com>
 <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com> <20240408184957.GD25058@redhat.com>
Date: Tue, 09 Apr 2024 00:17:15 +0200
Message-ID: <87il0r7b4k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 08 2024 at 20:49, Oleg Nesterov wrote:
> To me this test should simply do
>
> 	ksft_test_result(!ctd_failed, "check signal distribution\n");
> 	return 0;

Right.

> but I am not familiar with tools/testing/selftests/ and I am not sure
> I understand the last email from Thomas.

The discussion started about running new tests on older kernels. As this
is a feature and not a bug fix that obviously fails on older kernels.

So something like the uncompiled below should work.

Thanks,

        tglx
---
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -184,80 +184,83 @@ static int check_timer_create(int which)
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
-}
-
-static void distribution_handler(int nr)
-{
-	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
-		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
+	if (pthread_self() != ctd_thread)
+		ctd_failed = 1;
+	ctd_count--;
 }
 
-/*
- * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
- * timer signals. This primarily tests that the kernel does not favour any one.
- */
-static int check_timer_distribution(void)
+static void *ctd_thread_func(void *arg)
 {
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
+	return NULL;
+}
+
+static bool check_kernel_version(unsigned int min_major, unsigned int min_minor)
+{
+	unsigned int major, minor;
+	struct utsname info;
+
+	uname(&info);
+	if (sscanf(info.release, "%u.%u.", &major, &minor) != 2)
+		ksft_exit_fail();
+	return major > min_major || (major == min_major && minor >= min_minor);
+}
+
+/*
+ * Test that only the running thread receives the timer signal.
+ */
+static int check_timer_distribution(void)
+{
+	const char *errmsg;
+
+	if (!check_kernel_version(6, 3)) {
+		ksft_test_result_skip("check signal distribution (old kernel)\n");
 		return 0;
 	}
 
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
+	ksft_test_result(!ctd_failed, "check signal distribution\n");
 	return 0;
+
+err:
+	ksft_print_msg(errmsg);
+	return -1;
 }
 
 int main(int argc, char **argv)

