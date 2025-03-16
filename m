Return-Path: <linux-kselftest+bounces-29162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1BA6376F
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 21:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069BA7A523A
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 20:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12FC19995E;
	Sun, 16 Mar 2025 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OB6wG6/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7c+wN47I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36418A6A8;
	Sun, 16 Mar 2025 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742158621; cv=none; b=FbLc/7GS1R3yFBHq4Un6JlFA1meFg1bf9CO8TbaTNVpYHEi5fm3Z8nCiEIJsr8YKlVZ5ptcs3ayE3lwI587naCcMuENeAyburj1o6gx6C7R05LQXRYWQXPCMtFY/hYury+wO/maqVbZ0WVwLM0Jh3K83C+AeVWMVh4BGRU0XeGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742158621; c=relaxed/simple;
	bh=wfDxU6DtSE/cJbNDCKl9c31kHsoAkDBI1QoO45sGun4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qpy/CLOSbVpF0l+nz3EPzsoXTEnxehzRJZhs39TlzruKju1t/utHzSJF4M2EEpZ/rFbQSxQ/WB3w3FVp9zg3mRCkT45lxXzXMl1eNueMIkFUKDYVceaQcKCfHRQv2Gyjq8w3G4SHkCtLvRue8xlPCDyI7LsaJu5XmczO52xVEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OB6wG6/u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7c+wN47I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742158611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+OYxf6lPQBQG6RrmKDrfbwkkXlcbmNYx000UIS2bxI=;
	b=OB6wG6/ugfl/pk/k88s6rwqq9JLreDTeL0oMrpaIaY5q5r7IXHXwhgIIiYVa6BoHKodHgv
	4FchohNQ95y7z2SNVJapCy7/mt133CsCDb9pNj6H3rDTEqEig2rT089+jncIAky2/Jkiuo
	JUhd7kC0SV7HptIj8nQJPZgkImVHnC+GtZtSMJCoV2uFZjXtSDjuJILZyqax7kNWM6kvp4
	F7TR2kZ/CM4SH8dZcEY1N3Pui5fK5yYEjJeVDfdzGVuGUnMyrqCDpHrjrayyz9UUBER4fK
	orgrLmTLiw3rVNyMjpL7Q/4kfqbuTj5oQ/EV/tjhbd5YLpPzpQfuRxmyXMaKSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742158611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+OYxf6lPQBQG6RrmKDrfbwkkXlcbmNYx000UIS2bxI=;
	b=7c+wN47IUvQ7cuBmzZ8jziBeFwYfcu1cA9saOoXRgpvdCw2cnus9rcHhS0//gZhl4F4DWc
	k3JpF5bBrhnlN+Dg==
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, Miroslav Lichvar
 <mlichvar@redhat.com>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [RFC PATCH 1/2] time/timekeeping: Fix possible inconsistencies
 in _COARSE clockids
In-Reply-To: <CANDhNCqzHYJfaap5-TYPmtbaPm6AkS85hKdeSnprhEqMCAYcPw@mail.gmail.com>
References: <CANDhNCoueki=keYNcNr4eXqgLFPh3VupDJC0hFqxm4FNKfGzYg@mail.gmail.com>
 <20250315003800.3054684-1-jstultz@google.com> <877c4q5c9i.ffs@tglx>
 <CANDhNCqzHYJfaap5-TYPmtbaPm6AkS85hKdeSnprhEqMCAYcPw@mail.gmail.com>
Date: Sun, 16 Mar 2025 21:56:50 +0100
Message-ID: <874izs66el.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15 2025 at 16:22, John Stultz wrote:
> On Sat, Mar 15, 2025 at 12:23=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>> > So to fix this, rework the timekeeping_advance() logic a bit
>> > so that when we are called from do_adjtimex() and the offset
>> > is smaller then cycle_interval, that we call
>> > timekeeping_forward(), to first accumulate the sub-interval
>> > time into xtime_nsec. Then with no unaccumulated cycles in
>> > offset, we can do the mult adjustment without worry of the
>> > subtraction having an impact.
>>
>> It's a smart solution. I briefly pondered something similar, but I'm not
>> really fond of the fact, that it causes a clock_was_set() event for no
>> good reason.
>>
>> clock_was_set() means that there is a time jump. But that's absolutely
>> not the case with do_adjtimex() changing the frequency for quick
>> adjustments. That does not affect continuity at all.
>
> Oh, good point.  I wasn't thinking clearly about the semantics, and
> was being a little paranoid there (as most calls to
> timekeeping_forward_now() have clock_was_set() calls that follow). I
> suspect I can do away with that bit and avoid it.  I'll respin later
> this week.

Actually your patch is not even emitting a clock_was_set() event:

> +	if (offset < real_tk->cycle_interval) {
> +		timekeeping_forward(tk, now);
> +		*clock_set =3D 1;
> +		return 0;
> +	}

#define TK_CLEAR_NTP            (1 << 0)
#define TK_CLOCK_WAS_SET        (1 << 1)

So it clears NTP instead. Not really what you want either. :)

But yes, it simply can forward the clock without side effects.

I think that this should be done for all TICK_ADV_FREQ adjustments. In
case of such asynchronous adjustments it does not make any sense to take
the old ntp_error value into account and accumlate some more. In fact
this simply should clear ntp_error so the new value goes into effect as
provided by NTP and not skewed by ntp_error.

These async adjustments (usually very small ones) happen when the
current source degrades and chronyd/ntpd switches over to a new server.

Something like the below.

Thanks

        tglx
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -682,20 +682,19 @@ static void timekeeping_update_from_shad
 }
=20
 /**
- * timekeeping_forward_now - update clock to the current time
+ * timekeeping_forward - update clock to given cycle now value
  * @tk:		Pointer to the timekeeper to update
+ * @cycle_now:  Current clocksource read value
  *
  * Forward the current clock to update its state since the last call to
  * update_wall_time(). This is useful before significant clock changes,
  * as it avoids having to deal with this time offset explicitly.
  */
-static void timekeeping_forward_now(struct timekeeper *tk)
+static void timekeeping_forward(struct timekeeper *tk, u64 cycle_now)
 {
-	u64 cycle_now, delta;
+	u64 delta =3D clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->t=
kr_mono.mask,
+				      tk->tkr_mono.clock->max_raw_delta);
=20
-	cycle_now =3D tk_clock_read(&tk->tkr_mono);
-	delta =3D clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_m=
ono.mask,
-				  tk->tkr_mono.clock->max_raw_delta);
 	tk->tkr_mono.cycle_last =3D cycle_now;
 	tk->tkr_raw.cycle_last  =3D cycle_now;
=20
@@ -711,6 +710,21 @@ static void timekeeping_forward_now(stru
 }
=20
 /**
+ * timekeeping_forward_now - update clock to the current time
+ * @tk:		Pointer to the timekeeper to update
+ *
+ * Forward the current clock to update its state since the last call to
+ * update_wall_time(). This is useful before significant clock changes,
+ * as it avoids having to deal with this time offset explicitly.
+ */
+static void timekeeping_forward_now(struct timekeeper *tk)
+{
+	u64 cycle_now =3D tk_clock_read(&tk->tkr_mono);
+
+	timekeeping_forward(tk, cycle_now);
+}
+
+/**
  * ktime_get_real_ts64 - Returns the time of day in a timespec64.
  * @ts:		pointer to the timespec to be set
  *
@@ -2151,6 +2165,54 @@ static u64 logarithmic_accumulation(stru
 	return offset;
 }
=20
+static u64 timekeeping_accumulate(struct timekeeper *tk, u64 offset,
+				  enum timekeeping_adv_mode mode,
+				  unsigned int *clock_set)
+{
+	int shift =3D 0, maxshift;
+
+	/*
+	 * TK_ADV_FREQ indicates that adjtimex(2) directly set the
+	 * frequency or the tick length.
+	 *
+	 * Accumulate the offset, so that the new multiplier starts from
+	 * now. This is required as otherwise for offsets, which are
+	 * smaller than tk::cycle_interval, timekeeping_adjust() could set
+	 * xtime_nsec backwards, which subsequently causes time going
+	 * backwards in the coarse time getters. But even for the case
+	 * where offset is greater than tk::cycle_interval the periodic
+	 * accumulation does not have much value.
+	 *
+	 * Also reset tk::ntp_error as it does not make sense to keep the
+	 * old accumulated error around in this case.
+	 */
+	if (mode =3D=3D TK_ADV_FREQ) {
+		timekeeping_forward(tk, tk->tkr_mono.cycle_last + offset);
+		tk->ntp_error =3D 0;
+		return 0;
+	}
+
+	/*
+	 * With NO_HZ we may have to accumulate many cycle_intervals
+	 * (think "ticks") worth of time at once. To do this efficiently,
+	 * we calculate the largest doubling multiple of cycle_intervals
+	 * that is smaller than the offset.  We then accumulate that
+	 * chunk in one go, and then try to consume the next smaller
+	 * doubled multiple.
+	 */
+	shift =3D ilog2(offset) - ilog2(tk->cycle_interval);
+	shift =3D max(0, shift);
+	/* Bound shift to one less than what overflows tick_length */
+	maxshift =3D (64 - (ilog2(ntp_tick_length()) + 1)) - 1;
+	shift =3D min(shift, maxshift);
+	while (offset >=3D tk->cycle_interval) {
+		offset =3D logarithmic_accumulation(tk, offset, shift, clock_set);
+		if (offset < tk->cycle_interval << shift)
+			shift--;
+	}
+	return offset;
+}
+
 /*
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
@@ -2160,7 +2222,6 @@ static bool timekeeping_advance(enum tim
 	struct timekeeper *tk =3D &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk =3D &tk_core.timekeeper;
 	unsigned int clock_set =3D 0;
-	int shift =3D 0, maxshift;
 	u64 offset;
=20
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
@@ -2177,24 +2238,7 @@ static bool timekeeping_advance(enum tim
 	if (offset < real_tk->cycle_interval && mode =3D=3D TK_ADV_TICK)
 		return false;
=20
-	/*
-	 * With NO_HZ we may have to accumulate many cycle_intervals
-	 * (think "ticks") worth of time at once. To do this efficiently,
-	 * we calculate the largest doubling multiple of cycle_intervals
-	 * that is smaller than the offset.  We then accumulate that
-	 * chunk in one go, and then try to consume the next smaller
-	 * doubled multiple.
-	 */
-	shift =3D ilog2(offset) - ilog2(tk->cycle_interval);
-	shift =3D max(0, shift);
-	/* Bound shift to one less than what overflows tick_length */
-	maxshift =3D (64 - (ilog2(ntp_tick_length())+1)) - 1;
-	shift =3D min(shift, maxshift);
-	while (offset >=3D tk->cycle_interval) {
-		offset =3D logarithmic_accumulation(tk, offset, shift, &clock_set);
-		if (offset < tk->cycle_interval<<shift)
-			shift--;
-	}
+	offset =3D timekeeping_accumulate(tk, offset, mode, &clock_set);
=20
 	/* Adjust the multiplier to correct NTP error */
 	timekeeping_adjust(tk, offset);




