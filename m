Return-Path: <linux-kselftest+bounces-13833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A33C933CDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 14:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8018B20E69
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345C17FAA9;
	Wed, 17 Jul 2024 12:11:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121F38385;
	Wed, 17 Jul 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218296; cv=none; b=tpe+I7S3gGdmxCLmJ7MqjQ1+SUE8pY/Qroxbpxmd3Jj+EID5cLSicqtDHBTAy7yzvTT4HzIQtNupBvjWQ+qfEkEkaPdNjPgJd6pPh7gCcvngfLjMBj7WVhRG3orAutkUkw+A2COUz1UsoT5pJh7wF+y9LXBFZW7hGN/2K3lbeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218296; c=relaxed/simple;
	bh=Cc2J6wmh/RMwK6UDOtUfqKU3tK1CB6zpaXWCypDmyLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCPU4hFr2Sm0sLbbbLijKMXQSkuP7F5ovA6qzXmvddd+GfuK10FpG1zU2trQcj07P01Bi4g/RCKNpIx/nrm5X1VBAZZsRW+6ConJqb3eYGnwlLSHDn5DFcMBQH5V4oT6HTIqAmahXgi7mCjDTS+8pek61tv7AfzIkSBxZYR+VmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B9611063;
	Wed, 17 Jul 2024 05:11:59 -0700 (PDT)
Received: from [10.162.43.24] (e116581.arm.com [10.162.43.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFF313F766;
	Wed, 17 Jul 2024 05:11:30 -0700 (PDT)
Message-ID: <3782befb-c317-4bb0-a279-c90adb2ec47b@arm.com>
Date: Wed, 17 Jul 2024 17:41:27 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Skip test for non-LPA2 and non-LVA systems
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, Anshuman.Khandual@arm.com, broonie@kernel.org
References: <20240717111011.316037-1-dev.jain@arm.com>
 <da0054f5-b84e-4635-ae81-9c72f2f25542@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <da0054f5-b84e-4635-ae81-9c72f2f25542@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/17/24 17:27, Ryan Roberts wrote:
> On 17/07/2024 12:10, Dev Jain wrote:
>> Post my improvement of the test:
>> https://lore.kernel.org/all/20240522070435.773918-3-dev.jain@arm.com/
>> The test begins to fail on 4k and 16k pages, on non-LPA2 systems. To
>> reduce noise in the CI systems, let us skip the test when higher address
>> space is not implemented.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> The patch applies on linux-next.
>>
>>   tools/testing/selftests/mm/va_high_addr_switch.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
>> index fa7eabfaf841..c6040e1d6e53 100644
>> --- a/tools/testing/selftests/mm/va_high_addr_switch.c
>> +++ b/tools/testing/selftests/mm/va_high_addr_switch.c
>> @@ -293,6 +293,18 @@ static int run_test(struct testcase *test, int count)
>>   	return ret;
>>   }
>>   
>> +/* Check if userspace VA > 48 bits */
>> +static int high_address_present(void)
>> +{
>> +	void *ptr = mmap((void *)(1UL << 50), 1, PROT_READ | PROT_WRITE,
>> +			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> I think there is (very unlikely) possibility that something is already mapped at
> this address so it will be replaced due to MAP_FIXED. That could break the test.
> But the only way something could be already mapped is if ARM64_FORCE_52BIT is
> set and in that case, the test will fail anyway, right? So I think this is fine.

The testcases already assume that high addresses must be empty. Yes, FORCE_52BIT
is the only way something could already be mapped at high addresses, but in that
case the test fails trivially.

>
>> +	if (ptr == MAP_FAILED)
>> +		return 0;
>> +
>> +	munmap(ptr, 1);
>> +	return 1;
>> +}
> I'm guessing this will cause a function-not-used warning on arches other than
> arm64? Perhaps wrap it in `#ifdef __aarch64__`?

Ah yes, I just checked and that is true. I shall post v2 in some time, shall
wait if any more comments are there.

>
> Thanks,
> Ryan
>
>> +
>>   static int supported_arch(void)
>>   {
>>   #if defined(__powerpc64__)
>> @@ -300,7 +312,7 @@ static int supported_arch(void)
>>   #elif defined(__x86_64__)
>>   	return 1;
>>   #elif defined(__aarch64__)
>> -	return 1;
>> +	return high_address_present();
>>   #else
>>   	return 0;
>>   #endif

