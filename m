Return-Path: <linux-kselftest+bounces-30406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E1A821C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 12:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC43B7C84
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0512B13CFB6;
	Wed,  9 Apr 2025 10:09:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6B25D208;
	Wed,  9 Apr 2025 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193388; cv=none; b=Pq74pY3IHvGGGHgnULZLhfOPINskNODmTT5U4HtAhpWcDsfZ1HxZjlKUI4NoJESLs7PnmhQYonEpLE6NzYr+X1ePpCs7XvIwwZPgtiRAogMl9nz420K0A7uVeyTdkhlHu8cDXDLGwbrI8sd5RdxW+O0uevZEPTCBEYnlEtaPZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193388; c=relaxed/simple;
	bh=kc1qcLsVngK5MA1x/SDfInuUDccFMI4VtE0nArtN4nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulkGdOMDpY1c33tbT7Za59vHC+AnzgXohCMKVKrZqflWeQ5sJBPKJiA8T42DC7RYWwJ4xgQZ8Eo89fAQeAVD0OY55t/AOdH12mdABvS/zoL91IL5WiDODHONU/vaiP0ATHTdfPYHu9nz/mBswFCcIZFcWqqcHG4HKJkbdG+i+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0B2F106F;
	Wed,  9 Apr 2025 03:09:46 -0700 (PDT)
Received: from [10.162.42.12] (a077893.blr.arm.com [10.162.42.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E1043F59E;
	Wed,  9 Apr 2025 03:09:44 -0700 (PDT)
Message-ID: <0ec536d2-4b82-4e97-9985-15cd431059ba@arm.com>
Date: Wed, 9 Apr 2025 15:39:41 +0530
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
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <9da46633-e9c1-42a7-b52b-16cf89836abc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/9/25 15:27, David Hildenbrand wrote:
> On 09.04.25 11:50, Anshuman Khandual wrote:
>> Following build warning comes up for cow test as 'transferred' variable has
>> not been initialized. Fix the warning via zero init for the variable.
>>
>>    CC       cow
>> cow.c: In function ‘do_test_vmsplice_in_parent’:
>> cow.c:365:61: warning: ‘transferred’ may be used uninitialized [-Wmaybe-uninitialized]
>>    365 |                 cur = read(fds[0], new + total, transferred - total);
>>        |                                                 ~~~~~~~~~~~~^~~~~~~
>> cow.c:296:29: note: ‘transferred’ was declared here
>>    296 |         ssize_t cur, total, transferred;
>>        |                             ^~~~~~~~~~~
>>    CC       compaction_test
>>    CC       gup_longterm
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   tools/testing/selftests/mm/cow.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>> index f0cb14ea8608..b6cfe0a4b7df 100644
>> --- a/tools/testing/selftests/mm/cow.c
>> +++ b/tools/testing/selftests/mm/cow.c
>> @@ -293,7 +293,7 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>>           .iov_base = mem,
>>           .iov_len = size,
>>       };
>> -    ssize_t cur, total, transferred;
>> +    ssize_t cur, total, transferred = 0;
>>       struct comm_pipes comm_pipes;
>>       char *old, *new;
>>       int ret, fds[2];
> 
> 
> if (before_fork) {
>     transferred = vmsplice(fds[1], &iov, 1, 0);
> ...
> 
> if (!before_fork) {
>     transferred = vmsplice(fds[1], &iov, 1, 0);
> ...
> 
> for (total = 0; total < transferred; total += cur) {
> ...
> 
> 
> And I don't see any jump label that could jump to code that would ve using transferred.
> 
> What am I missing?

Probably because both those conditional statements are not mutually
exclusive above with an if-else construct. Hence compiler flags it
rather as a false positive ? Initializing with 0 just works around
that false positive.

