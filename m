Return-Path: <linux-kselftest+bounces-34809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB47AD6F24
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801B73A135C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B5A2F432F;
	Thu, 12 Jun 2025 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HyoKHZYP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722D2F4326;
	Thu, 12 Jun 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728251; cv=none; b=pXG/cELZPzq2+uw1Wgjn4cgKV5er4ur3+LxUr/Gj/Jdt5TvWHTvKXh3byBzcxgyeo2qu0n+FfzO216k/Y+xNU8iWNIBPePKAQqJBXjBhNb+x29Irvzwhft4VUAytY78Df4IYGrNkBmuzW9e33O1m5S6BV5KNhV4Oj83Q8eVwIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728251; c=relaxed/simple;
	bh=YjvbRnt6XlmgNec9sAIGdfmn0F6nyJAgEN3jwxWbdKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDXbowZR0gYxLBzviTT1GpRSQPx5aGEtaJN5HXC0zWQuK/6RZ2DqQuic3i7JvWm9GhP9KPo7Q01pudd+j3c7Djht1ftrmCkSRh3Hg/nUhQSQqiRZbXSp0IHk8DxUVsYcjyoPbnNuVVx04EMMnKk8lmX5TZAkCiIJz5HjIBRphtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HyoKHZYP; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749728245; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QSVPGRlqsJRFkbLxkOY6dxpAL7NHJT8NvpFrxAWvBSo=;
	b=HyoKHZYPScbjkawo6AOzROvNAi4zoOCT6vSV2uIoT06L2nVIhEpR750abtM7Yg02tyEh7+Z3IIwObSNeLCcw6jAvclMlkq/6OvuGT5RfAGzWmN9gVApa4tvW1h8p7WULc/qIF9KJcvSyT1rZvqjTyE7yWouMY+q69fnd0nezxqY=
Received: from 30.121.46.129(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdgxZ0V_1749728243 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Jun 2025 19:37:24 +0800
Message-ID: <42b76dbc-d1a1-4d00-b139-c50e0abf8b0c@linux.alibaba.com>
Date: Thu, 12 Jun 2025 19:37:23 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: khugepaged: fix the shmem collapse failure
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, shuah@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
 <e06530f6-5c2e-4b6f-b175-c7aaab79aa4e@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <e06530f6-5c2e-4b6f-b175-c7aaab79aa4e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/6/12 18:08, David Hildenbrand wrote:
> On 12.06.25 05:54, Baolin Wang wrote:
>> When running the khugepaged selftest for shmem (./khugepaged all:shmem),
> 
> Hmm, this combination is not run automatically through run_tests.sh, 
> right? IIUC, it only runs "./khugepaged" which tests anon only ...
> 
> Should we add it there? Then I would probably have noticed that myself 
> earlier :)

Yes, see patch 2.

>> I encountered the following test failures:
>> "
>> Run test: collapse_full (khugepaged:shmem)
>> Collapse multiple fully populated PTE table.... Fail
>> ...
>> Run test: collapse_single_pte_entry (khugepaged:shmem)
>> Collapse PTE table with single PTE entry present.... Fail
>> ...
>> Run test: collapse_full_of_compound (khugepaged:shmem)
>> Allocate huge page... OK
>> Split huge page leaving single PTE page table full of compound 
>> pages... OK
>> Collapse PTE table full of compound pages.... Fail
>> "
>>
>> The reason for the failure is that, it will set MADV_NOHUGEPAGE to 
>> prevent
>> khugepaged from continuing to scan shmem VMA after khugepaged finishes
>> scanning in the wait_for_scan() function. Moreover, shmem requires a 
>> refault
>> to establish PMD mappings.
>>
>> However, after commit 2b0f922323cc, PMD mappings are prevented if the 
>> VMA is
>> set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings 
>> during
>> refault.
> 
> Right. It's always problematic when we have some contradicting 
> information in the VMA vs. pagecache.
> 
>>
>> To fix this issue, we can set the MADV_NOHUGEPAGE flag after the shmem 
>> refault.
>> With this fix, the shmem test case passes.
>>
>> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are 
>> disabled by the hw/process/vma")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   tools/testing/selftests/mm/khugepaged.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/khugepaged.c 
>> b/tools/testing/selftests/mm/khugepaged.c
>> index 8a4d34cce36b..d462f62d8116 100644
>> --- a/tools/testing/selftests/mm/khugepaged.c
>> +++ b/tools/testing/selftests/mm/khugepaged.c
>> @@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char 
>> *p, int nr_hpages,
>>           usleep(TICK);
>>       }
>> -    madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>> -
>>       return timeout == -1;
>>   }
>> @@ -585,6 +583,7 @@ static void khugepaged_collapse(const char *msg, 
>> char *p, int nr_hpages,
>>       if (ops != &__anon_ops)
>>           ops->fault(p, 0, nr_hpages * hpage_pmd_size);
>> +    madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>>       if (ops->check_huge(p, expect ? nr_hpages : 0))
>>           success("OK");
>>       else
> 
> It's a shame we have this weird interface: there is no way we can clear 
> VM_HUGEPAGE without setting VM_NOHUGEPAGE :(

Right.

> But, do we even care about setting MADV_NOHUGEPAGE at all? IIUC, we'll 
> almost immediately later call cleanup_area() where we munmap(), right?

I tested removing the MADV_NOHUGEPAGE setting, and the khugepaged test 
cases all passed.

However, a potential impact of removing MADV_NOHUGEPAGE is that, 
khugepaged might report 'timeout', but check_huge() would still report 
'success' (assuming khugepaged tries to scan the VMA and successfully 
collapses it after the timeout). Such test result could be confusing.

I know this kind of case is very rare and may not even be detectable in 
tests. At least, I couldn't reproduce it. But I prefer to keep the 
original test logic and fix the issue without making further changes.

