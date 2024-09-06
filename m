Return-Path: <linux-kselftest+bounces-17397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB196F676
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 16:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC461F25197
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655991D27AC;
	Fri,  6 Sep 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cMpd6Fes"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6EA1D279B
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632134; cv=none; b=d3K/sdRPv6NxcMIwfpP6LrLdNF0PV20iaER0aTPtPOfpEtzsaWWNF52HwM5QBRb6TOvFG0WVWS6Sa0AJd8VB5AKcylXC3AJ9yqY32GVvbpJrueLAFV8Oxwy/lc0oOVpkRikBJscfqr03N6IrzBhPfjfqQPRskbtbUJQ1iBmqi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632134; c=relaxed/simple;
	bh=y5MxjUMhzpEGLcAk+RQ1L1Eah2Fr5EnO8/enSmmZa6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJh1Pa49yBEHnNKKxL3IOzhy/YzlG3x64Se4x/dC4e4dw+P5Wx/yMoSs+7r4k/3gBmzakYP3A+wOV96xFB1UE38o3uBYqww4eg33z7mxKn6lpgjo0BYJHXE+A9thdYcf+S/uB3yICz2cofUeFVEKY7ejlPPUkB8H87GJ2I1OIkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cMpd6Fes; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a109bc459so102959639f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725632130; x=1726236930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDDzZwDYU4Gy6OtpP5FWKJoDHuwx4Dvh85vp17WCwo4=;
        b=cMpd6FesQLw4KQNv5rOhx8z80CKGeF0F42uvuBmhprQOHMJYukT0lks+ZR/hkiMPE0
         sAjHkDVZnTM1r9pol90a0am6kRqWO398EkBZoqRMLxwRo/ggRenMbYF3FytPYnjbdXHI
         QXrGJYUHZ/uVD0KJ3WO7nesaC4DIu3Q7IOK1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632130; x=1726236930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDDzZwDYU4Gy6OtpP5FWKJoDHuwx4Dvh85vp17WCwo4=;
        b=dSBfPKssVFO3YKM5a+P+6udP+W65l+2A5mxvUVoBAHUfiKoxm2fZGA0BJ5FmZqA4a0
         J1GxQFSs/CPjyVgrrc3AsY8jpp84Li+zJmCF5TsMnaXbR3c/m3fJh6Ac17+K7e6WQcO+
         KwRmYmmxJ6fOzTaS7wEYznG39bt23u/1E493fBPnO7imJnlEcL17Ev1G5Sj3ef9BSWM5
         0MDMD+APAAUlx9cVLE+yDRa/WjYlASUCPtZyJETMJE6CROv9uT1+Wq7MhaxFYJuTbzyw
         hv61ZmlFwUAL2zKWIyRedF1Q1ufcJbPFmv6+BSr5ODMHyiHJ1BB7AQpeEp/V0rm7ypUD
         nOVA==
X-Gm-Message-State: AOJu0YzXZ082GaKdK4/9HfqaOcICzkinQzDCe33zNk2Z3fDfnv0pMAAb
	Iz0Wn7KgBpRZRHuDP9dYmpzBDwBMz2cNrdljn5wtg0/WyHrNzTCoDMr6qplUMkM=
X-Google-Smtp-Source: AGHT+IEqK3aHyVvIF5x9SIq59DQgu4GmB9tqUj2d49l/0SkuT/UStk0+VtWJJAOQEjuFzgu/WZZNlw==
X-Received: by 2002:a05:6e02:525:b0:39e:69bc:a7fe with SMTP id e9e14a558f8ab-39f797b23cdmr65602215ab.10.1725632130496;
        Fri, 06 Sep 2024 07:15:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de601csm4129939173.48.2024.09.06.07.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:15:30 -0700 (PDT)
Message-ID: <ae32280e-e3a2-418c-a148-c59956b6521c@linuxfoundation.org>
Date: Fri, 6 Sep 2024 08:15:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:resctrl: Fix build failure on archs without
 __cpuid_count()
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>, shuah@kernel.org,
 fenghua.yu@intel.com, reinette.chatre@intel.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905180231.20920-1-skhan@linuxfoundation.org>
 <ad3d035e-be82-44c4-a850-a33889fcf717@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ad3d035e-be82-44c4-a850-a33889fcf717@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/24 01:35, Muhammad Usama Anjum wrote:
> Hi Shuah,
> 
> Thank you for fixing it.
> 
> On 9/5/24 11:02 PM, Shuah Khan wrote:
>> When resctrl is built on architectures without __cpuid_count()
>> support, build fails. resctrl uses __cpuid_count() defined in
>> kselftest.h.
>>
>> Even though the problem is seen while building resctrl on aarch64,
>> this error can be seen on any platform that doesn't support CPUID.
>>
>> CPUID is a x86/x86-64 feature and code paths with CPUID asm commands
>> will fail to build on all other architectures.
>>
>> All others tests call __cpuid_count() do so from x86/x86_64 code paths
>> when _i386__ or __x86_64__ are defined. resctrl is an exception.
>>
>> Fix the problem by defining __cpuid_count() only when __i386__ or
>> __x86_64__ are defined in kselftest.h and changing resctrl to call
>> __cpuid_count() only when __i386__ or __x86_64__ are defined.
>>
>> In file included from resctrl.h:24,
>>                   from cat_test.c:11:
>> In function ‘arch_supports_noncont_cat’,
>>      inlined from ‘noncont_cat_run_test’ at cat_test.c:326:6:
>> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>>        |         ^~~~~~~
>> cat_test.c:304:17: note: in expansion of macro ‘__cpuid_count’
>>    304 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>        |                 ^~~~~~~~~~~~~
>> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>>        |         ^~~~~~~
>> cat_test.c:306:17: note: in expansion of macro ‘__cpuid_count’
>>    306 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>
>> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> LGTM
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thank you for the review and finding the problem to begin with.
Much appreciated.

> 
> ...
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 742782438ca3..ae3f0fa5390b 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -290,12 +290,12 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>   
>>   static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>>   {
>> -	unsigned int eax, ebx, ecx, edx;
>> -
>>   	/* AMD always supports non-contiguous CBM. */
>>   	if (get_vendor() == ARCH_AMD)
>>   		return true;
>>   
>> +#if defined(__i386__) || defined(__x86_64__) /* arch */
>> +	unsigned int eax, ebx, ecx, edx;
>>   	/* Intel support for non-contiguous CBM needs to be discovered. */
>>   	if (!strcmp(test->resource, "L3"))
>>   		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> @@ -305,6 +305,8 @@ static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>>   		return false;
>>   
>>   	return ((ecx >> 3) & 1);
>> +#endif /* end arch */
>> +	return false;
> nit: empty line before return

Will do.

> 
>>   }
>>   
>>   static int noncont_cat_run_test(const struct resctrl_test *test,
> 

thanks,
-- Shuah

