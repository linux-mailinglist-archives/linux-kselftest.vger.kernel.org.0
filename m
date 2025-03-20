Return-Path: <linux-kselftest+bounces-29516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8BA6ACA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 19:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218E24884C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075D1E5734;
	Thu, 20 Mar 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3B8WMO2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F0E1DE3A8
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493734; cv=none; b=Xab0jXeSMUZXcNf8v+up3Q6l54JPzSYvKrX9DpHTVph/N64wEl1RMrpMbKkpKPdDH5z0U8NYQUHsvFxFyi/Do0LO5uklzZy+hVfUhOhobLnSOyf/vCiQ4JSzmVYR3vmwBIax1ftv2EKM2LE4SeEPAFGOK7egGvu1RwFj848xSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493734; c=relaxed/simple;
	bh=NfLD+aV7WNHzuinaGLIv2qHDV06LYHAPAPx1TEPG8F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otANJchztsYbn7GLI+gFyiFomQcgCT/uQjpC0ahXkUL+gn07kDMjIKptNACiqIVQ67dQSTHNn3zi1AjWr9nXzUdkvBF7jxgsCo4vDNoSelq6PyJP0cS8VDXjzXHO4ffEG2ZX7pbZBt7KXQBusepw5vtCl84XeshFe7+p6FQwsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3B8WMO2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so11586251fa.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742493731; x=1743098531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps3xvTXiP2Q8pdSunqpw5GFrj/GawShWO6ob0r/ZRIQ=;
        b=S3B8WMO23PcnJgq4TzO9aovzF779qltA+uJ+cXzb8A+I63T8onhGwDsk1H5VBQrdQo
         yufQ7cMfdkg8Hj7I8JbnX1aTsb+H5jJ9fGMfhyUYBrSgdBuuusT2a7p2JiX93A7Xl+tF
         f48WO/6VbqNxPUfZ1phhVbbaZ/L+Tk+Zvp7BOxL64MJZzwB8iu7q4rhvODNJwgueQ86Z
         mwDUbFKgTmkUaIOkRioUg/AnKe7IhNn2ydg84CPCmiq4hSlPTtw0j8F4/k/IoCtOTMFP
         4J4Hbt8XV0kGts5adeGDpircAR2S7SMeE1B4MpYx7oRemsdpEreSgkELjEkBtK7UkJ0n
         M4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493731; x=1743098531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ps3xvTXiP2Q8pdSunqpw5GFrj/GawShWO6ob0r/ZRIQ=;
        b=r3KvaQ8ZuRLEczJMyJXLza8ZLTJXaI+49136ZywamZIh9r4Jf3hhPSVSuxbeLwaB9m
         1qSfWQEt7Zt6fT1+E7JqJVIgZOSXi5lsX4cObOlOwVYvSlzE2rXHkq2R0r+mWW1wwFqv
         UzxDfKVymrFhTSNBgtynWrTaGOrwf9aDM3V1yMxxQQK9asGTDjP1l8OP5lIF9Fw1d5iX
         mgzQr3KfSNil9oJmefhj4ZJkfWKy/pgLiDrvUVEifEoXJvWHXyXltw83CJZ3whkbu/cG
         /bwtEsi5bMJf7kgB0gEUn6MoI5TclxNN1EDg+xVg3rI/MH75O4ABO8n5vrPeJFKT2eWc
         L0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUJzb137cP3DC7srjjfC8b5yDUSRXTGUgeLVs2uFF8W+qI2JqnjU/t4GpNTV2lYfpoMXVhltIFhJxApncHzfB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+DJrSONCfhbkNUCIym9LV2FN8N2lnhluyY9+CI81z/vKuR/8/
	DhFixTiNShUJLX3U1fEZwORr7Yq+EQP/snWAC+HDgO5YJU1aL7MzcDj1JQLzdseDyEcCHyGaAiR
	eTlff3MiY5rKOhgj8I0MsIu6yXai8h3M4Vo3gwSyoAXJk2ioxIvpTRw==
X-Gm-Gg: ASbGnct/63fT/GLhY7lkJrhXJHIvLavBNNQSRHDlfKLhG+vzOFdZwbh0qJitzuxwkym
	uMiydc4cKAHYXUPwHVSqn2+Y76o/0qi7QL2dt9l+LpLI50sPyp7piJtMnUPqf7HrS+fafOpEZpy
	SMLVwh8Xgv6iZiObtXUd3maag=
X-Google-Smtp-Source: AGHT+IH1A2I3Q1xGxbrMuizjqlCPaL31QjjbRJF6QKnc6Zy2IZIs5ODnCMKnVFffDS6lMZ1Fo0I28c4wrpqW8Vm6Bqc=
X-Received: by 2002:a2e:bc04:0:b0:30c:201a:149a with SMTP id
 38308e7fff4ca-30d7e2aab8bmr549001fa.25.1742493730651; Thu, 20 Mar 2025
 11:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCoueki=keYNcNr4eXqgLFPh3VupDJC0hFqxm4FNKfGzYg@mail.gmail.com>
 <20250315003800.3054684-1-jstultz@google.com> <877c4q5c9i.ffs@tglx>
 <CANDhNCqzHYJfaap5-TYPmtbaPm6AkS85hKdeSnprhEqMCAYcPw@mail.gmail.com> <874izs66el.ffs@tglx>
In-Reply-To: <874izs66el.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Thu, 20 Mar 2025 19:01:56 +0100
X-Gm-Features: AQ5f1JouIpJsV-mk1ERtzhjPq3fo0yhyI84VjLLwlZBdX-L63aW0sE4ga6uFi3s
Message-ID: <CANDhNCrxmoK98pmL-ynPVu9tMpyrjMXZ_L7-R0nV2r=YGMg0OA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] time/timekeeping: Fix possible inconsistencies in
 _COARSE clockids
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 9:56=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
> On Sat, Mar 15 2025 at 16:22, John Stultz wrote:
> > On Sat, Mar 15, 2025 at 12:23=E2=80=AFPM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >> > So to fix this, rework the timekeeping_advance() logic a bit
> >> > so that when we are called from do_adjtimex() and the offset
> >> > is smaller then cycle_interval, that we call
> >> > timekeeping_forward(), to first accumulate the sub-interval
> >> > time into xtime_nsec. Then with no unaccumulated cycles in
> >> > offset, we can do the mult adjustment without worry of the
> >> > subtraction having an impact.
> >>
> >> It's a smart solution. I briefly pondered something similar, but I'm n=
ot
> >> really fond of the fact, that it causes a clock_was_set() event for no
> >> good reason.
> >>
> >> clock_was_set() means that there is a time jump. But that's absolutely
> >> not the case with do_adjtimex() changing the frequency for quick
> >> adjustments. That does not affect continuity at all.
> >
> > Oh, good point.  I wasn't thinking clearly about the semantics, and
> > was being a little paranoid there (as most calls to
> > timekeeping_forward_now() have clock_was_set() calls that follow). I
> > suspect I can do away with that bit and avoid it.  I'll respin later
> > this week.
>
> Actually your patch is not even emitting a clock_was_set() event:
>
> > +     if (offset < real_tk->cycle_interval) {
> > +             timekeeping_forward(tk, now);
> > +             *clock_set =3D 1;
> > +             return 0;
> > +     }
>
> #define TK_CLEAR_NTP            (1 << 0)
> #define TK_CLOCK_WAS_SET        (1 << 1)
>
> So it clears NTP instead. Not really what you want either. :)

Hey Thomas,
   Sorry for the slow reply here.   So I agree with you that we don't
want to set clock_set above, that was my mistake. But this last bit I
don't think is right, as timekeeping advance() just returns a bool
(return !!clock_set;), which is used to decide to call clock_was_set()
or not  - not the argument passed to clock_was_set().


> But yes, it simply can forward the clock without side effects.
>
> I think that this should be done for all TICK_ADV_FREQ adjustments. In
> case of such asynchronous adjustments it does not make any sense to take
> the old ntp_error value into account and accumlate some more. In fact
> this simply should clear ntp_error so the new value goes into effect as
> provided by NTP and not skewed by ntp_error.
>
> These async adjustments (usually very small ones) happen when the
> current source degrades and chronyd/ntpd switches over to a new server.
>
> Something like the below.

So I finally got a chance to look at the diff between your change and
mine, and your changes look good to me. Thanks again for catching the
clock_set thinko, and I agree clearing ntp_error looks like the right
thing to do.  I'm going to do some testing here with them and resubmit
shortly.

thanks
-john

