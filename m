Return-Path: <linux-kselftest+bounces-29996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C03A78250
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF9216F427
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0EE214213;
	Tue,  1 Apr 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VrT/DzH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ecyu4SU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB12046B7;
	Tue,  1 Apr 2025 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532168; cv=none; b=QmyOKFYj8Ul69eY50ZU+d9bKZ2hLaVJ/xtwTGxwHqpDWxvUXfP7fqryw+lM7Rdke1doEhsJuIZZfXZ/js1caez+m6dAu0Ar7O0ipX9+6UKLoTkFnOQvDnADF1NPDgglaglvORsz1cmHGpJletpct3UMDGJyTAzkvO2qgbm1Lrms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532168; c=relaxed/simple;
	bh=EgujnoBa6nsQn/IScrPesH7m6vJv4iil5agGF+4pITE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r8bCJwja7khFzxVpL7c6wlSrKqeNgcX/iiFGJP6iysUUdRV54KQNnhNbZcZHSGNRAukoItCqXjErZHU8eT6pNo/jkhKadU+sdUsqa4vXKZOPVOCe3p68QBIZ8dctCM0IBMB7iFP3zTbFXnwKu1w8JMQcwsduuBQD0LLTSrTWPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VrT/DzH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ecyu4SU7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743532164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EC8HRbYeaxQQI/c2Wi7DJaUcBUlB78Fi/nftbP8XnOA=;
	b=1VrT/DzHHtWIvDT6smt6Puda/Vy7c3CqdO9HPPnc4j/tx980L2VAFIwpikeoNggcmj3CU0
	3GI/kpG/05m3LTfF6tOdZFywYoJe4uqZhubl8oWtMZGuMpVKj4h+8vaIkUtuKGW3J0BLUb
	DnPuWWKGb4KSYuh+lxejnqMROUc8nl4L9R3tbuC5R/L02ei+Wx1vUUmLPm2ei5oNtSYM8k
	me9UjCKX94BK6fdmJSOChh7dda2Y1cOQ6enlBgaDfkvZexQSsJydyDSbRByP8Goql9r1f/
	2WkGn15eGNwjgEhuOu9ojWtPYPx9gHGAuwL9+nn71w9y58DwJcp+N4AXZwV3ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743532164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EC8HRbYeaxQQI/c2Wi7DJaUcBUlB78Fi/nftbP8XnOA=;
	b=Ecyu4SU7W9TUXybzWfiVhalIa61i57CvwYdgrPo28ong7wYB6z6wLQc2KLmCGCyFiJoM93
	3CkM3Cjf19FtWBAw==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies
 in _COARSE clockids
In-Reply-To: <Z-vL3cVZuQ8XQXhG@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost> <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost> <Z-qsg6iDGlcIJulJ@localhost>
 <87o6xgwftc.ffs@tglx> <Z-vL3cVZuQ8XQXhG@localhost>
Date: Tue, 01 Apr 2025 20:29:23 +0200
Message-ID: <87iknnwxa4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 01 2025 at 13:19, Miroslav Lichvar wrote:
> On Tue, Apr 01, 2025 at 08:34:23AM +0200, Thomas Gleixner wrote:
>> On Mon, Mar 31 2025 at 16:53, Miroslav Lichvar wrote:
>> > Mult reduction	Updates/sec	Skew before	Skew after
>> > 16		4		0.004		0.009
>> > 16		16		0.011		0.069
>> > 16		64		0.020		0.117
>> > 64		4		0.013		0.012
>> > 64		16		0.030		0.107
>> > 64		64		0.058		0.879
>> 
>> Hrm.
>> 
>> Can you try the delta patch below?
>
> It seems to improve the worst cases, but overall it's still
> a regression.
>
> Mult reduction	Updates/sec	Skew
> 16		4		0.012
> 16		16		0.014
> 16		64	        0.033
> 64		4		0.012
> 64		16		0.105
> 64		64		0.138

That's weird as it only delays the update to the next tick. My original
approach of maintaining seperate state for the coarse time keeper is
preserving the existing NTP behaviour.

Patch applies after reverting 757b000f7b93 ("timekeeping: Fix possible
inconsistencies in _COARSE clockids").

Thanks,

        tglx
---
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
@@ -31,6 +31,7 @@
 
 #define TK_CLEAR_NTP		(1 << 0)
 #define TK_CLOCK_WAS_SET	(1 << 1)
+#define TK_RETAIN_COARSE	(1 << 2)
 
 #define TK_UPDATE_ALL		(TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
 
@@ -164,6 +165,15 @@ static inline struct timespec64 tk_xtime
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
@@ -636,7 +646,34 @@ static void timekeeping_restore_shadow(s
 	memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->timekeeper));
 }
 
-static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)
+/*
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
+ * @offset contains the leftover cycles which were not accumulated.
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
+static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action, u64 offset)
 {
 	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 
@@ -659,6 +696,9 @@ static void timekeeping_update_from_shad
 	tk_update_leap_state(tk);
 	tk_update_ktime_data(tk);
 
+	if (!(action & TK_RETAIN_COARSE))
+		tk_update_coarse_nsecs(tk, offset);
+
 	update_vsyscall(tk);
 	update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
 
@@ -804,8 +844,8 @@ EXPORT_SYMBOL_GPL(ktime_get_with_offset)
 ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned int seq;
 	ktime_t base, *offset = offsets[offs];
+	unsigned int seq;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -813,7 +853,7 @@ ktime_t ktime_get_coarse_with_offset(enu
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		base = ktime_add(tk->tkr_mono.base, *offset);
-		nsecs = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+		nsecs = tk->coarse_nsec;
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -1374,7 +1414,7 @@ int do_settimeofday64(const struct times
 
 		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, ts_delta));
 		tk_set_xtime(tks, ts);
-		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL, 0);
 	}
 
 	/* Signal hrtimers about time change */
@@ -1413,7 +1453,7 @@ static int timekeeping_inject_offset(con
 
 		tk_xtime_add(tks, ts);
 		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
-		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL, 0);
 	}
 
 	/* Signal hrtimers about time change */
@@ -1493,7 +1533,7 @@ static int change_clocksource(void *data
 		timekeeping_forward_now(tks);
 		old = tks->tkr_mono.clock;
 		tk_setup_internals(tks, new);
-		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL, 0);
 	}
 
 	if (old) {
@@ -1690,7 +1730,7 @@ void __init timekeeping_init(void)
 
 	tk_set_wall_to_mono(tks, wall_to_mono);
 
-	timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
+	timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET, 0);
 }
 
 /* time in seconds when suspend began for persistent clock */
@@ -1774,7 +1814,7 @@ void timekeeping_inject_sleeptime64(cons
 		suspend_timing_needed = false;
 		timekeeping_forward_now(tks);
 		__timekeeping_inject_sleeptime(tks, delta);
-		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL, 0);
 	}
 
 	/* Signal hrtimers about time change */
@@ -1834,7 +1874,7 @@ void timekeeping_resume(void)
 
 	tks->ntp_error = 0;
 	timekeeping_suspended = 0;
-	timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
+	timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET, 0);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	touch_softlockup_watchdog();
@@ -1901,7 +1941,7 @@ int timekeeping_suspend(void)
 		}
 	}
 
-	timekeeping_update_from_shadow(&tk_core, 0);
+	timekeeping_update_from_shadow(&tk_core, 0, 0);
 	halt_fast_timekeeper(tks);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
@@ -2205,7 +2245,7 @@ static bool timekeeping_advance(enum tim
 	 */
 	clock_set |= accumulate_nsecs_to_secs(tk);
 
-	timekeeping_update_from_shadow(&tk_core, clock_set);
+	timekeeping_update_from_shadow(&tk_core, clock_set, offset);
 
 	return !!clock_set;
 }
@@ -2248,7 +2288,7 @@ void ktime_get_coarse_real_ts64(struct t
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
@@ -2271,7 +2311,7 @@ void ktime_get_coarse_real_ts64_mg(struc
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 		offset = tk_core.timekeeper.offs_real;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -2350,12 +2390,12 @@ void ktime_get_coarse_ts64(struct timesp
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
 
@@ -2539,7 +2579,8 @@ int do_adjtimex(struct __kernel_timex *t
 
 		if (tai != orig_tai) {
 			__timekeeping_set_tai_offset(tks, tai);
-			timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
+			timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET |
+						       TK_RETAIN_COARSE, 0);
 			clock_set = true;
 		} else {
 			tk_update_leap_state_all(&tk_core);
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
 




