Return-Path: <linux-kselftest+bounces-3932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090C7845785
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 13:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1AA1C21DE6
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 12:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9070163AA6;
	Thu,  1 Feb 2024 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R/kJqq2e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BCE163A8A;
	Thu,  1 Feb 2024 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790239; cv=none; b=A7VW8lfXFGccdFvwJAtpZFM3lgRZeAaoTOPCpT0vFs8YZ2ndX0QlCvHIcZn7O+l82OtoQz+TV/zRhhAe7Z8uG0BlMn4erswNhHATsQ1w12oU13gyjWP0Sn59kL067MNPvJ0tmS+lhQYAsNYrxxSpnZYfdyq57EG709BdSQN06BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790239; c=relaxed/simple;
	bh=j8QKIz2LyfqG7kXLMqtzk7hMvrhGXzbOQETFhOd/EaI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SmIbnBRD8ONNMAyM+UAW+iFlDPpHFZoP9lPSJT4pitfAvwTuegkuJATw5PgLXv3weDPjLNW/V3DBAT93Ez2z3HibvHRzCQPUWx/+AGBa4XbrM94BUuUNqbaJzgbUzCAiczdZi2PCqr3VicRD8+lZBNCO9Bk9cjuueNNFCKscR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R/kJqq2e; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706790236;
	bh=j8QKIz2LyfqG7kXLMqtzk7hMvrhGXzbOQETFhOd/EaI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=R/kJqq2eBKZjoZTcmiUwCtX+KsvoexBVNOsYpPxG/pVOWmPoFjYSMFTbSMsA1VRkM
	 NcMWRdJkLZ12znvltyCDAc31jvuLlhmsQdJqCf1dpnWuEb2zUwL6/2JBsnB3mDu2V/
	 bl1h9D+qNgcsdCQw4VGuUBZrwRhrKLPMhEVaJPXrubmM4XLbb6EQ8MhDiFQj69xeYZ
	 WgYmEFXizgICcDWZ6a52qZ+MIkfBwy1mPOxaeUSZpgP9bWQFKEwhf8+iG4zR9kc06r
	 +yRktM00Jeb2vplDjr1uJOAHPZu9HnQlhBGiJfRU6PAzTddQrhk5/ZNJ0NUDPZbiYI
	 cJX7qaiINLpLA==
Received: from [100.66.47.90] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BF129378047F;
	Thu,  1 Feb 2024 12:23:53 +0000 (UTC)
Message-ID: <8a340f1a-20b5-4792-9bca-b9ed2d95d384@collabora.com>
Date: Thu, 1 Feb 2024 17:24:09 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] selftests/mm: run_vmtests: remove sudo and conform
 to tap
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240125154608.720072-1-usama.anjum@collabora.com>
 <20240125154608.720072-3-usama.anjum@collabora.com>
 <f833c7f9-f59a-49d5-9fce-dc531c11509e@arm.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <f833c7f9-f59a-49d5-9fce-dc531c11509e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 5:04 PM, Ryan Roberts wrote:
> On 25/01/2024 15:46, Muhammad Usama Anjum wrote:
>> Remove sudo as some test running environments may not have sudo
>> available. Instead skip the test if root privileges aren't available in
>> the test.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Added this patch in v2
>>
>> We are allocating 2*RLIMIT_MEMLOCK.rlim_max memory and mmap() isn't
>> failing. This seems like true bug in the kernel. Even the root user
>> shouldn't be able to allocate more memory than allowed MEMLOCKed memory.
>> Any ideas?
>> ---
>>  tools/testing/selftests/mm/on-fault-limit.c | 36 ++++++++++-----------
>>  tools/testing/selftests/mm/run_vmtests.sh   |  2 +-
>>  2 files changed, 18 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
>> index b5888d613f34e..0ea98ffab3589 100644
>> --- a/tools/testing/selftests/mm/on-fault-limit.c
>> +++ b/tools/testing/selftests/mm/on-fault-limit.c
>> @@ -5,40 +5,38 @@
>>  #include <string.h>
>>  #include <sys/time.h>
>>  #include <sys/resource.h>
>> +#include "../kselftest.h"
>>  
>> -static int test_limit(void)
>> +static void test_limit(void)
>>  {
>> -	int ret = 1;
>>  	struct rlimit lims;
>>  	void *map;
>>  
>> -	if (getrlimit(RLIMIT_MEMLOCK, &lims)) {
>> -		perror("getrlimit");
>> -		return ret;
>> -	}
>> +	if (getrlimit(RLIMIT_MEMLOCK, &lims))
>> +		ksft_exit_fail_msg("getrlimit: %s\n", strerror(errno));
>>  
>> -	if (mlockall(MCL_ONFAULT | MCL_FUTURE)) {
>> -		perror("mlockall");
>> -		return ret;
>> -	}
>> +	if (mlockall(MCL_ONFAULT | MCL_FUTURE))
>> +		ksft_exit_fail_msg("mlockall: %s\n", strerror(errno));
>>  
>>  	map = mmap(NULL, 2 * lims.rlim_max, PROT_READ | PROT_WRITE,
>>  		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
>> +
>> +	ksft_test_result(map == MAP_FAILED, "Failed mmap\n");
>> +
>>  	if (map != MAP_FAILED)
>> -		printf("mmap should have failed, but didn't\n");
>> -	else {
>> -		ret = 0;
>>  		munmap(map, 2 * lims.rlim_max);
>> -	}
>> -
>>  	munlockall();
>> -	return ret;
>>  }
>>  
>>  int main(int argc, char **argv)
>>  {
>> -	int ret = 0;
>> +	ksft_print_header();
>> +	ksft_set_plan(1);
>> +
>> +	if (getuid())
>> +		ksft_test_result_skip("Require root privileges to run\n");
I'd sent a patch to fix this behavior today. This test should run without
root privileges.
https://lore.kernel.org/all/20240201071307.592317-1-usama.anjum@collabora.com

>> +	else
>> +		test_limit();
>>  
>> -	ret += test_limit();
>> -	return ret;
>> +	ksft_finished();
>>  }
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index 246d53a5d7f28..e373d592dbf5c 100755
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -291,7 +291,7 @@ echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
>>  
>>  CATEGORY="compaction" run_test ./compaction_test
>>  
>> -CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
>> +CATEGORY="mlock" run_test ./on-fault-limit
> 
> I think changing this is going to give unintended results. run_vmtests.sh must
> already be running as root. "sudo -u nobody" is deprivieging the test to run as
> nobody. The rlimit is not enforced for root so this test must run unprivileged
> to work. See man page for getrlimit():
> 
>   Since Linux 2.6.9, no limits are placed on the amount of memory that a
>   privileged process may lock, and this limit instead governs the amount of
>   memory that an unprivileged process may lock
> 
> So I think the correct fix is actually to install sudo on your CI.
run_vmtests.sh is invoked without sudo with following:
make -C tools/testing/selftests/mm run_tests

Installing sudo in rootfs wouldn't be trivial enough on the CI side.
Alternatively, we can check if sudo is present before executing this test
to avoid error that sudo isn't found.

> 
>>  
>>  CATEGORY="mmap" run_test ./map_populate
>>  
> 
> 

-- 
BR,
Muhammad Usama Anjum

