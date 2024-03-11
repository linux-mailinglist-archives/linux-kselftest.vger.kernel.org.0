Return-Path: <linux-kselftest+bounces-6215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDF08785F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 18:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CE41F215A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD0482DB;
	Mon, 11 Mar 2024 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NzfB3IFv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCC482D1;
	Mon, 11 Mar 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176525; cv=none; b=QhXlms1nobwMWhwmc+ImxY8zCuLhfBL+QGTeTM/I1KKPdoXucjwMCaBFoaSfPnVG07kKJKI8SLTLsPNHmXY2LFpQBeN9DzQXGDdSqKRo+vXu+avZX+ZtrfB2C4BrPvBAhSkl4/Jx1SZFwh9DihSVHQLws+3pJzJiy11tWEDT3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176525; c=relaxed/simple;
	bh=D9uVuEy9DT1FDOsqkYiOzDsS+RuUagKwN+xLlAFjNaE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lcuUFzU1l076b5AJtzZXncWy6NJotzaC1qC7R2TfCh0BTLBBetjSh0MVEJONy4OWdHkVLu/cNZwMXiBeW4rKNvsqJlBkT1qMc2PuKwNVfY3tsVGlGWrF6OaTb2gjJE3RHaLdWH6bLBZ9vKpp/B4wke/27MZV3GcqIJkQecbQ6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NzfB3IFv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710176521;
	bh=D9uVuEy9DT1FDOsqkYiOzDsS+RuUagKwN+xLlAFjNaE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NzfB3IFv1BMymbFajCTtjdsPZLtrU1+vW8HuhboF2hvMkBDGuRhBM/rlaBETAZGJz
	 1+ChAyn1jw3l7+zsp4NOlkmVfjz2qIRGI6GhiF9Fp96EJSB1tJ0f88OiWrIMWlU1AH
	 60sjB3+xcvBIXs148w65/crmfEPrRp507rEYf+ZO8QgJnmBNfxzKRh27eiTLLVwxC5
	 9tOS1x/sH/JIx4Acz/GLWWeBv0I73i1GSygOBg9F6MDuX2VPZLvrg5shaueKJxpNk3
	 9U/YV1kGkxdBj5qzMh2TDji5pRZaZSXfV2atuWHp+HyQcPfmL0+Nlc35k3bf6REurN
	 9b5iOByiYQnKQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F250E378200D;
	Mon, 11 Mar 2024 17:01:57 +0000 (UTC)
Message-ID: <c3362840-365e-40cb-80fe-895aa2d979ec@collabora.com>
Date: Mon, 11 Mar 2024 22:02:27 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: "Chang S. Bae" <chang.seok.bae@intel.com>, Shuah Khan <shuah@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Weihong Zhang <weihong.zhang@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>
References: <20240307183730.2858264-1-usama.anjum@collabora.com>
 <dc8d122a-22b7-4d17-abd9-66262af0b058@intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <dc8d122a-22b7-4d17-abd9-66262af0b058@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/9/24 6:06 AM, Chang S. Bae wrote:
> On 3/7/2024 10:37 AM, Muhammad Usama Anjum wrote:
>>
>> diff --git a/tools/testing/selftests/x86/amx.c
>> b/tools/testing/selftests/x86/amx.c
>> index d884fd69dd510..5d1ca0bbaaae7 100644
>> --- a/tools/testing/selftests/x86/amx.c
>> +++ b/tools/testing/selftests/x86/amx.c
>> @@ -103,9 +103,10 @@ static void clearhandler(int sig)
>>     #define CPUID_LEAF1_ECX_XSAVE_MASK    (1 << 26)
>>   #define CPUID_LEAF1_ECX_OSXSAVE_MASK    (1 << 27)
>> -static inline void check_cpuid_xsave(void)
>> +static inline int check_cpuid_xsave(void)
>>   {
>>       uint32_t eax, ebx, ecx, edx;
>> +    int ret = 0;
>>         /*
>>        * CPUID.1:ECX.XSAVE[bit 26] enumerates general
>> @@ -113,10 +114,16 @@ static inline void check_cpuid_xsave(void)
>>        * XGETBV.
>>        */
>>       __cpuid_count(1, 0, eax, ebx, ecx, edx);
>> -    if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
>> -        fatal_error("cpuid: no CPU xsave support");
>> -    if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
>> -        fatal_error("cpuid: no OS xsave support");
>> +    if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK)) {
>> +        ksft_print_msg("cpuid: no CPU xsave support\n");
>> +        ret = -1;
>> +    }
>> +    if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK)) {
>> +        ksft_print_msg("cpuid: no OS xsave support\n");
>> +        ret = -1;
>> +    }
>> +
>> +    return ret;
>>   }
> 
> I thought check_cpuid_xsave() can go away [1] by simplifying the
> availability check through arch_prctl():
In this patch, I'm just focusing on skip login on existing code. I'll make
this change when I'll transform the entire test to TAP.

> 
> +#define ARCH_GET_XCOMP_SUPP    0x1021
>  #define ARCH_GET_XCOMP_PERM    0x1022
>  #define ARCH_REQ_XCOMP_PERM    0x1023
> 
> @@ -928,8 +911,15 @@ static void test_ptrace(void)
> 
>  int main(void)
>  {
> -       /* Check hardware availability at first */
> -       check_cpuid_xsave();
> +       unsigned long features;
> +       long rc;
> +
> +       rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
> +       if (rc || (features & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
> +               ksft_print_msg("no AMX support\n");
> +               return KSFT_SKIP;
> +       }
> 
>> -static void check_cpuid_xtiledata(void)
>> +static int check_cpuid_xtiledata(void)
>>   {
>>       uint32_t eax, ebx, ecx, edx;
>>   @@ -153,12 +160,16 @@ static void check_cpuid_xtiledata(void)
>>        * eax: XTILEDATA state component size
>>        * ebx: XTILEDATA state component offset in user buffer
>>        */
>> -    if (!eax || !ebx)
>> -        fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
>> -                eax, ebx);
>> +    if (!eax || !ebx) {
>> +        ksft_print_msg("xstate cpuid: invalid tile data size/offset:
>> %d/%d\n",
>> +                   eax, ebx);
>> +        return -1;
>> +    }
>>         xtiledata.size          = eax;
>>       xtiledata.xbuf_offset = ebx;
>> +
>> +    return 0;
>>   }
> 
> I don't think it is okay to silently skip the test here. If the feature is
> available, the tile data size and offset should not be zero.
We are logging that data size/offset are invalid if either eax or ebx are
invalid and then we are skipping. Not sure what you are asking me to change.

> 
> Thanks,
> Chang
> 
> [1]
> https://lore.kernel.org/lkml/327cde12-daea-84ba-4b24-64fe12e89dea@intel.com/
> 

-- 
BR,
Muhammad Usama Anjum

