Return-Path: <linux-kselftest+bounces-10827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C06558D308B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 10:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33341C226B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECDA17BB02;
	Wed, 29 May 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0TPyU/Bm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DD17B507;
	Wed, 29 May 2024 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970005; cv=none; b=NzHRdXgWQCFg0ecUUc/ecsMLQeyhQmjRVk7RfBe9aVsm5sNMlj2KobISRQLhOTOmoAeqNJ+MU8lUzOnsE6iUSeUN/fBd709BKi0Kw6lA+GoE9GcoyWy7/kAyA/M0o4EY02r/10vhT9wpO7zxXis6nJmel+g+GISwh8OiWtxEth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970005; c=relaxed/simple;
	bh=C9NThqdx/W9npFCwEseQgicfZl61EOyPH13LNK3W6HM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NCWnPe8xAbfLDyrgFj/40G6R39zD9Lpq7YQLuQqYdFaeT0zM2ZoHRUYny/DSpMLfZm8aMt7J+z6O7ahpfaN7pdr3/02GfCdIEVRCBpZ64a0LNAuYHy2SUXfiOcm+k9yyHTTMol1W4ObERaalYXLiiqEP93UPusOFMh7B91ht4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0TPyU/Bm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716970002;
	bh=C9NThqdx/W9npFCwEseQgicfZl61EOyPH13LNK3W6HM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=0TPyU/Bmm41hIGdVrpdVaPzXI963Y+no4v0A8ghyC3bQvE3pjAxBLp11ReGn+iJGj
	 kHkobjweMEugNEjPF3NZ9sxAeJaf+HV/ftMvhjdSt4dSK8vN3fgK4BKF3WkP84nv4Q
	 Uahb+JJ/974RBI0oVHnj1sc0Gnbx4U5nBlVRPmFO1reC/hnSF+ebDirAVVv+V4iZIJ
	 6TOVPgMZK2NgCJxUzGxnXbSQcCWw6962KX8iQ3WtInBEYIve8tSOGA8wdcXd7zEe/c
	 3bwjDfVc7MQVEqo/FYZPuUoXJ2f/qc/ilOvZu530ffd2p2iCUIfveKG2Hqb4jwtAhz
	 1Rmw2FBaZJcGA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0A9D23782162;
	Wed, 29 May 2024 08:06:34 +0000 (UTC)
Message-ID: <0816b38b-41a1-431a-90a4-1ac33401a671@collabora.com>
Date: Wed, 29 May 2024 13:05:57 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/vDSO: fix clang build errors and warnings
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
References: <20240527211622.290635-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240527211622.290635-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 2:16 AM, John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...there are several warnings, and an error. This fixes all of those and
> allows these tests to run and pass.
> 
> 1. Fix linker error (undefined reference to memcpy) by providing a local
>    version of memcpy.
> 
> 2. clang complains about using this form:
> 
>     if (g = h & 0xf0000000)
> 
> ...so factor out the assignment into a separate step.
> 
> 3. The code is passing a signed const char* to elf_hash(), which expects
>    a const unsigned char *. There are several callers, so fix this at
>    the source by allowing the function to accept a signed argument, and
>    then converting to unsigned operations, once inside the function.
> 
> 4. clang doesn't have __attribute__((externally_visible)) and generates
>    a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
>    to require that attribute in order to build, run and pass tests here,
>    so remove it.
Just checked with GCC 5.1, it builds fine without any errors.

> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> 
> Changes since the first version:
> 
> 1) Rebased onto Linux 6.10-rc1
> 
> thanks,
> John Hubbard
> 
>  tools/testing/selftests/vDSO/parse_vdso.c      | 16 +++++++++++-----
>  .../selftests/vDSO/vdso_standalone_test_x86.c  | 18 ++++++++++++++++--
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 413f75620a35..4ae417372e9e 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -55,14 +55,20 @@ static struct vdso_info
>  	ELF(Verdef) *verdef;
>  } vdso_info;
>  
> -/* Straight from the ELF specification. */
> -static unsigned long elf_hash(const unsigned char *name)
> +/*
> + * Straight from the ELF specification...and then tweaked slightly, in order to
> + * avoid a few clang warnings.
> + */
> +static unsigned long elf_hash(const char *name)
>  {
>  	unsigned long h = 0, g;
> -	while (*name)
> +	const unsigned char *uch_name = (const unsigned char *)name;
> +
> +	while (*uch_name)
>  	{
> -		h = (h << 4) + *name++;
> -		if (g = h & 0xf0000000)
> +		h = (h << 4) + *uch_name++;
> +		g = h & 0xf0000000;
> +		if (g)
>  			h ^= g >> 24;
>  		h &= ~g;
>  	}
> diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> index 8a44ff973ee1..27f6fdf11969 100644
> --- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> +++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> @@ -18,7 +18,7 @@
>  
>  #include "parse_vdso.h"
>  
> -/* We need a libc functions... */
> +/* We need some libc functions... */
>  int strcmp(const char *a, const char *b)
>  {
>  	/* This implementation is buggy: it never returns -1. */
> @@ -34,6 +34,20 @@ int strcmp(const char *a, const char *b)
>  	return 0;
>  }
>  
> +/*
> + * The clang build needs this, although gcc does not.
> + * Stolen from lib/string.c.
> + */
> +void *memcpy(void *dest, const void *src, size_t count)
> +{
> +	char *tmp = dest;
> +	const char *s = src;
> +
> +	while (count--)
> +		*tmp++ = *s++;
> +	return dest;
> +}
> +
>  /* ...and two syscalls.  This is x86-specific. */
>  static inline long x86_syscall3(long nr, long a0, long a1, long a2)
>  {
> @@ -70,7 +84,7 @@ void to_base10(char *lastdig, time_t n)
>  	}
>  }
>  
> -__attribute__((externally_visible)) void c_main(void **stack)
> +void c_main(void **stack)
>  {
>  	/* Parse the stack */
>  	long argc = (long)*stack;
> 
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b

-- 
BR,
Muhammad Usama Anjum

