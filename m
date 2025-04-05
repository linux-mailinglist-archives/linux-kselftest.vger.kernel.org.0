Return-Path: <linux-kselftest+bounces-30162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A94BA7CBE2
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 23:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B1B189446B
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 21:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F71C5F05;
	Sat,  5 Apr 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TW4SZQc1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhzGtdeU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133591A5B8E;
	Sat,  5 Apr 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743889237; cv=none; b=Zd570AhvHc5pXDY0fKOl9AwxWQuL0vagFXoXJu6CGauvGDOE2auKn/53RRvbOtvWUMUj0IcQzESD7ClhTGkq598ZoqMlZzzDdC7EOmcdoSQ+cfKNk1E9yefa9NpiqzC7ql2YIKR9UOr/4/fAiJKcRNzIlD4qjKG8MeALMkwRQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743889237; c=relaxed/simple;
	bh=kprPlZZJiNMgWvA/NE/VYNCv1+PSLSeS4FCZkoRgwmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ez3xpk3ohAREZOmzTw0+B4aJKz7hKaoc8Mlks35MAT6udNj4CpT0HfzclB7TuMplglNBBYUwr1dX4PIrQS45Vbhsa4oj3murwF1/I+1xcwb+2cSPxWUKoLxVGzfxzNNqkgdk6If4SJMar266++MY53EY0WO+Uhz1hlPUrBHPcMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TW4SZQc1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NhzGtdeU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743889232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QU3+HHdh2agb5fZtEaD6Yh66AlIt9/giV7XCKXqObU=;
	b=TW4SZQc1h7FhzNZKqP3L615qfmY87W77rJQax+PdGAWM+ZDnPUKAk79mY5DL0pPSwvafsF
	6DLlp5ISKeMW8nx/WJMhkt08aqUg26gB/Xn3q4LcTHvyYrFfynpfLPw+R7C9aWkTam411e
	OivRn7EEyjKZBrUtLhZu/nIfgk7hyocSsxUNOyAfYp111LizlHJc/rM19unewU2pHy1PxC
	uyOSGcEjdJMtY3AE97Yq2nQbuu7vLS7CuxBvlhyNsUZgqpNyAohq/2hcMjX3hhQ/jZXZzP
	L0WvouoxSEFSVfxqg0bpsNzM02EEAtY5pM23BGTJsH7FLmKrLhNfLY/g8TpHAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743889232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QU3+HHdh2agb5fZtEaD6Yh66AlIt9/giV7XCKXqObU=;
	b=NhzGtdeUKUwyNwtzCDMzACgnzXrAi3aiefvxJ0DnLW2TRRleXdep1af9Sr+/gjsb35swSm
	aGMhEIHAy45QyECg==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: [PATCH] timekeeping: Prevent coarse clocks going backwards
In-Reply-To: <877c41wkis.ffs@tglx>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost> <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost> <Z-qsg6iDGlcIJulJ@localhost>
 <87o6xgwftc.ffs@tglx> <Z-vL3cVZuQ8XQXhG@localhost> <87iknnwxa4.ffs@tglx>
 <Z-5HlSUEh1xgCi4f@localhost> <877c41wkis.ffs@tglx>
Date: Sat, 05 Apr 2025 23:40:31 +0200
Message-ID: <87h632wals.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lei Chen raised an issue with CLOCK_MONOTONIC_COARSE seeing time
inconsistencies. Lei tracked down that this was being caused by the
adjustment

    tk->tkr_mono.xtime_nsec -= offset;

which is made to compensate for the unaccumulated cycles in offset when the
multiplicator is adjusted forward, so that the non-_COARSE clockids don't
see inconsistencies.

However, the _COARSE clockid getter functions use the adjusted xtime_nsec
value directly and do not compensate the negative offset via the
clocksource delta multiplied with the new multiplicator. In that case the
caller can observe time going backwards in consecutive calls.

By design, this negative adjustment should be fine, because the logic run
from timekeeping_adjust() is done after it accumulated approximately

     multiplicator * interval_cycles

into xtime_nsec.  The accumulated value is always larger then the

     mult_adj * offset

value, which is subtracted from xtime_nsec. Both operations are done
together under the tk_core.lock, so the net change to xtime_nsec is always
always be positive.

However, do_adjtimex() calls into timekeeping_advance() as well, to
apply the NTP frequency adjustment immediately. In this case,
timekeeping_advance() does not return early when the offset is smaller
then interval_cycles. In that case there is no time accumulated into
xtime_nsec. But the subsequent call into timekeeping_adjust(), which
modifies the multiplicator, subtracts from xtime_nsec to correct for the
new multiplicator.

Here because there was no accumulation, xtime_nsec becomes smaller than
before, which opens a window up to the next accumulation, where the
_COARSE clockid getters, which don't compensate for the offset, can
observe the inconsistency.

This has been tried to be fixed by forwarding the timekeeper in the case
that adjtimex() adjusts the multiplier, which resets the offset to zero:

  757b000f7b93 ("timekeeping: Fix possible inconsistencies in _COARSE clockids")

That works correctly, but unfortunately causes a regression on the
adjtimex() side. There are two issues:
    
   1) The forwarding of the base time moves the update out of the original
      period and establishes a new one.
    
   2) The clearing of the accumulated NTP error is changing the behaviour as
      well.
    
Userspace expects that multiplier/frequency updates are in effect, when the
syscall returns, so delaying the update to the next tick is not solving the
problem either.
    
Commit 757b000f7b93 was reverted so that the established expectations of
user space implementations (ntpd, chronyd) are restored, but that obviously
brought the inconsistencies back.

One of the initial approaches to fix this was to establish a seperate
storage for the coarse time getter nanoseconds part by calculating it from
the offset. That was dropped on the floor because not having yet another
state to maintain was simpler. But given the result of the above exercise,
this solution turns out to be the right one. Bring it back in a slightly
modified form.

The coarse time keeper uses xtime_nsec for calculating the nanoseconds part
of the coarse time stamp. After timekeeping_advance() adjusted the
multiplier in timekeeping_adjust(), the current time's nanosecond part is:

  nsec = (xtime_nsec + offset * mult) >> shift;

Introduce timekeeper::coarse_nsec and store that nanoseconds part in it,
switch the time getter functions and the VDSO update to use that value.
coarse_nsec is cleared on all operations which forward or initialize the
timekeeper because those operations do not have a remaining offset.

This leaves the adjtimex() behaviour unmodified and prevents coarse time
from going backwards.

Fixes: da15cfdae033 ("time: Introduce CLOCK_REALTIME_COARSE")
Reported-by: Lei Chen <lei.chen@smartx.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/lkml/20250310030004.3705801-1-lei.chen@smartx.com/
---
 include/linux/timekeeper_internal.h |    8 +++-
 kernel/time/timekeeping.c           |   60 ++++++++++++++++++++++++++++++++----
 kernel/time/vsyscall.c              |    4 +-
 3 files changed, 61 insertions(+), 11 deletions(-)

--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -51,7 +51,7 @@ struct tk_read_base {
  * @offs_real:			Offset clock monotonic -> clock realtime
  * @offs_boot:			Offset clock monotonic -> clock boottime
  * @offs_tai:			Offset clock monotonic -> clock tai
- * @tai_offset:			The current UTC to TAI offset in seconds
+ * @coarse_nsec:		The nanoseconds part for coarse time getters
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
  * @clock_was_set_seq:		The sequence number of clock was set events
@@ -76,6 +76,7 @@ struct tk_read_base {
  *				ntp shifted nano seconds.
  * @ntp_err_mult:		Multiplication factor for scaled math conversion
  * @skip_second_overflow:	Flag used to avoid updating NTP twice with same second
+ * @tai_offset:			The current UTC to TAI offset in seconds
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffy times)
@@ -100,7 +101,7 @@ struct tk_read_base {
  * which results in the following cacheline layout:
  *
  * 0:	seqcount, tkr_mono
- * 1:	xtime_sec ... tai_offset
+ * 1:	xtime_sec ... coarse_nsec
  * 2:	tkr_raw, raw_sec
  * 3,4: Internal variables
  *
@@ -121,7 +122,7 @@ struct timekeeper {
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
-	s32			tai_offset;
+	u32			coarse_nsec;
 
 	/* Cacheline 2: */
 	struct tk_read_base	tkr_raw;
@@ -144,6 +145,7 @@ struct timekeeper {
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
 	u32			skip_second_overflow;
+	s32			tai_offset;
 };
 
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -164,6 +164,15 @@ static inline struct timespec64 tk_xtime
 	return ts;
 }
 
+static inline struct timespec64 tk_xtime_coarse(const struct timekeeper *tk)
+{
+	struct timespec64 ts;
+
+	ts.tv_sec = tk->xtime_sec;
+	ts.tv_nsec = tk->coarse_nsec;
+	return ts;
+}
+
 static void tk_set_xtime(struct timekeeper *tk, const struct timespec64 *ts)
 {
 	tk->xtime_sec = ts->tv_sec;
@@ -252,6 +261,7 @@ static void tk_setup_internals(struct ti
 	tk->tkr_raw.clock = clock;
 	tk->tkr_raw.mask = clock->mask;
 	tk->tkr_raw.cycle_last = tk->tkr_mono.cycle_last;
+	tk->coarse_nsec = 0;
 
 	/* Do the ns -> cycle conversion first, using original mult */
 	tmp = NTP_INTERVAL_LENGTH;
@@ -708,6 +718,12 @@ static void timekeeping_forward_now(stru
 		tk_normalize_xtime(tk);
 		delta -= incr;
 	}
+
+	/*
+	 * Clear the offset for the coarse time as the above forward
+	 * brought the offset down to zero.
+	 */
+	tk->coarse_nsec = 0;
 }
 
 /**
@@ -804,8 +820,8 @@ EXPORT_SYMBOL_GPL(ktime_get_with_offset)
 ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned int seq;
 	ktime_t base, *offset = offsets[offs];
+	unsigned int seq;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -813,7 +829,7 @@ ktime_t ktime_get_coarse_with_offset(enu
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		base = ktime_add(tk->tkr_mono.base, *offset);
-		nsecs = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+		nsecs = tk->coarse_nsec;
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -1831,6 +1847,8 @@ void timekeeping_resume(void)
 	/* Re-base the last cycle value */
 	tks->tkr_mono.cycle_last = cycle_now;
 	tks->tkr_raw.cycle_last  = cycle_now;
+	/* Reset the offset for the coarse time getters */
+	tks->coarse_nsec = 0;
 
 	tks->ntp_error = 0;
 	timekeeping_suspended = 0;
@@ -2152,6 +2170,33 @@ static u64 logarithmic_accumulation(stru
 }
 
 /*
+ * Update the nanoseconds part for the coarse time keepers. They can't rely
+ * on xtime_nsec because xtime_nsec is adjusted when the multiplication
+ * factor of the clock is adjusted. See timekeeping_apply_adjustment().
+ *
+ * This is required because tk_read::cycle_last must be advanced by
+ * timekeeper::cycle_interval so that the accumulation happens with a
+ * periodic reference.
+ *
+ * But that adjustment of xtime_nsec can make it go backward to compensate
+ * for a larger multiplicator.
+ *
+ * timekeeper::offset contains the leftover cycles which were not accumulated.
+ * Therefore the nanoseconds portion of the time when the clocksource was
+ * read in timekeeping_advance() is:
+ *
+ *	nsec = (xtime_nsec + offset * mult) >> shift;
+ *
+ * Calculate that value and store it in timekeeper::coarse_nsec, from where
+ * the coarse time getters consume it.
+ */
+static inline void tk_update_coarse_nsecs(struct timekeeper *tk, u64 offset)
+{
+	offset *= tk->tkr_mono.mult;
+	tk->coarse_nsec = (tk->tkr_mono.xtime_nsec + offset) >> tk->tkr_mono.shift;
+}
+
+/*
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
@@ -2205,6 +2250,9 @@ static bool timekeeping_advance(enum tim
 	 */
 	clock_set |= accumulate_nsecs_to_secs(tk);
 
+	/* Compensate the coarse time getters xtime_nsec offset */
+	tk_update_coarse_nsecs(tk, offset);
+
 	timekeeping_update_from_shadow(&tk_core, clock_set);
 
 	return !!clock_set;
@@ -2248,7 +2296,7 @@ void ktime_get_coarse_real_ts64(struct t
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
@@ -2271,7 +2319,7 @@ void ktime_get_coarse_real_ts64_mg(struc
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 		offset = tk_core.timekeeper.offs_real;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -2350,12 +2398,12 @@ void ktime_get_coarse_ts64(struct timesp
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		now = tk_xtime(tk);
+		now = tk_xtime_coarse(tk);
 		mono = tk->wall_to_monotonic;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	set_normalized_timespec64(ts, now.tv_sec + mono.tv_sec,
-				now.tv_nsec + mono.tv_nsec);
+				  now.tv_nsec + mono.tv_nsec);
 }
 EXPORT_SYMBOL(ktime_get_coarse_ts64);
 
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -98,12 +98,12 @@ void update_vsyscall(struct timekeeper *
 	/* CLOCK_REALTIME_COARSE */
 	vdso_ts		= &vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
 	vdso_ts->sec	= tk->xtime_sec;
-	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	vdso_ts->nsec	= tk->coarse_nsec;
 
 	/* CLOCK_MONOTONIC_COARSE */
 	vdso_ts		= &vc[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
 	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec		= tk->coarse_nsec;
 	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
 	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 

