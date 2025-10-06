Return-Path: <linux-kselftest+bounces-42788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87ABBF375
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 22:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43793A66DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 20:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D42DF145;
	Mon,  6 Oct 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLcuykQW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81842DE6FC
	for <linux-kselftest@vger.kernel.org>; Mon,  6 Oct 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782912; cv=none; b=NsgX/coopj/AaRQRJ1ULgwCCj3cMNB18UEeu5COQqlGUm95IliPKwfnYxXq4CKQ9fVB/PUHhQjLhoqligyoIvDPIRRYyb1735OuR347tcrKB7s8GCnX98lfN/BdhJS2hNhV0v3EMDKdEohiGQIJjUs/MoklAL1QM6wizPn0w+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782912; c=relaxed/simple;
	bh=wRqM1wL0rtVZzWbUB1vZjAZ//+DX1ksR98VvmNXh1Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aj0NB/1BKUwtM2gmBegLjdwse0nahaGMqw1QAc6dowD7KIVJhIzFQzdSDEA5yrU8uV0jd9ZHa25QLd1CSaP90OLBDuhJKsMOJnG9+GnAInIkyd7IngvPRAB/tcoAvoypFRHpM2DnhuYFRApyWElhXDRZOr8VZerEJ+suGJGo9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLcuykQW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e542196c7so36021035e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759782907; x=1760387707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8A8mrbjHOp4I+EQv9aLZuINyxZFXeZgTqLUL4/gbts=;
        b=JLcuykQWTX1qhWoGcyL4rEQ654Dn8fEafHNnYaDb6dJmDejlYhMexc8dmKE0V+67KA
         VXeK/+jdcGamwSsNrowIARdasb/A3kfrVP+mYMrjG2fMDyohKFx1OR/CBHF/NQieDvTm
         nYhYkQLV5FmuVpoGFvxSlH9sEY7KtEtF6AA69dHyfafQLyW7FbgGfvjK7QzAsZKhJRxF
         6b1Bh3dSp4xPjBWSZAhhNHoWPX4ZTv1vyvmhV1EfLHKX0+BMy3LeCJPJ/qPM7TxeZzUu
         gAvPPXnbv8/OFMtna0TOzl2h/DsQ3zNdQkpQ+LVjhXyApki4ODJMjXgeiBA/a3ojS0nY
         rm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759782907; x=1760387707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8A8mrbjHOp4I+EQv9aLZuINyxZFXeZgTqLUL4/gbts=;
        b=Imi1A/E2zl7yfHqiVD6oo05w5dWvfI3FgEOjKZLQFAAbkVC0ILIsMBcsMDxKAL5cwc
         C3MmEPQm4Q86hu3aORUSX90hCjx26QtoLDsP3N1Tnl9bfeetsGbaZpqO/YnNS2IXJeL3
         zneyaBNq5i7uZ+YoSC5WAbSXjt2hDBzp4mgtPqbB1cx/D0X5oLVhiS6+ysKOnFv7qSNU
         KXO6yH+eCjAywcY4JjeqXN9QJc10/WMVgA4iL3PokUX1uKTMidEFwo4fuAL8KTqPn5Ff
         28vt7o0FvFUu4sO2oO63+5a1yg1mcIl7bF5AWm1rK2AoyodZtOR6At0NVo31ocQihrCh
         1KXg==
X-Forwarded-Encrypted: i=1; AJvYcCWwlL2qP7T1hWPTN5R5qkLPwIdEOq2TUKDr4xbs+7lG+wAjzpVnLdliuSBFIsQ7/G9katBFnAJhOqCMF204moM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNcUUnv/TxjpFezr38MSx2r909c9Jpy4a3Me/a0DI1TVvr8DV
	QcSizl7Jo1cjdvvIyLD3TvAOBmxQXtI8tbEDKaqxMufcGmq4cQiVJ0GL
X-Gm-Gg: ASbGncs2mlxFVbW7r6tJYLBXxBCZCNqfd2569LpHUY23gQB9AN0lUn1tdfap/RtnBFF
	MkIrZn5re7niwibqWMP1W56u30HK6ivmdIx84p8nKTbzFW4LQzVOs06dx0PVClkW00C25UhkcYR
	aLm83bAJ6zGh2nof9clxkfi/hCQGLC/BuGSaKRUauVn3kO/ulCKD5ON85gDtHw9YLJvRQ3RUHdu
	b8U4jVq0q1yA6JPLm7JbR90ceaaKfP8yc0d7p+BwLa5oNEVP0xLHU6x7/US842ui7iQ+aLu2mxX
	lOIC9MS7DSDo5CilE4rNuqDB/1+eNKb+qpVSfAOyoLJovUJSpEWvQ6IKBeloWR+I1d6FyxwFNPO
	pTT00wiXqJC2Sgw30omDAgKs+/Mi3W2O0IZuS2Yc6tppdsE8YzyAKQJIcIaSWrnFfL2zGa4kpKc
	BBdBwTEGyz8jmz
X-Google-Smtp-Source: AGHT+IEnzSpQE+ROtayFnE2b4dPjTQF2CaZO9TdUfVNFcX6ejR4aNYCswD7XdVH/ajIMwYylIXY+YQ==
X-Received: by 2002:a05:600c:2287:b0:45d:d86b:b386 with SMTP id 5b1f17b1804b1-46fa29f13dfmr4596085e9.14.1759782906754;
        Mon, 06 Oct 2025 13:35:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723591fcsm172334545e9.10.2025.10.06.13.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:35:06 -0700 (PDT)
Date: Mon, 6 Oct 2025 21:35:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Eliav Farber <farbere@amazon.com>, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, james.morse@arm.com, rric@kernel.org,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, sean@poorly.run, jdelvare@suse.com,
 linux@roeck-us.net, linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
 maz@kernel.org, wens@csie.org, jernej.skrabec@gmail.com, agk@redhat.com,
 snitzer@redhat.com, dm-devel@redhat.com, davem@davemloft.net,
 kuba@kernel.org, mcoquelin.stm32@gmail.com,
 krzysztof.kozlowski@canonical.com, malattia@linux.it, hdegoede@redhat.com,
 mgross@linux.intel.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 sakari.ailus@linux.intel.com, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
 dushistov@mail.ru, luc.vanoostenryck@gmail.com, rostedt@goodmis.org,
 pmladek@suse.com, senozhatsky@chromium.org,
 andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
 minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, jmaloy@redhat.com,
 ying.xue@windriver.com, shuah@kernel.org, willy@infradead.org,
 sashal@kernel.org, quic_akhilpo@quicinc.com, ruanjinjie@huawei.com,
 David.Laight@aculab.com, herve.codina@bootlin.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-edac@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, tipc-discussion@lists.sourceforge.net,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v2 07/19 5.15.y] minmax: simplify and clarify
 min_t()/max_t() implementation
Message-ID: <20251006213242.3462e746@pumpkin>
In-Reply-To: <2025100648-capable-register-101b@gregkh>
References: <20251003130006.41681-1-farbere@amazon.com>
	<20251003130006.41681-8-farbere@amazon.com>
	<2025100648-capable-register-101b@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 12:47:45 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

(I've had to trim the 'To' list to send this...)

> On Fri, Oct 03, 2025 at 12:59:54PM +0000, Eliav Farber wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> >=20
> > [ Upstream commit 017fa3e89187848fd056af757769c9e66ac3e93d ]
> >=20
> > This simplifies the min_t() and max_t() macros by no longer making them
> > work in the context of a C constant expression.
> >=20
> > That means that you can no longer use them for static initializers or
> > for array sizes in type definitions, but there were only a couple of
> > such uses, and all of them were converted (famous last words) to use
> > MIN_T/MAX_T instead.
> >=20
> > Cc: David Laight <David.Laight@aculab.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Eliav Farber <farbere@amazon.com> =20
>=20
> Eliav, your testing infrastructure needs some work, this patch breaks
> the build on this kernel tree:
>=20
> In file included from ./include/linux/kernel.h:16,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/wait.h:7,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from fs/erofs/internal.h:10,
>                  from fs/erofs/zdata.h:9,
>                  from fs/erofs/zdata.c:6:
> fs/erofs/zdata.c: In function =E2=80=98z_erofs_decompress_pcluster=E2=80=
=99:
> fs/erofs/zdata.h:185:61: error: ISO C90 forbids variable length array =E2=
=80=98pages_onstack=E2=80=99 [-Werror=3Dvla]
>   185 |         min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page =
*), 96U)
>       |                                                             ^~~~

That constant seems to get (renamed and) changed to 32 in a later patch.
I'm not sure of the rational for the min() at all.
I think THREAD_SIZE is the size of the kernel stack? Or at least related to=
 it.
The default seems to be 8k on x86-64 and 4k or 8k on i386.
So it is pretty much always going to be 96.

Linus added MIN() that can be used for array sizes.
But I'd guess this could just be changed to 32 - need to ask the erofs guys.

	David


> ./include/linux/minmax.h:49:23: note: in definition of macro =E2=80=98__c=
mp_once_unique=E2=80=99
>    49 |         ({ type ux =3D (x); type uy =3D (y); __cmp(op, ux, uy); })
>       |                       ^
> ./include/linux/minmax.h:164:27: note: in expansion of macro =E2=80=98__c=
mp_once=E2=80=99
>   164 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>       |                           ^~~~~~~~~~
> fs/erofs/zdata.h:185:9: note: in expansion of macro =E2=80=98min_t=E2=80=
=99
>   185 |         min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page =
*), 96U)
>       |         ^~~~~
> fs/erofs/zdata.c:847:36: note: in expansion of macro =E2=80=98Z_EROFS_VMA=
P_ONSTACK_PAGES=E2=80=99
>   847 |         struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
>       |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
>=20
> I'll drop this whole series, please do a bit more testing before sending
> out a new version.
>=20
> thanks,
>=20
> greg k-h
>=20


