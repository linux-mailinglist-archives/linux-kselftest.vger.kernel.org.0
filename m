Return-Path: <linux-kselftest+bounces-3936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D001E845803
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 13:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE281C2754B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 12:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E1386642;
	Thu,  1 Feb 2024 12:45:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5053370;
	Thu,  1 Feb 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791535; cv=none; b=G/34bJurrcJeN8t+0fK5ZsgYgA2KPsQhuiIz2cNa050D6xRgGvmeDtuPnJhAF9qXA8Zx7WiZD8wrd3QsIn4WWKVdR8ypHcJu3lTajlNIp0aAwCFR+op6Bpbq3x0MKLsOXsegYaXfm0K+/6D1HdNeb6FeOMYTVYmli9cNQtxDhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791535; c=relaxed/simple;
	bh=GY6uX8nz1dsOQhEZNQD7MwuTXlaNAUtRZtXWxuAegYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UljkuGWt0ncIXsfOpPEgF4CWeIoYlsW8InVH+Q/FW8w2ZwX+M0snxkR91/72BTU6t3v9Qc/Ex+o7t1LF1A3d5qJ2oYgkEohDfqLHL1P0kOzUBZF3thjQMbAV0bSvYzvsMTCOASBQIyV9D9JlaJu9SuPw0n3H98G7FQ2ZL3l8ZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AE57DA7;
	Thu,  1 Feb 2024 04:46:13 -0800 (PST)
Received: from [10.57.79.60] (unknown [10.57.79.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D66863F762;
	Thu,  1 Feb 2024 04:45:29 -0800 (PST)
Message-ID: <c85c0aa1-4f84-4e3e-8a92-a74e3439c76d@arm.com>
Date: Thu, 1 Feb 2024 12:45:29 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] selftests/mm: run_vmtests: remove sudo and conform
 to tap
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125154608.720072-1-usama.anjum@collabora.com>
 <20240125154608.720072-3-usama.anjum@collabora.com>
 <f833c7f9-f59a-49d5-9fce-dc531c11509e@arm.com>
 <8a340f1a-20b5-4792-9bca-b9ed2d95d384@collabora.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8a340f1a-20b5-4792-9bca-b9ed2d95d384@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 12:24, Muhammad Usama Anjum wrote:
> On 2/1/24 5:04 PM, Ryan Roberts wrote:
>> On 25/01/2024 15:46, Muhammad Usama Anjum wrote:
>>> Remove sudo as some test running environments may not have sudo
>>> available. Instead skip the test if root privileges aren't available in
>>> the test.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v1:
>>> - Added this patch in v2
>>>
>>> We are allocating 2*RLIMIT_MEMLOCK.rlim_max memory and mmap() isn't
>>> failing. This seems like true bug in the kernel. Even the root user
>>> shouldn't be able to allocate more memory than allowed MEMLOCKed memory.
>>> Any ideas?
>>> ---
>>>  tools/testing/selftests/mm/on-fault-limit.c | 36 ++++++++++-----------
>>>  tools/testing/selftests/mm/run_vmtests.sh   |  2 +-
>>>  2 files changed, 18 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
>>> index b5888d613f34e..0ea98ffab3589 100644
>>> --- a/tools/testing/selftests/mm/on-fault-limit.c
>>> +++ b/tools/testing/selftests/mm/on-fault-limit.c
>>> @@ -5,40 +5,38 @@
>>>  #include <string.h>
>>>  #include <sys/time.h>
>>>  #include <sys/resource.h>
>>> +#include "../kselftest.h"
>>>  
>>> -static int test_limit(void)
>>> +static void test_limit(void)
>>>  {
>>> -	int ret = 1;
>>>  	struct rlimit lims;
>>>  	void *map;
>>>  
>>> -	if (getrlimit(RLIMIT_MEMLOCK, &lims)) {
>>> -		perror("getrlimit");
>>> -		return ret;
>>> -	}
>>> +	if (getrlimit(RLIMIT_MEMLOCK, &lims))
>>> +		ksft_exit_fail_msg("getrlimit: %s\n", strerror(errno));
>>>  
>>> -	if (mlockall(MCL_ONFAULT | MCL_FUTURE)) {
>>> -		perror("mlockall");
>>> -		return ret;
>>> -	}
>>> +	if (mlockall(MCL_ONFAULT | MCL_FUTURE))
>>> +		ksft_exit_fail_msg("mlockall: %s\n", strerror(errno));
>>>  
>>>  	map = mmap(NULL, 2 * lims.rlim_max, PROT_READ | PROT_WRITE,
>>>  		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
>>> +
>>> +	ksft_test_result(map == MAP_FAILED, "Failed mmap\n");
>>> +
>>>  	if (map != MAP_FAILED)
>>> -		printf("mmap should have failed, but didn't\n");
>>> -	else {
>>> -		ret = 0;
>>>  		munmap(map, 2 * lims.rlim_max);
>>> -	}
>>> -
>>>  	munlockall();
>>> -	return ret;
>>>  }
>>>  
>>>  int main(int argc, char **argv)
>>>  {
>>> -	int ret = 0;
>>> +	ksft_print_header();
>>> +	ksft_set_plan(1);
>>> +
>>> +	if (getuid())
>>> +		ksft_test_result_skip("Require root privileges to run\n");
> I'd sent a patch to fix this behavior today. This test should run without
> root privileges.
> https://lore.kernel.org/all/20240201071307.592317-1-usama.anjum@collabora.com
> 
>>> +	else
>>> +		test_limit();
>>>  
>>> -	ret += test_limit();
>>> -	return ret;
>>> +	ksft_finished();
>>>  }
>>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>>> index 246d53a5d7f28..e373d592dbf5c 100755
>>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>>> @@ -291,7 +291,7 @@ echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
>>>  
>>>  CATEGORY="compaction" run_test ./compaction_test
>>>  
>>> -CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
>>> +CATEGORY="mlock" run_test ./on-fault-limit
>>
>> I think changing this is going to give unintended results. run_vmtests.sh must
>> already be running as root. "sudo -u nobody" is deprivieging the test to run as
>> nobody. The rlimit is not enforced for root so this test must run unprivileged
>> to work. See man page for getrlimit():
>>
>>   Since Linux 2.6.9, no limits are placed on the amount of memory that a
>>   privileged process may lock, and this limit instead governs the amount of
>>   memory that an unprivileged process may lock
>>
>> So I think the correct fix is actually to install sudo on your CI.
> run_vmtests.sh is invoked without sudo with following:
> make -C tools/testing/selftests/mm run_tests

Unfortunately, I live in a world where my build machine isn't always the same as
the target machine, so I'm not too familiar with this method of invocation.

Regardless, the vast majority of the tests in run_vmtests.sh (as well as the
configuration code in the script itself) require root. So invoking
run_vmtests.sh as anything other than root is a BadIdea (TM). And when
run_vmtests.sh is running as root, then you need the "sudo -u nobody" to
deprivilege this particular test.

> 
> Installing sudo in rootfs wouldn't be trivial enough on the CI side.
> Alternatively, we can check if sudo is present before executing this test
> to avoid error that sudo isn't found.

Yeah, that's probably the easiest solution; just skip it if the requirements are
not met.

> 
>>
>>>  
>>>  CATEGORY="mmap" run_test ./map_populate
>>>  
>>
>>
> 


