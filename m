Return-Path: <linux-kselftest+bounces-24093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA945A06D9B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 06:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8C33A642A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 05:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F90156220;
	Thu,  9 Jan 2025 05:33:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8BE33C9;
	Thu,  9 Jan 2025 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736400787; cv=none; b=CXznQZrPrn7xzB+J/JANExLY1PS6UV9x2ZN80S/KATIsFaoK7Dtdficr7QPmdw2XSL76RVRgwjHmMfzFSNh/qLsQCou3cHwSDZVpKh49GaB/InpMsCjWiWbdtANnzix5V/cOd54ZsvMUr5jFb2XoF2m0/AZt6LXa4QhRDf0C4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736400787; c=relaxed/simple;
	bh=d/Fjpk3qPTcK8VnbwUAtz96++dLwBdQ9/bNesa+5ra0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4WqwYBybhUiXrBn8dPHUpQUaa/PuaDqr+TvLXeQdB2B1H3vBxmX8SMg7PnN8wF8G9Vg9RRyIFprl1jqzFVo7M9gqmilzN6EDoGu18Oh6h9g3ZtQhzS4+DFDkkLKJYpQhe/qVFQBmqk9kqqSBXg9/4nBE4+Ia6evFF5kaOujTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23D9A13D5;
	Wed,  8 Jan 2025 21:33:33 -0800 (PST)
Received: from [10.162.43.52] (K4MQJ0H1H2.blr.arm.com [10.162.43.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12EC53F59E;
	Wed,  8 Jan 2025 21:33:01 -0800 (PST)
Message-ID: <ebcbd1b5-2408-4228-b4bf-63dbbe2257dd@arm.com>
Date: Thu, 9 Jan 2025 11:02:58 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests/mm: virtual_address_range: Dump to
 /dev/null
To: David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-3-3834a2fb47fe@linutronix.de>
 <2c5ab3af-2e58-449a-94f2-5cbcaa8b66f2@arm.com>
 <63481999-0665-4f40-a1bd-377a6ae69f90@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <63481999-0665-4f40-a1bd-377a6ae69f90@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/01/25 7:00 pm, David Hildenbrand wrote:
> On 08.01.25 07:09, Dev Jain wrote:
>>
>> On 07/01/25 8:44 pm, Thomas Weißschuh wrote:
>>> During the execution of validate_complete_va_space() a lot of memory is
>>> on the VM subsystem. When running on a low memory subsystem an OOM may
>>> be triggered, when writing to the dump file as the filesystem may also
>>> require memory.
>>>
>>> On my test system with 1100MiB physical memory:
>>>
>>>     Tasks state (memory values in pages):
>>>     [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file 
>>> rss_shmem pgtables_bytes swapents oom_score_adj name
>>>     [     57]     0    57 34359215953      695      256 0       439 
>>> 1064390656        0             0 virtual_address
>>>
>>>     Out of memory: Killed process 57 (virtual_address) 
>>> total-vm:137436863812kB, anon-rss:1024kB, file-rss:0kB, 
>>> shmem-rss:1756kB, UID:0 pgtables:1039444kB oom_score_adj:0
>>>     <snip>
>>>     fault_in_iov_iter_readable+0x4a/0xd0
>>>     generic_perform_write+0x9c/0x280
>>>     shmem_file_write_iter+0x86/0x90
>>>     vfs_write+0x29c/0x480
>>>     ksys_write+0x6c/0xe0
>>>     do_syscall_64+0x9e/0x1a0
>>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>
>>> Write the dumped data into /dev/null instead which does not require
>>> additional memory during write(), making the code simpler as a
>>> side-effect.
>>>
>>> Signed-off-by: Thomas Weißschuh<thomas.weissschuh@linutronix.de>
>>> ---
>>>   tools/testing/selftests/mm/virtual_address_range.c | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c 
>>> b/tools/testing/selftests/mm/virtual_address_range.c
>>> index 
>>> 484f82c7b7c871f82a7d9ec6d6c649f2ab1eb0cd..4042fd878acd702d23da2c3293292de33bd48143 
>>> 100644
>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>> @@ -103,10 +103,9 @@ static int validate_complete_va_space(void)
>>>       FILE *file;
>>>       int fd;
>>>   -    fd = open("va_dump", O_CREAT | O_WRONLY, 0600);
>>> -    unlink("va_dump");
>>> +    fd = open("/dev/null", O_WRONLY);
>>>       if (fd < 0) {
>>> -        ksft_test_result_skip("cannot create or open dump file\n");
>>> +        ksft_test_result_skip("cannot create or open /dev/null\n");
>>>           ksft_finished();
>>>       }
> >>   >> @@ -152,7 +151,6 @@ static int validate_complete_va_space(void)
>>>           while (start_addr + hop < end_addr) {
>>>               if (write(fd, (void *)(start_addr + hop), 1) != 1)
>>>                   return 1;
>>> -            lseek(fd, 0, SEEK_SET);
>>>                 hop += MAP_CHUNK_SIZE;
>>>           }
>>>
>>
>> The reason I had not used /dev/null was that write() was succeeding 
>> to /dev/null
>> even from an address not in my VA space. I was puzzled about this 
>> behaviour of
>> /dev/null and I chose to ignore it and just use a real file.
>>
>> To test this behaviour, run the following program:
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>> #include <fcntl.h>
>> #include <sys/mman.h>
>> intmain()
>> {
>> intfd;
>> fd = open("va_dump", O_CREAT| O_WRONLY, 0600);
>> unlink("va_dump");
>> // fd = open("/dev/null", O_WRONLY);
>> intret = munmap((void*)(1UL<< 30), 100);
>> if(!ret)
>> printf("munmap succeeded\n");
>> intres = write(fd, (void*)(1UL<< 30), 1);
>> if(res == 1)
>> printf("write succeeded\n");
>> return0;
>> }
>> The write will fail as expected, but if you comment out the va_dump
>> lines and use /dev/null, the write will succeed.
>
> What exactly do we want to achieve with the write? Verify that the 
> output of /proc/self/map is reasonable and we can actually resolve a 
> fault / map a page?
>
> Why not access the memory directly+signal handler or using 
> /proc/self/mem, so you can avoid the temp file completely?
>

We want to determine whether an address belongs to our address space. 
The proper way to do that is
to access the memory, get a segfault and jump to signal handler. I 
wanted to avoid this code churn,
so chose to use write() so that I can validate the address without 
getting a segfault.


