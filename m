Return-Path: <linux-kselftest+bounces-29855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87340A72C48
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 10:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D08177E61
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008120B204;
	Thu, 27 Mar 2025 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0SdLKf31";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8RpvHH9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56F13C8EA;
	Thu, 27 Mar 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067356; cv=none; b=YlrEqv1IgYlG+KJYHLAIfD7k4K9TkEv5jtLW+lVZDQbCruG90mEIjzqWReCtxSdRrefCr/uMLT5B05Fj9Q97CTxXrFukrZcxTQppPP82wrxO8X8Uj1r+lkEN5phuhZIpvF4aCyX7nAOOwMnUIylyOv739Jwl/o1D/ZAfhhVmp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067356; c=relaxed/simple;
	bh=HSwpJCE+9S/QXXVLY2uZUXNQoobSi1kJ+BvYoaB+08M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nPYw6he5Iu+sDUnYy0NTPbyBIHaLcmUO56wK2q8e5TzouqdfjfV+qcSuVI8e0Bge5qGulpJ1bG8WBT2J4+7i0gVzYZDkkW7e19Vw7rVM967slZoub2FI1ZWc9kjdcvga4nZ/k1tkJ/1RYrlY4KzeeWLCHMg+aIp6KO1y4suhF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0SdLKf31; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8RpvHH9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743067351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KEK3jcEN8joqVyburAERGhmitjt7xYkxorlQv+/di0=;
	b=0SdLKf31IP04gYTK/0I5duOypubjwAD39xHm4v2mX8VV7NiUObYTb/ELGQSJpas9qrZDUo
	cUS/otPkFU77JiawClI/DTFgk2B46zIIdl/hn3QHnSd3Rdj7j379CrY+SOnPOWzNZ5rgNY
	bP59TSwQskOO1H3i5JjpjjCSjr/rK801xEUX5BR0Th8AEe5Xw8DnP7ZQPydkmbGX/oe/NX
	p3jpWt9Nf5hY9cG4h6k3iq5F4YNIYGJ9tDiVj+UmTMtX6jgVRocrOBGnBF5g+ZvhhYa2jz
	G59cJpFW50VmfvS5kzNNCtB10WLrfPcnJSovoFNTMuh5Cd9bi4XqbtyWd3UOPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743067351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KEK3jcEN8joqVyburAERGhmitjt7xYkxorlQv+/di0=;
	b=Q8RpvHH9VIaiHWEi1g4fu6ZJz1LlSypxPm16LIvzE3X20/BK/Qed3y7SbJu+eQ/mHzelxh
	ON6FGg328tWDSsCQ==
To: Miroslav Lichvar <mlichvar@redhat.com>, John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, kernel-team@android.com, Lei Chen
 <lei.chen@smartx.com>
Subject: Re: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies
 in _COARSE clockids
In-Reply-To: <Z-KURRE_Gr72Xv_n@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost>
Date: Thu, 27 Mar 2025 10:22:31 +0100
Message-ID: <874izezv3c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 25 2025 at 12:32, Miroslav Lichvar wrote:
> On Thu, Mar 20, 2025 at 01:03:00PM -0700, John Stultz wrote:
>> +static u64 timekeeping_accumulate(struct timekeeper *tk, u64 offset,
>> +				  enum timekeeping_adv_mode mode,
>> +				  unsigned int *clock_set)
>
>> +	 * Also reset tk::ntp_error as it does not make sense to keep the
>> +	 * old accumulated error around in this case.
>> +	 */
>
> I'm not sure if I still understand the timekeeping code correctly, but
> that doesn't seem right to me. At least the comment should explain why
> it does not make sense to keep the NTP error.
>
> Resetting the NTP error causes a small time step. An NTP/PTP client
> can be setting the frequency very frequently, e.g. up to 128 times per
> second and the interval between updates can be random. If the timing

I never observed that behaviour, but I'm not a NTP/PTP wizard/power user.

> was right, I suspect it could cause a measurable drift. The client
> should be able to compensate for it, but why make its job harder by
> making the clock less predictable. My expectation for the clock is
> that its frequency will not change if the same (or only slightly
> different) frequency is set repeatedly by adjtimex().

The point is that timekeeper::ntp_error accumulates the error between
NTP and the clock interval. With John's change to forward the clock in
case of adjtimex() setting the tick length or frequency, the previously
accumulated information is out of sync because the forwarding resets the
period asynchronously.

The fundamental property of the timekeeper adjustment is that it
advances everything in multiples of the clock interval. The clock
interval is the number of hardware clock increments per tick, which has
been determined from the initial multiplier/shift pair of the clock
source at the point where the clock source is installed as the
timekeeper source. It never changes throughout the life time of the
clocksource.

The original implementation respected this base period, but John's
approach of forwarding, which cures the coarse time getter issue,
violates it. As a consequence the previous error accumulation is not
longer based on the base period because the period has been reset to the
random point in time when adjtimex() was invoked, which makes the error
accumulation a random number.

There are two ways to deal with that. Both require to revert this
change completely.

   1) Handle the coarse time getter problem seperately and leave the
      existing adjtimex logic alone. That was my initial suggestion:

      https://lore.kernel.org/all/87cyej5rid.ffs@tglx

   2) Handle adjtimex(ADJ_TICK/ADJ_FREQUENCY) at the next tick boundary
      instead of doing it immediately at the random point in time when
      adjtimex() is invoked.

      That cures the coarse time getter problem as well, but obviously
      delays the multiplier update to the next tick, which means that
      only the last adjtimex(ADJ_TICK/ADJ_FREQUENCY) invocation between
      two ticks becomes effective.

      From a pure mathematical point of view, this is keeping everything
      consistent. A quick test shows that it works. Though again, I'm
      not the NTP wizard here and don't know which dragons are lurking
      in the NTP/PTP clients.

      Patch on top of the revert below. That requires some thought
      vs. NOHZ delaying the next tick, but that's a solvable problem.

Thanks,

        tglx
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -34,14 +34,6 @@
 
 #define TK_UPDATE_ALL		(TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
 
-enum timekeeping_adv_mode {
-	/* Update timekeeper when a tick has passed */
-	TK_ADV_TICK,
-
-	/* Update timekeeper on a direct frequency change */
-	TK_ADV_FREQ
-};
-
 /*
  * The most important data for readout fits into a single 64 byte
  * cache line.
@@ -2155,7 +2147,7 @@ static u64 logarithmic_accumulation(stru
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static bool timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool timekeeping_advance(void)
 {
 	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
@@ -2173,8 +2165,8 @@ static bool timekeeping_advance(enum tim
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
 				   tk->tkr_mono.clock->max_raw_delta);
 
-	/* Check if there's really nothing to do */
-	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
+	/* Check if there's really something to do */
+	if (offset < real_tk->cycle_interval)
 		return false;
 
 	/*
@@ -2216,7 +2208,7 @@ static bool timekeeping_advance(enum tim
  */
 void update_wall_time(void)
 {
-	if (timekeeping_advance(TK_ADV_TICK))
+	if (timekeeping_advance())
 		clock_was_set_delayed();
 }
 
@@ -2548,10 +2540,6 @@ int do_adjtimex(struct __kernel_timex *t
 
 	audit_ntp_log(&ad);
 
-	/* Update the multiplier immediately if frequency was set directly */
-	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-		clock_set |= timekeeping_advance(TK_ADV_FREQ);
-
 	if (clock_set)
 		clock_was_set(CLOCK_SET_WALL);
 

