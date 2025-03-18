Return-Path: <linux-kselftest+bounces-29388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33B6A67F3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 23:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3F9883B8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A72063DB;
	Tue, 18 Mar 2025 22:05:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80239F9DA
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335551; cv=none; b=JrHUYbvUdac43xcPCeCnJ5PjTbOm52O2bpbka7MlQtIJj17/7QjyMVtaUkjI/UcqV14rQbLrHjcu272FeDLqXRqw7Lqh2+F4YhTs5IsSY01TtEwgOM7L5BqWhk52+8WDUpMr8ZDHVZNm/j0NpzzIKD8kAddTqQs+o3vFCfIRMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335551; c=relaxed/simple;
	bh=bPyTyv6am7dnAxKckZ57Yon0PUAhRu2RxF4vkunS11M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfZlX3vZVOUj3Xiwi4vXcipMyx2/FR0QEQh/lnNuwfD3yR9nikv3SnDnO42RILiIP64hiiZu7+HRvrD1M/84yXlUbJ2C8ZA6NwIfR5BJdNJvIwzvrEE54ZgJbBVL/XeSnY/SsSVsm4OnfTUZJpwU9c5ZK2p8UWHbP/SS5oJKBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAEB113D5;
	Tue, 18 Mar 2025 15:05:55 -0700 (PDT)
Received: from [10.57.81.111] (unknown [10.57.81.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 799793F673;
	Tue, 18 Mar 2025 15:05:46 -0700 (PDT)
Message-ID: <7d4b1d60-0674-4759-8302-1e51a00756c0@arm.com>
Date: Tue, 18 Mar 2025 22:05:44 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] selftests/mm: Fix half_ufd_size_MB calculation
Content-Language: en-GB
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250318174343.243631-1-ryan.roberts@arm.com>
 <Z9nPaevXTsvIElVS@x1.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z9nPaevXTsvIElVS@x1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2025 19:54, Peter Xu wrote:
> On Tue, Mar 18, 2025 at 05:43:39PM +0000, Ryan Roberts wrote:
>> $half_ufd_size_MB is supposed to be half of the available hugetlb memory
>> expressed in MB. But previously it was calculated in pages since
>> $freepgs is the number of free pages.
>>
>> When huge pages are 2M it doesn't make a whole lot of difference; the
>> number of pages that get used is just halved. But on arm64 with 16K or
>> 64K base pages, the PMD size (and default hugetlb size) is 32M and 512M
>> respectively. So in this case we end up passing a number of MB that is
>> smaller than a single hugetlb page and the test raises an error.
>>
>> Fixes: 2e47a445d7b3 ("selftests/mm: run_vmtests.sh: fix hugetlb mem size calculation")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> There's a similar fix already in akpm/mm-hotfixes-stable:
> 
> 67a2f86846f2 selftests/mm: run_vmtests.sh: fix half_ufd_size_MB calculation

Oops, my bad, forgot to check mm branches. This was just a drive-by fix while
working in another context.

Hopefully Andrew is ok to take the other 2 patches and drop this one? If not,
let me know and I'll resend the two other patches on their own.

Thanks,
Ryan

> 
> Thanks,
> 
>> ---
>>  tools/testing/selftests/mm/run_vmtests.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index da7e26668103..14fa9d40d574 100755
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -304,7 +304,7 @@ uffd_stress_bin=./uffd-stress
>>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
>>  # Hugetlb tests require source and destination huge pages. Pass in half
>>  # the size of the free pages we have, which is used for *each*.
>> -half_ufd_size_MB=$((freepgs / 2))
>> +half_ufd_size_MB=$(((freepgs * hpgsize_KB / 2) / 1024))
>>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
>>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
>>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
>> --
>> 2.43.0
>>
> 


