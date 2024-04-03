Return-Path: <linux-kselftest+bounces-7076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FEB896F08
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 14:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2841C238FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A100F59155;
	Wed,  3 Apr 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkFrhMgP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ag9EqcHN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC6B66E;
	Wed,  3 Apr 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148081; cv=none; b=Ec5s+9nftwGnebnMUKAt9vJPE1DXZld6eHfMDm2q2M5zOdnZWUeBTeGFuy91mt52Z3kx8iP0IL/+TDB/yWYAB6Jej8R1pRKhKTO+rldoTZ57qcKwIbcNCimbpfqHO/hSylUdDpQXbydTH1VBfMzkZgG9ASMF3tBHF1s0BZADKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148081; c=relaxed/simple;
	bh=8mKGsxi0RIo7UC0KAoB9yp5qpM4nBYh1Fe5vakSTcJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AuFs5Y+26xf0KkyOVq5q7767V5zh+oycQv1gttYVF1nK4JXoQT/YKNWJQYbKYe9Sjd9kgc8djNHkm98FwXR3+VtQxVl7ucF9mcKzOXzio0QYhrh/k9juRYc69601yj6+5iXu7pCWTyzbwZ6aC+77a84qa4QsPqpwTUVydECRfGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TkFrhMgP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ag9EqcHN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712148077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8VcjIqJYxqL7stv0uL/vZUNq6uNvM3BP6g5mSRVMO0=;
	b=TkFrhMgPzV1MWq/iw8liKFrNWj6RpfRhswmjmiUnOFwoXWeEmcaVjTRmaj3oIxO0/QGhaq
	T2tTvC14dLQEIrNQMVAaFpm/xq4cR/rfC1a40PMABKETn7QNuun+2Ny+Z7MoD4fFOGqMx3
	3/5rk5duDBfDgiKjq74bCw4ZcY3LIbiigRcLrTLtipjsWs362vjDhsNeFXm256wM8dj/RV
	fqfCBY9zluR1oBQsH2SB9PY6L631z8T8lKFbKUup3PpC90PmfGf4yO06pnue+BQlEuBQH2
	wZ2r/S/7jdA2wSmYl4JietlTRCEgSy4C4/AkEj++PAKG+ypBDzz01p8XsH9CkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712148077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8VcjIqJYxqL7stv0uL/vZUNq6uNvM3BP6g5mSRVMO0=;
	b=Ag9EqcHNXII8mxlpd+yiaY1+USazt/F0l7SzBD+SJ2H/XU4wqPvsmhqjbQF3OrwIiFmAbO
	2vKJVbvJs8MvRWDA==
To: John Stultz <jstultz@google.com>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, Carlos Llamas
 <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
In-Reply-To: <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
References: <20230316123028.2890338-1-elver@google.com>
 <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx>
 <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
Date: Wed, 03 Apr 2024 14:41:17 +0200
Message-ID: <874jcid3f6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02 2024 at 10:23, John Stultz wrote:
> On Tue, Apr 2, 2024 at 7:57=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> This test in particular exercises new functionality/behaviour, which
>> really has no business to be backported into stable just to make the
>> relevant test usable on older kernels.
>
> That's fair. I didn't have all the context around what motivated the
> change and the follow-on test, which is why I'm asking here.

It's a performance enhancement to avoid waking up idle threads for
signal delivery instead of just delivering it to the current running
thread which made the CPU timer fire. So it does not qualify for fix.

>> Why would testing with latest tests against an older kernel be valid per
>> se?
>
> So yeah, it definitely can get fuzzy trying to split hairs between
> when a change in behavior is a "new feature" or a "fix".
>
> Greg could probably articulate it better, but my understanding is the
> main point for running newer tests on older kernels is that newer
> tests will have more coverage of what is expected of the kernel. For
> features that older kernels don't support, ideally the tests will
> check for that functionality like userland applications would, and
> skip that portion of the test if it's unsupported. This way, we're
> able to find issues (important enough to warrant tests having been
> created) that have not yet been patched in the -stable trees.
>
> In this case, there is a behavioral change combined with a compliance
> test, which makes it look a bit more like a fix, rather than a feature
> (additionally the lack of a way for userland to probe for this new
> "feature" makes it seem fix-like).  But the intended result of this is
> just spurring this discussion to see if it makes sense to backport or
> not.  Disabling/ignoring the test (maybe after Thomas' fix to avoid it
> from hanging :) is a fine solution too, but not one I'd want folks to
> do until they've synced with maintainers and had full context.

I was staring at this test because it hangs even on upstream on a
regular base, at least in a VM. The timeout change I posted prevents the
hang, but still the posixtimer test will not have 0 fails.

The test if fragile as hell as there is absolutely no guarantee that the
signal target distribution is as expected. The expectation is based on a
statistical assumption which does not really hold.

So I came up with a modified variant of that, which can deduce pretty
reliably that the test runs on an older kernel.

Thanks,

        tglx
---
Subject: selftests/timers/posix_timers: Make signal distribution test less =
fragile
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 15 May 2023 00:40:10 +0200

The signal distribution test has a tendency to hang for a long time as the
signal delivery is not really evenly distributed. In fact it might never be
distributed across all threads ever in the way it is written.

Address this by:

   1) Adding a timeout which aborts the test

   2) Letting the test threads do a usleep() once they got a signal instead
      of running continuously. That ensures that the other threads will exp=
ire
      the timer and get the signal

   3) Adding a detection whether all signals arrvied at the main thread,
      which allows to run the test on older kernels.

While at it get rid of the pointless atomic operation on a the thread local
variable in the signal handler.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   48 +++++++++++++++++----=
-----
 1 file changed, 32 insertions(+), 16 deletions(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -184,18 +184,22 @@ static int check_timer_create(int which)
 	return 0;
 }
=20
-int remain;
-__thread int got_signal;
+static int remain;
+static __thread int got_signal;
=20
 static void *distribution_thread(void *arg)
 {
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
-	return NULL;
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED) && !done) {
+		if (got_signal)
+			usleep(10);
+	}
+
+	return (void *)got_signal;
 }
=20
 static void distribution_handler(int nr)
 {
-	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
+	if (++got_signal =3D=3D 1)
 		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
 }
=20
@@ -205,8 +209,6 @@ static void distribution_handler(int nr)
  */
 static int check_timer_distribution(void)
 {
-	int err, i;
-	timer_t id;
 	const int nthreads =3D 10;
 	pthread_t threads[nthreads];
 	struct itimerspec val =3D {
@@ -215,7 +217,11 @@ static int check_timer_distribution(void
 		.it_interval.tv_sec =3D 0,
 		.it_interval.tv_nsec =3D 1000 * 1000,
 	};
+	int err, i, nsigs;
+	time_t start, now;
+	timer_t id;
=20
+	done =3D 0;
 	remain =3D nthreads + 1;  /* worker threads + this thread */
 	signal(SIGALRM, distribution_handler);
 	err =3D timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
@@ -231,7 +237,7 @@ static int check_timer_distribution(void
=20
 	for (i =3D 0; i < nthreads; i++) {
 		err =3D pthread_create(&threads[i], NULL, distribution_thread,
-				     NULL);
+				     thread_sigs + i);
 		if (err) {
 			ksft_print_msg("Can't create thread: %s (%d)\n",
 				       strerror(errno), errno);
@@ -240,23 +246,33 @@ static int check_timer_distribution(void
 	}
=20
 	/* Wait for all threads to receive the signal. */
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	now =3D start =3D time(NULL);
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED)) {
+		now =3D time(NULL);
+		if (now - start > 5)
+			break;
+	}
+	done =3D 1;
=20
-	for (i =3D 0; i < nthreads; i++) {
+	if (timer_delete(id)) {
+		ksft_perror("Can't delete timer\n");
+		return -1;
+	}
+
+	for (i =3D 0, nsigs =3D 0; i < nthreads; i++) {
 		err =3D pthread_join(threads[i], NULL);
 		if (err) {
 			ksft_print_msg("Can't join thread: %s (%d)\n",
 				       strerror(errno), errno);
 			return -1;
 		}
+		nsigs +=3D thread_sigs[i];
 	}
=20
-	if (timer_delete(id)) {
-		ksft_perror("Can't delete timer");
-		return -1;
-	}
-
-	ksft_test_result_pass("check_timer_distribution\n");
+	if (!nsigs)
+		ksft_test_result_skip("No signal distribution. Assuming old kernel\n");
+	else
+		ksft_test_result(now - start < 5, "check_timer_distribution\n");
 	return 0;
 }
=20



