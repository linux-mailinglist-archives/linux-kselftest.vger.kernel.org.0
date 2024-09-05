Return-Path: <linux-kselftest+bounces-17329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF596E467
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F08B26497
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5646B1A4AA1;
	Thu,  5 Sep 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D9LhcuF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661D17741
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569407; cv=none; b=rtTGj956R3JgqPmc+izRh4BwiEfhiXwbKYdCo+xEMMduiL15B3eyQBM5DqXyKvBRulHCfroracK27iXO5kHmW+5dyySC5sYWcWs3LSvdTOrBmzBayxIaZiXmbP8xpWhlorU3Do7bCKoy0fa9kwB1Us4cNv+HGf7lqp7NOYApG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569407; c=relaxed/simple;
	bh=wIWBzCrGFQAewhEvnP4R5MHLhIkwE/YPqorJtUSeyNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akpDr8murZuUBJ1eJNVNq5/0rgUJt1JwgcLrDrGTKYxvOqqeijxdP32HBur+Ynnbn4C/lnPEicCQRVnoAhdLEfhuQF5GG2U8xK0mOxIHrlwIw8blWTZuOqM6NdRvfqdLqipT2NJ0TPbuNDBfPOr5BHTyJNPqm8uH3Y3TG2It+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D9LhcuF+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20543fdb7acso10765085ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Sep 2024 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725569403; x=1726174203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5j67CEFXRNtr6Xmy9mtD1raBCmoEtjn9HBt1C7xdQ8=;
        b=D9LhcuF+mz5sS6I6eVBd7x0hZKzRJTt3zDTNPkNwnYpASo3ndOZ4I7IaeA2E/oKDRE
         pSwlil9uwl3+7KJYUAoF9dwFSkXh/7deC18vqZdrfBwEPpMQm7mwcTiIEaJ4hwSEzW9I
         bqINsgUTyN+2ZoM7IQwNAn22Yg+dr031ycvt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725569403; x=1726174203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5j67CEFXRNtr6Xmy9mtD1raBCmoEtjn9HBt1C7xdQ8=;
        b=koJZzx4w+c0Rb6bc5KelbmRZ3lZSMoV4rKMWK7ZhLOt4lSszq2IuGTqg2kzOQtLu4s
         xiHzrlEuQQfwKtlH6fTbvGOvkVRpGdMw0yIXhi4K3Zqx9CacUa5gDv8to2nL37OPmgZo
         YShydI8DkAH7YdqIjIvUJm4pVxQEQsf2jICcwWyjZ8kocgNil4HVzZHfG5gk5oeRpmCL
         Hqb+gmghtuHHmIL3MpzMuwppnX7rAOEh0sIh/VvBJ5I7FQVwxfcMs9pkd77yfBgAv8yS
         1N73NIgFQRB5T0e+DdLblx8REZt5E7NrupIh31ygbGRsVWmuDwtmCQohkmiFNiyGT8u9
         kewA==
X-Gm-Message-State: AOJu0YyZ1rLkbSpNjS7HDVP5TwyBTww9ZLl/OYS5cZGaweOuXol4PXyE
	NayCMHINkLdWA2U5PeWQxbXFreQQczGkt2igoBS3AGWm4nvdldBb+qzV3BBn0D4=
X-Google-Smtp-Source: AGHT+IFh22jR+8w+nkXoquRiBAOM1X4buf1PQjdHJ+PRqs30ybWFT9p88swEqu8VHP14oYHZxRwjAg==
X-Received: by 2002:a17:902:a516:b0:1fb:2bed:6418 with SMTP id d9443c01a7336-206f065a8d7mr3261405ad.57.1725569403226;
        Thu, 05 Sep 2024 13:50:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea55a28sm32296555ad.220.2024.09.05.13.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 13:50:02 -0700 (PDT)
Message-ID: <51a72459-5e96-46a1-b28b-da421cdbc5e8@linuxfoundation.org>
Date: Thu, 5 Sep 2024 14:50:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:resctrl: Fix build failure on archs without
 __cpuid_count()
To: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
 fenghua.yu@intel.com, ilpo.jarvinen@linux.intel.com,
 usama.anjum@collabora.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905180231.20920-1-skhan@linuxfoundation.org>
 <2af94be4-95f1-48c9-a552-88352cd5d44d@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2af94be4-95f1-48c9-a552-88352cd5d44d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/5/24 14:45, Reinette Chatre wrote:
> Hi Shuah,
> 
> Thank you very much for looking into this.
> 
> On 9/5/24 11:02 AM, Shuah Khan wrote:
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
>>                   from cat_test.c:11:
>> In function ‘arch_supports_noncont_cat’,
>>      inlined from ‘noncont_cat_run_test’ at cat_test.c:326:6:
>> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>>        |         ^~~~~~~
>> cat_test.c:304:17: note: in expansion of macro ‘__cpuid_count’
>>    304 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>        |                 ^~~~~~~~~~~~~
>> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>>        |         ^~~~~~~
>> cat_test.c:306:17: note: in expansion of macro ‘__cpuid_count’
>>    306 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>
> 
> If needing to know where this fix is needed, there can be a:
> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")

Thanks - will add it when I apply the patch.

> 
>> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Perhaps:
> Closes: https://lore.kernel.org/lkml/20240809071059.265914-1-usama.anjum@collabora.com/

Thanks. I will add it when I apply the patch.

> 
>> Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/kselftest.h        | 2 ++
>>   tools/testing/selftests/resctrl/cat_test.c | 6 ++++--
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>> index b8967b6e29d5..e195ec156859 100644
>> --- a/tools/testing/selftests/kselftest.h
>> +++ b/tools/testing/selftests/kselftest.h
>> @@ -61,6 +61,7 @@
>>   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>>   #endif
>> +#if defined(__i386__) || defined(__x86_64__) /* arch */
>>   /*
>>    * gcc cpuid.h provides __cpuid_count() since v4.4.
>>    * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
>> @@ -75,6 +76,7 @@
>>                     : "=a" (a), "=b" (b), "=c" (c), "=d" (d)    \
>>                     : "0" (level), "2" (count))
>>   #endif
>> +#endif /* end arch */
>>   /* define kselftest exit codes */
>>   #define KSFT_PASS  0
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 742782438ca3..ae3f0fa5390b 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -290,12 +290,12 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>   static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>>   {
>> -    unsigned int eax, ebx, ecx, edx;
>> -
>>       /* AMD always supports non-contiguous CBM. */
>>       if (get_vendor() == ARCH_AMD)
>>           return true;
>> +#if defined(__i386__) || defined(__x86_64__) /* arch */
>> +    unsigned int eax, ebx, ecx, edx;
>>       /* Intel support for non-contiguous CBM needs to be discovered. */
>>       if (!strcmp(test->resource, "L3"))
>>           __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> @@ -305,6 +305,8 @@ static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>>           return false;
>>       return ((ecx >> 3) & 1);
>> +#endif /* end arch */
>> +    return false;
>>   }
>>   static int noncont_cat_run_test(const struct resctrl_test *test,
> 
> Thank you very much.
> 
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> 

thanks,
-- Shuah


