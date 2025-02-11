Return-Path: <linux-kselftest+bounces-26388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AF0A31067
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C9C1647CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC214253B6B;
	Tue, 11 Feb 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTIrM3b8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FACA230D0E;
	Tue, 11 Feb 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289472; cv=none; b=GxgNfXlGvth5LUDZLc5WXWWjoGktHdJ/kkhMZONYA1iHYyP1iIz9t1Vwk5h+lzuBvkACKArtJ6UeR6Noo4RZYDifn/kWnNEXgAiipBVGqinM8+2+WcBPD60zLrUynz8aeM4ZnkMXs+YH8u32NLE/eJqIooaLho+9YBY3YMUtI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289472; c=relaxed/simple;
	bh=igUfBnW0H/ZVwHw5B0VCNQjBq/WY6prMD9Yy2g+H1Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3aKfDHmAu6NEeLBbh5aNtuWJpfYaiJD79vOaIQjt3aFS64Wr6/+/DCtu3XGeUOxUdM3shjbEBrLvUpi53B4KJm995l9PgLO5Si1HK/QKbuY2ufVCiF5yJoihWX8BMcmb9EPrJaRBHNmj+F7mvHAGLmHYHHJ1SLcLPruHZ0oMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTIrM3b8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3072f8dc069so59953881fa.3;
        Tue, 11 Feb 2025 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739289469; x=1739894269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdNtGAmQ1++8CfeOM4m4R0aD5lviL2ojURbZJ38nqN8=;
        b=WTIrM3b8VhL3XWDVrhdpvpBP8fa5vsYGpOhPUhIcrBtVNz6o2TaV/J/Q50dexss1Ug
         G3U8XBrQDnQRniZAdWrQ8+ZzhS2GDNc5oNSoyk1wRTBuNbvOayOi5OyvTJPQ+77KUaNy
         zX7c8flXFpiPzs7EewwhUbrWs4EkmdG/1Ate840UxOMhbn7qaHtyLWWNTl9Dq5mxJJ8f
         mKqk4YTveLiPHOaFHO3BxjZ841Lspxi82eC8cRXnOIe7ssEzxZVIpGP2Xdf7Y+h5Fo2+
         mX5l9B7mcURUWWxYHujkK3sZhEvlA9CGZKAYeF9fxkZM+T5vufgG3skPe8bPWTvYa2lb
         QEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739289469; x=1739894269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdNtGAmQ1++8CfeOM4m4R0aD5lviL2ojURbZJ38nqN8=;
        b=vPSx96DLka9SkFt+sev/UBa+g5gN1TEla6rE8lqWstm1nxStNuJhtxTtSJDjyXxbX5
         DHNq5UGipLFBa0wAmVtGtHbmJHBf9aBq7axknGWruk7ANwBFwPNKIwSrD2sm8pp0LGQe
         Mo6rVf2Ga5ioB8qFCfRE2ItT3F5Gw3TBUVyKX60s0X2kbCBR31nDWdNUbPVEAc7JVc7h
         W5jiZ7IWFZj6cv5gtFuMrqRC7/gp4qs5CVW8IpXZIZANXL2txfG1UR5kFmQ+mcDTzojr
         A5yFLpL0JlC90oFY7FSeHh3bBuPRCcqHswyrbUea7/EW+M5j0jrjEK30OMh8zPzaXB17
         8dNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1XfAhXPaglFR4KwEXkCxWnDvFn5P9MymM6r+qwOyymcAmZtOQYvTz1Kb6HzNWQu/vaz9Psl+khhJO+0o=@vger.kernel.org, AJvYcCVkWILthBVPU+uMec62z2v2AQw5XWf1QSqWWk9kE+rr1uNpq/yM/85rNlx/cM/W0nQ1rtd1YF9QjnkUVNM8oqyC@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbVIePqx5GyOcc6ZyHgqKS2kKoWQ4SxIjZGw4fS45UvBlb8r9
	wHWpjm6Ha4AkoDHqFq42n3mxnQtKwzvd1wnMZVva6ogmA1/hpkRC9N/xU5VWEdz5SpT1VhH/5xB
	XKFQhRpVz83VP0E2nyZmMKQ/zN20=
X-Gm-Gg: ASbGncsbqkQJZ/TwT5b1sIRpZTYkXYxE7ZZksK0yBJvr8UcUtvrejycJx+jlRvPvxVt
	Br+z3o0/Q/kc5LPU6vZWSPHOGT1GYNOM2hdeU5bHxZhacuWkH/X5MEWNuZ/lgiwaqBi6JrVcO5x
	9tybNMTRyzan98
X-Google-Smtp-Source: AGHT+IH5Lz0xVbHy2p7Zzd4KjMIBOwTnYpwQCbbBgzjrW4cXXKUYmm+YalGaUZeuwCE6afHPMv8niA/jCbhVDmiEtDs=
X-Received: by 2002:a05:651c:1a0c:b0:309:2ed:72df with SMTP id
 38308e7fff4ca-309036dbf68mr31481fa.24.1739289468908; Tue, 11 Feb 2025
 07:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <Z6tvciJpQgTwYpGx@smile.fi.intel.com> <CAJ-ks9mcxW7zY33FPB+mZ75dQ2Xqo-viM9CpbL=0i0WXUPJRhw@mail.gmail.com>
 <Z6tytjvT1A-5TOrq@smile.fi.intel.com>
In-Reply-To: <Z6tytjvT1A-5TOrq@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 10:57:11 -0500
X-Gm-Features: AWEUYZkWuX3dcPWDfQFbMW4zVQMNolJOxu8giTzDL1QisWsULtS548fQuUplDvs
Message-ID: <CAJ-ks9kSBMh0=dgPC-NiOhibnK_LhBjBdZ_AQ91h-DBZfYR1sw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:54=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 11, 2025 at 10:47:03AM -0500, Tamir Duberstein wrote:
> > On Tue, Feb 11, 2025 at 10:40=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Feb 11, 2025 at 10:13:36AM -0500, Tamir Duberstein wrote:
>
> ...
>
> > > > - Use original test assertions as KUNIT_*_EQ_MSG produces hard-to-p=
arse
> > > >   messages. The new failure output is:
> > >
> > > It would be good if you put into cover letter, or even in the respect=
ful patch
> > > the example of the error report for the old code and new code that it=
 will be
> > > clear how it changes.
> > >
> > > >     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1=
hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> > > >             not ok 1 " "
> > > >         # numbers_list_field_width_val_width: ASSERTION FAILED at l=
ib/scanf_kunit.c:92
> > > >     vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:%1hx:%4hx:%4h=
x:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
> > > >             not ok 2 ":"
> > > >         # numbers_list_field_width_val_width: ASSERTION FAILED at l=
ib/scanf_kunit.c:92
> > > >     vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4hx,%1hx,%4hx,=
%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
> > > >             not ok 3 ","
> > > >         # numbers_list_field_width_val_width: ASSERTION FAILED at l=
ib/scanf_kunit.c:92
> > > >     vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4hx-%4hx-%1hx-=
%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
> > > >             not ok 4 "-"
> > > >         # numbers_list_field_width_val_width: ASSERTION FAILED at l=
ib/scanf_kunit.c:92
> > > >     vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/%2hx/%1hx/%4h=
x/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
> > > >             not ok 5 "/"
> > > >         # numbers_list_field_width_val_width: pass:0 fail:5 skip:0 =
total:5
> > > >         not ok 4 numbers_list_field_width_val_width
> > > >         # numbers_slice: ASSERTION FAILED at lib/scanf_kunit.c:92
> > > >     vsscanf("3c87eac0f4afa1f9231da52", "%1hx%4hx%4hx%4hx%1hx%4hx%4h=
x%1hx", ...) expected 1257942031 got 2886715518
> >
> > Makes sense. As you can see the error report for the new code is
> > included here. I'll add the old code's error report if I have to
> > respin v8.
>
> At a bare minimum. can you add in the reply to this email?

Oh, sure:

On Tue, Feb 11, 2025 at 6:54=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> [...]
>
> [  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", "%4h=
x %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 1690959=
881
> [  383.102843] test_scanf: vsscanf("f12:2:d:2:c166:1:36b:1906", "%3hx:%1h=
x:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...) expected 131085 got 851970
> [  383.105376] test_scanf: vsscanf("4,b2fe,3,593,6,0,3bde,0", "%1hx,%4hx,=
%1hx,%3hx,%1hx,%1hx,%4hx,%1hx", ...) expected 93519875 got 242430
> [  383.105659] test_scanf: vsscanf("6-1-2-1-d9e6-f-93e-e567", "%1hx-%1hx-=
%1hx-%1hx-%4hx-%1hx-%3hx-%4hx", ...) expected 65538 got 131073
> [  383.106127] test_scanf: vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2h=
x/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...) expected 125069 got 3901554741
> [  383.106235] test_scanf: vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx=
%1hx%4hx%4hx%1hx%4hx%3hx", ...) expected 571539457 got 106936
> [  383.106398] test_scanf: failed 6 out of 2545 tests

This is from https://lore.kernel.org/all/Z6s6WsIw3VCGys6K@pathway.suse.cz/
(doesn't load for me, seems lore is having problems).

