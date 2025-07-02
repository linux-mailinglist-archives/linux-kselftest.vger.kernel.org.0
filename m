Return-Path: <linux-kselftest+bounces-36273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905EEAF0CC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 09:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AAA1888471
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 07:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D0227B8C;
	Wed,  2 Jul 2025 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="VZ0ClbI4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9D219E8C;
	Wed,  2 Jul 2025 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441988; cv=pass; b=FMG/XXK7urvWAqGzT/RucJuG9vu64NDjb+M+ifYmP95YmrkeCsg0H1vFMDe6UFlHDPxMSkoszshET0APvP6XviFUzWXgpWHjZWJGksP2pjJUFj2VEMiiSmRjLpzx8TL4B/V9JPh31h0k5kEdcBTMMx6AiFCMWc1QSqLWIAu998s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441988; c=relaxed/simple;
	bh=BLIq5vj4c8xsi6t/A3iQ1LDcDCW83a66Xr98kkzGJSU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CnrONMMVUvslfOT9+/tXnR2pnOJC8+zAkFExdJchTYw7onoSu0Ntuh25zBoULFKSqf1bOeX91RZOVdcyDO2y9/gYAd2qZe0tcPt3lBiUSU7Ncb8ePPWF+1341hzm6ocGxDPfhoWZGx2FzsEJbBqfFm3OLwnQ8DexX/O1XmpWlco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=VZ0ClbI4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751441966; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NmUh/1fjpIBArR4N9g4lqkbzkmO110cbQJsMuglmkB5CZV0paCjiWvwJqDXRd5hfsMD3+BgEYxkRX0L3gIEoBOGiaAkVET/D0xh0JJIzJ/rv4bVtEptW6s5Oy5a+SUB/0IHiV4P9RY0QRO+wlZlINvR+qIl1HiQwOI31069Enx8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751441966; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+KxUmFeRC8bMIw5Ny9ddbbRTXTvex9p04JtTzsIBz/Q=; 
	b=EINfJhRxOE82S/I83LeHXTnUAWOY6Q8aRHpX2doyMKAt3zj5C4lYZyQFWd3NHt9BqBEN3r91LHW170aZqLLkAV820NQUv/7U340m/hRxQcsh89cc3oPFL2BE5GUSTGsq2pmA/Fkw6yNkvyjDnIEUmbgGjJtQ52KUrI9i+mV3b3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751441966;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+KxUmFeRC8bMIw5Ny9ddbbRTXTvex9p04JtTzsIBz/Q=;
	b=VZ0ClbI4Zwnmgg+XayfBJRLWhMg0lJ12UPuI5wgUT2yrVVZwoK69Am7bVjupAovB
	0UvxQxyMjFmXio5f7t5CYruxkhSta5kMblB0EeiNQCC79t4BEIaSyxxQJF/cWh7QlX3
	rtSv0JVccKgSI1IXAVqyzDNlCceEZgPMOzW/+isw=
Received: by mx.zohomail.com with SMTPS id 1751441963179311.66631066300556;
	Wed, 2 Jul 2025 00:39:23 -0700 (PDT)
Message-ID: <6846faf7-20b5-4f08-a8f0-9946f993b0e9@collabora.com>
Date: Wed, 2 Jul 2025 12:39:17 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: pagemap_scan ioctl: add PFN ZERO test cases
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20250630102443.137809-1-usama.anjum@collabora.com>
 <20027e0c-f43b-4d10-a4d6-41dcc38145bd@redhat.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20027e0c-f43b-4d10-a4d6-41dcc38145bd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 7/1/25 7:51 PM, David Hildenbrand wrote:
> On 30.06.25 12:24, Muhammad Usama Anjum wrote:
>> Add test cases to test the correctness of PFN ZERO flag of pagemap_scan
>> ioctl. Test with normal pages backed memory and huge pages backed
>> memory.
> 
> Just to verify: would this trigger on kernels before my fix?
Yes, it does trigger the bug without the fix.

> 
>>
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> The bug has been fixed [1].
>>
>> [1] https://lore.kernel.org/all/20250617143532.2375383-1-david@redhat.com
>> ---
>>   tools/testing/selftests/mm/pagemap_ioctl.c | 57 +++++++++++++++++++++-
>>   1 file changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/
>> testing/selftests/mm/pagemap_ioctl.c
>> index 57b4bba2b45f3..6138de0087edf 100644
>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>> @@ -1,4 +1,5 @@
>>   // SPDX-License-Identifier: GPL-2.0
>> +
>>   #define _GNU_SOURCE
>>   #include <stdio.h>
>>   #include <fcntl.h>
>> @@ -1480,6 +1481,57 @@ static void transact_test(int page_size)
>>                     extra_thread_faults);
>>   }
>>   +void zeropfn_tests(void)
>> +{
>> +    unsigned long long mem_size;
>> +    struct page_region vec;
>> +    int i, ret;
>> +    char *mem;
>> +
>> +    /* Test with page backed memory */
> 
> What is "page backed memory" ? :)
I mean, normal memory which isn't huge page backed. I've renamed it to
Test with normal memory.

> 
>> +    mem_size = 10 * page_size;
>> +    mem = mmap(NULL, mem_size, PROT_READ, MAP_PRIVATE | MAP_ANON, -1,
>> 0);
>> +    if (mem == MAP_FAILED)
>> +        ksft_exit_fail_msg("error nomem\n");
>> +
>> +    /* Touch each page to ensure it's mapped */
>> +    for (i = 0; i < mem_size; i += page_size)
>> +        (void)((volatile char *)mem)[i];
>> +
>> +    ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
>> +                (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0,
>> PAGE_IS_PFNZERO);
>> +    if (ret < 0)
>> +        ksft_exit_fail_msg("error %d %d %s\n", ret, errno,
>> strerror(errno));
>> +
>> +    ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
>> +             "%s all pages must have PFNZERO set\n", __func__);
>> +
>> +    munmap(mem, mem_size);
>> +
>> +    /* Test with huge page */
>> +    mem_size = 10 * hpage_size;
>> +    mem = memalign(hpage_size, mem_size);
>> +    if (!mem)
>> +        ksft_exit_fail_msg("error nomem\n");
>> +
>> +    ret = madvise(mem, mem_size, MADV_HUGEPAGE);
>> +    if (ret)
>> +        ksft_exit_fail_msg("madvise failed %d %s\n", errno,
>> strerror(errno));
> 
> Might fail on older kernels, so we usually treat this as a skip.
I'll skip it in next version.

> 
>> +
>> +    for (i = 0; i < mem_size; i += hpage_size)
>> +        (void)((volatile char *)mem)[i];
>> +
>> +    ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
>> +                (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0,
>> PAGE_IS_PFNZERO);
>> +    if (ret < 0)
>> +        ksft_exit_fail_msg("error %d %d %s\n", ret, errno,
>> strerror(errno));
>> +
>> +    ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
>> +             "%s all huge pages must have PFNZERO set\n", __func__);
> 
> Wouldn't this be able to fail if /sys/kernel/mm/transparent_hugepage/
> use_zero_page is set to false, 
I wasn't aware of it. I'll check user_zero_page first as initial condition.

> or if mmap() gave us a suboptimally-
> aligned range?
mem = memalign(hpage_size, mem_size) is being used to allocate this. So
aligment should be correct.

> 
> You'd have to read each and every page to get the ordinary shared
> zeropage in these configs instead without making the test too complicated.
In the above for loop, we are reading each new page already. Let's
resolve this and then I'll post the v2 which is ready.

> 
>> +
>> +    free(mem);
> 
> 
> Shouldn't this be an munmap() ?
free() is being used to free memory allocated by memalign().

> 
>> +}
>> +
>>   int main(int __attribute__((unused)) argc, char *argv[])
>>   {
>>       int shmid, buf_size, fd, i, ret;
>> @@ -1494,7 +1546,7 @@ int main(int __attribute__((unused)) argc, char
>> *argv[])
>>       if (init_uffd())
>>           ksft_exit_pass();
>>   -    ksft_set_plan(115);
>> +    ksft_set_plan(117);
> 
> We should probably look into converting this test to kselftest_harness.
> 


-- 
Regards,
Usama

