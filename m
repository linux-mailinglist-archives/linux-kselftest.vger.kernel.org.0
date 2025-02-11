Return-Path: <linux-kselftest+bounces-26401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCC2A312DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 18:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668411885948
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50531F940A;
	Tue, 11 Feb 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y54eDFzY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608126BD8E;
	Tue, 11 Feb 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294819; cv=none; b=Px99ixPzmOvYrU4UKtnLhQwlhlrLzcDbqcUWPeqN8WFzQxhLEWPuWiQm+OnrNcafFiC1SY4N7LRCcbOuKwvuJn0GdRMdxUgqEcubV4MmVYYq5YquIkNI2LnXpiraAVfsDX40CrvJmwn1vd458qX4uIFvCcQj6FcDUBd+m0TPRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294819; c=relaxed/simple;
	bh=SwAtmGKbkRk/6jd58XdhuX1Gpa+J8POWiyyQkB9m+JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkmoXztZOInPYF5DTWxO/7nnZimWt7Xm8aFNAx03RrWKqf64wzYNiC2DlBBxJlsYiL/N0SKiqEAB9oIdVwoR1mZxbOWoWczhGmkmKPx+UejRAScnjS2xlO382GOQQ63Ty7ue0g9dHuiRhGJiFmWLNYZ6/6SUOlPdDRYxgojdXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y54eDFzY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so54066341fa.3;
        Tue, 11 Feb 2025 09:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739294816; x=1739899616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/my1KtNGprdh0u6If/d4X7EsH9AZGyeXBq0Impw/fg=;
        b=Y54eDFzYp1eRuyMbn3oMn4Ra2cSqFwEomZAXXq1zJTelCogoTVEu3af5Fya0UUc5Fc
         07KbQiiKfm1edUd5V4K7bC3ifwro1fZvoQrE3T6/pY9qCrKksUvojrAHKQOxHe91SEt6
         Am5AriFn0YU1hqm2u3CA6kIK/c5v2AD1ZQ5NgHTn3A7gWLhOAaBMybTW672BVK16vdwv
         JnEeGrizXP3EokG4/q6ElbCCSuBTMjCDEKstaU8iG4KAKH4NUgDuCqWHjz/hJ9RaDnhV
         Dyevc/HPbSrE+7KTbsDk/AS3oXyt9nDrxc7X9pHgOKjLysjmVjkw6e15nrnfd92tVPvn
         E4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739294816; x=1739899616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/my1KtNGprdh0u6If/d4X7EsH9AZGyeXBq0Impw/fg=;
        b=GiPsZlzVHxdw6cgS1zbw7ejO7iGR9Zcw7PHotGrbdPHpm8pWnVVy8GFyd1p8+hW8Eo
         FJ8vAgfn0OzL4PuTcKdi4SdE6KAkn1oANeDY4/9NARqrXF/KVMnXD3NGTg1sZn1Yi8iH
         VMHdJlTzGprv4zNxMkwj2fqKQKUF7UBAdIuIUCIF7rOtIPCVmavLiKQ8fM2Pgdgm5GvG
         +FNRQwqRqG48vQZiOmSBbOg20qyaOLs3qoQNpJ5XwVfhXZ7Uq5IQ/U4qlWJfxWC1PNGA
         2nwDs2E1ukOGcjnNmtAGS9H2wm85fvl38k+1lzcf+QOz4LC+2cgiai0JeIgWQcOk7WPm
         YSgg==
X-Forwarded-Encrypted: i=1; AJvYcCVv/+ouNepe+hkmlYZnwHd9vbC4jmBwIwXFTgwOK/6R9FXAySEQMQarMKNc5qq2sQ6rt66XC1IBK3ekaSKU6Pqs@vger.kernel.org, AJvYcCXXvTRv3kzxpZqqhrn4E8IQmgsbaGjxZmSQJt5ZqWLMy5Hr5EVbA9XODmN57ifXqV6EKFP5RODLb3MCxxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPoEqOTMQlYeptQFkhXphfgF/Na7feNDQvjVL3cmpmzBs2SQi
	yHK+MoiTHTO8TPRmc8xNJ7VKbxN61dh+BZfdFLJVHx3fDuK+2icrJDtkiF6+54v2GVgt57CCEdz
	tq/xPJaZ0n97+DY9Nk38WXIw7Vk8=
X-Gm-Gg: ASbGncvYzs8/1Ou0/fUYNmtPB+xNBWh+QkVjj6YPPT7UQwf5cqwywE3C+pPumEggafY
	nUNPmctA7GBOp4TXRqpelP0BKeRADqNywhvT2esqT2DQhlZ4DqPS1YvNVOOy3b/x/pBuaRf0kbN
	dcPpFhOpFX5s8l
X-Google-Smtp-Source: AGHT+IHWwI24rlnQWXy+pv30sHDR4wlFuDZ/mYg3TNCsyhM+shlNOQDOh4VfaXVfC3pnIMH/vaUUb90OSM9ohWdFPAs=
X-Received: by 2002:a2e:a912:0:b0:308:f455:1f79 with SMTP id
 38308e7fff4ca-309037dc4edmr1148881fa.21.1739294815807; Tue, 11 Feb 2025
 09:26:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <Z6tvciJpQgTwYpGx@smile.fi.intel.com> <CAJ-ks9mcxW7zY33FPB+mZ75dQ2Xqo-viM9CpbL=0i0WXUPJRhw@mail.gmail.com>
 <Z6tytjvT1A-5TOrq@smile.fi.intel.com> <CAJ-ks9kSBMh0=dgPC-NiOhibnK_LhBjBdZ_AQ91h-DBZfYR1sw@mail.gmail.com>
 <Z6uGPZZ7LioJmekz@smile.fi.intel.com>
In-Reply-To: <Z6uGPZZ7LioJmekz@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 12:26:19 -0500
X-Gm-Features: AWEUYZkpMIKRrj-0oAj59PKiCMH9W9MOjIvqSINScPvWNcK-xBfj7wRKPtBuFoU
Message-ID: <CAJ-ks9mGwXmiJ3_Kk4j0MnEqn24A9UJJXVhqtUjcG8W5ifodsA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:17=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 11, 2025 at 10:57:11AM -0500, Tamir Duberstein wrote:
> > On Tue, Feb 11, 2025 at 10:54=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Feb 11, 2025 at 10:47:03AM -0500, Tamir Duberstein wrote:
> > > > On Tue, Feb 11, 2025 at 10:40=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Tue, Feb 11, 2025 at 10:13:36AM -0500, Tamir Duberstein wrote:
>
> ...
>
> > > > > > - Use original test assertions as KUNIT_*_EQ_MSG produces hard-=
to-parse
> > > > > >   messages. The new failure output is:
> > > > >
> > > > > It would be good if you put into cover letter, or even in the res=
pectful patch
> > > > > the example of the error report for the old code and new code tha=
t it will be
> > > > > clear how it changes.
> > > > >
> > > > > >     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4h=
x %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> > > > > >             not ok 1 " "
> > > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED =
at lib/scanf_kunit.c:92
> > > > > >     vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:%1hx:%4hx=
:%4hx:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
> > > > > >             not ok 2 ":"
> > > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED =
at lib/scanf_kunit.c:92
> > > > > >     vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4hx,%1hx,%=
4hx,%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
> > > > > >             not ok 3 ","
> > > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED =
at lib/scanf_kunit.c:92
> > > > > >     vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4hx-%4hx-%=
1hx-%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
> > > > > >             not ok 4 "-"
> > > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED =
at lib/scanf_kunit.c:92
> > > > > >     vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/%2hx/%1hx=
/%4hx/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
> > > > > >             not ok 5 "/"
> > > > > >         # numbers_list_field_width_val_width: pass:0 fail:5 ski=
p:0 total:5
> > > > > >         not ok 4 numbers_list_field_width_val_width
> > > > > >         # numbers_slice: ASSERTION FAILED at lib/scanf_kunit.c:=
92
> > > > > >     vsscanf("3c87eac0f4afa1f9231da52", "%1hx%4hx%4hx%4hx%1hx%4h=
x%4hx%1hx", ...) expected 1257942031 got 2886715518
> > > >
> > > > Makes sense. As you can see the error report for the new code is
> > > > included here. I'll add the old code's error report if I have to
> > > > respin v8.
> > >
> > > At a bare minimum. can you add in the reply to this email?
> >
> > Oh, sure:
> >
> > On Tue, Feb 11, 2025 at 6:54=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
> > >
> > > [...]
> > >
> > > [  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", =
"%4hx %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 169=
0959881
> > > [  383.102843] test_scanf: vsscanf("f12:2:d:2:c166:1:36b:1906", "%3hx=
:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...) expected 131085 got 851970
> > > [  383.105376] test_scanf: vsscanf("4,b2fe,3,593,6,0,3bde,0", "%1hx,%=
4hx,%1hx,%3hx,%1hx,%1hx,%4hx,%1hx", ...) expected 93519875 got 242430
> > > [  383.105659] test_scanf: vsscanf("6-1-2-1-d9e6-f-93e-e567", "%1hx-%=
1hx-%1hx-%1hx-%4hx-%1hx-%3hx-%4hx", ...) expected 65538 got 131073
> > > [  383.106127] test_scanf: vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx=
/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...) expected 125069 got 3901554741
> > > [  383.106235] test_scanf: vsscanf("c9bea1b8122113e9a168df573", "%4hx=
%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...) expected 571539457 got 106936
>
> > > [  383.106398] test_scanf: failed 6 out of 2545 tests
>
> Is it me who cut something or the above missing this information (total t=
ests)?
> If the latter, how are we supposed to answer to the question if the faile=
d test
> is from new bunch of cases I hypothetically added or regression of the ex=
isting
> ones? Without this it seems like I need to go through all failures. OTOH =
it may
> be needed anyway as failing test case needs an investigation.

I assume you mean missing from the new output. Yeah, KUnit doesn't do
this counting. Instead you get the test name in the failure message:

> > > > > >     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4h=
x %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> > > > > >             not ok 1 " "
> > > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED =
at lib/scanf_kunit.c:92

I think maybe you're saying: what if I add a new assertion (rather
than a new test case), and I start getting failure reports - how do I
know if the reporter is running old or new test code?

In an ideal world the message above would give you all the information
you need by including the line number from the test. This doesn't
quite work out in this case because of the various test helper
functions; you end up with a line number in the test helper rather
than in the test itself. We could fix that by passing around __FILE__
and __LINE__ (probably by wrapping the test helpers in a macro). What
do you think?

