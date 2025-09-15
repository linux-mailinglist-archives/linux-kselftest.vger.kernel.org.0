Return-Path: <linux-kselftest+bounces-41524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBD7B58533
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 21:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8568418997F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 19:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A16281358;
	Mon, 15 Sep 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlEJqrmt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB823281526
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963696; cv=none; b=UqBGkW9nLIQgWpK+ny+z8yt46eY42UAUs/WIR1x7iiH4py0hh/aLk9vUj42T/+gIPUTuaavKLcpTKXZsiLRvufy+CLUg7Y8raY4uojtZ17WY6InWglaUHAlrGR3Od8dw+APmTN02AldsViCtCu59N8TUL76be77d+6qFvjUj/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963696; c=relaxed/simple;
	bh=c/xwwXA3LmBOBhBu2xW7scBMnY4EehI2985j3EdXFks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PM8T1+3KJWlCN7y7CUsPuJyKbVnTPAJ8U1rshCYad9mxfFqU6iphfatO/T8Ohl0f9bU6GJU7v72kT0xE0ddZm2UGNg47nLOJ7mu3oOyC9eRwrA5cFc4Yuiu3teccRxP44Nczo6S81VM38ljRut4uppwwQwUejUGVabK8vFEUI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jlEJqrmt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7742adc1f25so3158025b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757963694; x=1758568494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6wqGfRu2qI7+46L6ERmQDqDyxlRm+K7+bHyAwd1/ys=;
        b=jlEJqrmtHfQvrHt+RJ2K77Bi1DMrt2z4sYHpbdXzBuWZEJBMMFFrfCYuYjFcO9/zbx
         sYbYKLTurMtBAaYl5T42NHK0TZctBCNI2dWU2qlXeUDvbZQIk8Wk+XHHzK3IQucLAYeY
         g11iC1fV+fgrfdvGQ7mpJTMFrwiCXqgXgB/7yc7OuEZ7J0N98TPy9vwDdrMVDoj22cdF
         K/ADqFZTSHa4JYaFXV/QZoqlbsWdTKOwXXq1VXLXvD8wNh57PHzYDW3Gc2kh94u6+q0k
         aUBVVDt0/uknwv8D51oQ0b9PlfsB8rHPRcQuD/cg10wlI7er1wSWIT50Zv8MRqK4Of5x
         FQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963694; x=1758568494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6wqGfRu2qI7+46L6ERmQDqDyxlRm+K7+bHyAwd1/ys=;
        b=THfcyfzZ44k/RdKk5gMdEx7oKzJBmyPbL8xtzVaWkRJ/iV9a47Fb7Su/MtUWr+yiKh
         YU1U/eJcQdkZtFkXPneQP0HSzsk1d3Af+jDTzJCLrd0RYwO7zmzbqOVq/9fr/Z59oZU5
         PL1gDtJ3dRKMiLJuW1mKns77p/E/y+JWWVl96kV4hZZMRLaWTEz7OcmVqlg2S/TFU/sq
         Xc00TtvqEXrwyimQiTbmC+1hgAvh04Jr60IKDRw6eQfe3VBwt+Sdgm5GWyZOuErrZ1jG
         RIIy+roNuP0vkH5MpYEkwWohqf4MI/Yr+Cp7M1GpZbyBEgrRagaEeQJg/sbiXNODBi3q
         nFgg==
X-Forwarded-Encrypted: i=1; AJvYcCXtaqu6Xtpoc23r72Ojmiqigxp51muyOO1uetZDy18RJbbuO1IvhN2FYLIuQc8x9i4E9j4ljo/IfhD/wHf8BhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8YKF1D+R2wjqfKGsnpC+HTsGQBNOYrx0NlgmAAMo9fzcU2Fxs
	DMjpn6JjNGLRxXIGG5B0KNQfyGnHfGB5HKpE73eDScNyXTRqDFZoyOMXS8jnFwgTo9z7dJ4HzT4
	f5egwrKxrJxUeY/I3SAPGcXTG+ESYSLdjW5wh7nJk8Q==
X-Gm-Gg: ASbGnctwu6RofOZZXEM9DrtIsbtmnDQ/InNf5n8i2NTCZev2y+shexGFqKr23vEEQR+
	Fg3Xpgemew4ihqQmasDISavJnKjHE8vwEAF0esgUV1yM0NOjBFTAhszlQCS12WkOxLPhgwdtKjQ
	jv8VaMuZqyszGotOKYhHT6h7OgzX3O/PXT3tgQDCZt+vWRR/1X1QaWcMvtzXIuwQH6cB8Uset2w
	6d0Nskx3hSiqgJGXtuBq4ZHJPPexzpz3n9IDZXI2YU2mcEQklHUJL00jupuphZKbKoGcabnDC+7
	JdK22g==
X-Google-Smtp-Source: AGHT+IFS5Yosk8zDvCLXFq8KmRAPDnuqfaDSdxmgmvOa6yUNvkUlqGro+dILUrXNR4yBf3K+Z0YAEwYFzYRDWuMc2Nk=
X-Received: by 2002:a17:903:40d1:b0:267:bd66:14f3 with SMTP id
 d9443c01a7336-267bd661815mr9354435ad.51.1757963694201; Mon, 15 Sep 2025
 12:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
 <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de> <965c8d7e-c5f2-4bd8-ab7c-c3116632f015@sirena.org.uk>
 <5e4d9943-3a8d-4281-9007-f49bfc66dc6d@weissschuh.net> <b9b8b8cf-4920-4f9d-bcea-bea913058601@weissschuh.net>
 <a1dc9839-ab45-4dd6-9eeb-4bbc35bf8d90@sirena.org.uk> <5fe12804-2538-42c5-b5c7-66d36ff947d9@t-8ch.de>
In-Reply-To: <5fe12804-2538-42c5-b5c7-66d36ff947d9@t-8ch.de>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Sep 2025 00:44:42 +0530
X-Gm-Features: AS18NWAPyThDdNoP11CbNq-0STFMKwn1jS9ssO9hoUB8yYX9018L0FgtP4-g6Ow
Message-ID: <CA+G9fYsnPBYoeVMzQJMCPA1JGhcJXr53Y-_uOMKdB_3D7ZGQNQ@mail.gmail.com>
Subject: Re: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error: use
 of undeclared identifier 'HWCAP_GCS'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Mark Brown <broonie@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sept 2025 at 14:53, Thomas Wei=C3=9Fschuh <linux@weissschuh.net>=
 wrote:
>
> On 2025-09-12 12:14:00+0100, Mark Brown wrote:
> > On Fri, Sep 12, 2025 at 01:07:58PM +0200, Thomas Wei=C3=9Fschuh wrote:
> >
> > > The Makefile does *not* use -nostdinc, so the nolibc program probably=
 finds the toolchain's glibc asm/hwcap.h.
> > > There also doesn't seem to be a static arm64 hwcap header in tools/in=
clude in the first place.
> > > I am still wondering how this works for the other tests.
> >
> > make headers_install puts a copy in usr/include, probably we just need
> > to include that in the include path.
>
> Naresh, could you test the patch below?
> The other custom $(CC) rules in the gcs directory are also not
> respecting $(CFLAGS), but I'll leave these for now.

I have applied this patch on top of Linux next-20250912 tag and
tested and reported build regressions got fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/s=
elftests/arm64/gcs/Makefile
> index d2f3497a9..1fbbf0ca1 100644
> --- a/tools/testing/selftests/arm64/gcs/Makefile
> +++ b/tools/testing/selftests/arm64/gcs/Makefile
> @@ -14,11 +14,11 @@ LDLIBS+=3D-lpthread
>  include ../../lib.mk
>
>  $(OUTPUT)/basic-gcs: basic-gcs.c
> -       $(CC) -g -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostd=
lib \
> -               -static -include ../../../../include/nolibc/nolibc.h \
> +       $(CC) $(CFLAGS) -fno-asynchronous-unwind-tables -fno-ident -s -no=
stdlib -nostdinc \
> +               -static -I../../../../include/nolibc -include ../../../..=
/include/nolibc/nolibc.h \
>                 -I../../../../../usr/include \
>                 -std=3Dgnu99 -I../.. -g \
> -               -ffreestanding -Wall $^ -o $@ -lgcc
> +               -ffreestanding $^ -o $@ -lgcc
>
>  $(OUTPUT)/gcs-stress-thread: gcs-stress-thread.S
>         $(CC) -nostdlib $^ -o $@
>

- Naresh

