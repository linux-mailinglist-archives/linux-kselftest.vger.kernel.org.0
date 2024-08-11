Return-Path: <linux-kselftest+bounces-15120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A5394E03D
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 08:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083AC1C20D47
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 06:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA315AF6;
	Sun, 11 Aug 2024 06:07:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D655E11CAB;
	Sun, 11 Aug 2024 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723356422; cv=none; b=isuRMe8nIbBIub8sjkpeaVENTlpEdrl/1+2Oelr6rbYB/wdIDtkjREpsKzsfNSMz90uzR228MjZ59brR/tY59Zu2CmpAbDEODT7hXG5fpySrOS3eo2T9W3eQ3b6vEKCgc/VrYfNwQ3HSosLNmdaDsATCSy/0GUgZIdw4tCieElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723356422; c=relaxed/simple;
	bh=3cCuEG7omtJUoPB4w0IwnZEfhSej2gjL7C0cbSC5JL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPGE0dIZL3HTa6zbrIaYc+94pZJc8zLx00tYk+sibaXrc7lKitoTzXnyT+3g1iT8lMXnEtRjt0JpDn2gI1LAWI04EPxaLJ/czUeuozRBvSbbTT7OPKxzm9N4uE0tt7EBjHob2vDPS23RtXtSjhC1zGMc1ztb6wb+7gkv9dSPwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DE39FEC;
	Sat, 10 Aug 2024 23:07:24 -0700 (PDT)
Received: from [10.163.57.79] (unknown [10.163.57.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DCF63F6A8;
	Sat, 10 Aug 2024 23:06:48 -0700 (PDT)
Message-ID: <ee1b9177-fb12-4bcb-a644-8d5d3d9f16fa@arm.com>
Date: Sun, 11 Aug 2024 11:36:26 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 shuah@kernel.org, willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, ying.huang@intel.com
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-2-dev.jain@arm.com>
 <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
 <5a4ae1d3-d753-4261-97a8-926e44d4217a@arm.com>
 <367b0403-7477-4857-9e7c-5a749c723432@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <367b0403-7477-4857-9e7c-5a749c723432@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/11/24 00:22, David Hildenbrand wrote:
> On 10.08.24 20:42, Dev Jain wrote:
>>
>> On 8/9/24 19:17, David Hildenbrand wrote:
>>> On 09.08.24 12:31, Dev Jain wrote:
>>>> As already being done in __migrate_folio(), wherein we backoff if the
>>>> folio refcount is wrong, make this check during the unmapping phase,
>>>> upon
>>>> the failure of which, the original state of the PTEs will be restored
>>>> and
>>>> the folio lock will be dropped via migrate_folio_undo_src(), any 
>>>> racing
>>>> thread will make progress and migration will be retried.
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>>    mm/migrate.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index e7296c0fb5d5..477acf996951 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t
>>>> get_new_folio,
>>>>        }
>>>>          if (!folio_mapped(src)) {
>>>> +        /*
>>>> +         * Someone may have changed the refcount and maybe sleeping
>>>> +         * on the folio lock. In case of refcount mismatch, bail out,
>>>> +         * let the system make progress and retry.
>>>> +         */
>>>> +        struct address_space *mapping = folio_mapping(src);
>>>> +
>>>> +        if (folio_ref_count(src) != folio_expected_refs(mapping, 
>>>> src))
>>>> +            goto out;
>>>
>>> This really seems to be the latest point where we can "easily" back
>>> off and unlock the source folio -- in this function :)
>>>
>>> I wonder if we should be smarter in the migrate_pages_batch() loop
>>> when we start the actual migrations via migrate_folio_move(): if we
>>> detect that a folio has unexpected references *and* it has waiters
>>> (PG_waiters), back off then and retry the folio later. If it only has
>>> unexpected references, just keep retrying: no waiters -> nobody is
>>> waiting for the lock to make progress.
>>
>>
>> The patch currently retries migration irrespective of the reason of
>> refcount change.
>>
>> If you are suggesting that, break the retrying according to two 
>> conditions:
>
> That's not what I am suggesting ...
>
>>
>>
>>> This really seems to be the latest point where we can "easily" back
>>> off and unlock the source folio -- in this function :)
>>> For example, when migrate_folio_move() fails with -EAGAIN, check if
>>> there are waiters (PG_waiter?) and undo+unlock to try again later.
>>
>>
>> Currently, on -EAGAIN, migrate_folio_move() returns without undoing src
>> and dst; even if we were to fall
>
> ...
>
> I am wondering if we should detect here if there are waiters and undo 
> src+dst.

After undoing src+dst, which restores the PTEs, how are you going to set the

PTEs to migration again? That is being done through migrate_folio_unmap(),

and the loops of _unmap() and _move() are different. Or am I missing 
something...

>

