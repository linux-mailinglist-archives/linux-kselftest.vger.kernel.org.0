Return-Path: <linux-kselftest+bounces-26477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D79A32C91
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054E53AC5B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B6256C62;
	Wed, 12 Feb 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIDxdnhL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D72253F09;
	Wed, 12 Feb 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379332; cv=none; b=jFPVwBvouJ2vWeOKBhwLjvIXgC2cWDuyC8ol2XxIMHTTvcI0RBimE1Tg3HRbjLfIFl3/DiBv6kvRb/XGXcEb/iZoSIrVw17/Becs9enwpamv2/DcU7nB3Z0d4wJRK9Bv/GMKiH5squsPQkwlXgqVGvB2eF2Q169BIbCteBSxlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379332; c=relaxed/simple;
	bh=60cHMAsDRvIOHo48UF7M2hduYfC6u+0l/5xeFUgi6wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnYoKYqR2yyA/iix3FOic6bHk7dfOhJoQr1+l8UtDtKuwAcs2nz4jd6mb7CYwzcrI23oIkyb5bZ1Eqfz9oH/K1/orAhabvhoQVhusbgExZI1C9PnNNLKzGlDOTtq/XSqS+cuFTAEuUmlBXqxcEx/UC1YEYni4JHWArE1IlYSr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIDxdnhL; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308f53aef4fso26946281fa.0;
        Wed, 12 Feb 2025 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739379329; x=1739984129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBvdLo8gkR8Wy8cwK/8Vm6VLKmV1zg6ayYB1+AAnbp0=;
        b=fIDxdnhLQCKOzSGFTKVsGCLD3kndMohah1Gk0EIsHt3mBzNvve9EtdU4+WF9qw4+c1
         JkowzElcUaoQJXfpUZoS9fidWdB4Sq5hLq9xGOT15k/BJWmruZZPAfPM3zMowqiJFoi3
         4Xkpu+VoHhNSJloriIaUIZjGN86JoTRVtuJEucNJZVJs0oId2Xs46RvQtDUcVfENcpt3
         xZo0BHhxXm4sVlFUzqS4bDMT4jgfRehnzW97bzpy86+QS3Yy/eqVd1f3/GpigSrSznR0
         539tcaheXRy3FToUe9HJRa60gWCxk+AA6M1Y3pdwzSp0FNUxrTXgWnA9llp6+mLAJk8N
         Qd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379329; x=1739984129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBvdLo8gkR8Wy8cwK/8Vm6VLKmV1zg6ayYB1+AAnbp0=;
        b=XCcEzqnCBa6+autOi24WO1guycqE1r5htjZHs3IZxnXd5BO8xlk5y3szZKHtSRYt4R
         4kdwx3dWkllMVyV2lulV7kG5voz98/+PW/yPmI1CN9NKGit9K0T67owqK395VG4LMo5U
         peLTsMwriqo/Zo+1P2XDJxlDhrjzzBi1a5zLZlsDuhNvHtVApzCnjET8uGcCbZtRM1P7
         k9NIglcGHS0VC0qJBT3llZYTAzuu5afWhW9/BO6HqJOnaXjc1sQk1tUFIfOsAjYEFDqY
         3tB9QIRK2/TI3OzdV5kXKCIVWHGeWTxMb+072Q1AKIytHR4e3TifWOK1ZOXomJuPsBf9
         VsxA==
X-Forwarded-Encrypted: i=1; AJvYcCU1QplbU0HDfRgfWGlzOkp4xMIoDa6PP+MQDksVVvWpMDQjVHZLhmzgECg0DJvhHh/27FaHifhJE7hMwU4=@vger.kernel.org, AJvYcCVxVC8yjmQDyiJ9RG2y8rPPQu2ccOYUbUTMUx6/wCours5L1Z1pcz2vyvIcd1ChQNCQich4T8NHdikS9br8fGBg@vger.kernel.org
X-Gm-Message-State: AOJu0YxsH9DXf+1WUOr2+ThLebtnzXRpvyQzsKAwEMmXK8fHSBAyDnID
	AzI1QuijGoG34VYwJrQ+Rv+yl1RfxjjS9MQIrX36eRcCABqoXuA+phxrDifotTmlNoK59rEKpXQ
	OFvXGwPpy7AkPEDKl4w4p45duD8g=
X-Gm-Gg: ASbGnct3TND1nFLRf+UVyBceNCvvIcpqDTRorTNqYucIXdrBK1h3FKQh3iYg5l0V68+
	OO48HFoVSID5GjF+Cwc2y+YfgLDvVxEUbRosAY5k8ikZ8PojtSFN2Gc5f8mMavyMdr/KakqGv/P
	ruxsTzPReolIC1
X-Google-Smtp-Source: AGHT+IGlPgCSSnQs6QH/QeGmHrfb6k7riD6rc3wGRHOG75RycIS7kEPtaSqxnS6MDYNzFsUjm8bKnI+kG9vozNb7gGA=
X-Received: by 2002:a05:651c:b2b:b0:307:db5f:c44f with SMTP id
 38308e7fff4ca-309036697d7mr17588861fa.19.1739379328691; Wed, 12 Feb 2025
 08:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <Z6tvciJpQgTwYpGx@smile.fi.intel.com> <CAJ-ks9mcxW7zY33FPB+mZ75dQ2Xqo-viM9CpbL=0i0WXUPJRhw@mail.gmail.com>
 <Z6tytjvT1A-5TOrq@smile.fi.intel.com> <CAJ-ks9kSBMh0=dgPC-NiOhibnK_LhBjBdZ_AQ91h-DBZfYR1sw@mail.gmail.com>
 <Z6uGPZZ7LioJmekz@smile.fi.intel.com> <CAJ-ks9mGwXmiJ3_Kk4j0MnEqn24A9UJJXVhqtUjcG8W5ifodsA@mail.gmail.com>
In-Reply-To: <CAJ-ks9mGwXmiJ3_Kk4j0MnEqn24A9UJJXVhqtUjcG8W5ifodsA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Feb 2025 11:54:52 -0500
X-Gm-Features: AWEUYZmF5UVTVNJrgqmcY6YHP16q-YpXs83zwjEBlC-szLP67C1U0B5hNhwVw28
Message-ID: <CAJ-ks9k9d4aX+P9F10h3TqHPOCHEQ5m=QyMAv7bU+Xyb3LRsOQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:26=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> > Is it me who cut something or the above missing this information (total=
 tests)?
> > If the latter, how are we supposed to answer to the question if the fai=
led test
> > is from new bunch of cases I hypothetically added or regression of the =
existing
> > ones? Without this it seems like I need to go through all failures. OTO=
H it may
> > be needed anyway as failing test case needs an investigation.
>
> I assume you mean missing from the new output. Yeah, KUnit doesn't do
> this counting. Instead you get the test name in the failure message:
>
> > > > > > >     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %=
4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> > > > > > >             not ok 1 " "
> > > > > > >         # numbers_list_field_width_val_width: ASSERTION FAILE=
D at lib/scanf_kunit.c:92
>
> I think maybe you're saying: what if I add a new assertion (rather
> than a new test case), and I start getting failure reports - how do I
> know if the reporter is running old or new test code?
>
> In an ideal world the message above would give you all the information
> you need by including the line number from the test. This doesn't
> quite work out in this case because of the various test helper
> functions; you end up with a line number in the test helper rather
> than in the test itself. We could fix that by passing around __FILE__
> and __LINE__ (probably by wrapping the test helpers in a macro). What
> do you think?

I gave this a try locally, and it produced this output:

>     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_k=
unit.c:94
> lib/scanf_kunit.c:555: vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx=
 %4hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
>         not ok 1 " "
>     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_k=
unit.c:94
> lib/scanf_kunit.c:555: vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:=
%1hx:%4hx:%4hx:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
>         not ok 2 ":"
>     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_k=
unit.c:94
> lib/scanf_kunit.c:555: vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4=
hx,%1hx,%4hx,%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
>         not ok 3 ","
>     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_k=
unit.c:94
> lib/scanf_kunit.c:555: vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4=
hx-%4hx-%1hx-%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
>         not ok 4 "-"
>     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_k=
unit.c:94
> lib/scanf_kunit.c:555: vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/=
%2hx/%1hx/%4hx/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
>         not ok 5 "/"

Andy, Petr: what do you think? I've added this (and the original
output, as you requested) to the cover letter for when I reroll v8
(not before next week).

