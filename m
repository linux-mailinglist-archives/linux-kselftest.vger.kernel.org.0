Return-Path: <linux-kselftest+bounces-3310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9700B835EDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 11:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5F2287D9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EBC39FCB;
	Mon, 22 Jan 2024 10:00:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085739FF9;
	Mon, 22 Jan 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917601; cv=none; b=NgIvv+NZ9ZfEIpKQbF+0baJDZTWK8kAPSVjE60l3LdLzJ9Dp9DhRS2cLM0M8hHSJGqmBY15piAP86xe8V0sQF+Nhn3T72sXsh405XvTZJx09+gFtz5vrohVc9EuCh+N41jL7Mc6UPbmlAZD5yRtSoi4W4Maam/pd1n/O8gyPCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917601; c=relaxed/simple;
	bh=uwfu2Su/sc/XbQSWeZAeuqMRHd9Dh7GQ1+M4uoI5ZG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/CCFqPeJsdgytBLGgI3ZZiGC0PRo4XqmtAqoh3Jgu99kCL8cS4NeMkB6CBDamFVhMBOYv7jvc+7KC9I3W2TiiNWx95Ub7K+lgG85VNhG7uP1CZZKzMSgh0N4ALzkFAYQgKCaFRcYa2Ce167QIj7wSPpdHvjd3D9rJ9SqYfvnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 762DDDA7;
	Mon, 22 Jan 2024 02:00:44 -0800 (PST)
Received: from [10.1.33.151] (XHFQ2J9959.cambridge.arm.com [10.1.33.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95F453F5A1;
	Mon, 22 Jan 2024 01:59:57 -0800 (PST)
Message-ID: <06d796a1-1ae2-4f97-8fd6-0e3529ae2799@arm.com>
Date: Mon, 22 Jan 2024 09:59:56 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: add missing tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240116090641.3411660-1-usama.anjum@collabora.com>
 <ffdba8c4-f1a2-4141-a3d4-0c85dfea6fef@arm.com>
 <e3b2c142-aaae-481d-8206-5e8f374fd37e@collabora.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e3b2c142-aaae-481d-8206-5e8f374fd37e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 08:46, Muhammad Usama Anjum wrote:
> On 1/19/24 9:09 PM, Ryan Roberts wrote:
>> Hi Muhammad,
>>
>> Afraid this patch is causing a regression on our CI system when it turned up in
>> linux-next today. Additionally, 2 of thetests you have added are failing because
>> the scripts are not exported correctly...
> Andrew has dropped this patch for now.
> 
>>
>> On 16/01/2024 09:06, Muhammad Usama Anjum wrote:
>>> Add missing tests to run_vmtests.sh. The mm kselftests are run through
>>> run_vmtests.sh. If a test isn't present in this script, it'll not run
>>> with run_tests or `make -C tools/testing/selftests/mm run_tests`.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>  tools/testing/selftests/mm/run_vmtests.sh | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>>> index 246d53a5d7f2..a5e6ba8d3579 100755
>>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>>> @@ -248,6 +248,9 @@ CATEGORY="hugetlb" run_test ./map_hugetlb
>>>  CATEGORY="hugetlb" run_test ./hugepage-mremap
>>>  CATEGORY="hugetlb" run_test ./hugepage-vmemmap
>>>  CATEGORY="hugetlb" run_test ./hugetlb-madvise
>>> +CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh
>>> +CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh
>>
>> These 2 tests are failing because the test scripts are not exported. You will
>> need to add them to the TEST_FILES variable in the Makefile.
> This must be done. I'll investigate even after adding them if these scripts
> are robust enough to pass.

Great thanks!

> 
>>
>>> +CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
>>
>> The addition of this test causes 2 later tests to fail with ENOMEM. I suspect
>> its a side-effect of marking the hugetlbs as hwpoisoned? (just a guess based on
>> the test name!). Once a page is marked poisoned, is there a way to un-poison it?
>> If not, I suspect that's why it wasn't part of the standard test script in the
>> first place.
> hugetlb-read-hwpoison failed as probably the fix in the kernel for the test
> hasn't been merged in the kernel. The other tests (uffd-stress) aren't
> failing on my end and on CI [1][2]

To be clear, hugetlb-read-hwpoison isn't failing for me, its just causing the
subsequent tests uffd-stress tests to fail. Both of those subsequent tests are
allocating hugetlbs so my guess is that since this test is marking some hugetlbs
as poisoned, there are no longer enough for the subsequent tests.

> 
> [1] https://lava.collabora.dev/scheduler/job/12577207#L3677
> [2] https://lava.collabora.dev/scheduler/job/12577229#L4027
> 
> Maybe its configurations issue which is exposed now. Not sure. Maybe
> hugetlb-read-hwpoison is changing some configuration and not restoring it.

Well yes - its marking some hugetlb pages as HWPOISONED.

> Maybe your system has less number of hugetlb pages.

YEs probably; What is hugetlb-read-hwpoison's requirement for size and number of
hugetlb pages? the run_vmtests.sh script allocates the required number of
default-sized hugetlb pages before running any tests (I guess this value should
be increased for hugetlb-read-hwpoison's requirements?).

Additionally, our CI preallocates non-default sizes from the kernel command line
at boot. Happy to increase these if you can tell me what the new requirement is:

hugepagesz=1G hugepages=0:2,1:2 hugepagesz=32M hugepages=0:2,1:2
default_hugepagesz=2M hugepages=0:64,1:64 hugepagesz=64K hugepages=0:2,1:2

Thanks,
Ryan

> 
>>
>> These are the tests that start failing:
>>
>> # # ------------------------------------
>> # # running ./uffd-stress hugetlb 128 32
>> # # ------------------------------------
>> # # nr_pages: 64, nr_pages_per_cpu: 8
>> # # ERROR: context init failed (errno=12, @uffd-stress.c:254)
>> # # [FAIL]
>> # not ok 18 uffd-stress hugetlb 128 32 # exit=1
>> # # --------------------------------------------
>> # # running ./uffd-stress hugetlb-private 128 32
>> # # --------------------------------------------
>> # # nr_pages: 64, nr_pages_per_cpu: 8
>> # # bounces: 31, mode: rnd racing ver poll, ERROR: UFFDIO_COPY error: -12ERROR:
>> UFFDIO_COPY error: -12 (errno=12, @uffd-common.c:614)
>> # #  (errno=12, @uffd-common.c:614)
>> # # [FAIL]
>>
>> Quickest way to repo is:
>>
>> $ sudo ./run_vmtests.sh -t "userfaultfd hugetlb"
>>
>> Thanks,
>> Ryan
>>
>>
>>>  
>>>  nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
>>>  # For this test, we need one and just one huge page
>>
>>
> 


