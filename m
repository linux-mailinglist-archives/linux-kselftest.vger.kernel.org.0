Return-Path: <linux-kselftest+bounces-26663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA2A361F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8C63AF932
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB946266EFE;
	Fri, 14 Feb 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2HKVxDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B1266EE4;
	Fri, 14 Feb 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547619; cv=none; b=mxTKarN3Fl4JIl8XItVC067AqdcAPRO3Hy+0bngDXDFTMp3JxjYFh0G6SVV9mxEVseuuRZOAr+54dhvk3XrmW+IEeY0mzrADb9lYgMZ7EWFnxUvzuqlZPlfp3wLl86k+4abw8+embzhVtZRYfSSZCMWCx5v6ZMquGFX7AEZjmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547619; c=relaxed/simple;
	bh=+QmiX/j6oLuhc8wlluKKM+QbhJ04+U1GOJmtRacp7YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jo6VGNEZsviCfqHlWQeBTrPhwjWLrMYAiIvV+/kcVVoFwtlQxVoKopJ12XCeLh2SDvcae55KkUZMORUvIF2mNIo636TajGDXgLe2hylX5NyO2oxywGVQEOjaDxUN8wzAy/MAHCc5DpE7DYqMf8X9PTWiJddvnuGDBoc+risFwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2HKVxDc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-308f71d5efcso21731211fa.3;
        Fri, 14 Feb 2025 07:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739547616; x=1740152416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apgvojEvDMH2926nB2eKFMcoV7wtc42+Vp3yl/XLDJ4=;
        b=J2HKVxDcEybboGhgcXWGVN89EJyP/2ilJ+rtmPOmKqfBD1c5akQFbs3fLNaX2lAlyk
         IoMqrn/7F7KX/hxgak2aq9l3dRfiwbu7Ir3O1xBGlMrtUiJmlkCcsCDz0AFGJlMUt3Hy
         LIetkz3gipn/3SVU+QBruaPshn1UwaMcpN5XVMJko9dIarDDPBL+Hs+Ma56bWAiC4lfJ
         BuElj7+F1IaN8+oi6yQihNB8WMHW51kwIh1KRhBiTy6Vi4VBtLUk2LALio1HdxYEqV6i
         VBrIaMOuspmLfjqD4Zi172B5RPEXAg9qt57QM2571vg9+VCYRKlF+BoarCppV3HCDON1
         wFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547616; x=1740152416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apgvojEvDMH2926nB2eKFMcoV7wtc42+Vp3yl/XLDJ4=;
        b=TksUJ1NC9qrDXUCByKgwLuYniyBYUIQ+9xOoYp/XcigK+vWkoea1KhI63diE9WHDBM
         9XiTyjK1a4BaX9N5jEhQDf7F67kDOnv9lw8kDCSGJ1pBaZG85+kWYYt/qtOWdLTtsZ8h
         ItmiovF9pMle+tniRI/EYe6JGIyycR5LlPATUH21jGefWGkas4OajVjQvbkjNlHUbMfp
         VBTHYOG14ltCMj12e6nzBdTb0X/e4UlSxjx1rVzz0cvoK/DQ49QItjCv3rstjDEA9+3z
         k3+8zcpxw3hqJzx3JIgV6d0CSawz0zjEC8MpmpL5vCA/CgC09JpUHa67oKJ3KEalKyyA
         uX5A==
X-Forwarded-Encrypted: i=1; AJvYcCUVuAENsG6TydrfrbTmrqXJeUvVvq3vK1UH0YFQT6tSBgYVb5pgxrMiTLHpPFPy3lRoYRypEgvWs35AX58=@vger.kernel.org, AJvYcCX6F/IjraTWGWvXneh1M8XBrVh5BQUD6EBC2GAD+vF46PQZ/hypaI1JdZUcC3nqcHJHyli6YtYON7ulQX5YjSke@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0CrGEgRyISs0k5K+mxPwr/HlQ1whRycvpZ9F76tJT1+OO1V/T
	ap2h9J+DtOBYS9unOgaUXPwmfIgf8tTPhArxt68UPXC1qJTvpUxyhmI1e0icmG0jD4cFHX7WyqM
	qWThIqosaQllUNCTwX6BSbD6JJ68=
X-Gm-Gg: ASbGnctMY4bUrZs1tlyawghwjK/wqknEZi/ISDUFSsnD3lavpFocbBesDXjEXpNC8gh
	XFOf8ro1GSvXFjjrZXF86uHEJo79AcxKwNxdIgsYPsBw8H0hUogaGr/Ny/aBd7u35Gharvvt7vI
	wzEpl8U8r1awWyDddeDBCLgcv3AAucjHY=
X-Google-Smtp-Source: AGHT+IFAQDNDWBcp2bHDIQeQSvrdGYlj1gLZPnpl4bAInHrn2ILYGX2CPz2+oHopIC+aB5h4aCPXO9POpdgCfdnPoTM=
X-Received: by 2002:a05:651c:542:b0:308:e9ae:b5a9 with SMTP id
 38308e7fff4ca-3090379da66mr43812201fa.6.1739547615971; Fri, 14 Feb 2025
 07:40:15 -0800 (PST)
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
 <CAJ-ks9k9d4aX+P9F10h3TqHPOCHEQ5m=QyMAv7bU+Xyb3LRsOQ@mail.gmail.com> <Z69GLMVPCuKKz1gk@pathway.suse.cz>
In-Reply-To: <Z69GLMVPCuKKz1gk@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 10:39:39 -0500
X-Gm-Features: AWEUYZmr-3UjtPNIc3R37HyLXKuEGwEx_3ZnSHBlKWjogJRc-JRriPQO_ICZEHI
Message-ID: <CAJ-ks9mwBzvS+izME-DU2rOxKZmbM7GtWydxXMLBdkRz3rna-Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] scanf: convert self-test to KUnit
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:33=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Wed 2025-02-12 11:54:52, Tamir Duberstein wrote:
> > On Tue, Feb 11, 2025 at 12:26=E2=80=AFPM Tamir Duberstein <tamird@gmail=
.com> wrote:
> > >
> > > > Is it me who cut something or the above missing this information (t=
otal tests)?
> > > > If the latter, how are we supposed to answer to the question if the=
 failed test
> > > > is from new bunch of cases I hypothetically added or regression of =
the existing
> > > > ones? Without this it seems like I need to go through all failures.=
 OTOH it may
> > > > be needed anyway as failing test case needs an investigation.
> > >
> > > I assume you mean missing from the new output. Yeah, KUnit doesn't do
> > > this counting. Instead you get the test name in the failure message:
> > >
> > > > > > > > >     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4=
hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> > > > > > > > >             not ok 1 " "
> > > > > > > > >         # numbers_list_field_width_val_width: ASSERTION F=
AILED at lib/scanf_kunit.c:92
> > >
> > > I think maybe you're saying: what if I add a new assertion (rather
> > > than a new test case), and I start getting failure reports - how do I
> > > know if the reporter is running old or new test code?
> > >
> > > In an ideal world the message above would give you all the informatio=
n
> > > you need by including the line number from the test. This doesn't
> > > quite work out in this case because of the various test helper
> > > functions; you end up with a line number in the test helper rather
> > > than in the test itself. We could fix that by passing around __FILE__
> > > and __LINE__ (probably by wrapping the test helpers in a macro). What
> > > do you think?
>
> I am not sure how many changes are needed to wrap the test helpers in
> a macro.
>
> > I gave this a try locally, and it produced this output:
> >
> > >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/sca=
nf_kunit.c:94
> > > lib/scanf_kunit.c:555: vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx =
%2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> > >         not ok 1 " "
> > >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/sca=
nf_kunit.c:94
> > > lib/scanf_kunit.c:555: vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%=
2hx:%1hx:%4hx:%4hx:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
> > >         not ok 2 ":"
> > >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/sca=
nf_kunit.c:94
> > > lib/scanf_kunit.c:555: vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4h=
x,%4hx,%1hx,%4hx,%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
> > >         not ok 3 ","
> > >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/sca=
nf_kunit.c:94
> > > lib/scanf_kunit.c:555: vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41",=
 "%4hx-%4hx-%1hx-%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 9938=
1
> > >         not ok 4 "-"
> > >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/sca=
nf_kunit.c:94
> > > lib/scanf_kunit.c:555: vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%=
1hx/%2hx/%1hx/%4hx/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
> > >         not ok 5 "/"
>
> But I really like that the error message shows the exact line of the
> caller. IMHO, it is very helpful in this module. I like it.
>
> IMHO, it also justifies removing the pr_debug() messages (currently 1st p=
atch).
>
> > Andy, Petr: what do you think? I've added this (and the original
> > output, as you requested) to the cover letter for when I reroll v8
> > (not before next week).
>
> I suggest, to do the switch into macros in the 1st patch.
> Remove the obsolete pr_debug() lines in 2nd patch.
> Plus two more patches switching the module to kunit test.
>
> I am personally fine with this change.
>
> Best Regards,
> Petr

Thanks Petr. I'll send v8 now, then.

