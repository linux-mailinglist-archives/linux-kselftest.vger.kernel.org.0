Return-Path: <linux-kselftest+bounces-41315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41753B54A74
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47A516109F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB12FB97F;
	Fri, 12 Sep 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tVRFgT3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08501EA7DD;
	Fri, 12 Sep 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674640; cv=none; b=p7bGDBCcN5dqrmH5SlLd+6/3DrZe2BE56RFR+5tf3BlsC845njByi0wXtGPy8AbpUNUzlLFCgOGyDNCqGyCfWSca3zXnGRlgHCZnxjVMf5Lk4n4Z7DOxkgjBWeTV0wAtNGA082ypzmZeoNVrKrDiQUUI60128ixRvrO7rV9U6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674640; c=relaxed/simple;
	bh=CMxrwtZy/ej5tje20LY39IhUva5QLPmlbeCy5NB1eG0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fx5xkThRguaFz60AGQrGuw1Hyb/qd1NKSnt0Jy1tHC+PwJSVcoA8cMNhAhJw3NWOqBEdx2C9np8J8KcquOYaedeJITsxAIfrXfvxJ5Wr8ip/4qSyLWey/VolMVFX9v7VGNkRbtUNE3ODSMXBCUC2OiQIURN/HENg2hIGPmZi9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tVRFgT3w; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757674635;
	bh=CMxrwtZy/ej5tje20LY39IhUva5QLPmlbeCy5NB1eG0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tVRFgT3wPYBUhvz+I5yGaaOIRcr0LyGbSRTT2P1N9PeCVOaLBduiBTQGUXLiGCvIA
	 zjABJUVEI1WNKBNoAf92rvRgtrqlqM5MDvIT5QMBjKl1KtTmeph63lke6b+5ZITH0l
	 GojC3Twv02/3b4xlee55++ebmE0Jb051+Wm5gbbU=
Date: Fri, 12 Sep 2025 12:57:12 +0200 (GMT+02:00)
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
Message-ID: <5e4d9943-3a8d-4281-9007-f49bfc66dc6d@weissschuh.net>
In-Reply-To: <965c8d7e-c5f2-4bd8-ab7c-c3116632f015@sirena.org.uk>
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com> <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de> <965c8d7e-c5f2-4bd8-ab7c-c3116632f015@sirena.org.uk>
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
X-Correlation-ID: <5e4d9943-3a8d-4281-9007-f49bfc66dc6d@weissschuh.net>

Sep 12, 2025 12:49:58 Mark Brown <broonie@kernel.org>:

> On Fri, Sep 12, 2025 at 08:30:08AM +0200, Thomas Wei=C3=9Fschuh wrote:
>> On 2025-09-12 00:48:47+0530, Naresh Kamboju wrote:
>
>> index c99a6b39ac14..816b497634d6 100644
>> --- a/tools/testing/selftests/arm64/gcs/gcs-util.h
>> +++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
>> @@ -26,6 +26,10 @@ struct user_gcs {
>> };
>> #endif
>>
>> +#ifndef HWCAP_GCS
>> +#define HWCAP_GCS (1UL << 32)
>> +#endif
>> +
>
> We're doing that for glibc using tests because there's some unfortunate
> interaction between including the relevant kernel header and glibc's
> headers (I forget the details) which means that including the kernel
> header directly conflicts with something glibc is doing.=C2=A0 For nolibc=
 I
> would expect us to using the kernel's hwcap definitions?

nolibc doesn't even have its own asm/hwcap.h (or any asm/ header for that m=
atter).
So a kernel header has to be used,
maybe an old one is pulled from somewhere?

(I won't have access to a development machine today anymore)

Thomas

