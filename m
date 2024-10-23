Return-Path: <linux-kselftest+bounces-20496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882429AD1F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 19:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EFE288EFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99FB1D0943;
	Wed, 23 Oct 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElzxxtT2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE61D0949
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702320; cv=none; b=sCF9H47mM/fyjv6Q404EK1E8QanhD9LErOT5X9g6oz0K7dGzrTBZKqQNa0KgOH3t1IyT2SJcgI6j42vk+qlQdJCRZTr5TGUPlhwhfAoJnQCcXlMzI8VcXRjrlbfnHgHSgP2cT8Yk3oHEv6BiqLbEJbazaLkDq4Wm8hkeQJ+elv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702320; c=relaxed/simple;
	bh=40pb8klW+ODECpPhXH68YScfylnlcQv/76gyaYpEBVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTLnDDhtzTMjHobz5xmheRrkZdyhCvN7/ABpouv6HwQ+xZ90yflg6ny+r9XBCQWQ35POuFqj0JbGL8cTWd2kN9AYJNpnsZ7zv52KoNtp4rew4XLP+CUuRGSSQEzOF+GAaXVOuYJe3VagEYCXz7Lywulo7w/UPgZqNt2apz+Jeug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElzxxtT2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729702319; x=1761238319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=40pb8klW+ODECpPhXH68YScfylnlcQv/76gyaYpEBVs=;
  b=ElzxxtT2A6UXnJkYUXqbHsVvxetfEeNcrvkWO9FubPnse5ldaVTXwBIA
   v6oYy6eJKjea9P5MT6wLzKyLoGGqNeQh7qLtj+jvW+MgeKNiXqka2xlZk
   +u/uQ8VC8yyH2eYCK2GMlzlfwdQqi113comBHyPNcsaf38xg4M8YPovs6
   IjkmT4K4OC0fS7QV+KVkHHjSTYzjS+I00vKlWEvy7dR6fumnbygEcziHd
   JXoS5TgJ+pGrmpT7P2MlZ5V2CXpgFvlF+rVn3QhYPH8f62AEXKQhWeoxl
   +D/WyXOXkK4qbnFtGoEIM/r0Es+0UjnFB9zUdP3MZK9BhHqCVmXDe3eG5
   g==;
X-CSE-ConnectionGUID: KD/CZgHIQSaKq5UYl19K9w==
X-CSE-MsgGUID: btl4UpChQ8ad/DC/bgwmqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40695411"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="40695411"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 09:51:58 -0700
X-CSE-ConnectionGUID: ILx0V+eORuWSVE0ZoH8Ggg==
X-CSE-MsgGUID: blE4w4hCRXGtp82vFwdQTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84897952"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.124.221.6]) ([10.124.221.6])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 09:51:56 -0700
Message-ID: <6b575236-7e4e-4128-9ab6-7ecec7b81428@intel.com>
Date: Wed, 23 Oct 2024 09:51:55 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] selftests/mm: Use generic pkey register
 manipulation
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, anshuman.khandual@arm.com,
 aruna.ramakrishna@oracle.com, broonie@kernel.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, dave.martin@arm.com, jeffxu@chromium.org,
 joey.gouly@arm.com, pierre.langlois@arm.com, shuah@kernel.org,
 sroettger@google.com, will@kernel.org, linux-kselftest@vger.kernel.org,
 x86@kernel.org
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
 <20241023150511.3923558-5-kevin.brodsky@arm.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241023150511.3923558-5-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/24 08:05, Kevin Brodsky wrote:
...> diff --git a/tools/testing/selftests/mm/pkey-x86.h
b/tools/testing/selftests/mm/pkey-x86.h
> index 5f28e26a2511..53ed9a336ffe 100644
> --- a/tools/testing/selftests/mm/pkey-x86.h
> +++ b/tools/testing/selftests/mm/pkey-x86.h
> @@ -34,6 +34,8 @@
>  #define PAGE_SIZE		4096
>  #define MB			(1<<20)
>  
> +#define PKEY_ALLOW_NONE		0x55555555

Hi Kevin,

Looking at this in context, I think "PKEY_ALLOW_NONE" is not a great
name.  On one hand, we have:

	PKEY_DISABLE_ACCESS
	PKEY_DISABLE_WRITE

which are values for *A* pkey.

But PKEY_ALLOW_NONE is a whole register value and spans permissions for
many keys.  We don't want folks trying to do something like:

	pkey_alloc(flags, PKEY_ALLOW_NONE);

If I were naming it in x86 code, I'd probably call it:

	PKRU_ALLOW_NONE

or something.

>  static inline void __page_o_noops(void)
>  {
>  	/* 8-bytes of instruction * 512 bytes = 1 page */
> diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
> index a8088b645ad6..b5e1767ee5d9 100644
> --- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
> +++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
> @@ -37,6 +37,8 @@ pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
>  pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
>  siginfo_t siginfo = {0};
>  
> +static u64 pkey_reg_no_access;

Ideally, this would be a real const or a #define because it really is
static.  Right?  Or is there something dynamic about the ARM
implementation's value?

...
>  	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
> @@ -142,7 +145,8 @@ static void *thread_segv_maperr_ptr(void *ptr)
>  	syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
>  
>  	/* Disable MPK 0.  Only MPK 1 is enabled. */
> -	__write_pkey_reg(0x55555551);
> +	pkey_reg = set_pkey_bits(pkey_reg_no_access, 1, 0);
> +	__write_pkey_reg(pkey_reg);

The existing magic numbers are not great, but could we do:

#define PKEY_ALLOW_ALL 0x0

So that this can be written like this:

	pkey_reg = PKRU_ALLOW_NONE;
	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_ALLOW_ALL);

That would get rid of the magic '0'.

>  	/* Segfault */
>  	*bad = 1;
> @@ -240,6 +244,7 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
>  	int pkey;
>  	int parent_pid = 0;
>  	int child_pid = 0;
> +	u64 pkey_reg;
>  
>  	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
>  
> @@ -257,7 +262,9 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
>  	assert(stack != MAP_FAILED);
>  
>  	/* Allow access to MPK 0 and MPK 1 */
> -	__write_pkey_reg(0x55555550);
> +	pkey_reg = set_pkey_bits(pkey_reg_no_access, 0, 0);
> +	pkey_reg = set_pkey_bits(pkey_reg, 1, 0);
> +	__write_pkey_reg(pkey_reg);

... and using the pattern from above, this is quite a bit more readable:

	pkey_reg = PKRU_ALLOW_NONE;
	pkey_reg = set_pkey_bits(pkey_reg, 0, PKEY_ALLOW_ALL);
	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_ALLOW_ALL);

...
> +	/* Only allow X for MPK 0 and nothing for other keys */
> +	pkey_reg_no_access = set_pkey_bits(PKEY_ALLOW_NONE, 0,
> +					   PKEY_DISABLE_ACCESS);
If the comment says "only allow X", then I'd expect the code to say:

	pkey_reg_no_access = set_pkey_bits(PKEY_ALLOW_NONE, 0, PKEY_X);

... or something similar.

