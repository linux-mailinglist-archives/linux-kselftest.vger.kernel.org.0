Return-Path: <linux-kselftest+bounces-31122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C5A93322
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 09:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F127E8E4558
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 07:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EFB26B2CE;
	Fri, 18 Apr 2025 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bs2FuZZj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vfm6nR+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6F209F2A;
	Fri, 18 Apr 2025 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744959638; cv=none; b=mnK4E7tJsGOkpGVtWHaF+MPG3OcNGiE1nI52At//lHMw4+1SCGoBrWFs6ifKQL4w5oPtiDBXCttSh5mpPKXOEybGHuYS5kgRBF6XqPVikbneMIcjoIQdPnnwtYaQcVDZ9fsDW2m0oxHzshFoFyBepTt4vXgtPYEU9lXLp9E1LKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744959638; c=relaxed/simple;
	bh=hg38UisYOjWi+AhqMt5rKPG94W/k41CEU87XQWxObtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i3g400tkBFwLqooQkAqQr/qlW3fbYBumalaHMHSsesjkJS3qmH1GTI8bkW6oGuW2vESJnMfrJaV4dSFwPf9zhpvYRvjy9DOeFuSFpa3w2AWG5/2zx+TW6gJEpZEkPsJpTswoIGWeTgX7WP0vwnfcwOgxisHtk5Et/mkzokPqBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bs2FuZZj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vfm6nR+q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744959634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLyjDDjWwH6JT+Z/8Im4zVZiWELCF2Yg3D6i3ZeuIZQ=;
	b=bs2FuZZjEVlXbSXKhXFkdbKJEik2vxkDfkWh3ooIhyNyDXMFuP93gPMvUyJbsXhX7ylUmG
	prdgPNcebC7DGRo/mXvpwa35tRDBGtCb18pOiMCLbWcL0jKAF4sMa+aXJtm8cXt7DiOWBn
	Q+r0VHGD2DxBNamjpSDSAzj6r0e1TG1t2huAdaaNfVwISJ6fsIYIvjyOAJQCFdls2rQhqc
	jdBUa074QayyTBMufSSOgTR0ntnvdGIndEe2wUF0hFHWwao+W1NN4afJKzpiStbGfZaS9C
	mpw1QozjLmlws5DUMDuILGpPW8VnmzYkDqs/ZGPj0tdBbrDfeCSs5wNosocvog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744959634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLyjDDjWwH6JT+Z/8Im4zVZiWELCF2Yg3D6i3ZeuIZQ=;
	b=vfm6nR+qg5pCY+UQ6lC/DA8m8G87/hmxxWkQ7SZksExYmC8rgSEXR87a07hu2UsnrUa8it
	OzmU7HW53q8TmSAA==
To: John Stultz <jstultz@google.com>
Cc: Miroslav Lichvar <mlichvar@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, kernel-team@android.com, Lei Chen
 <lei.chen@smartx.com>
Subject: Re: [PATCH] timekeeping: Prevent coarse clocks going backwards
In-Reply-To: <87tt6mq8jz.ffs@tglx>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost> <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost> <Z-qsg6iDGlcIJulJ@localhost>
 <87o6xgwftc.ffs@tglx> <Z-vL3cVZuQ8XQXhG@localhost> <87iknnwxa4.ffs@tglx>
 <Z-5HlSUEh1xgCi4f@localhost> <877c41wkis.ffs@tglx> <87h632wals.ffs@tglx>
 <CANDhNCrUhZktW=_h9YTZndmyHwe9YbUMG6uVYaEuQyuKsG4AEg@mail.gmail.com>
 <87tt6mq8jz.ffs@tglx>
Date: Fri, 18 Apr 2025 09:00:34 +0200
Message-ID: <87r01qq7hp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 18 2025 at 08:37, Thomas Gleixner wrote:
> On Thu, Apr 17 2025 at 17:46, John Stultz wrote:
>> Instead it seems like we should just do:
>>   tk->coarse_nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
>
> You end up with the same problem again because xtime_nsec can move
> backwards when the multiplier is updated, no?

Something like the below should work.

Thanks,

        tglx
---
 include/linux/timekeeper_internal.h |   10 ++++-
 kernel/time/timekeeping.c           |   62 ++++++++++++++++++++++++++++++++----
 kernel/time/vsyscall.c              |    4 +-
 3 files changed, 65 insertions(+), 11 deletions(-)

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
@@ -76,6 +76,8 @@ struct tk_read_base {
  *				ntp shifted nano seconds.
  * @ntp_err_mult:		Multiplication factor for scaled math conversion
  * @skip_second_overflow:	Flag used to avoid updating NTP twice with same second
+ * @tai_offset:			The current UTC to TAI offset in seconds
+ * @coarse_offset:		The offset of the coarse timekeeper in clock cycles
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffy times)
@@ -100,7 +102,7 @@ struct tk_read_base {
  * which results in the following cacheline layout:
  *
  * 0:	seqcount, tkr_mono
- * 1:	xtime_sec ... tai_offset
+ * 1:	xtime_sec ... coarse_nsec
  * 2:	tkr_raw, raw_sec
  * 3,4: Internal variables
  *
@@ -121,7 +123,7 @@ struct timekeeper {
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
-	s32			tai_offset;
+	u32			coarse_nsec;
 
 	/* Cacheline 2: */
 	struct tk_read_base	tkr_raw;
@@ -144,6 +146,8 @@ struct timekeeper {
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
 	u32			skip_second_overflow;
+	s32			tai_offset;
+	u32			coarse_offset;
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
+	tk->coarse_offset = 0;
 
 	/* Do the ns -> cycle conversion first, using original mult */
 	tmp = NTP_INTERVAL_LENGTH;
@@ -636,6 +646,34 @@ static void timekeeping_restore_shadow(s
 	memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->timekeeper));
 }
 
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
+ * timekeeper::offset contains the leftover cycles which were not accumulated.
+ * Therefore the nanoseconds portion of the time when the clocksource was
+ * read in timekeeping_advance() is:
+ *
+ *	nsec = (xtime_nsec + offset * mult) >> shift;
+ *
+ * Calculate that value and store it in timekeeper::coarse_nsec, from where
+ * the coarse time getters consume it.
+ */
+static inline void tk_update_coarse_nsecs(struct timekeeper *tk)
+{
+	u64 offset = (u64)tk->coarse_offset * tk->tkr_mono.mult;
+
+	tk->coarse_nsec = (tk->tkr_mono.xtime_nsec + offset) >> tk->tkr_mono.shift;
+}
+
 static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)
 {
 	struct timekeeper *tk = &tk_core.shadow_timekeeper;
@@ -658,6 +696,7 @@ static void timekeeping_update_from_shad
 
 	tk_update_leap_state(tk);
 	tk_update_ktime_data(tk);
+	tk_update_coarse_nsecs(tk);
 
 	update_vsyscall(tk);
 	update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
@@ -708,6 +747,12 @@ static void timekeeping_forward_now(stru
 		tk_normalize_xtime(tk);
 		delta -= incr;
 	}
+
+	/*
+	 * Clear the offset for the coarse time as the above forward
+	 * brought the offset down to zero.
+	 */
+	tk->coarse_offset = 0;
 }
 
 /**
@@ -804,8 +849,8 @@ EXPORT_SYMBOL_GPL(ktime_get_with_offset)
 ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned int seq;
 	ktime_t base, *offset = offsets[offs];
+	unsigned int seq;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -813,7 +858,7 @@ ktime_t ktime_get_coarse_with_offset(enu
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		base = ktime_add(tk->tkr_mono.base, *offset);
-		nsecs = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+		nsecs = tk->coarse_nsec;
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -1831,6 +1876,8 @@ void timekeeping_resume(void)
 	/* Re-base the last cycle value */
 	tks->tkr_mono.cycle_last = cycle_now;
 	tks->tkr_raw.cycle_last  = cycle_now;
+	/* Reset the offset for the coarse time getters */
+	tks->coarse_offset = 0;
 
 	tks->ntp_error = 0;
 	timekeeping_suspended = 0;
@@ -2205,6 +2252,9 @@ static bool timekeeping_advance(enum tim
 	 */
 	clock_set |= accumulate_nsecs_to_secs(tk);
 
+	/* Compensate the coarse time getters xtime_nsec offset */
+	tk->coarse_offset = (u32)offset;
+
 	timekeeping_update_from_shadow(&tk_core, clock_set);
 
 	return !!clock_set;
@@ -2248,7 +2298,7 @@ void ktime_get_coarse_real_ts64(struct t
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
@@ -2271,7 +2321,7 @@ void ktime_get_coarse_real_ts64_mg(struc
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 		offset = tk_core.timekeeper.offs_real;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -2350,12 +2400,12 @@ void ktime_get_coarse_ts64(struct timesp
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
 

