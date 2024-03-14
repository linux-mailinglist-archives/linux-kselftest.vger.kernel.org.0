Return-Path: <linux-kselftest+bounces-6316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF1687B97D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 09:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2C91C2154A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2786BB5E;
	Thu, 14 Mar 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oDk/vc0b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7149B6BB56;
	Thu, 14 Mar 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405962; cv=none; b=GxDjYO2JI4Omj2N1HvNt+oQ/O0tQUHp7YKBK9KMLgcQeJNe26RWXUtkpU9VDvWyYokCMxRRTnceDspEXeqbLyLObfpE5hqFeznykAY/hxfVhnaV2XkFpgE+IkmJv4QeM3NenlBRC65tQuyCBt6ef0kwU1iXRF+gJbXenHtEbHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405962; c=relaxed/simple;
	bh=almCwjmSv496A0+vWnZxh1TFaAh0w7CwD+k7Lrgi7wI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nsmzj68ireqGdSjgKvYBBQEnUyTuPr6UvJVBGt+XGn+Efv82Urm0733EWt6BpvhzvSOrkdCCUAfOUYLbI5GZUB+cfOzTQmItdzqdBhBqOKpWGjt9evGUqxMJJJvkXsgceVX+63PaxGwdYachZEgPd0MVy2Yu1ht+awlGQq2vl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oDk/vc0b; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710405958;
	bh=almCwjmSv496A0+vWnZxh1TFaAh0w7CwD+k7Lrgi7wI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oDk/vc0blI7okKBLO9A0oTSunqnhzePRCYgUgOmyPF8x64FWLiSeX9OrA7SiG2FiR
	 N39hU/RnAuAXo0aq8Ea1h3KniOSz+xg+zGmwxYnWM1SWbZThkkLvnZyTIzGJ8MhcZE
	 KreRcvBx5IPkzXqAgrbxeRBxZyRaEAZkjOmaqLJ3n7cQeCtyb5DdH9gJF83pSRtp2w
	 maDyLVw7HKtOjJ6okijVA6ONhbSx2UUcm4229CMpq1DOamH7F82kZSUfvCm8A6WTdR
	 8y379o+j/9mALxEhUbaqY8WF018oB8ObMPdJH2z1/dt3W/gbQ3rE3JRZgonxmec/O8
	 eUdNzBgE1nesw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 05465378105A;
	Thu, 14 Mar 2024 08:45:54 +0000 (UTC)
Message-ID: <07e2e91b-7b0d-4810-a2a1-ed4654ecafb4@collabora.com>
Date: Thu, 14 Mar 2024 13:46:22 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
Subject: Re: [PATCH v2 12/12] selftests/mm: virtual_address_range: conform to
 TAP format output
To: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>
References: <20240202113119.2047740-1-usama.anjum@collabora.com>
 <20240202113119.2047740-13-usama.anjum@collabora.com>
 <12b0aa90-3b4f-4fb0-b4df-c677f496cb09@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <12b0aa90-3b4f-4fb0-b4df-c677f496cb09@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/14/24 10:00 AM, Dev Jain wrote:
> 
> On 2/2/24 17:01, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   .../selftests/mm/virtual_address_range.c      | 44 +++++++++----------
>>   1 file changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c
>> b/tools/testing/selftests/mm/virtual_address_range.c
>> index bae0ceaf95b13..7bcf8d48256a6 100644
>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>> @@ -12,6 +12,7 @@
>>   #include <errno.h>
>>   #include <sys/mman.h>
>>   #include <sys/time.h>
>> +#include "../kselftest.h"
>>     /*
>>    * Maximum address range mapped with a single mmap()
>> @@ -68,23 +69,15 @@ static char *hind_addr(void)
>>       return (char *) (1UL << bits);
>>   }
>>   -static int validate_addr(char *ptr, int high_addr)
>> +static void validate_addr(char *ptr, int high_addr)
>>   {
>>       unsigned long addr = (unsigned long) ptr;
>>   -    if (high_addr) {
>> -        if (addr < HIGH_ADDR_MARK) {
>> -            printf("Bad address %lx\n", addr);
>> -            return 1;
>> -        }
>> -        return 0;
>> -    }
>> +    if (high_addr && addr < HIGH_ADDR_MARK)
>> +        ksft_exit_fail_msg("Bad address %lx\n", addr);
>>   -    if (addr > HIGH_ADDR_MARK) {
>> -        printf("Bad address %lx\n", addr);
>> -        return 1;
>> -    }
>> -    return 0;
>> +    if (addr > HIGH_ADDR_MARK)
>> +        ksft_exit_fail_msg("Bad address %lx\n", addr);
>>   }
>>     static int validate_lower_address_hint(void)
>> @@ -107,23 +100,29 @@ int main(int argc, char *argv[])
>>       char *hint;
>>       unsigned long i, lchunks, hchunks;
>>   +    ksft_print_header();
>> +    ksft_set_plan(1);
>> +
>>       for (i = 0; i < NR_CHUNKS_LOW; i++) {
>>           ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
>>                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>             if (ptr[i] == MAP_FAILED) {
>> -            if (validate_lower_address_hint())
>> -                return 1;
>> +            if (validate_lower_address_hint()) {
>> +                ksft_test_result_skip("Memory constraint not fulfilled\n");
>> +                ksft_finished();
>> +            }
> 
> Hi,
> 
> When validate_lower_address_hint() returns 1, it implies that despite
> filling the lower
> 
> range, mmap succeeded. IMHO, ksft_exit_fail_msg() should be used instead,
> with a
> 
> more descriptive message indicating that the memory was unexpectedly
> allocated.
Can you fire up a patch for this? Otherwise I'll get back to it next week.

> 
> 
> Regards
> 
> Dev
> 
>>               break;
>>           }
>>   -        if (validate_addr(ptr[i], 0))
>> -            return 1;
>> +        validate_addr(ptr[i], 0);
>>       }
>>       lchunks = i;
>>       hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
>> -    if (hptr == NULL)
>> -        return 1;
>> +    if (hptr == NULL) {
>> +        ksft_test_result_skip("Memory constraint not fulfilled\n");
>> +        ksft_finished();
>> +    }
>>         for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>>           hint = hind_addr();
>> @@ -133,8 +132,7 @@ int main(int argc, char *argv[])
>>           if (hptr[i] == MAP_FAILED)
>>               break;
>>   -        if (validate_addr(hptr[i], 1))
>> -            return 1;
>> +        validate_addr(hptr[i], 1);
>>       }
>>       hchunks = i;
>>   @@ -145,5 +143,7 @@ int main(int argc, char *argv[])
>>           munmap(hptr[i], MAP_CHUNK_SIZE);
>>         free(hptr);
>> -    return 0;
>> +
>> +    ksft_test_result_pass("Test\n");
>> +    ksft_finished();
>>   }

-- 
BR,
Muhammad Usama Anjum

