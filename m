Return-Path: <linux-kselftest+bounces-20672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390789B0773
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 17:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAC31C256CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6C1FB899;
	Fri, 25 Oct 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUlznoBs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358113B584
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868962; cv=none; b=qPoIA6GhrpqBAJV0suB4phQnR/cKoSq4KVXJkszd8Z0tXVOCqvArB/T/6z7e6mUc77fxptXULw+y7ibPGUYbDyafmHJ1/0ndMkIrZdCd/+CVfZhaTWD/GzjsdEG7LZm5QtaMIQjF6KgALo+byPsu048PfGcAZjc47IZTCy1kyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868962; c=relaxed/simple;
	bh=dt4LircY8aOQfF9FuQwvH4AoiZ4cwa4wv4f+/EJIsnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDI92WprGCsidlLTEGOavRXSuKBFRXOChu4pGUjPSBiS7FsRoA0nerahDFYX0p2mIrdq0SGwxD6/uTN95z8wikeHTtI6hBmRidjIX+z0FSlRoaNvlQ6vYwyLcSABWtu8ru3mLhQ4b1SxZpaEtZ4FxTx4MsPBEG7XSzFK9awYlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUlznoBs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729868961; x=1761404961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dt4LircY8aOQfF9FuQwvH4AoiZ4cwa4wv4f+/EJIsnQ=;
  b=DUlznoBsFcgNE3Zt9jXOUhaVBdr7wNZAeJrgrk4HVXo0RkhkzWSDcHze
   AZWtpLHDNhFAUqegMldcsaFHrvfPAxJzdAMueYcLlK7ilJ/TzYQqc7Y7b
   5Qk9G8rarhiPx12IlYv/tOxH6NBVneE7ckQfsAZscrlAlHR+E4dAyn1ga
   FTix40DROvce3EU1bGkl0Iih8dCBfLEpbTaIEfshoh4TtvARDjnlWmZsO
   Woq2BOwV9JpnDjpaJRUoWtKwTyHPjVDZHb8fbws4Yk4olbc4O0nR6OX5j
   vRYpwsQS60GBmfWViE4lyPYqqeRTEN5tX2heO6pSJtJpsAf26+pNHwPY/
   Q==;
X-CSE-ConnectionGUID: ZdF7X/gZSoOQVLnO52PKcw==
X-CSE-MsgGUID: jZrsWzA5Sge/umaaFZez7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="17173901"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="17173901"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:09:20 -0700
X-CSE-ConnectionGUID: +l00sF5NT9e9T0Tk9q/v5g==
X-CSE-MsgGUID: ENWLZACFRsuLhh2nkwOPzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="85524405"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.222.14]) ([10.124.222.14])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:09:18 -0700
Message-ID: <5fa27331-db95-4d60-8fd9-19fbd18f12bb@intel.com>
Date: Fri, 25 Oct 2024 08:09:18 -0700
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
 x86@kernel.org, Yury Khrustalev <Yury.Khrustalev@arm.com>
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
 <20241023150511.3923558-5-kevin.brodsky@arm.com>
 <6b575236-7e4e-4128-9ab6-7ecec7b81428@intel.com>
 <c35d8783-c754-4864-b964-4a3bfaa4cd11@arm.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <c35d8783-c754-4864-b964-4a3bfaa4cd11@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/24 01:31, Kevin Brodsky wrote:
> I agree, the naming is not ideal, I lacked inspiration! Maybe
> PKEY_REG_ALLOW_NONE to remain generic?

Works for me.

>>>  static inline void __page_o_noops(void)
>>>  {
>>>  	/* 8-bytes of instruction * 512 bytes = 1 page */
>>> diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
>>> index a8088b645ad6..b5e1767ee5d9 100644
>>> --- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
>>> +++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
>>> @@ -37,6 +37,8 @@ pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
>>>  pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
>>>  siginfo_t siginfo = {0};
>>>  
>>> +static u64 pkey_reg_no_access;
>> Ideally, this would be a real const or a #define because it really is
>> static.  Right?  Or is there something dynamic about the ARM
>> implementation's value?
> 
> It isn't dynamic no, the issue is that on architectures where pkeys
> restrict execution we need to allow X for pkey 0. Of course it would be
> possible to define PKEY_REG_ALLOW_ALL in such a way that X is allowed
> for pkey 0, but I was concerned this might be misleading. No strong
> opinion either way, happy to make it purely a macro, maybe with a better
> name?

I do think we should differentiate truly "no access" value from the one
that allows X on pkey 0, at least in the selftest.  Define a helper that
uses the *real* "no access" value:

/*
 * Returns the most restrictive register value
 * that can be used in the selftest.
 */
static inline u64 pkey_reg_restrictive_default(void)
{
	/*
	 * The selftest code runs (mostly) with its code mapped with
	 * pkey-0.  Allows execution on pkey-0 so that each site doesn't
	 * have to do this:
	 */
	return set_pkey_bits(PKEY_REG_NO_ACCESS, 0, PKEY_X);
}

and then use it like this:

	pkey_reg = pkey_reg_restrictive_default();
 	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_ALLOW_ALL);

>>>  	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
>>> @@ -142,7 +145,8 @@ static void *thread_segv_maperr_ptr(void *ptr)
>>>  	syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
>>>  
>>>  	/* Disable MPK 0.  Only MPK 1 is enabled. */
>>> -	__write_pkey_reg(0x55555551);
>>> +	pkey_reg = set_pkey_bits(pkey_reg_no_access, 1, 0);
>>> +	__write_pkey_reg(pkey_reg);
>> The existing magic numbers are not great, but could we do:
>>
>> #define PKEY_ALLOW_ALL 0x0
>>
>> So that this can be written like this:
>>
>> 	pkey_reg = PKRU_ALLOW_NONE;
>> 	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_ALLOW_ALL);
>>
>> That would get rid of the magic '0'.
> 
> Definitely better yes. But how about using Yury's uapi addition,
> PKEY_UNRESTRICTED [1]?
> 

Works for me.

>> ...
>>> +	/* Only allow X for MPK 0 and nothing for other keys */
>>> +	pkey_reg_no_access = set_pkey_bits(PKEY_ALLOW_NONE, 0,
>>> +					   PKEY_DISABLE_ACCESS);
>> If the comment says "only allow X", then I'd expect the code to say:
>>
>> 	pkey_reg_no_access = set_pkey_bits(PKEY_ALLOW_NONE, 0, PKEY_X);
>>
>> ... or something similar.
> 
> I could #define PKEY_X PKEY_DISABLE_ACCESS but is the mixture of
> negative and positive polarity really helping? We cannot define PKEY_R
> and PKEY_W so that (for instance) PKEY_R | PKEY_X does what it says.
> Having to use PKEY_DISABLE_ACCESS to mean "X only" is not ideal, but
> this is what userspace already has to do.

There would be some churn, but we could also convert the whole thing
over to just use explicit RWX enable bits, like in the
thread_segv_maperr_ptr() test:

	// Truly turn everything off:
	pkey_reg = PKEY_REG_NO_ACCESS;
 	pkey_reg = set_pkey_perm(pkey_reg, 1, PKEY_RW);

I'm not sure that's worth the churn though.



