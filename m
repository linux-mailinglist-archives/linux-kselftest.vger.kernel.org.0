Return-Path: <linux-kselftest+bounces-41317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0846B54AAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76835680624
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29722FF670;
	Fri, 12 Sep 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J4sSSjc3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D82FF15E;
	Fri, 12 Sep 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675285; cv=none; b=hniWXdciPHsA4wSRLZd1Stn+c62sJX4xp6DZ/N4u5es2C/HT/bzbUyOPfHaCJGH6wcCQVzMyowGyhkV+EIpapfgcuFtMqTvLzmiOkl7kItDKk6QtsgarUIzoiIizvNnZyZ5ii6eh18NWVIGhoASQRGKkS/EUKbX/q/8JpbjzScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675285; c=relaxed/simple;
	bh=XdzlRKK0YYlKL6FZpkN26fSLgIGwOiSuk6wPK7rRaPk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ehXNzT4O7tbBdQsWhYpQRpqH7x/fZxZlDQijLp7U1qB9wuQZ7XRe85oV3N9nNXEWk6SjX44q5UetyW6JqFyyVD5rJ3UnTrM+4p4GvFy86JiT2uI9jFtaGS9ZVIPmQu1BHBM1Uoe3H+xy5IPBunScNis9ijdbFOZ2yCBVmjHH6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J4sSSjc3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757675281;
	bh=XdzlRKK0YYlKL6FZpkN26fSLgIGwOiSuk6wPK7rRaPk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=J4sSSjc3gHxbN6pUJYV/ujaYiL2Dj+xeYc5HMo09pIvME3yeUcpbSWpV9HcFTguDI
	 2TO1kd+Id86BgOhij0H9Pu8ZGa5kpz/zRmv3Xt40wE69uh0czzST26yCVz/F8K83MO
	 FRG321OuYAdYcQEk4Fo0bUBwSP8blPnkS8Tm1rM8=
Date: Fri, 12 Sep 2025 13:07:58 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Shuah Khan <shuah@kernel.org>
Message-ID: <b9b8b8cf-4920-4f9d-bcea-bea913058601@weissschuh.net>
In-Reply-To: <5e4d9943-3a8d-4281-9007-f49bfc66dc6d@weissschuh.net>
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com> <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de> <965c8d7e-c5f2-4bd8-ab7c-c3116632f015@sirena.org.uk> <5e4d9943-3a8d-4281-9007-f49bfc66dc6d@weissschuh.net>
Subject: Re: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error:
 use of undeclared identifier 'HWCAP_GCS'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <b9b8b8cf-4920-4f9d-bcea-bea913058601@weissschuh.net>

Sep 12, 2025 12:57:15 Thomas Wei=C3=9Fschuh <linux@weissschuh.net>:

> Sep 12, 2025 12:49:58 Mark Brown <broonie@kernel.org>:
>
>> On Fri, Sep 12, 2025 at 08:30:08AM +0200, Thomas Wei=C3=9Fschuh wrote:
>>> On 2025-09-12 00:48:47+0530, Naresh Kamboju wrote:
>>
>>> index c99a6b39ac14..816b497634d6 100644
>>> --- a/tools/testing/selftests/arm64/gcs/gcs-util.h
>>> +++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
>>> @@ -26,6 +26,10 @@ struct user_gcs {
>>> };
>>> #endif
>>>
>>> +#ifndef HWCAP_GCS
>>> +#define HWCAP_GCS (1UL << 32)
>>> +#endif
>>> +
>>
>> We're doing that for glibc using tests because there's some unfortunate
>> interaction between including the relevant kernel header and glibc's
>> headers (I forget the details) which means that including the kernel
>> header directly conflicts with something glibc is doing.=C2=A0 For nolib=
c I
>> would expect us to using the kernel's hwcap definitions?
>
> nolibc doesn't even have its own asm/hwcap.h (or any asm/ header for that=
 matter).
> So a kernel header has to be used,
> maybe an old one is pulled from somewhere?


The Makefile does *not* use -nostdinc, so the nolibc program probably finds=
 the toolchain's glibc asm/hwcap.h.
There also doesn't seem to be a static arm64 hwcap header in tools/include =
in the first place.
I am still wondering how this works for the other tests.


Thomas

