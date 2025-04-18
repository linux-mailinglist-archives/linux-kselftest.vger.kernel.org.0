Return-Path: <linux-kselftest+bounces-31121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E39CA93227
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE2D4A003D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94EB26982E;
	Fri, 18 Apr 2025 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GsVx85DA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dsh66z6h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12801269801;
	Fri, 18 Apr 2025 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744958260; cv=none; b=BsDNaeZZaC2XcH9K6BNk1lFmOF/5NPl6L1vIEZfI/7PdoRl42E9oD0bGS06kUNkKnwj207UhtVxQLTWZw7cThXG+SRv811x6vs3F+brMsb2tPl0/5WIQzZ5BQlfVkdplVgn0rwY9cVNeSOYAU2NTsFMletYR3SyDJSWPLTvMMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744958260; c=relaxed/simple;
	bh=0aBynvLXG7RFAuhSAB7nkyhz3bwLN7OMHNJoYY+pKY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dG6scDpIf9RiORu54hVACJKh03Jvf8ETngEPBN3vhTwWYICJCN0ZEWavggG2kY7IKp8BFZn6Wdl7NfylD4ffSS3ShQ9pgD5s6rxvKOpMz8mrumDmBlAF2fkzSIE6Y6B+KDul4N278Qje3y60dxi4mMKtVu1DwLf4SO+4cYREosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GsVx85DA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dsh66z6h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744958257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPPChowSmI742MDoycbATSJM4vPswT2WvPmIjq0t7Ik=;
	b=GsVx85DA+WxqGAi+60Q+e8FtM1t2J8aJCRc//BBw2pJxfuKRbnXVl6DkpNzhFq6o8Qx4+m
	vg+mN461NZGFa0BMQ7BvdZSlWsqrPmRLddgTUV6BFEL8bXn5jNbMlBGNJfT9uqUmRqdWDF
	md3/tF3EgmIL1+To4vwoJZrCymn1y2AiwDTevCtGo0x/zcn34MTvJjHSstn1M4lS1hHqLp
	4x3mrYXFZBThydOzFUOQ/eYxzbBDViwsMabrcOUlO57tLPSXFfSsEsXWBa3jeuWB/RCAtE
	C4sgIIKYbrZPVM2qFsnnSY7nOAUPsGfoEp2cwYUvntF9H6fW+AD5bBqCnDe2Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744958257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPPChowSmI742MDoycbATSJM4vPswT2WvPmIjq0t7Ik=;
	b=Dsh66z6hmGNwSnPQOmSj+XpMcABwG6e2vMhU5wPIlb8TCZgzgrpubZOod5i93rTbQXA9+n
	qThs4ATOuuV5yxDA==
To: John Stultz <jstultz@google.com>
Cc: Miroslav Lichvar <mlichvar@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, kernel-team@android.com, Lei Chen
 <lei.chen@smartx.com>
Subject: Re: [PATCH] timekeeping: Prevent coarse clocks going backwards
In-Reply-To: <CANDhNCrUhZktW=_h9YTZndmyHwe9YbUMG6uVYaEuQyuKsG4AEg@mail.gmail.com>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost> <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost> <Z-qsg6iDGlcIJulJ@localhost>
 <87o6xgwftc.ffs@tglx> <Z-vL3cVZuQ8XQXhG@localhost> <87iknnwxa4.ffs@tglx>
 <Z-5HlSUEh1xgCi4f@localhost> <877c41wkis.ffs@tglx> <87h632wals.ffs@tglx>
 <CANDhNCrUhZktW=_h9YTZndmyHwe9YbUMG6uVYaEuQyuKsG4AEg@mail.gmail.com>
Date: Fri, 18 Apr 2025 08:37:36 +0200
Message-ID: <87tt6mq8jz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17 2025 at 17:46, John Stultz wrote:
> On Sat, Apr 5, 2025 at 2:40=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> @@ -1831,6 +1847,8 @@ void timekeeping_resume(void)
>>         /* Re-base the last cycle value */
>>         tks->tkr_mono.cycle_last =3D cycle_now;
>>         tks->tkr_raw.cycle_last  =3D cycle_now;
>> +       /* Reset the offset for the coarse time getters */
>> +       tks->coarse_nsec =3D 0;
>>
>>         tks->ntp_error =3D 0;
>>         timekeeping_suspended =3D 0;
>
>
> So using the clocksource-switch test in kselftest, I can pretty easily
> hit inconsistencies with this.
>
> The reason is since we use the coarse_nsec as the nanosecond portion
> of the coarse clockids, I don't think we ever want to set it to zero,
> as whenever we do so, we lose the previous contents and cause the
> coarse time to jump back.

Bah. Obviously. What was I thinking?

> It seems more likely that we'd want to do something similar to
> tk_update_coarse_nsecs() filling it in with the shifted down
> tk->tkr_mono.xtime_nsec.

Indeed. The earlier approach of handing the offset to
timekeeping_update_from_shadow() was exactly doing that. I dropped that
because of the uglyness vs. the TAI update case in adjtimex().

>> +static inline void tk_update_coarse_nsecs(struct timekeeper *tk, u64 of=
fset)
>> +{
>> +       offset *=3D tk->tkr_mono.mult;
>> +       tk->coarse_nsec =3D (tk->tkr_mono.xtime_nsec + offset) >> tk->tk=
r_mono.shift;
>> +}
>
> Thinking more on this, I get that you're providing the offset to save
> the "at the point" time into the coarse value, but I think this ends
> up complicating things.
>
> Instead it seems like we should just do:
>   tk->coarse_nsec =3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;

You end up with the same problem again because xtime_nsec can move
backwards when the multiplier is updated, no?

Thanks,

        tglx

