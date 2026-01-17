Return-Path: <linux-kselftest+bounces-49234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80824D38E02
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDEE73008197
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C630FC1B;
	Sat, 17 Jan 2026 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="S/J2s2LJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62413093B2;
	Sat, 17 Jan 2026 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768648131; cv=none; b=LWrspzXznh/C79uer6e/85NbOaHvNOBdHk6vDt5rAOgLcie2kFE/asy5FNdUAo8bGH2zEl1TsIgjfofdglL2xfpP+BqXrU8qxiJMxF7xtzCO4ArfqNOscy34mBmJRYtYDB3e3CJcSCL0rCIzXkXbgMVpNcAy3nCLFPRHzD9NU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768648131; c=relaxed/simple;
	bh=+xBLSIUx2N5KxfA2VeFB//he0XAsrbIf0+B/O+Yz9Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5ApkZqSQf1dZOWUBDwXuRmSENKPFEHxK2GB9qPV7NwaKCLMM1upgg8XRVV+JNklE60Yhl7slzz36zi86H2Q54wjUnOOTeCw7J/DtudrfTQSWoy+iTaJHpM9oXhOB8A7ISPJR75eHIpuHT6/v5J9/T+IqxWnzR5R+tzXzImkPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=S/J2s2LJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 549E340E00DE;
	Sat, 17 Jan 2026 11:08:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dnQvOZ78Pixd; Sat, 17 Jan 2026 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768648119; bh=/A+0bk7B40xIPt0aGnnJOZFvRXKoh6vVmNLjdynIbEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/J2s2LJHctqwlE0CtnLqOtSoI0/kwSFlCjfgzW9ohr6XUK6scjyDjYSYeZP2vLWn
	 iEQF03TwH8JJELhwItr3de8rHFBfeZTdV4t7g7KLD2oeH0KnLcFvm3QsyF9q87PfZl
	 CJA0L5xNmMoPNqBu/q0p9r8dHvjzzN1TCW6t4Jft3ZnAb4cfCsB0AcClAiECwBgpAz
	 MUaM4I5Bc35q9QV9EZQTwd4PuwAGUIn/4kG+u/4YG2UJYbJwmMaPwNWVmc7CYPiUmg
	 23TR6JWA+t8z8pISYWVqrxSS85chTH6orToXtCuauij7K9W/DMVru0jawAO7VKY6Py
	 iMBnkvgLOv7jkqW2+q9m/shl852bevU7nNMxbYS3UuOkaugUHTkPn4XVl3z+JtG1/2
	 3m3KNPMtaOl+hoI86M+5nEKodJZsuQKTSSTVLYeEfTfrWFevDm2YvBmduCW8lsjj/R
	 je9Nu807YnHV57be3lVQqJ3rujkUuwRha0a4j+iDiOj2q7RMiezRYKukaIxPKOsKfO
	 mnGQf1FfBiwrxppsR72uAOhpxk/APaCJtnto2nYZbMoAeumgNblyJw41yFzdMEgG1s
	 DyvlZahH5YFpLxyHI1R0T2jCenLtkoBPwtSQ2tQWlXU0f+3X0DpNeWz2ZZiZhgIS8j
	 zTTrXMAV4yCmjqoWlhcka3pE=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7521940E00DA;
	Sat, 17 Jan 2026 11:08:17 +0000 (UTC)
Date: Sat, 17 Jan 2026 12:08:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: naresh.kamboju@linaro.org, broonie@kernel.org, anders.roxell@linaro.org,
	arnd@arndb.de, benjamin.copeland@linaro.org,
	dan.carpenter@linaro.org, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, lkft-triage@lists.linaro.org,
	mingo@redhat.com, regressions@lists.linux.dev,
	richard.weiyang@gmail.com, shuah@kernel.org, surenb@google.com,
	tglx@linutronix.de, x86@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] selftests/x86: Add selftests include path for
 kselftest.h after centralization
Message-ID: <20260117110809.GAaWttmUvKQddPgw07@fat_crate.local>
References: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
 <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022062948.162852-1-reddybalavignesh9979@gmail.com>

On Wed, Oct 22, 2025 at 11:59:48AM +0530, Bala-Vignesh-Reddy wrote:
> The previous change centralizing kselftest.h include path in lib.mk
> caused x86 selftests to fail, as x86 Makefile overwrites CFLAGS using
> ":=", dropping the include path added in lib.mk. Therefore, helpers.h
> could not find kselftest.h during compilation.
> 
> Fix this by adding the tools/testing/sefltest to CFLAGS in x86 Makefile.
> 
> Fixes: 4d89827dfb27 ("selftests: complete kselftest include centralization")

This should be:

e6fbd1759c9e ("selftests: complete kselftest include centralization")

@akpm: I see you took the above commit - I'll take this fix through tip.

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com/T/#m83fd330231287fc9d6c921155bee16c591db7360
> 
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
> ---
>  tools/testing/selftests/x86/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 83148875a12c..434065215d12 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -36,6 +36,7 @@ BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>  BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
>  
>  CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
> +CFLAGS += -I $(top_srcdir)/tools/testing/selftests/
>  
>  # call32_from_64 in thunks.S uses absolute addresses.
>  ifeq ($(CAN_BUILD_WITH_NOPIE),1)
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

