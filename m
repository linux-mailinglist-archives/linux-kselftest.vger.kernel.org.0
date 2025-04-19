Return-Path: <linux-kselftest+bounces-31192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF04A941DF
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 07:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2ECD19E0E39
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 05:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760914901B;
	Sat, 19 Apr 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0M2k4EM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A3184F
	for <linux-kselftest@vger.kernel.org>; Sat, 19 Apr 2025 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745042161; cv=none; b=qUWz19x+2x7yNZtdcopyB85IGpmaHtGN/VgW4RfGp9hjcf9lB3VcgE766Qf3rZSVVJCapldQWe/MbbTpNgncB9/VfPgwxOC40PeiWOK219MzKNWM1R12Cq1ED1W/ZQfTHqZ1rPAP3xLcZWzqIBcuvaD16/PY+B6Rd+oxCbRWQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745042161; c=relaxed/simple;
	bh=Ow5OzIdQrw1DFiXgXxbjMJWQK3tqwXy5Fav+FGiBbw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bV9PLfpeHcRftcrUG3hBBH8jQQzTCxK6oWbY6LQrcI1uiAMynF8vsUD0jJpWZWlsCab2Q4yWBusyPilnCcMX4RM9zmBjtz8uLTXzx7iKqFK7Oze/eiJcztc/FGNiz1Ak7MAGmpi5IwVFp2e1BsPAWno//BrVnsx4OpZe69dapvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0M2k4EM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54991d85f99so3850227e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 22:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745042158; x=1745646958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdPIwZMbbH/v4IfyGs8wVOWQZOeGXcJa+MlXzZtV0wg=;
        b=O0M2k4EMdNYKsB4wsF2xOYGGIev4+1sujkeVG6+tfZKZaQFTz6BKg7QbBwhCKrW8qv
         JEN0E6jW/YDV90DpLYp5MccTWuD0+eA/SoQxNyL9MNPXiqnR41FSosKRTOiWwBgqMEVl
         DW2hBqQfOxmQuFKQg4+WbJ3lRP3hrGOvrSrbll2FTMout70QdgLC2HefLM00QQ3isfSE
         8ihm0YYoKs2dl1DJMixvBiuiQCMuu6xlu5P4qBaEhLoKgXB6C9mW2Y8VD3mFNe4eU4+Z
         8Mf3faMGCSbidIyjb8nENdlYIgWyiwz+cahiKWrZ1fP9HLkf5VjIVT4vA4EAfzBFZba+
         E6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745042158; x=1745646958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdPIwZMbbH/v4IfyGs8wVOWQZOeGXcJa+MlXzZtV0wg=;
        b=KgIBb45/7liIvbbV89UOzUlwqUt8BtMP20b6Y5lNJjixkY+2J7dnjb70MrmHxH0YqD
         rpnt7AHPBUSJghF2BP97wffVs5/fpOaumBAyArf5uw5cOagkHPO/uHaaGqi0g96VABUq
         Saw/B3RvI+5rLJTMAYlcNlIM/r/fCbBuUkNax7dcHguZYuK07QzwOoBtr7PwrY9a+TMH
         vfOfD5Q0xmd1VHO1kB5+xALAh9ohT/RUFefdIHjzMuQdEhXDOUA3FYmSGSiYridSapu9
         HiEKxFGUdzHJ4GW8N5NY1vwxAziiX70k+efY9zlhQ0rzkT2YYA9a9Lj9MFVJaok18YUM
         q+3g==
X-Forwarded-Encrypted: i=1; AJvYcCUXxHlzB9fbuchCObPaVvlLD7Ix7KWbO1qfPOkPIwtt6PyB2M4WHIxI90GLJy1t/lIuTmBcfLheXiHsf8y5u7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NbzEbWfytm5+Bd3r21tNPu7eqQQb1dMneniIbtEYwYuP268l
	9ARmAONSG9WS7xBKIhP5XLqplb9Vh/Rt3YesuL4GVKS8TJo9SPaUil8Nzpa86ShZ7nIgRRxESqH
	4LOTu0uW16kP3NJXnlnfnhUOKcLNJA1e8JGM=
X-Gm-Gg: ASbGncsViKDUNY0lFAkaID9SKerdoMGKkpi2NrgEPu471NfkfCZ+WnOVpxPzDPpTf4C
	3yKdU9dfHL98PIMBBbjekD3bnLrggcXkY8ZU7Rl2X0742S2R7ahIYdb9uHMhvgbmwcG6SjJ+col
	nMEnmDGQOoDC0sCyUmLJ0cNvrPDKKAyY2v4yfsu0ewaD5PgYHgm7pWh+WrgOUUeQ==
X-Google-Smtp-Source: AGHT+IEcHxjZqljPDfrwZ+WwyAACsxSZEdF+AnzuNtbkAxWcFAZWBScBT4hoQ7usLT55L4a5MJ5+ffD8mkHxy7acQLs=
X-Received: by 2002:a05:6512:31cf:b0:54b:117f:686f with SMTP id
 2adb3069b0e04-54d6e7f4e06mr1275061e87.28.1745042157705; Fri, 18 Apr 2025
 22:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320200306.1712599-1-jstultz@google.com> <Z-KURRE_Gr72Xv_n@localhost>
 <874izezv3c.ffs@tglx> <Z-Vx8kV4M3khPknC@localhost> <Z-qsg6iDGlcIJulJ@localhost>
 <87o6xgwftc.ffs@tglx> <Z-vL3cVZuQ8XQXhG@localhost> <87iknnwxa4.ffs@tglx>
 <Z-5HlSUEh1xgCi4f@localhost> <877c41wkis.ffs@tglx> <87h632wals.ffs@tglx>
 <CANDhNCrUhZktW=_h9YTZndmyHwe9YbUMG6uVYaEuQyuKsG4AEg@mail.gmail.com>
 <87tt6mq8jz.ffs@tglx> <87r01qq7hp.ffs@tglx>
In-Reply-To: <87r01qq7hp.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Fri, 18 Apr 2025 22:55:45 -0700
X-Gm-Features: ATxdqUHKCUss3Lu3EUOBiHOPQD5kXjTO7sufFV19DZLFsnOExQXyOVNeazDE9Mw
Message-ID: <CANDhNCr21HXQOqfhcJFM6x7pNHCevSEKdg2_jz7KbLj=g8+0Sg@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Prevent coarse clocks going backwards
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Miroslav Lichvar <mlichvar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 12:00=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> On Fri, Apr 18 2025 at 08:37, Thomas Gleixner wrote:
> > On Thu, Apr 17 2025 at 17:46, John Stultz wrote:
> >> Instead it seems like we should just do:
> >>   tk->coarse_nsec =3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
> >
> > You end up with the same problem again because xtime_nsec can move
> > backwards when the multiplier is updated, no?
>
> Something like the below should work.

Hey Thomas,
  So I did test this version (I'll call it v2) of the patch and it
does avoid the problem I was seeing earlier with your first patch.

Though I also just sent my own slight rework of your patch
(https://lore.kernel.org/lkml/20250419054706.2319105-1-jstultz@google.com/)=
.
The main difference with my version is just the avoidance of mid-tick
updates to the coarse clock by adjtime calls (and the slight benefit
of avoiding the mult in the update path, but this is probably minor).

It's done ok in my testing so far, but obviously the effects of these
changes can be subtle.

I'm ok with either approach, so let me know what you'd prefer.
For your version:
  Acked-by: John Stultz <jstultz@google.com>

thanks
-john

