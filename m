Return-Path: <linux-kselftest+bounces-3397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C01A9838A37
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 10:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF10B223D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 09:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E9D58ACA;
	Tue, 23 Jan 2024 09:23:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A858ABB;
	Tue, 23 Jan 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001820; cv=none; b=EGyLDLEePS3E/ENmp8U3pdV+zau+7UStqXK2jeVWgXG90WxqSBYakQI6JpCHnchKCDHPQxU05wRPwFuWQT2Ch57op0ZSDz51PFl6bdRNFxaJ/YmQw4kdi2L2OqOZG5e3WhjIXlIukTJPaplYsjmqSWex4VvtjvEA0Q3oynf05o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001820; c=relaxed/simple;
	bh=oG2yIczf8/y17txyC32qJgSVw5RnlOFlFIHspGw8Dc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ps3ftugxvtNwcoffhO/pgB9cRKxyxckmw9BWpprq2LLMcTcwgts1AnavwXmzU6G2UceD6CPyBepmspbf0hcvGEr5wTeeemjFe2mEU6LAsxMKIPXxVNjDdQTj+05ytOUOlXxlCQZ771MM4zK6sbmbJz7Dkc244j3UZLi6zCwChWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BF331FB;
	Tue, 23 Jan 2024 01:24:23 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2423F5A1;
	Tue, 23 Jan 2024 01:23:36 -0800 (PST)
Message-ID: <af614809-6d07-466d-8592-94a81ffd7e22@arm.com>
Date: Tue, 23 Jan 2024 09:23:35 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: add missing tests
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240116090641.3411660-1-usama.anjum@collabora.com>
 <ffdba8c4-f1a2-4141-a3d4-0c85dfea6fef@arm.com>
 <e3b2c142-aaae-481d-8206-5e8f374fd37e@collabora.com>
 <06d796a1-1ae2-4f97-8fd6-0e3529ae2799@arm.com>
 <de0e9e64-9833-4c60-8234-30b709b135db@collabora.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <de0e9e64-9833-4c60-8234-30b709b135db@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 07:51, Muhammad Usama Anjum wrote:
> On 1/22/24 2:59 PM, Ryan Roberts wrote:
>>>>> +CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
>>>>
>>>> The addition of this test causes 2 later tests to fail with ENOMEM. I suspect
>>>> its a side-effect of marking the hugetlbs as hwpoisoned? (just a guess based on
>>>> the test name!). Once a page is marked poisoned, is there a way to un-poison it?
>>>> If not, I suspect that's why it wasn't part of the standard test script in the
>>>> first place.
>>> hugetlb-read-hwpoison failed as probably the fix in the kernel for the test
>>> hasn't been merged in the kernel. The other tests (uffd-stress) aren't
>>> failing on my end and on CI [1][2]
>>
>> To be clear, hugetlb-read-hwpoison isn't failing for me, its just causing the
>> subsequent tests uffd-stress tests to fail. Both of those subsequent tests are
>> allocating hugetlbs so my guess is that since this test is marking some hugetlbs
>> as poisoned, there are no longer enough for the subsequent tests.
>>
>>>
>>> [1] https://lava.collabora.dev/scheduler/job/12577207#L3677
>>> [2] https://lava.collabora.dev/scheduler/job/12577229#L4027
>>>
>>> Maybe its configurations issue which is exposed now. Not sure. Maybe
>>> hugetlb-read-hwpoison is changing some configuration and not restoring it.
>>
>> Well yes - its marking some hugetlb pages as HWPOISONED.
>>
>>> Maybe your system has less number of hugetlb pages.
>>
>> YEs probably; What is hugetlb-read-hwpoison's requirement for size and number of
>> hugetlb pages? the run_vmtests.sh script allocates the required number of
>> default-sized hugetlb pages before running any tests (I guess this value should
>> be increased for hugetlb-read-hwpoison's requirements?).
>>
>> Additionally, our CI preallocates non-default sizes from the kernel command line
>> at boot. Happy to increase these if you can tell me what the new requirement is:
> I'm not sure about the exact requirement of the number of hugetlb for these
> tests. But I specify hugepages=1000 and tests work for me.

1000 hugepages @2M is ~2G, which is quite a big ask for small arm systems. And
for big arm systems that use 64K base pages, the default hugepage size is 512M,
so 1000 of those is 512G which is also quite a big ask. So I'd prefer not to
make 1000 hugepages the requirement.

Looking at the test, I think its using 8 default sized hugepages; But supporting
it properly is still complex as the HWPOISON operation is destructive. I'll
reply with more detail against the v2 patch.

> 
> I've sent v2 [1]. Would it be possible to run your CI on that and share
> results before we merge that one?
> 
> [1]
> https://lore.kernel.org/all/20240123073615.920324-1-usama.anjum@collabora.com
> 
>>
>> hugepagesz=1G hugepages=0:2,1:2 hugepagesz=32M hugepages=0:2,1:2
>> default_hugepagesz=2M hugepages=0:64,1:64 hugepagesz=64K hugepages=0:2,1:2
>>
>> Thanks,
>> Ryan
>>
> 


