Return-Path: <linux-kselftest+bounces-24094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B7AA06DAC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 06:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52365162680
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 05:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A132144BB;
	Thu,  9 Jan 2025 05:40:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666B143888;
	Thu,  9 Jan 2025 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736401236; cv=none; b=sVTGVt6cYROvgSTQUqc95LEkpVcCsT+8s3tMdFrhz1q9lKkaPfvk6f4EBV5C1wsFqfW/DipVKQ+GcVKiLevDqnqJyn57FMg10AZ2VkKOu0Kx9+0RZFYrCmk8X8XiP/fz08heJ2jhD82l9Bjizo5TTlcWiTrpu1gaV8InfT7jTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736401236; c=relaxed/simple;
	bh=qcj88o7NG239bX/ANM3Sp+hpRKTRHuFx55BeBZtzW40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fO8o3SMjvlydocn1B9iozJTKLvcDbCPKEmi7NmytimLxrmSSr4g781apDy8ufRvzHZ2ydNsyjgpddfp4lhQcs7mIM5Wp7sB5nN8LQ6Yy3SEBuw4WDP9ax3s/JGN2W8I1mg6OjSA+/KgxrhIfB7+NS+sdhg8lh0BE54eEGO6aJUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF9B213D5;
	Wed,  8 Jan 2025 21:41:01 -0800 (PST)
Received: from [10.162.43.52] (K4MQJ0H1H2.blr.arm.com [10.162.43.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B80363F59E;
	Wed,  8 Jan 2025 21:40:30 -0800 (PST)
Message-ID: <7b653f96-537c-4c6b-9776-399ebaf352ff@arm.com>
Date: Thu, 9 Jan 2025 11:10:27 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
 <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
 <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
 <05edee1e-04f1-4f19-816f-db03c182a201@redhat.com>
 <20250108165052-c03470bd-6ff7-44c9-87b9-9145456bdea8@linutronix.de>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250108165052-c03470bd-6ff7-44c9-87b9-9145456bdea8@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/01/25 9:43 pm, Thomas Weißschuh wrote:
> On Wed, Jan 08, 2025 at 02:36:57PM +0100, David Hildenbrand wrote:
>> On 08.01.25 09:05, Thomas Weißschuh wrote:
>>> On Wed, Jan 08, 2025 at 11:46:19AM +0530, Dev Jain wrote:
>>>> On 07/01/25 8:44 pm, Thomas Weißschuh wrote:
>>>>> If not enough physical memory is available the kernel may fail mmap();
>>>>> see __vm_enough_memory() and vm_commit_limit().
>>>>> In that case the logic in validate_complete_va_space() does not make
>>>>> sense and will even incorrectly fail.
>>>>> Instead skip the test if no mmap() succeeded.
>>>>>
>>>>> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
>>>>> Cc: stable@vger.kernel.org
>> CC stable on tests is ... odd.
> I thought it was fairly common, but it isn't.
> Will drop it.

Oh, well...
https://lore.kernel.org/all/20240521074358.675031-4-dev.jain@arm.com/
I have done that before :) although the change I was making was fixing a
fundamental flaw in the test and your change is fixing the test for a
specific case (memory pressure), so I tend to concur with David.

>
>>>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>>>>
>>>>> ---
>>>>> The logic in __vm_enough_memory() seems weird.
>>>>> It describes itself as "Check that a process has enough memory to
>>>>> allocate a new virtual mapping", however it never checks the current
>>>>> memory usage of the process.
>>>>> So it only disallows large mappings. But many small mappings taking the
>>>>> same amount of memory are allowed; and then even automatically merged
>>>>> into one big mapping.
>>>>> ---
>>>>>     tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
>>>>>     1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>>>> index 2a2b69e91950a37999f606847c9c8328d79890c2..d7bf8094d8bcd4bc96e2db4dc3fcb41968def859 100644
>>>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>>>> @@ -178,6 +178,12 @@ int main(int argc, char *argv[])
>>>>>     		validate_addr(ptr[i], 0);
>>>>>     	}
>>>>>     	lchunks = i;
>>>>> +
>>>>> +	if (!lchunks) {
>>>>> +		ksft_test_result_skip("Not enough memory for a single chunk\n");
>>>>> +		ksft_finished();
>>>>> +	}
>>>>> +
>>>>>     	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
>>>>>     	if (hptr == NULL) {
>>>>>     		ksft_test_result_skip("Memory constraint not fulfilled\n");
>>>>>
>>>> I do not  know about __vm_enough_memory(), but I am going by your description:
>>>> You say that the kernel may fail mmap() when enough physical memory is not
>>>> there, but it may happen that we have already done 100 mmap()'s, and then
>>>> the kernel fails mmap(), so if (!lchunks) won't be able to handle this case.
>>>> Basically, lchunks == 0 is not a complete indicator of kernel failing mmap().
>>> __vm_enough_memory() only checks the size of each single mmap() on its
>>> own. It does not actually check the current memory or address space
>>> usage of the process.
>>> This seems a bit weird, as indicated in my after-the-fold explanation.
>>>
>>>> The basic assumption of the test is that any process should be able to exhaust
>>>> its virtual address space, and running the test under memory pressure and the
>>>> kernel violating this behaviour defeats the point of the test I think?
>>> The assumption is correct, as soon as one mapping succeeds the others
>>> will also succeed, until the actual address space is exhausted.
>>>
>>> Looking at it again, __vm_enough_memory() is only called for writable
>>> mappings, so it would be possible to use only readable mappings in the
>>> test. The test will still fail with OOM, as the many PTEs need more than
>>> 1GiB of physical memory anyways, but at least that produces a usable
>>> error message.
>>> However I'm not sure if this would violate other test assumptions.
>>>
>> Note that with MAP_NORESRVE, most setups we care about will allow mapping as
>> much as you want, but on access OOM will fire.
> Thanks for the hint.
>
>> So one could require that /proc/sys/vm/overcommit_memory is setup properly
>> and use MAP_NORESRVE.
> Isn't the check for lchunks == 0 essentially exactly this?
>
>> Reading from anonymous memory will populate the shared zeropage. To mitigate
>> OOM from "too many page tables", one could simply unmap the pieces as they
>> are verified (or MAP_FIXED over them, to free page tables).
> The code has to figure out if a verified region was created by mmap(),
> otherwise an munmap() could crash the process.
> As the entries from /proc/self/maps may have been merged and (I assume)
> the ordering of mappings is not guaranteed, some bespoke logic to establish
> the link will be needed.
>
> Is it fine to rely on CONFIG_ANON_VMA_NAME?
> That would make it much easier to implement.
>
> Using MAP_NORESERVE and eager munmap()s, the testcase works nicely even
> in very low physical memory conditions.
>
> Thomas

