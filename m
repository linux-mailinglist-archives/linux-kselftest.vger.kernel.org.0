Return-Path: <linux-kselftest+bounces-7104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F248B897546
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AD9288E26
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C177B3E487;
	Wed,  3 Apr 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ouf7GHaC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z9SOqAvv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABF17C98;
	Wed,  3 Apr 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161926; cv=none; b=Pf07x9Z3SGS9WxbSg82yfYKhaTiEST//Zzm2+R4eKO2HEFAdcVspXM2viyzV9yQSUQUiYGrt4pu8Jzobh6Y3JFTrAeg9MEqyDbTwLvw6IsZgOFVrE3PN9PZhKVMPDyLbZZVeuf+cR+1LutP9WRdrVH/vm8JblEcIeD6pBAQeDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161926; c=relaxed/simple;
	bh=9vgw20i3aY7puKKhpdSKUq8VMauUIYN/C6m+FYzatuo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=eq+86g0eO7fhN5MxW5HZkQ9p7QRd68JEZvyBzz3iIZ50vzES27Lob/da9FBNSnPuIFS5opsKZAkCbqnafArfDfNgJ4LKLkxM3eHfRli3DctBA8rwOpomeosZ972bXq9HXAxnDPg8hp9kmRavDii4CwoMHJGzPZRzJARqjn9pQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ouf7GHaC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z9SOqAvv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712161923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=QL5+NDE0RM/D6PNrdYdHtXWw+c3iYIalpqMyMeR1Y8E=;
	b=Ouf7GHaCwmroDlOY5y+oNG1tK3hx2BlX9bPsk0F2TVkDtdpLUqCNGm3t8e84B0TlSO16jm
	BPQn9K8kisSVvWkk8QAbI2A1ZClo61prHZoE86Oks5qBZJRlPrM5ZeCopbsTFwL771xm/h
	spR37v+PnY5/H/mJOCEq7JYCCwPe5VAbSogXdGK99HaqTOSqmU4HmSKDFTS0kTwUM+vjgu
	PvuguutEBq1BcqB278Su2fiIArFKHdDzAJ6g/LjvxwXbe/nd5e8kG+0l54f/Agftqz0DbV
	c/1YfGszueCR4Y3n87etCYhu3xQgHL3TdC7kQmXucsmbxSec7j8jTvtHz+zfkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712161923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=QL5+NDE0RM/D6PNrdYdHtXWw+c3iYIalpqMyMeR1Y8E=;
	b=z9SOqAvvuemk2Ka9WcmpR5blHQJSW3c4lCUIs5SdylkA6G74nLnC7oTtfXL+Zn53MysRv1
	voT5MGNgrTg/EmBg==
To: Oleg Nesterov <oleg@redhat.com>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, Carlos Llamas
 <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
In-Reply-To: <87sf02bgez.ffs@tglx>
Date: Wed, 03 Apr 2024 18:32:02 +0200
Message-ID: <87r0fmbe65.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 03 2024 at 17:43, Thomas Gleixner wrote:
> On Wed, Apr 03 2024 at 17:03, Oleg Nesterov wrote:
>>
>> Why distribution_thread() can't simply exit if got_signal != 0 ?
>>
>> See https://lore.kernel.org/all/20230128195641.GA14906@redhat.com/
>
> Indeed. It's too obvious :)

Revised simpler version below.

Thanks,

        tglx
---
Subject: selftests/timers/posix_timers: Make signal distribution test less fragile
From: Thomas Gleixner <tglx@linutronix.de>

The signal distribution test has a tendency to hang for a long time as the
signal delivery is not really evenly distributed. In fact it might never be
distributed across all threads ever in the way it is written.

Address this by:

   1) Adding a timeout which aborts the test

   2) Letting the test threads exit once they got a signal instead of
      running continuously. That ensures that the other threads will
      have a chance to expire the timer and get the signal.

   3) Adding a detection whether all signals arrvied at the main thread,
      which allows to run the test on older kernels and emit 'SKIP'.

While at it get rid of the pointless atomic operation on a the thread local
variable in the signal handler.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   41 ++++++++++++++++----------
 1 file changed, 26 insertions(+), 15 deletions(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -184,18 +184,19 @@ static int check_timer_create(int which)
 	return 0;
 }
 
-int remain;
-__thread int got_signal;
+static int remain;
+static __thread int got_signal;
 
 static void *distribution_thread(void *arg)
 {
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	while (!done && !got_signal);
+
 	return NULL;
 }
 
 static void distribution_handler(int nr)
 {
-	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
+	if (++got_signal == 1)
 		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
 }
 
@@ -205,8 +206,6 @@ static void distribution_handler(int nr)
  */
 static int check_timer_distribution(void)
 {
-	int err, i;
-	timer_t id;
 	const int nthreads = 10;
 	pthread_t threads[nthreads];
 	struct itimerspec val = {
@@ -215,7 +214,11 @@ static int check_timer_distribution(void
 		.it_interval.tv_sec = 0,
 		.it_interval.tv_nsec = 1000 * 1000,
 	};
+	time_t start, now;
+	timer_t id;
+	int err, i;
 
+	done = 0;
 	remain = nthreads + 1;  /* worker threads + this thread */
 	signal(SIGALRM, distribution_handler);
 	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
@@ -230,8 +233,7 @@ static int check_timer_distribution(void
 	}
 
 	for (i = 0; i < nthreads; i++) {
-		err = pthread_create(&threads[i], NULL, distribution_thread,
-				     NULL);
+		err = pthread_create(&threads[i], NULL, distribution_thread, NULL);
 		if (err) {
 			ksft_print_msg("Can't create thread: %s (%d)\n",
 				       strerror(errno), errno);
@@ -240,7 +242,18 @@ static int check_timer_distribution(void
 	}
 
 	/* Wait for all threads to receive the signal. */
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	now = start = time(NULL);
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED)) {
+		now = time(NULL);
+		if (now - start > 2)
+			break;
+	}
+	done = 1;
+
+	if (timer_delete(id)) {
+		ksft_perror("Can't delete timer\n");
+		return -1;
+	}
 
 	for (i = 0; i < nthreads; i++) {
 		err = pthread_join(threads[i], NULL);
@@ -251,12 +264,10 @@ static int check_timer_distribution(void
 		}
 	}
 
-	if (timer_delete(id)) {
-		ksft_perror("Can't delete timer");
-		return -1;
-	}
-
-	ksft_test_result_pass("check_timer_distribution\n");
+	if (__atomic_load_n(&remain, __ATOMIC_RELAXED) == nthreads)
+		ksft_test_result_skip("No signal distribution. Assuming old kernel\n");
+	else
+		ksft_test_result(now - start <= 2, "check signal distribution\n");
 	return 0;
 }
 

