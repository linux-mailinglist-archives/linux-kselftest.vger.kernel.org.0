Return-Path: <linux-kselftest+bounces-15144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED9894E67D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 08:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8290D1F212FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 06:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2014D6F6;
	Mon, 12 Aug 2024 06:20:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA114E2C1;
	Mon, 12 Aug 2024 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443615; cv=none; b=sahpw+SH8Vj8u9Ti6iQOTLDIjHaD6ffZz4C/afeZR1d3WCT3xOpCe7t5cYBvpWgZnxG3/hI2eaJ7GgIWbJQ+M9duCYD8aE4HEMvSo1ZOKubrRM73QoYETQk3r5edgwNQMtl6M1Telj9xik1rGMoUgmlsTq9bUkXXCBbWwLDFTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443615; c=relaxed/simple;
	bh=PLa+WOKUwAA72SYRTgdsr8wbeHyvzaXOK6rskYHsqzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAaFoE1p94rtjpDe5A0/16hzLMg0mxtBoEV9JcU8zGVTZFXwuWwra8rDWhRe3miSOU9UimxiSsYGqbG9+MMnp1GArR+lnfINELDWOQKNz5LpD2kSUVrr08rmUoE2G2duGkN7G/QtviMhvlb1b+wquB7w9ZkH5ZAuuXqvtndnoec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45830FEC;
	Sun, 11 Aug 2024 23:20:38 -0700 (PDT)
Received: from [10.162.43.141] (e116581.arm.com [10.162.43.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 171353F73B;
	Sun, 11 Aug 2024 23:20:02 -0700 (PDT)
Message-ID: <8ca30d9a-ffcf-4ccb-a791-2596b830cc08@arm.com>
Date: Mon, 12 Aug 2024 11:49:59 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: Do not fail test for a single migration
 failure
To: Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org,
 shuah@kernel.org, david@redhat.com, willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-3-dev.jain@arm.com>
 <e3bf3d2b-eb19-4678-916e-7a7f572b2936@linuxfoundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <e3bf3d2b-eb19-4678-916e-7a7f572b2936@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/9/24 22:43, Shuah Khan wrote:
> On 8/9/24 04:31, Dev Jain wrote:
>> Do not fail the test for just a single instance of migration failure,
>> since migration is a best-effort service.
>
> The cover letter says:
>
> "Given that migration is a best-effort service, it is wrong to fail the
> test for just a single failure; hence, fail the test after 100 
> consecutive
> failures (where 100 is still a subjective choice)."
>
> You do want to mention the above here.


Sure, shall update in v2.


>
> The reason being, I would like to know what this does to the run-time of
> this test if migration fails and retried 100 times.


Sure; just for the note, it won't affect the execution time of the test 
since
that is controlled by a timeout mechanism.


>
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>> Tested-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   tools/testing/selftests/mm/migration.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/migration.c 
>> b/tools/testing/selftests/mm/migration.c
>> index 6908569ef406..64bcbb7151cf 100644
>> --- a/tools/testing/selftests/mm/migration.c
>> +++ b/tools/testing/selftests/mm/migration.c
>> @@ -15,10 +15,10 @@
>>   #include <signal.h>
>>   #include <time.h>
>>   -#define TWOMEG (2<<20)
>> -#define RUNTIME (20)
>> -
>> -#define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>> +#define TWOMEG        (2<<20)
>> +#define RUNTIME        (20)
>> +#define MAX_RETRIES    100
>> +#define ALIGN(x, a)    (((x) + (a - 1)) & (~((a) - 1)))
>>     FIXTURE(migration)
>>   {
>> @@ -65,6 +65,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
>>       int ret, tmp;
>>       int status = 0;
>>       struct timespec ts1, ts2;
>> +    int failures = 0;
>>         if (clock_gettime(CLOCK_MONOTONIC, &ts1))
>>           return -1;
>> @@ -79,13 +80,17 @@ int migrate(uint64_t *ptr, int n1, int n2)
>>           ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
>>                   MPOL_MF_MOVE_ALL);
>>           if (ret) {
>> -            if (ret > 0)
>> +            if (ret > 0) {
>> +                /* Migration is best effort; try again */
>> +                if (++failures < MAX_RETRIES)
>> +                    continue;
>>                   printf("Didn't migrate %d pages\n", ret);
>> +            }
>>               else
>>                   perror("Couldn't migrate pages");
>>               return -2;
>>           }
>> -
>> +        failures = 0;
>>           tmp = n2;
>>           n2 = n1;
>>           n1 = tmp;
>
> thanks,
> -- Shuah

