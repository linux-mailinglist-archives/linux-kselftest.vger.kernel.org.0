Return-Path: <linux-kselftest+bounces-31178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D51DA93D2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 20:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C38A5818
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD174224237;
	Fri, 18 Apr 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jm7Mc944"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE021B9E7
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001651; cv=none; b=BCvHFMWs4z8wfUjdq9f3SlLZZh8BgBkS6o3QOVCxfXPbD56hZKW48pypCEhEKE9/FHLCAb6rHQT8HNfy96aHpGH2SHPcUOdiy1IofCi5zX6pM3KaaGr9lPZHZr+2aUMNtMfiQkQvai9MAZa6JR5FKe2AnpvTSJ5VG/teMj3QjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001651; c=relaxed/simple;
	bh=cqw05yzHdahroJKLOI/H3fvXy55QPQV2NEI62iCX4pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c03emtE0TdnkpH+Q2k+0MJ7PL8YMP9W9LmM3ez3s7ZRcTG2kbYVN2zHPCp+w7J6/8ZrLpaOMWuc7oOJ2Sg3s38dhWcPc3NCtHp6vyIBAAVvFW/diAJgXW+1PuEgnNifNyISiRKdXfN2RgCOsR4KFPcY6Alzrct2Klfv6YJhqeT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jm7Mc944; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-548409cd2a8so2857381e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745001648; x=1745606448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmJRxZYKBul0NPpO5GbE0uoXdY8UOk5hBegV76Q7fvc=;
        b=Jm7Mc944UYFh7EKr/mZXZf1buMlsmvQwBqkU5xR6U/56q+PvkymTmpodsAomjuzqOi
         TFDghhdPZbwTidr8j0jxSskJDi2fd7z3fj6aRUhs5Q7Ta9coUYRTFep+JiCgpzfgWqU9
         0MtT9zgUJnIAusixkRYbtGoRiZY3vqcX9JynJJJ7DGibIenPrejRpZz3MVqfmbnlx+lf
         JOVnZh/vuHfcjRUDK+SvQjZ506csIqEJ2gboWarMERUckKf4KIe/pgUly6f1g83gnbB+
         0dJP18GgT2WNOKtyTus+wMYZiI/BILU9K9hSJd8m/FVWlfQP3ChgcUZ0/Dk9u4688ejW
         UJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745001648; x=1745606448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmJRxZYKBul0NPpO5GbE0uoXdY8UOk5hBegV76Q7fvc=;
        b=srv/3X4BTcZ9cD668tC9wF6OuUZASoV4lNoFOT5bwAgZsTpAr24X32Zu5w1Q9hrq8F
         iSYY4593aqDPxb/WmJozEYTuJJK40rrX3rvftzFHPz2jQMkglGRFdg/p5ttEr752y0oP
         812EJESBKv+xX6k3nmk4EOzr0PWeT3RgU0mfC4PHC4yxOkBBdWMEDoP9D+N/oYhq26AC
         xAHjDTrqUvp/Bgp5XF8btMB1pecvCzLLJYR+J1oB5t0w85r9kCKNWjXtLdJVZlQ9Yaax
         Tn/w8TPlOE6w0kESA9cMZXBG4fPl9C8zQdF7IpsxtDefioDvvUWmZ3pA8DbqSvJVPOIF
         TQJg==
X-Forwarded-Encrypted: i=1; AJvYcCXbUqWjZzfxSehCdfVEYUrXjaL1+CzAjZfmADdyJi/xdeVgWvLa3Sbh+ABeGwwN0EMsXKhvkhzdM2H1Ea1h8UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wh5H55STBE9F6m4FoDa2lxc83oQ+Uf2pI7zegP1AJREFoQ5k
	hnh4k4bFnvhjb4Tq+LPSITfvGrTul9NwVoGrkjoiUn8pMuoavUSD/J9v6pU1K0aEvVz75JxTinm
	v0p9p29A6rgcPzqRwugdMGgObKTFeWOpjMf8=
X-Gm-Gg: ASbGnctKzNhDQ2Mx7fyHSdBKwEWII/pneJx5M7PUG0ojkYiktjY/J+Yx0VzaK8bdCUM
	aoRm6coB9IOYeQTni4oj89ojYjWTLnap8hpONV3j83rL4CtcF+Pm/Gy4YHIMPb1A9iB5eFxEIT/
	Qf1QyRVIEGFN0JL/u2jfqtKrjt2txxECT6tUkscdHQ4GT/TgUin9c=
X-Google-Smtp-Source: AGHT+IHwauR7oICVDPTufhPDofzFlYVO2KmfnqSJasO3/jpSYaW0ewuRj6/e23srPSp/mjovhyFhKvvdFvxaFMAMeWc=
X-Received: by 2002:a05:6512:2315:b0:54a:cbfb:b62e with SMTP id
 2adb3069b0e04-54d6e657553mr1402614e87.35.1745001647864; Fri, 18 Apr 2025
 11:40:47 -0700 (PDT)
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
 <CANDhNCrUhZktW=_h9YTZndmyHwe9YbUMG6uVYaEuQyuKsG4AEg@mail.gmail.com> <87tt6mq8jz.ffs@tglx>
In-Reply-To: <87tt6mq8jz.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Fri, 18 Apr 2025 11:40:35 -0700
X-Gm-Features: ATxdqUEVFnbxOsO7kS3fCud4zm8XAeBb8rxR4hR9fCFdWvV-CzY8t1AtIxHhH0U
Message-ID: <CANDhNCrNYuxP7xqNLKWGnhMOBEHGhD9-FceNAj7n=fQUsLwvMA@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Prevent coarse clocks going backwards
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Miroslav Lichvar <mlichvar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 11:37=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> On Thu, Apr 17 2025 at 17:46, John Stultz wrote:
> > On Sat, Apr 5, 2025 at 2:40=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> >> +static inline void tk_update_coarse_nsecs(struct timekeeper *tk, u64 =
offset)
> >> +{
> >> +       offset *=3D tk->tkr_mono.mult;
> >> +       tk->coarse_nsec =3D (tk->tkr_mono.xtime_nsec + offset) >> tk->=
tkr_mono.shift;
> >> +}
> >
> > Thinking more on this, I get that you're providing the offset to save
> > the "at the point" time into the coarse value, but I think this ends
> > up complicating things.
> >
> > Instead it seems like we should just do:
> >   tk->coarse_nsec =3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
>
> You end up with the same problem again because xtime_nsec can move
> backwards when the multiplier is updated, no?

That's assuming you update coarse_nsec on every call to do_adjtimex,
which I don't think is necessary (or wanted - as it would sort of be a
behavior change to the COARSE clockids).

The root issue here has been that there was a mistaken assumption that
the small negative adjustment done to the xtime_nsec base to match the
mult adjustment would only happen after a larger accumulation, but the
timekeeping_advance() call from do_adjtimex() doesn't actually intend
to advance the clock (just change the frequency), so those small
negative adjustments made via do_adjtimex() between accumulations
become visible to the coarse clockids.

Since the coarse clockids are expected to provide ~tick-granular time,
if we are keeping separate state, we should only be
incrementing/setting that state when we accumulate (with each
cycle_interval). We don't need to be making updates to the coarse
clock between ticks on every do_adjtime call. So saving off the
tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift value after we actually
accumulated something should be fine. Any inter-tick frequency
adjustments to xtime_nsec can be ignored by the coarse clockid state.

I'll test with your updated patch here, as I suspect it will avoid the
problem I'm seeing, but I do think things can be further simplified.

thanks
-john

