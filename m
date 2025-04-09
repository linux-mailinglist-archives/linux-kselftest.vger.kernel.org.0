Return-Path: <linux-kselftest+bounces-30408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9CA82201
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 12:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9761D886870
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF5025C71D;
	Wed,  9 Apr 2025 10:25:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E0423ED56;
	Wed,  9 Apr 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194333; cv=none; b=hzh3V77oPNd0V1WMSW9LmrXeZ079LNBTPCj1lEPhUzgiAv7aCMsdWZghUNviDCrY8lkITZL7ZUJFxyzYZWtQXH7amOnCMJAu7xenrsuSS+E7Cx42RqiB2itVneRCjNoLdYKmTZBNAprCmpSxMfZ51pklfHDQv4NK4vvfYWANdyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194333; c=relaxed/simple;
	bh=3yrThab0Ex3N9iFowCRKFRqOWLW+tw2c+ci7nXTM9N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqJyQ6pb999Ytb3UBe5MYE8SewWGc+kdNCkWuMKzqsDLJ4MxPv7Bq4VeFk6dQ4oIWTzBKcxKN9PMrT26VhUyuaEeYFsL8WdvaiFe480N22PHuaDxRZvV2RFaSFVpnlg+VPbEVS3Q7N1XYNiCDjorHmX9IWzFj7yTycWUkhw/mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 688B6106F;
	Wed,  9 Apr 2025 03:25:31 -0700 (PDT)
Received: from [10.162.42.12] (a077893.blr.arm.com [10.162.42.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7F933F59E;
	Wed,  9 Apr 2025 03:25:28 -0700 (PDT)
Message-ID: <5c37c129-a8cb-4f17-8af1-059450083c73@arm.com>
Date: Wed, 9 Apr 2025 15:55:25 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix compiler -Wmaybe-uninitialized warning
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409095006.1422620-1-anshuman.khandual@arm.com>
 <9da46633-e9c1-42a7-b52b-16cf89836abc@redhat.com>
 <0ec536d2-4b82-4e97-9985-15cd431059ba@arm.com>
 <dcf585d8-8293-42ea-9d31-23825cc2f658@redhat.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <dcf585d8-8293-42ea-9d31-23825cc2f658@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/9/25 15:51, David Hildenbrand wrote:
> On 09.04.25 12:09, Anshuman Khandual wrote:
>>
>>
>> On 4/9/25 15:27, David Hildenbrand wrote:
>>> On 09.04.25 11:50, Anshuman Khandual wrote:
>>>> Following build warning comes up for cow test as 'transferred' variable has
>>>> not been initialized. Fix the warning via zero init for the variable.
>>>>
>>>>     CC       cow
>>>> cow.c: In function ‘do_test_vmsplice_in_parent’:
>>>> cow.c:365:61: warning: ‘transferred’ may be used uninitialized [-Wmaybe-uninitialized]
>>>>     365 |                 cur = read(fds[0], new + total, transferred - total);
>>>>         |                                                 ~~~~~~~~~~~~^~~~~~~
>>>> cow.c:296:29: note: ‘transferred’ was declared here
>>>>     296 |         ssize_t cur, total, transferred;
>>>>         |                             ^~~~~~~~~~~
>>>>     CC       compaction_test
>>>>     CC       gup_longterm
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>    tools/testing/selftests/mm/cow.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>>>> index f0cb14ea8608..b6cfe0a4b7df 100644
>>>> --- a/tools/testing/selftests/mm/cow.c
>>>> +++ b/tools/testing/selftests/mm/cow.c
>>>> @@ -293,7 +293,7 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>>>>            .iov_base = mem,
>>>>            .iov_len = size,
>>>>        };
>>>> -    ssize_t cur, total, transferred;
>>>> +    ssize_t cur, total, transferred = 0;
>>>>        struct comm_pipes comm_pipes;
>>>>        char *old, *new;
>>>>        int ret, fds[2];
>>>
>>>
>>> if (before_fork) {
>>>      transferred = vmsplice(fds[1], &iov, 1, 0);
>>> ...
>>>
>>> if (!before_fork) {
>>>      transferred = vmsplice(fds[1], &iov, 1, 0);
>>> ...
>>>
>>> for (total = 0; total < transferred; total += cur) {
>>> ...
>>>
>>>
>>> And I don't see any jump label that could jump to code that would ve using transferred.
>>>
>>> What am I missing?
>>
>> Probably because both those conditional statements are not mutually
>> exclusive above with an if-else construct. Hence compiler flags it
>> rather as a false positive ? Initializing with 0 just works around
>> that false positive.
> 
> This is something the compiler should clearly be able to verify. before_fork is never changed in that function.
> 
> We should not work around wrong compilers.
> 
> Which compiler are you using such that you run into this issue?

gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0

