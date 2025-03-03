Return-Path: <linux-kselftest+bounces-28017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7FA4BA8D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 10:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67CD16EAD5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFE81F0E57;
	Mon,  3 Mar 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="kC2Bm6ew"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA31F03FF;
	Mon,  3 Mar 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993256; cv=none; b=QSVmj84BfWks3NZ0SQLtvdl/8GyU24qYd1ll9JSV9k6wGdK2FwwyPCm/oXR+osnJ/pC4vARq6c1ac57jUJS2bGpOYyl5y0JgXnTX4xY5XiXtaT/VXapYRYIhmqbt5F7dwFiQLRM08EPvOlhY2suIQLjARFlVAS7pfEk4yF4goaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993256; c=relaxed/simple;
	bh=chComhkvQM7hjrOlo496KkOXaJ8o5+5iL+TOUadbwbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bs7R2ziXcRleLu8pJ2cpAlLd69c4Jz39GW8dQrkOycPmkYyeFoaVU49Woj3NmTdfChAjWtKYP4eBAEOtP++qAAD9Uspe/QSCGGv/91kBxji3LipD+xyzIbAwe59MbK0xu4qm78xw6y+wUxIbvc8ywFle9BUuoEtFZSD2/FJs9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=kC2Bm6ew; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740993246; x=1741598046; i=ps.report@gmx.net;
	bh=vOKZuUQ00m+hMECjFH5bRLathiddkOHnJQDSvLtCogs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kC2Bm6ewPcZGEHNO7Ym6u9F28WxLW10S8UaTPp9QCn3t7J41SC9unaTWIExKMsWD
	 ZGIE+yVNY+qdn89dd+aPWR+fsKU5VVeN7BNC+7fI9GcvRBzQKXV2gjY3zv9vaaugq
	 cE+JNq8iUr0HrfHfc4MIkI+hLkPOFTpAQkmOR77Lksl9K9vZsKpQy1NHN/3jBeoez
	 wYu3j6TPI+J85QkyEnjBOiCICXhdpxLGy4HfTVIFG0ZIFhHLIfZCE+5dUykmes12S
	 ek9SzfiJAPQyuV41epxY94TtsgTV6Wr/49rqgyQiHkYuHI74qPRL/YRL4U7hhnBGG
	 IPG1bNq6PlDz1//gFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.38]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1tJnqq2b4Q-00cf5F; Mon, 03
 Mar 2025 10:14:06 +0100
Date: Mon, 3 Mar 2025 10:14:05 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Siddharth Menon <simeddon@gmail.com>
Cc: shuah@kernel.org, brauner@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/pidfd: Fix missing headers
Message-ID: <20250303101405.28000aaa@gmx.net>
In-Reply-To: <20250302205859.14782-1-simeddon@gmail.com>
References: <20250302205859.14782-1-simeddon@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uFneSmlJfJNj6P6VQGyotHin5Mn/ma55g2VJc4Q5ve4woqXafi8
 mpT2odQ+vtJHaPpYEQY1764F0TUEfdmQhaRwr3kfn9bMnPNDCxR0dABTfuw5Hdeq/16l7qO
 rLUgZLbFgPu+te1MMuHmyboFFTOD7q/IIEMDPW9E/cHlEr8kJDRewV1j6+SodsSQKu3xz/T
 BsU77P2E3yERQfuHVmakQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EarfKLCXDSo=;zec+8U1+EXlg1K5AdfBDNGCiffg
 jSO+Uc/N27UmNAdzFQo0qutRn7/K3ZNvNsWz/N3Dda4viL6560wHVhg0TjaTgGEt5OxIlOzII
 JsEwT1D5Cuo8TfKilY3LVreO/Vv3hNzPAwfs4f74bgLqOl2z669Pc7dnqCa8pLaojMu7R2Ema
 VaPpsQaECLIm43m8qjup2FuYpR3kiK104amqN1OLGP4mFVaCUhMiAqcqPmHlkcmHoFfyYQXYF
 Zp2TZY7wVt2E4ZdA514WUTNimBXtjcTvLewVtN/FdVtl4YOtXYnTV7jKa7U30dSCtdcS7xQAo
 UIeaqqsuK0jLQzkelh7hdaTibOMD0prPTVbQ/PUQqrFW0WYJrGfbWZ2NrSFreWkGC9D30v5Bo
 2CFR1L28cx3OgnG8hgpWXjRoIh9n4fEh2d5uHcIEsFQbL+Vv5LG6dfMcHxcZODR4wxT8Et6oE
 NpX8kB9LvP2W/6+P2Ajegm5RG0X/wpBnd2LITBgatEpefYjyW8JjZ+ibF1EXA0MIVqbehsZ6Y
 RnXqCwQCBJmpE+sipXYFAbfc7huwucJXQRLkG4xr5tQ89QJFnO/GTsHvVpzsKtk8vNzjlMRAj
 fu9iRuUt6dLyTo76QQQwBGXvCZT1L48bE/9tU4QcVj6dbWjI1zUjE4kY/Dkg3+s5vlm3r188T
 PX7NKPJZdVTRIma9SEbTA9UT8iP8Q+n7Cizpycv8J5ob9yqCaROB5CicX9+Jo31OBIQ6g+3Ad
 F+TyLjaOHa6fMtl3hEab/eMri4dMN4E6eG+T6y8HRhBWq8fb3qq+mytXbwMI0a4DSEHNg/Uv6
 AbHMdtKvixUUyGFL4izaO1TzYqWn6l8knOE3/5ORfKKw8wDyVUtIqdzg+wG/9uolLmVZw2Q5s
 n/B/y0anyKTIAPGlstV0TV2fgpqh2FoggilfaROcr+5OuVBgNWle1ErSNkya34sjjlVgICrQn
 Xn1PNeHHIVwofMnfTCkJ9ru28djorV2Di8hZVBVaoaLU4LpZNHiTz2rXkP+Gjh9jIN6rOjy90
 /LuTolmMYZMnPHPbUvPv07xAsm3EIJe3yh3al9RWnN4F5Q0wdiRMyCX5vKcI4sefPtGzsA8RI
 nPXj8zGaVTqBaK7Y8KouwjVZeXsW4uflnrs9AFRK0HZAbjckONraa2ESEbupYRDQR4IMiUcpr
 LtmhC6fBri8U1Tjy5lt6VGrJIs224d/GxWRuiJ5CTO5JBFDy9qUQ15m3vc6vGp65/U79BDxr4
 n2Z3kYqAztBpikWkdJBrX/QvC4fVJrzX9mdGJ1FvhBXmOsu+JdSfcWW/X7upanseUnq+Rb64L
 JoPvvHTciVP+GCKm3QNvAwZMhKBSZA9FXvEyLCsz5ndd17WDRbkOw1VRFkNXghLXuQnWQ6Epk
 TH8HGvulAzV/0SXe+RSKEgVA1CjCoKEASWeGGpUTIazFBOjNY4i6DLEAbj

Hello Siddharth,

On Mon,  3 Mar 2025 02:22:44 +0530, Siddharth Menon <simeddon@gmail.com> wr=
ote:

> Fix compilation errors caused by missing headers in the pidfd selftest.
>=20
> The errors include:
> pidfd_fdinfo_test.c:230:13: error: implicit declaration of function =E2=
=80=98mount=E2=80=99
> pidfd_setns_test.c:172:54: error: implicit declaration of function =E2=80=
=98ioctl=E2=80=99
>=20
> Siddharth Menon (2):
>   selftests/pidfd: Fix missing header
>   selftests/pidfd: Fix missing header
>=20
>  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
>  tools/testing/selftests/pidfd/pidfd_setns_test.c  | 1 +
>  2 files changed, 2 insertions(+)
>=20

Predated patches already available, see

        https://lore.kernel.org/linux-kselftest/20250115105211.390370-1-ps.=
report@gmx.net/
        https://lore.kernel.org/linux-kselftest/20250115105211.390370-2-ps.=
report@gmx.net/
	https://lore.kernel.org/linux-kselftest/20250115105211.390370-3-ps.report@=
gmx.net/

Regards,
Peter

